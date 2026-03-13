//
//  ARTrackingView.swift
//  SunTracker
//
//  AR 太阳追踪视图 - 使用陀螺仪实时追踪太阳
//

import SwiftUI
import CoreLocation

struct ARTrackingView: View {
    @EnvironmentObject var locationManager: LocationService
    @EnvironmentObject var motionManager: MotionService
    @State private var solarPosition: SolarPosition?
    @State private var showCalibration = false
    @State private var trackingMode: TrackingMode = .compass
    
    enum TrackingMode: CaseIterable {
        case compass
        #if os(iOS)
        case ar
        #endif
        case overlay
        
        #if os(macOS)
        // macOS 只显示两个选项
        static var allCases: [TrackingMode] = [.compass, .overlay]
        #endif
    }
    
    var body: some View {
        ZStack {
            // 背景 - 相机预览或天空渐变
            switch trackingMode {
            case .compass, .overlay:
                SkyBackgroundView()
            #if os(iOS)
            case .ar:
                // 这里可以集成 ARKit
                SkyBackgroundView()
                    .overlay(Text("AR 模式需要 ARKit 支持").font(.caption))
            #endif
            }
            
            VStack {
                // 顶部控制栏
                TopControlBarView(trackingMode: $trackingMode, showCalibration: $showCalibration)
                
                Spacer()
                
                // 追踪指示器
                if let position = solarPosition {
                    TrackingIndicatorView(
                        solarPosition: position,
                        deviceHeading: motionManager.deviceMotion?.heading ?? 0
                    )
                }
                
                // 底部数据面板
                BottomDataPanelView(solarPosition: solarPosition, motion: motionManager.deviceMotion)
            }
            .padding()
        }
        .onAppear {
            startTracking()
        }
        .alert("校准指南针", isPresented: $showCalibration) {
            Button("确定") { }
        } message: {
            #if os(iOS)
            Text("请在空中画 8 字移动设备以校准磁力计")
            #else
            Text("macOS 不支持磁力计校准")
            #endif
        }
    }
    
    private func startTracking() {
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { _ in
            updateSolarPosition()
        }
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

// MARK: - 天空背景视图

struct SkyBackgroundView: View {
    var body: some View {
        GeometryReader { geometry in
            let height = geometry.size.height
            let sunY = height * 0.3
            
            // 天空渐变
            LinearGradient(
                gradient: Gradient(colors: [
                    Color(red: 0.1, green: 0.4, blue: 0.8),  // 深蓝
                    Color(red: 0.4, green: 0.7, blue: 1.0),  // 浅蓝
                    Color(red: 1.0, green: 0.9, blue: 0.7)   // 地平线
                ]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()
        }
    }
}

// MARK: - 顶部控制栏

struct TopControlBarView: View {
    @Binding var trackingMode: ARTrackingView.TrackingMode
    @Binding var showCalibration: Bool
    
    var body: some View {
        HStack {
            Picker("", selection: $trackingMode) {
                Text("指南针").tag(ARTrackingView.TrackingMode.compass)
                #if os(iOS)
                Text("AR").tag(ARTrackingView.TrackingMode.ar)
                #endif
                Text("叠加").tag(ARTrackingView.TrackingMode.overlay)
            }
            .pickerStyle(.segmented)
            
            Spacer()
            
            Button(action: { showCalibration = true }) {
                Image(systemName: "location.north.line")
                    .font(.title2)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

// MARK: - 追踪指示器

struct TrackingIndicatorView: View {
    let solarPosition: SolarPosition
    let deviceHeading: Double
    
    var body: some View {
        VStack(spacing: 20) {
            // 水平方向指示
            HStack {
                Spacer()
                
                // 太阳方向箭头
                let angleDiff = solarPosition.azimuth - deviceHeading
                let normalizedAngle = normalizeAngle(angleDiff)
                
                VStack {
                    Image(systemName: "arrow.up")
                        .font(.title)
                        .rotationEffect(.degrees(normalizedAngle))
                        .foregroundColor(.orange)
                    
                    Text("转 \(String(format: "%.0f", abs(normalizedAngle)))°")
                        .font(.caption)
                }
                
                Spacer()
            }
            
            // 仰角指示
            VStack(spacing: 8) {
                Text("仰角")
                    .font(.caption)
                    .foregroundColor(.white)
                
                GeometryReader { geometry in
                    ZStack(alignment: .leading) {
                        // 背景
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.white.opacity(0.3))
                            .frame(height: 20)
                        
                        // 太阳位置
                        let progress = (solarPosition.elevation + 90) / 180
                        Circle()
                            .fill(Color.orange.gradient)
                            .frame(width: 30, height: 30)
                            .position(x: CGFloat(progress) * geometry.size.width, y: 10)
                            .shadow(radius: 4)
                    }
                }
                .frame(height: 20)
                
                HStack {
                    Text("-90°")
                        .font(.caption2)
                    Spacer()
                    Text("0°")
                        .font(.caption2)
                    Spacer()
                    Text("90°")
                        .font(.caption2)
                }
                .foregroundColor(.white)
            }
            .padding()
            .background(.ultraThinMaterial)
            .cornerRadius(16)
        }
    }
    
    private func normalizeAngle(_ angle: Double) -> Double {
        var normalized = angle
        while normalized > 180 { normalized -= 360 }
        while normalized < -180 { normalized += 360 }
        return normalized
    }
}

// MARK: - 底部数据面板

struct BottomDataPanelView: View {
    let solarPosition: SolarPosition?
    let motion: DeviceMotion?
    
    var body: some View {
        VStack(spacing: 12) {
            HStack(spacing: 24) {
                // 太阳方位
                VStack {
                    Text("太阳方位")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(solarPosition?.azimuthString ?? "—")
                        .font(.title3.bold())
                }
                
                // 太阳仰角
                VStack {
                    Text("太阳仰角")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(solarPosition?.elevationString ?? "—")
                        .font(.title3.bold())
                }
                
                // 设备朝向
                VStack {
                    Text("设备朝向")
                        .font(.caption2)
                        .foregroundColor(.secondary)
                    Text(motion != nil ? String(format: "%.0f°", motion!.heading) : "—")
                        .font(.title3.bold())
                }
            }
            
            // 状态指示
            HStack {
                Circle()
                    .fill(solarPosition?.isVisible ?? false ? Color.green : Color.gray)
                    .frame(width: 8, height: 8)
                
                Text(solarPosition?.isVisible ?? false ? "太阳可见" : "太阳在地平线下")
                    .font(.caption)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(16)
    }
}

#Preview {
    ARTrackingView()
        .environmentObject(LocationService())
        .environmentObject(MotionService())
}
