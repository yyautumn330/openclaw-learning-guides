# SunTracker 开发指南

## 🚀 快速开始

### 1. 打开项目

```bash
cd /Users/autumn/.openclaw/workspace/SunTracker
open SunTracker.xcodeproj
```

### 2. 选择运行目标

- **iOS**: 选择 iPhone 模拟器或真机
- **macOS**: 选择 Mac

### 3. 运行

点击 ▶️ 或按 `Cmd + R`

---

## 📁 项目结构

```
SunTracker/
├── SunTrackerApp.swift      # App 入口 @main
├── Views/                   # SwiftUI 视图
│   ├── ContentView.swift    # 主界面（Tab 导航）
│   ├── SolarPositionView.swift  # 太阳位置（指南针）
│   ├── SunTimesView.swift   # 日出日落时间
│   └── ARTrackingView.swift # AR 追踪模式
├── Models/                  # 数据模型
│   └── SolarPosition.swift  # 太阳位置数据结构
├── Services/                # 服务层
│   ├── LocationService.swift # GPS 定位
│   └── MotionService.swift   # 陀螺仪/磁力计
└── Utilities/               # 工具类
    └── Astronomy.swift      # 天文计算核心算法
```

---

## 🔧 核心功能说明

### 天文计算 (Astronomy.swift)

使用 **NOAA 太阳位置算法**，精度 < 0.01°

```swift
// 计算太阳位置
let (azimuth, elevation) = Astronomy.calculateSolarPosition(
    date: Date(),
    latitude: 40.0,
    longitude: 116.0
)

// 计算日出日落
let (sunrise, sunset) = Astronomy.calculateSunTimes(
    date: Date(),
    latitude: 40.0,
    longitude: 116.0
)
```

### 定位服务 (LocationService.swift)

封装 `CLLocationManager`，自动处理权限请求

```swift
@EnvironmentObject var locationManager: LocationService

// 获取坐标
let lat = locationManager.latitude
let lon = locationManager.longitude
```

### 运动传感器 (MotionService.swift)

封装 `CMMotionManager`，提供设备朝向

```swift
@EnvironmentObject var motionManager: MotionService

// 获取设备朝向（0-360°）
let heading = motionManager.deviceMotion?.heading
```

---

## 🎨 UI 组件

### 指南针视图

显示太阳方位，橙色圆点表示太阳位置

### 日出日落卡片

- 日出时间（黄色渐变）
- 日落时间（橙色渐变）
- 白天时长
- 黄金时刻提示

### AR 追踪视图

- 设备朝向实时追踪
- 太阳方向箭头指引
- 仰角进度条

---

## 📱 平台适配

### iOS
- 支持 iPhone 和 iPad
- 可使用 ARKit 增强现实（需额外开发）
- 需要真机测试陀螺仪

### macOS
- 支持 MacBook 和 Mac Desktop
- 陀螺仪仅限 MacBook Pro/Air
- 桌面端主要使用指南针模式

---

## 🔐 权限配置

在 `Info.plist` 中已配置：

```xml
<key>NSLocationWhenInUseUsageDescription</key>
<string>需要访问您的位置以计算当地的太阳位置和日出日落时间</string>

<key>NSMotionUsageDescription</key>
<string>需要访问设备运动传感器以实现太阳追踪功能</string>
```

---

## 🧪 测试建议

### 单元测试

```swift
func testSolarPositionCalculation() {
    let (azimuth, elevation) = Astronomy.calculateSolarPosition(
        date: Date(),
        latitude: 40.0,
        longitude: 116.0
    )
    
    XCTAssertGreaterThanOrEqual(azimuth, 0)
    XCTAssertLessThanOrEqual(azimuth, 360)
}
```

### 真机测试

1. 在真机上测试 GPS 定位
2. 测试陀螺仪响应
3. 户外测试太阳方向准确性

---

## 🚧 后续优化

### 功能增强
- [ ] ARKit 真实相机叠加
- [ ] 太阳轨迹 3D 可视化
- [ ] 天气数据集成（云层遮挡）
- [ ] 拍照模式（带太阳位置水印）
- [ ] 摄影计划（最佳拍摄时间提醒）

### 性能优化
- [ ] 后台位置更新优化
- [ ] 传感器数据滤波
- [ ] 电量优化

### UI/UX
- [ ] 深色模式完善
- [ ] 小组件（Widget）
- [ ] Apple Watch 支持

---

## 📦 发布准备

### App Store 提交

1. 配置开发者证书
2. 设置 Bundle ID
3. 准备截图和预览
4. 填写隐私政策

### 截图清单
- 主界面（太阳位置）
- 日出日落时间
- AR 追踪模式
- 指南针视图

---

## 🐛 常见问题

### Q: 定位权限被拒绝
A: 在设置中手动授予权限，或重置位置权限

### Q: 陀螺仪数据不准确
A: 执行 8 字校准，远离磁场干扰

### Q: 太阳位置偏差大
A: 检查 GPS 定位精度，确保经纬度准确

---

## 📚 参考资料

- [NOAA Solar Calculator](https://gml.noaa.gov/grad/solcalc/)
- [Core Location Framework](https://developer.apple.com/documentation/corelocation)
- [Core Motion Framework](https://developer.apple.com/documentation/coremotion)
- [SwiftUI Documentation](https://developer.apple.com/documentation/swiftui)

---

**🌅 Happy Coding & Sun Tracking!**
