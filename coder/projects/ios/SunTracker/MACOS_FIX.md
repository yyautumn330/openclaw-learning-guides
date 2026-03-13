# macOS 编译错误修复指南

## 问题：`'authorizedWhenInUse' is unavailable in macOS`

### 原因
`CLAuthorizationStatus.authorizedWhenInUse` 枚举值在 macOS 上不可用。macOS 只有 `.authorizedAlways`。

### 解决方案

已将平台特定代码分离到独立的函数中，使用 `#if os(iOS)` 条件编译：

```swift
#if os(iOS)
private func handleIOSAuthorizationChange() {
    switch authorizationStatus {
    case .authorizedWhenInUse, .authorizedAlways:
        startUpdating()
    // ...
    }
}
#else
private func handleMacAuthorizationChange() {
    if authorizationStatus == .authorizedAlways {
        startUpdating()
    }
    // ...
}
#endif
```

---

## 所有已修复的错误

| 错误 | 状态 | 修复方式 |
|------|------|----------|
| `MotionMotionService` | ✅ | 拼写修正 |
| `CMMotionManager` | ✅ | `#if os(iOS)` |
| `navigationBarTitleDisplayMode` | ✅ | `#if os(iOS)` |
| `refreshable` | ✅ | `#if os(iOS)` |
| `authorizedWhenInUse` | ✅ | 平台分离函数 |

---

## 在 Xcode 中重新编译

### 方法 1：清理构建缓存
```bash
cd /Users/autumn/.openclaw/workspace/SunTracker
# 在 Xcode 中：Product → Clean Build Folder (Cmd+Shift+K)
```

### 方法 2：删除 DerivedData
```bash
rm -rf ~/Library/Developer/Xcode/DerivedData/SunTracker-*
```

### 方法 3：重新打开项目
```bash
open SunTracker.xcodeproj
```

---

## 验证步骤

1. **打开项目**
   ```bash
   open -a Xcode SunTracker.xcodeproj
   ```

2. **选择 macOS 目标**
   - 在 Scheme 选择器中选择 "My Mac"

3. **编译**
   - 按 `Cmd + B` 编译
   - 或点击 ▶️ 运行

4. **检查错误**
   - 应该没有编译错误
   - 可能有警告（可以忽略）

---

## macOS 运行效果

### 可用功能 ✅
- 太阳位置计算
- 日出日落时间
- 黄金时刻
- 指南针显示
- 叠加模式

### 不可用功能 ❌
- AR 模式（Tab 中隐藏）
- 陀螺仪追踪
- 下拉刷新
- 磁力计校准

### 提示信息
在 macOS 上运行时，MotionService 会显示：
> "macOS 不支持运动传感器，请使用指南针模式"

---

## 如果还有错误

### 检查部署目标
在 Xcode 中：
1. 选择项目文件
2. 选择 "SunTracker" target
3. 检查 "Deployment Target"
   - iOS: 16.0+
   - macOS: 13.0+

### 清理缓存
```bash
# 删除 DerivedData
rm -rf ~/Library/Developer/Xcode/DerivedData

# 重新打开 Xcode
open -a Xcode
```

### 检查条件编译
确保所有 iOS 特定代码都用 `#if os(iOS)` 包裹：
```bash
grep -rn "authorizedWhenInUse" SunTracker/
# 应该只在 #if os(iOS) 块内出现
```

---

## 联系

如果还有问题，检查：
1. Xcode 版本（建议 15.0+）
2. macOS 版本（建议 13.0+）
3. Swift 版本（建议 5.9+）

---

**最后更新**: 2026-02-23
**修复文件**: `Services/LocationService.swift`
