//
//  SolarPosition.swift
//  SunTracker
//
//  太阳位置数据模型
//

import Foundation
import CoreLocation

/// 太阳位置数据
struct SolarPosition: Identifiable, Equatable {
    let id = UUID()
    let timestamp: Date
    let azimuth: Double      // 方位角 (0-360°)
    let elevation: Double    // 仰角 (-90-90°)
    let latitude: Double
    let longitude: Double
    
    /// 太阳是否在视野内（仰角 > 0）
    var isVisible: Bool {
        elevation > 0
    }
    
    /// 格式化方位角
    var azimuthString: String {
        String(format: "%.1f°", azimuth)
    }
    
    /// 格式化仰角
    var elevationString: String {
        String(format: "%.1f°", elevation)
    }
    
    /// 方向描述
    var direction: String {
        switch azimuth {
        case 0..<22.5: return "北"
        case 22.5..<67.5: return "东北"
        case 67.5..<112.5: return "东"
        case 112.5..<157.5: return "东南"
        case 157.5..<202.5: return "南"
        case 202.5..<247.5: return "西南"
        case 247.5..<292.5: return "西"
        case 292.5..<337.5: return "西北"
        default: return "北"
        }
    }
}

/// 太阳事件（日出日落等）
struct SunEvents: Identifiable {
    let id = UUID()
    let date: Date
    let sunrise: Date?
    let sunset: Date?
    let solarNoon: Date?
    let goldenHourMorning: (start: Date?, end: Date?)
    let goldenHourEvening: (start: Date?, end: Date?)
    
    /// 格式化日出时间
    var sunriseString: String {
        guard let sunrise = sunrise else { return "—" }
        return Self.formatTime(sunrise)
    }
    
    /// 格式化日落时间
    var sunsetString: String {
        guard let sunset = sunset else { return "—" }
        return Self.formatTime(sunset)
    }
    
    /// 白天时长
    var daylightDuration: String {
        guard let sunrise = sunrise, let sunset = sunset else { return "—" }
        let duration = sunset.timeIntervalSince(sunrise)
        let hours = Int(duration) / 3600
        let minutes = (Int(duration) % 3600) / 60
        return "\(hours)小时\(minutes)分钟"
    }
    
    private static func formatTime(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: date)
    }
}
