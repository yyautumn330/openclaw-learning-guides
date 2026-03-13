# 符号和编码问题修复

## 错误信息

```
No symbol named 'compass' found in system symbol set
*** -[NSXPCDecoder validateAllowedClass:forKey:]: NSSecureCoding allowed classes list contains [NSObject class]
```

## 问题分析

### 1. SF Symbols 名称问题

某些 SF Symbols 名称在不同 macOS 版本上可能不存在或不兼容。

### 2. NSXPC 编码问题

`CLLocationManager` 通过 XPC 通信，直接发布 `CLLocation` 对象可能导致编码问题。

## 修复内容

### 1. 替换不兼容的符号

| 原符号 | 新符号 | 文件 |
|--------|--------|------|
| `scope` | `location.fill.viewfinder` | ContentView.swift |
| `compass` (按钮) | `location.north.line` | ARTrackingView.swift |

**保留的符号** (已验证兼容):
- `sun.max.fill` ✅
- `clock.fill` ✅
- `compass` (数据卡片) ✅
- `location.north` ✅
- `angle` ✅
- `eye` ✅

### 2. 修复 LocationService 编码问题

**问题**: 直接发布 `CLLocation` 对象可能触发 NSXPC 安全问题

**修复**:
```swift
// 添加单独的 Double 属性
@Published var latitude: Double?
@Published var longitude: Double?

// 在 delegate 中安全更新
func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    guard let location = locations.last else { return }
    
    DispatchQueue.main.async {
        self.latitude = location.coordinate.latitude
        self.longitude = location.coordinate.longitude
        self.currentLocation = location
    }
}
```

## 已修复的文件

1. **ContentView.swift**
   - `scope` → `location.fill.viewfinder`

2. **ARTrackingView.swift**
   - `compass` (按钮) → `location.north.line`

3. **LocationService.swift**
   - 添加 `latitude` 和 `longitude` 属性
   - 使用 `DispatchQueue.main.async` 安全更新
   - 避免 NSXPC 编码问题

## SF Symbols 兼容性

### 跨平台符号（推荐）
```swift
// 导航
"location.fill"
"location.north.line"
"location.fill.viewfinder"

// 时间
"clock.fill"
"calendar"

// 太阳
"sun.max.fill"
"sunrise.fill"
"sunset.fill"

// 通用
"eye"
"angle"
"compass"
```

### 可能有问题的符号
```swift
"scope"        // macOS 可能不存在
"radar"        // 某些版本没有
"globe"        // 可能有变体
```

## 测试

在 Xcode 中重新运行：
```bash
open /Users/autumn/.openclaw/workspace/SunTracker/SunTracker.xcodeproj
```

选择 iPhone 或 Mac，点击运行，检查：
1. 没有符号错误
2. 没有 NSXPC 警告
3. 定位功能正常

---

**修复日期**: 2026-02-23
**影响文件**: 
- Views/ContentView.swift
- Views/ARTrackingView.swift
- Services/LocationService.swift
