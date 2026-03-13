//
//  Astronomy.swift
//  SunTracker
//
//  天文计算核心算法 - 基于 NOAA 太阳位置计算
//

import Foundation
import CoreLocation

/// 天文计算工具类
struct Astronomy {
    
    // MARK: - 太阳位置计算
    
    /// 计算太阳位置（方位角和仰角）
    static func calculateSolarPosition(date: Date, latitude: Double, longitude: Double) -> (azimuth: Double, elevation: Double) {
        var utcCalendar = Calendar(identifier: .gregorian)
        utcCalendar.locale = Locale(identifier: "en_US_POSIX")
        utcCalendar.timeZone = TimeZone(identifier: "UTC")!
        
        let components = utcCalendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let year = Double(components.year ?? 2024)
        let month = Double(components.month ?? 1)
        let day = Double(components.day ?? 1)
        let hour = Double(components.hour ?? 12)
        let minute = Double(components.minute ?? 0)
        
        let jd = julianDay(year: year, month: month, day: day, hour: hour, minute: minute)
        let g = 357.529 + 0.98560028 * (jd - 2451545)
        let gRad = g.degreesToRadians
        let q = 280.459 + 0.98564736 * (jd - 2451545)
        let l = q + 1.915 * sin(gRad) + 0.020 * sin(2 * gRad)
        let lRad = l.degreesToRadians
        let e = 23.439 - 0.00000036 * (jd - 2451545)
        let eRad = e.degreesToRadians
        
        let ra = atan2(cos(eRad) * sin(lRad), cos(lRad)).radiansToDegrees
        let dec = asin(sin(eRad) * sin(lRad)).radiansToDegrees
        let gmst = 280.46061837 + 360.98564736629 * (jd - 2451545) + 0.000387933 * pow(jd - 2451545, 2)
        let lst = gmst + longitude
        let ha = lst - ra
        let haRad = ha.degreesToRadians
        let latRad = latitude.degreesToRadians
        let decRad = dec.degreesToRadians
        
        let sinAlt = sin(latRad) * sin(decRad) + cos(latRad) * cos(decRad) * cos(haRad)
        let elevation = asin(sinAlt).radiansToDegrees
        
        let cosAz = (sin(decRad) - sinAlt * sin(latRad)) / (cos(latRad) * cos(elevation.degreesToRadians))
        var azimuth = acos(cosAz).radiansToDegrees
        
        if sin(haRad) > 0 {
            azimuth = 360 - azimuth
        }
        
        return (azimuth: azimuth, elevation: elevation)
    }
    
    // MARK: - 日出日落计算
    
    /// 计算日出日落时间（返回本地时间）
    static func calculateSunTimes(date: Date, latitude: Double, longitude: Double) -> (sunrise: Date?, sunset: Date?) {
        let localCalendar = Calendar.current
        let timeZone = localCalendar.timeZone
        let timeZoneOffset = Double(timeZone.secondsFromGMT(for: date))
        
        var utcCalendar = Calendar(identifier: .gregorian)
        utcCalendar.locale = Locale(identifier: "en_US_POSIX")
        utcCalendar.timeZone = TimeZone(identifier: "UTC")!
        
        let components = utcCalendar.dateComponents([.year, .month, .day], from: date)
        let year = Double(components.year ?? 2024)
        let month = Double(components.month ?? 1)
        let day = Double(components.day ?? 1)
        
        let jd = julianDay(year: year, month: month, day: day, hour: 12, minute: 0)
        
        let g = 357.529 + 0.98560028 * (jd - 2451545)
        let eqtime = 229.18 * (0.000075 + 0.001868 * cos(g.degreesToRadians) 
                              - 0.032077 * sin(g.degreesToRadians) 
                              - 0.014615 * cos(2 * g.degreesToRadians) 
                              - 0.040849 * sin(2 * g.degreesToRadians))
        
        let decl = 0.006918 - 0.399912 * cos(g.degreesToRadians) 
                  + 0.070257 * sin(g.degreesToRadians) 
                  - 0.006758 * cos(2 * g.degreesToRadians) 
                  + 0.000907 * sin(2 * g.degreesToRadians) 
                  - 0.002697 * cos(3 * g.degreesToRadians) 
                  + 0.00148 * sin(3 * g.degreesToRadians)
        
        let latRad = latitude.degreesToRadians
        let zenith = 90.833.degreesToRadians
        let cosHA = (cos(zenith) / (cos(latRad) * cos(decl))) - tan(latRad) * tan(decl)
        
        guard abs(cosHA) <= 1 else {
            return (nil, nil)
        }
        
        let ha = acos(cosHA).radiansToDegrees
        
        // 计算 UTC 时间（分钟）
        let sunriseMinutesUTC = 720 - 4 * (longitude + ha) - eqtime
        let sunsetMinutesUTC = 720 - 4 * (longitude - ha) - eqtime
        
        // 转换为本地时间（加时区偏移）
        let sunriseMinutesLocal = sunriseMinutesUTC + timeZoneOffset / 60.0
        let sunsetMinutesLocal = sunsetMinutesUTC + timeZoneOffset / 60.0
        
        // 构建本地时间组件
        var sunriseComponents = components
        sunriseComponents.hour = Int(sunriseMinutesLocal / 60)
        sunriseComponents.minute = Int(sunriseMinutesLocal.truncatingRemainder(dividingBy: 60))
        sunriseComponents.second = 0
        
        var sunsetComponents = components
        sunsetComponents.hour = Int(sunsetMinutesLocal / 60)
        sunsetComponents.minute = Int(sunsetMinutesLocal.truncatingRemainder(dividingBy: 60))
        sunsetComponents.second = 0
        
        // 创建本地时间
        let sunrise = localCalendar.date(from: sunriseComponents)
        let sunset = localCalendar.date(from: sunsetComponents)
        
        return (sunrise: sunrise, sunset: sunset)
    }
    
