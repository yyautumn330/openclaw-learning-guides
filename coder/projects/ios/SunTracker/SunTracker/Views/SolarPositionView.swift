//
//  SolarPositionView.swift
//  SunTracker
//
//  太阳位置显示视图 - 指南针 + 仰角
//

import SwiftUI
import CoreLocation

struct SolarPositionView: View {
    @EnvironmentObject var locationManager: LocationService
    @EnvironmentObject var motionManager: MotionService
    @State private var solarPosition: SolarPosition?
    @State private var updateTimer: Timer?
    
    var body: some View {
        ScrollView {
            VStack(spacing: 30) {
                // 位置信息
                LocationInfoView()
                
                // 指南针视图
                if let position = solarPosition {
                    CompassView(solarPosition: position)
                }
                
                // 太阳数据卡片
                SolarDataCardsView(position: solarPosition)
                
                // 太阳轨迹图
                if let position = solarPosition {
                    SolarPathView(solarPosition: position)
                }
            }
            .padding()
        }
        .navigationTitle("太阳位置")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        .refreshable {
            updateSolarPosition()
        }
        #endif
        .onAppear {
            startUpdating()
        }
        .onDisappear {
            stopUpdating()
        }
    }
    
    private func startUpdating() {
        updateSolarPosition()
        updateTimer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { _ in
            updateSolarPosition()
        }
    }
    
    private func stopUpdating() {
        updateTimer?.invalidate()
        updateTimer = nil
    }
    
    private func updateSolarPosition() {
        guard let lat = locationManager.latitude,
              let lon = locationManager.longitude else {
            return
        }
        
        let position = Astronomy.calculateSolarPosition(
            date: Date(),
            latitude: lat,
            longitude: lon
        )
        
        solarPosition = SolarPosition(
            timestamp: Date(),
            azimuth: position.azimuth,
            elevation: position.elevation,
            latitude: lat,
            longitude: lon
        )
    }
}

// MARK: - 位置信息视图

struct LocationInfoView: View {
    @EnvironmentObject var locationManager: LocationService
    
    var body: some View {
        VStack(spacing: 8) {
            HStack {
                Image(systemName: "location.fill")
                    .foregroundColor(.blue)
                
                if let lat = locationManager.latitude,
                   let lon = locationManager.longitude {
                    Text(String(format: "%.4f°, %.4f°", lat, lon))
                        .font(.caption)
                } else {
                    Text("获取位置中...")
                        .font(.caption)
                }
            }
            
            if locationManager.isUpdating {
                HStack(spacing: 8) {
                    ProgressView()
                        .frame(width: 12, height: 12)
                    Text("更新中")
                        .font(.caption2)
                }
                .foregroundColor(.secondary)
            }
        }
        .padding()
        .background(Color.blue.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - 指南针视图

struct CompassView: View {
    let solarPosition: SolarPosition
    @EnvironmentObject var motionManager: MotionService
    
    var body: some View {
        VStack {
            ZStack {
                // 指南针外圈
                Circle()
                    .stroke(Color.gray.opacity(0.3), lineWidth: 4)
                    .frame(width: 200, height: 200)
                
                // 方向标记
                CompassMarkersView()
                
                // 太阳指示器
                SolarIndicatorView(azimuth: solarPosition.azimuth)
                
                // 中心点
                Circle()
                    .fill(Color.orange)
                    .frame(width: 16, height: 16)
            }
            
            Text("太阳方向：\(solarPosition.direction)")
                .font(.headline)
                .padding(.top)
            
            Text("方位角：\(solarPosition.azimuthString)")
                .font(.caption)
                .foregroundColor(.secondary)
        }
    }
}

struct CompassMarkersView: View {
    var body: some View {
        ZStack {
            Text("N").font(.caption.bold()).offset(y: -90)
            Text("E").font(.caption.bold()).offset(x: 90)
            Text("S").font(.caption.bold()).offset(y: 90)
            Text("W").font(.caption.bold()).offset(x: -90)
        }
        .foregroundColor(.gray)
    }
}

struct SolarIndicatorView: View {
    let azimuth: Double
    
    var body: some View {
        GeometryReader { geometry in
            let radius = geometry.size.width / 2 - 20
            let angle = (azimuth - 90) * .pi / 180  // 转换为 SwiftUI 坐标
            let x = radius * cos(angle)
            let y = radius * sin(angle)
            
            Circle()
                .fill(Color.orange.gradient)
                .frame(width: 24, height: 24)
                .position(x: geometry.size.width / 2 + x, y: geometry.size.height / 2 + y)
                .shadow(color: .orange.opacity(0.5), radius: 8)
        }
        .frame(width: 200, height: 200)
    }
}

// MARK: - 太阳数据卡片

struct SolarDataCardsView: View {
    let position: SolarPosition?
    
    var body: some View {
        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
            DataCardView(
                title: "仰角",
                value: position?.elevationString ?? "—",
                icon: "angle",
                color: .blue
            )
            
            DataCardView(
                title: "方位角",
                value: position?.azimuthString ?? "—",
                icon: "location.fill",
                color: .orange
            )
            
            DataCardView(
                title: "可见性",
                value: (position?.isVisible ?? false) ? "☀️ 可见" : "🌙 不可见",
                icon: "eye",
                color: .green
            )
            
            DataCardView(
                title: "方向",
                value: position?.direction ?? "—",
                icon: "location.north",
                color: .purple
            )
        }
    }
}

struct DataCardView: View {
    let title: String
    let value: String
    let icon: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Image(systemName: icon)
                    .foregroundColor(color)
                Text(title)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            Text(value)
                .font(.title2.bold())
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(color.opacity(0.1))
        .cornerRadius(12)
    }
}

// MARK: - 太阳轨迹视图

struct SolarPathView: View {
    let solarPosition: SolarPosition
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("太阳轨迹")
                    .font(.headline)
                Spacer()
                Text(solarPosition.direction)
                    .font(.caption)
                    .foregroundColor(.secondary)
            }
            
