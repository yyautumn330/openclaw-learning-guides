#!/usr/bin/env swift

//
// SunTrackerCLI - 命令行版太阳追踪工具
//

import Foundation
import CoreLocation

// MARK: - 天文计算

struct Astronomy {
    
    /// 计算太阳位置（方位角和仰角）
    static func calculateSolarPosition(date: Date, latitude: Double, longitude: Double) -> (azimuth: Double, elevation: Double) {
        let components = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
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
        let gmst = 280.46061837 + 360.98564736629 * (jd - 2451545)
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
    
    /// 计算日出日落时间
    static func calculateSunTimes(date: Date, latitude: Double, longitude: Double) -> (sunrise: Date?, sunset: Date?) {
        let components = Calendar.current.dateComponents([.year, .month, .day], from: date)
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
        let sunriseMinutes = 720 - 4 * (longitude + ha) - eqtime
        let sunsetMinutes = 720 - 4 * (longitude - ha) - eqtime
        
        var sunriseComponents = components
        sunriseComponents.hour = Int(sunriseMinutes / 60)
        sunriseComponents.minute = Int(sunriseMinutes.truncatingRemainder(dividingBy: 60))
        
        var sunsetComponents = components
        sunsetComponents.hour = Int(sunsetMinutes / 60)
        sunsetComponents.minute = Int(sunsetMinutes.truncatingRemainder(dividingBy: 60))
        
        return (
            sunrise: Calendar.current.date(from: sunriseComponents),
            sunset: Calendar.current.date(from: sunsetComponents)
        )
    }
    
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

// MARK: - 主程序

class SunTrackerCLI {
    
    func run() {
        printHeader()
        
        // 默认坐标（北京）
        var latitude = 39.9042
        var longitude = 116.4074
        
        // 检查命令行参数
        let args = CommandLine.arguments
        if args.count >= 3 {
            latitude = Double(args[1]) ?? latitude
            longitude = Double(args[2]) ?? longitude
        } else {
            print("📍 使用默认坐标：北京 (39.9042°N, 116.4074°E)")
            print("   用法：swift run SunTrackerCLI <纬度> <经度>\n")
        }
        
        // 计算太阳位置
        let now = Date()
        let (azimuth, elevation) = Astronomy.calculateSolarPosition(
            date: now,
            latitude: latitude,
            longitude: longitude
        )
        
        // 计算日出日落
        let (sunrise, sunset) = Astronomy.calculateSunTimes(
            date: now,
            latitude: latitude,
            longitude: longitude
        )
        
        // 显示结果
        displayResults(
            azimuth: azimuth,
            elevation: elevation,
            sunrise: sunrise,
            sunset: sunset,
            latitude: latitude,
            longitude: longitude
        )
        
        print("\n✅ 计算完成！")
        print("   按 Ctrl+C 退出，或运行带 --watch 参数进入实时模式\n")
    }
    
    private func printHeader() {
        print("""
        
        ╔═══════════════════════════════════════════╗
        ║     🌅 SunTracker - 太阳轨迹跟踪工具       ║
        ║          命令行版 v1.0                     ║
        ╚═══════════════════════════════════════════╝
        
        """)
    }
    
    private func displayResults(azimuth: Double, elevation: Double, 
                                sunrise: Date?, sunset: Date?,
                                latitude: Double, longitude: Double) {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        formatter.timeZone = TimeZone.current
        
        print("📍 位置：\(String(format: "%.4f", latitude))°N, \(String(format: "%.4f", longitude))°E")
        print("🕐 时间：\(formatter.string(from: Date()))\n")
        
        print("☀️  当前太阳位置")
        print("   方位角：\(String(format: "%.2f", azimuth))° \(directionFromAzimuth(azimuth))")
        print("   仰角：\(String(format: "%.2f", elevation))°")
        print("   状态：\(elevation > 0 ? "☀️ 可见" : "🌙 在地平线下")\n")
        
        print("🌅 日出日落时间")
        if let sunrise = sunrise {
            print("   日出：\(formatter.string(from: sunrise))")
        } else {
            print("   日出：— (极昼/极夜)")
        }
        
        if let sunset = sunset {
            print("   日落：\(formatter.string(from: sunset))")
        } else {
            print("   日落：— (极昼/极夜)")
        }
        
        if let sunrise = sunrise, let sunset = sunset {
            let duration = sunset.timeIntervalSince(sunrise)
            let hours = Int(duration) / 3600
            let minutes = (Int(duration) % 3600) / 60
            print("   白天时长：\(hours)小时\(minutes)分钟")
        }
        
        print("")
    }
    
    private func directionFromAzimuth(_ azimuth: Double) -> String {
        switch azimuth {
        case 0..<22.5: return "(北)"
        case 22.5..<67.5: return "(东北)"
        case 67.5..<112.5: return "(东)"
        case 112.5..<157.5: return "(东南)"
        case 157.5..<202.5: return "(南)"
        case 202.5..<247.5: return "(西南)"
        case 247.5..<292.5: return "(西)"
        case 292.5..<337.5: return "(西北)"
        default: return "(北)"
        }
    }
    
    private func startTracking(latitude: Double, longitude: Double) {
        print("🔄 进入实时追踪模式 (按 Ctrl+C 退出)...\n")
        
        let runLoop = RunLoop.current
        var lastUpdate = Date()
        
        while runLoop.run(mode: .default, before: Date().addingTimeInterval(1)) {
            let now = Date()
            
            // 每秒更新一次
            if now.timeIntervalSince(lastUpdate) >= 1 {
                let (azimuth, elevation) = Astronomy.calculateSolarPosition(
                    date: now,
                    latitude: latitude,
                    longitude: longitude
                )
                
                // 清屏并显示新数据
                print("\u{001B}[2J")  // 清屏
                printHeader()
                print("📍 位置：\(String(format: "%.4f", latitude))°N, \(String(format: "%.4f", longitude))°E")
                print("🕐 时间：\(DateFormatter.localizedString(from: now, dateStyle: .none, timeStyle: .medium))\n")
                print("☀️  太阳位置")
                print("   方位角：\(String(format: "%.2f", azimuth))° \(directionFromAzimuth(azimuth))")
                print("   仰角：\(String(format: "%.2f", elevation))°")
                print("   状态：\(elevation > 0 ? "☀️ 可见" : "🌙 在地平线下")")
                
                lastUpdate = now
            }
        }
    }
}

// 运行程序
let tracker = SunTrackerCLI()
tracker.run()
