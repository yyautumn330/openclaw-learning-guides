# 修复重复声明错误

## 错误信息

```
Invalid redeclaration of 'latitude'
Invalid redeclaration of 'longitude'
```

## 问题原因

在 `LocationService.swift` 中同时存在：

1. **新添加的 @Published 属性**（第 20-21 行）
   ```swift
   @Published var latitude: Double?
   @Published var longitude: Double?
   ```

2. **原有的计算属性**（已删除）
   ```swift
   var latitude: Double? {
       currentLocation?.coordinate.latitude
   }
   
   var longitude: Double? {
       currentLocation?.coordinate.longitude
   }
   ```

Swift 不允许同一作用域内有两个同名的属性，即使是不同类型。

## 修复方案

**删除计算属性**，只保留 `@Published` 属性。

### 修复前 ❌
```swift
class LocationService: NSObject, ObservableObject {
    @Published var latitude: Double?      // ← 新添加
    @Published var longitude: Double?     // ← 新添加
    
    // ... 其他代码
    
    var latitude: Double? {               // ← 原有（重复！）
        currentLocation?.coordinate.latitude
    }
    
    var longitude: Double? {              // ← 原有（重复！）
        currentLocation?.coordinate.longitude
    }
}
```

### 修复后 ✅
```swift
class LocationService: NSObject, ObservableObject {
    @Published var latitude: Double?      // ← 保留
    @Published var longitude: Double?     // ← 保留
    
    // ... 其他代码（删除了计算属性）
}
```

## 优势

使用 `@Published` 属性的好处：
1. **自动通知 UI 更新** - SwiftUI 会自动刷新
2. **线程安全** - 在 `DispatchQueue.main.async` 中更新
3. **避免重复计算** - 直接存储值，不需要每次访问都解包 `currentLocation`

## 使用方式

在视图中：
```swift
@EnvironmentObject var locationManager: LocationService

// 直接使用
if let lat = locationManager.latitude,
   let lon = locationManager.longitude {
    Text("位置：\(lat), \(lon)")
}
```

## 已修复的文件

- **Services/LocationService.swift**
  - 删除了重复的计算属性
  - 保留 `@Published` 属性

---

**修复日期**: 2026-02-23
**编译状态**: ✅ 应该可以正常编译了