            GeometryReader { geometry in
                let width = geometry.size.width
                let height = geometry.size.height
                
                // 天空背景渐变
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(red: 0.1, green: 0.2, blue: 0.4),
                        Color(red: 0.3, green: 0.5, blue: 0.7),
                        Color(red: 0.6, green: 0.7, blue: 0.9)
                    ]),
                    startPoint: .top,
                    endPoint: .bottom
                )
                .cornerRadius(12)
                
                // 地平线
                Rectangle()
                    .fill(Color(red: 0.2, green: 0.5, blue: 0.3).opacity(0.3))
                    .frame(height: height * 0.3)
                    .offset(y: height * 0.35)
                
                // 太阳轨迹弧线
                Path { path in
                    let centerX = width / 2
                    let groundY = height * 0.65
                    let arcHeight = height * 0.5
                    
                    path.move(to: CGPoint(x: 20, y: groundY))
                    path.addQuadCurve(
                        to: CGPoint(x: width - 20, y: groundY),
                        control: CGPoint(x: centerX, y: groundY - arcHeight)
                    )
                }
                .stroke(Color.orange.opacity(0.6), lineWidth: 2)
                .frame(height: height)
                
                // 时间刻度（每 4 小时）
                ForEach([6, 10, 14, 18], id: \.self) { hour in
                    let progress = CGFloat(hour - 6) / 12.0
                    let x = 20 + (width - 40) * progress
                    let groundY = height * 0.65
                    let arcHeight = height * 0.5
                    let y = groundY - arcHeight * sin(progress * .pi)
                    
                    VStack(spacing: 2) {
                        Circle()
                            .fill(Color.white.opacity(0.8))
                            .frame(width: 8, height: 8)
                        Text(String(format: "%02d:00", hour))
                            .font(.caption2)
                            .foregroundColor(.white.opacity(0.8))
                    }
                    .position(x: x, y: y)
                }
                
                // 当前太阳位置
                if solarPosition.isVisible {
                    let hourProgress = CGFloat((solarPosition.azimuth - 90) / 180.0)
                    let clampedProgress = max(0, min(1, hourProgress))
                    let x = 20 + (width - 40) * clampedProgress
                    let groundY = height * 0.65
                    let arcHeight = height * 0.5
                    let y = groundY - arcHeight * sin(clampedProgress * .pi)
                    
                    VStack(spacing: 4) {
                        Circle()
                            .fill(
                                RadialGradient(
                                    colors: [.yellow, .orange],
                                    center: .center,
                                    startRadius: 0,
                                    endRadius: 12
                                )
                            )
                            .frame(width: 24, height: 24)
                            .shadow(color: .orange.opacity(0.8), radius: 8)
                        
                        Text(solarPosition.elevationString)
                            .font(.caption2)
                            .fontWeight(.bold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 2)
                            .background(.ultraThinMaterial)
                            .cornerRadius(8)
                    }
                    .position(x: x, y: y - 10)
                }
            }
            .frame(height: 200)
        }
        .padding()
        .background(Color.gray.opacity(0.1))
        .cornerRadius(16)
    }
}
