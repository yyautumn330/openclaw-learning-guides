//
//  MotionService.swift
//  SunTracker
//
//  运动传感器服务 - 陀螺仪 + 磁力计
//

import Foundation
import SwiftUI
import Combine

#if os(iOS)
import CoreMotion
#endif

/// 设备运动数据
struct DeviceMotion {
    var heading: Double      // 设备朝向 (0-360°)
    var pitch: Double        // 俯仰角 (-90-90°)
    var roll: Double         // 翻滚角 (-180-180°)
    var timestamp: Date
}

/// 运动传感器管理器
class MotionService: ObservableObject {
    #if os(iOS)
    private let motionManager = CMMotionManager()
    #endif
    
    private var updateTimer: Timer?
    
    @Published var deviceMotion: DeviceMotion?
    @Published var isAvailable = false
    @Published var errorMessage: String?
    @Published var isUpdating = false
    
    /// 校准后的磁北朝向（考虑磁偏角）
    @Published var trueHeading: Double = 0
    
    init() {
        checkAvailability()
    }
    
    /// 检查传感器可用性
    private func checkAvailability() {
        #if os(iOS)
        isAvailable = motionManager.isDeviceMotionAvailable
        if !isAvailable {
            errorMessage = "设备不支持运动传感器"
        }
        #else
        // macOS 不支持 Core Motion
        isAvailable = false
        errorMessage = "macOS 不支持运动传感器，请使用指南针模式"
        #endif
    }
    
    /// 开始更新传感器数据
    func startUpdating() {
        guard !isUpdating else { return }
        
        #if os(iOS)
        guard isAvailable else { return }
        
        isUpdating = true
        motionManager.deviceMotionUpdateInterval = 0.1  // 10Hz
        
        motionManager.startDeviceMotionUpdates(using: .xArbitraryZVertical) { [weak self] motion, error in
            guard let self = self else { return }
            
            if let error = error {
                self.errorMessage = error.localizedDescription
                return
            }
            
            guard let motion = motion else { return }
            
            DispatchQueue.main.async {
                // 获取设备朝向
                var heading = motion.heading * 180 / .pi
                if heading < 0 { heading += 360 }
                
                self.deviceMotion = DeviceMotion(
                    heading: heading,
                    pitch: motion.attitude.pitch * 180 / .pi,
                    roll: motion.attitude.roll * 180 / .pi,
                    timestamp: Date()
                )
            }
        }
        #else
        // macOS 模式下不启动传感器
        isUpdating = false
        #endif
    }
    
    /// 停止更新传感器数据
    func stopUpdating() {
        isUpdating = false
        #if os(iOS)
        motionManager.stopDeviceMotionUpdates()
        #endif
    }
    
    /// 校准磁力计（画 8 字）
    func calibrate() {
        #if os(iOS)
        // Core Motion 会自动校准，这里可以添加 UI 提示
        motionManager.startDeviceMotionUpdates()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) { [weak self] in
            self?.motionManager.stopDeviceMotionUpdates()
        }
        #else
        // macOS 不支持校准
        #endif
    }
}
