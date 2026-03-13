//
//  SunTrackerApp.swift
//  SunTracker
//
//  太阳轨迹跟踪 App - 结合陀螺仪的 AR 太阳定位
//

import SwiftUI

@main
struct SunTrackerApp: App {
    @StateObject private var locationManager = LocationService()
    @StateObject private var motionManager = MotionService()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(locationManager)
                .environmentObject(motionManager)
        }
        #if os(macOS)
        .commands {
            CommandGroup(replacing: .newItem) {}
        }
        #endif
    }
}
