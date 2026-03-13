//
//  ContentView.swift
//  SunTracker
//
//  主界面 - 显示太阳位置、时间和追踪模式
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @EnvironmentObject var locationManager: LocationService
    @EnvironmentObject var motionManager: MotionService
    @State private var selectedTab = 0
    @State private var showARMode = false
    
    var body: some View {
        #if os(iOS)
        NavigationView {
            TabView(selection: $selectedTab) {
                // 太阳位置视图
                SolarPositionView()
                    .tabItem {
                        Label("太阳", systemImage: "sun.max.fill")
                    }
                    .tag(0)
                
                // 日出日落时间
                SunTimesView()
                    .tabItem {
                        Label("时间", systemImage: "clock.fill")
                    }
                    .tag(1)
                
                // 3D 太阳可视化
                Solar3DView()
                    .tabItem {
                        Label("3D", systemImage: "cube.box.fill")
                    }
                    .tag(2)
                
                // AR 追踪模式（仅 iOS）
                ARTrackingView()
                    .tabItem {
                        Label("追踪", systemImage: "location.fill.viewfinder")
                    }
                    .tag(3)
            }
            .overlay(
                Group {
                    if locationManager.authorizationStatus == .notDetermined {
                        PermissionPromptView()
                    }
                }
            )
            .onAppear {
                locationManager.startUpdating()
                motionManager.startUpdating()
            }
            .onDisappear {
                locationManager.stopUpdating()
                motionManager.stopUpdating()
            }
            .navigationViewStyle(.stack)
        }
        #else
        // macOS 版本
        TabView(selection: $selectedTab) {
            // 太阳位置视图
            SolarPositionView()
                .tabItem {
                    Label("太阳", systemImage: "sun.max.fill")
                }
                .tag(0)
            
            // 日出日落时间
            SunTimesView()
                .tabItem {
                    Label("时间", systemImage: "clock.fill")
                }
                .tag(1)
            
            // 3D 太阳可视化
            Solar3DView()
                .tabItem {
                    Label("3D", systemImage: "cube.box.fill")
                }
                .tag(2)
        }
        .overlay(
            Group {
                if locationManager.authorizationStatus == .notDetermined {
                    PermissionPromptView()
                }
            }
        )
        .onAppear {
            locationManager.startUpdating()
            motionManager.startUpdating()
        }
        .onDisappear {
            locationManager.stopUpdating()
            motionManager.stopUpdating()
        }
        #endif
    }
}

// MARK: - 权限提示视图

struct PermissionPromptView: View {
    @EnvironmentObject var locationManager: LocationService
    
    var body: some View {
        VStack(spacing: 20) {
            Image(systemName: "location.slash")
                .font(.system(size: 60))
                .foregroundColor(.orange)
            
            Text("需要定位权限")
                .font(.title2.bold())
            
            Text("请允许访问位置信息以计算太阳位置")
                .multilineTextAlignment(.center)
                .foregroundColor(.secondary)
            
            Button("授予权限") {
                locationManager.requestPermission()
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .background(.ultraThinMaterial)
        .cornerRadius(20)
        .padding(40)
    }
}

#Preview {
    ContentView()
        .environmentObject(LocationService())
        .environmentObject(MotionService())
}