    // MARK: - 黄金时刻计算
    
    /// 计算黄金时刻（Golden Hour）
    static func calculateGoldenHour(date: Date, latitude: Double, longitude: Double) -> (morningStart: Date?, morningEnd: Date?, eveningStart: Date?, eveningEnd: Date?) {
        let sunTimes = calculateSunTimes(date: date, latitude: latitude, longitude: longitude)
        
        guard let sunrise = sunTimes.sunrise, let sunset = sunTimes.sunset else {
            return (nil, nil, nil, nil)
        }
        
        let calendar = Calendar.current
        let morningStart = calendar.date(byAdding: .minute, value: -30, to: sunrise)
        let morningEnd = calendar.date(byAdding: .minute, value: 30, to: sunrise)
        let eveningStart = calendar.date(byAdding: .minute, value: -30, to: sunset)
        let eveningEnd = calendar.date(byAdding: .minute, value: 30, to: sunset)
        
        return (morningStart, morningEnd, eveningStart, eveningEnd)
    }
    
    // MARK: - 太阳轨迹点计算
    
    /// 计算指定日期的太阳轨迹点（用于绘制轨迹和时间刻度）
    /// - Returns: 数组，包含每个小时的太阳位置（方位角，仰角，小时）
    static func calculateSolarPath(date: Date, latitude: Double, longitude: Double) -> [(azimuth: Double, elevation: Double, hour: Int)] {
        var pathPoints: [(Double, Double, Int)] = []
        let localCalendar = Calendar.current
        
        // 计算 24 小时的太阳位置（0-23 点）
        for hour in 0...23 {
            var components = localCalendar.dateComponents([.year, .month, .day], from: date)
            components.hour = hour
            components.minute = 0
            components.second = 0
            
            if let hourDate = localCalendar.date(from: components) {
                let (azimuth, elevation) = calculateSolarPosition(
                    date: hourDate,
                    latitude: latitude,
                    longitude: longitude
                )
                pathPoints.append((azimuth, elevation, hour))
            }
        }
        
        return pathPoints
    }
    
    // MARK: - 辅助函数
    
    private static func julianDay(year: Double, month: Double, day: Double, hour: Double, minute: Double) -> Double {
        let y = month > 2 ? year : year - 1
        let m = month > 2 ? month : month + 12
        let a = floor(y / 100)
        let b = 2 - a + floor(a / 4)
        return floor(365.25 * (y + 4716)) + floor(30.6001 * (m + 1)) + day + hour / 24 + minute / 1440 + b - 1524.5
    }
}

extension Double {
    var degreesToRadians: Double { self * .pi / 180 }
    var radiansToDegrees: Double { self * 180 / .pi }
}
