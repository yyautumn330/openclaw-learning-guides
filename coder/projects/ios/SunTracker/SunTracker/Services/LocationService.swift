//
//  LocationService.swift
//  SunTracker
//
//  定位服务 - 获取用户地理位置
//

import Foundation
import CoreLocation
import SwiftUI

/// 定位服务管理器
class LocationService: NSObject, ObservableObject {
    private let manager = CLLocationManager()
    
    @Published var authorizationStatus: CLAuthorizationStatus = .notDetermined
    @Published var currentLocation: CLLocation?
    @Published var errorMessage: String?
    @Published var isUpdating = false
    @Published var latitude: Double?
    @Published var longitude: Double?
    
    override init() {
        super.init()
        manager.delegate = self
        manager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    /// 请求定位权限
    func requestPermission() {
        manager.requestWhenInUseAuthorization()
    }
    
    /// 检查是否已授权（平台适配）
    private var isAuthorized: Bool {
        getAuthorizedStatus()
    }
    
    #if os(iOS)
    private func getAuthorizedStatus() -> Bool {
        return authorizationStatus == .authorizedWhenInUse || 
               authorizationStatus == .authorizedAlways
    }
    #else
    private func getAuthorizedStatus() -> Bool {
        return authorizationStatus == .authorizedAlways
    }
    #endif
    
    /// 开始更新位置
    func startUpdating() {
        guard isAuthorized else {
            requestPermission()
            return
        }
        isUpdating = true
        manager.startUpdatingLocation()
    }
    
    /// 停止更新位置
    func stopUpdating() {
        isUpdating = false
        manager.stopUpdatingLocation()
    }
    
    /// 获取当前位置坐标
    var coordinate: CLLocationCoordinate2D? {
        currentLocation?.coordinate
    }
    
    /// 处理授权状态变化（平台适配）
    func handleAuthorizationChange() {
        #if os(iOS)
        handleIOSAuthorizationChange()
        #else
        handleMacAuthorizationChange()
        #endif
    }
    
    #if os(iOS)
    private func handleIOSAuthorizationChange() {
        switch authorizationStatus {
        case .authorizedWhenInUse, .authorizedAlways:
            startUpdating()
        case .denied, .restricted:
            errorMessage = "定位权限被拒绝"
            isUpdating = false
        case .notDetermined:
            break
        @unknown default:
            break
        }
    }
    #else
    private func handleMacAuthorizationChange() {
        // macOS 上检查 authorizedAlways
        if authorizationStatus == .authorizedAlways {
            startUpdating()
        } else if authorizationStatus == .denied || 
                  authorizationStatus == .restricted {
            errorMessage = "定位权限被拒绝"
            isUpdating = false
        }
        // notDetermined 时等待用户授权
    }
    #endif
}

// MARK: - CLLocationManagerDelegate

extension LocationService: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        
        // 安全地更新位置（避免 NSXPC 编码问题）
        DispatchQueue.main.async {
            self.latitude = location.coordinate.latitude
            self.longitude = location.coordinate.longitude
            self.currentLocation = location
            self.errorMessage = nil
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        DispatchQueue.main.async {
            self.errorMessage = error.localizedDescription
        }
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        DispatchQueue.main.async {
            self.authorizationStatus = manager.authorizationStatus
            self.handleAuthorizationChange()
        }
    }
}
