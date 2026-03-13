# SunTracker - 太阳轨迹跟踪 App

🌅 追踪太阳位置、日出日落时间，结合陀螺仪实现 AR 太阳定位

## 功能特性

- ✅ 实时太阳位置计算（方位角 + 仰角）
- ✅ 日出日落时间预测
- ✅ 陀螺仪/AR 太阳追踪模式
- ✅ 基于 GPS 的精准定位
- ✅ iOS + macOS 双平台支持
- ✅ 黄金时刻/蓝色时刻提示

## 技术栈

- **语言**: Swift 5.9+
- **框架**: SwiftUI, Core Motion, Core Location, ARKit (iOS)
- **最低版本**: iOS 16.0+, macOS 13.0+

## 项目结构

```
SunTracker/
├── SunTrackerApp.swift      # App 入口
├── Models/
│   ├── SolarPosition.swift  # 太阳位置计算
│   └── SunEvents.swift      # 日出日落计算
├── Views/
│   ├── ContentView.swift    # 主界面
│   ├── CompassView.swift    # 指南针视图
│   └── ARView.swift         # AR 追踪视图
├── Services/
│   ├── LocationService.swift # 定位服务
│   └── MotionService.swift   # 陀螺仪服务
└── Utilities/
    └── Astronomy.swift       # 天文算法
```

## 运行方式

### iOS
```bash
cd SunTracker
open SunTracker.xcodeproj
# 选择 iOS 设备或模拟器运行
```

### macOS
```bash
cd SunTracker
open SunTracker.xcodeproj
# 选择 Mac 运行
```

## 天文算法

使用 NOAA 太阳位置算法，精度 < 0.01°

## 许可证

MIT License
