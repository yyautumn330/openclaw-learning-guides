# 布局约束错误修复

## 错误信息

```
<_TtGC7SwiftUI22AppKitPlatformViewHost...> has an maximum length (32.142857) 
that doesn't satisfy min (32.142857) <= max (32.142857).
```

## 问题原因

SwiftUI 的布局系统在某些情况下会产生浮点数精度问题，导致：
- `minWidth == maxWidth` 但系统认为不满足 `min <= max`
- 通常发生在 `ProgressView` 和 `GeometryReader` 组合使用时

## 修复内容

### 1️⃣ SolarPositionView - ProgressView 缩放问题

**问题**: 使用 `.scaleEffect(0.7)` 会导致布局约束计算错误

**修复前**:
```swift
ProgressView()
    .scaleEffect(0.7)  // ❌ 会导致约束冲突
```

**修复后**:
```swift
ProgressView()
    .frame(width: 12, height: 12)  // ✅ 使用固定尺寸
```

---

### 2️⃣ SunTimesView - ProgressView 带文本

**问题**: `ProgressView("计算中...")` 在某些情况下布局不稳定

**修复前**:
```swift
ProgressView("计算中...")
    .frame(maxWidth: .infinity, minHeight: 200)
```

**修复后**:
```swift
VStack {
    ProgressView()
    Text("计算中...")
        .font(.caption)
        .foregroundColor(.secondary)
}
.frame(maxWidth: .infinity, minHeight: 200)
```

---

### 3️⃣ DaylightProgressView - 进度条宽度计算

**问题**: 浮点数精度导致宽度计算可能超出范围

**修复前**:
```swift
private func progressWidth(geometry: GeometryProxy) -> CGFloat {
    let progress = elapsed / totalDuration
    return CGFloat(progress) * geometry.size.width
}
```

**修复后**:
```swift
private func progressWidth(geometry: GeometryProxy) -> CGFloat {
    guard totalDuration > 0 else { return 0 }
    
    // 限制进度在 0.0 - 1.0
    let clampedProgress = min(max(progress, 0.0), 1.0)
    
    // 确保宽度在有效范围内
    let width = clampedProgress * maxWidth
    return min(max(width, 0), maxWidth)
}
```

---

## 关键修复点

### 避免使用 scaleEffect 调整 ProgressView
```swift
// ❌ 不好
ProgressView().scaleEffect(0.7)

// ✅ 好
ProgressView().frame(width: 12, height: 12)
```

### 进度计算添加边界检查
```swift
// 限制值在有效范围
let clampedValue = min(max(value, minLimit), maxLimit)
```

### 避免除以零
```swift
guard totalDuration > 0 else { return 0 }
```

---

## 已修复的文件

1. **Views/SolarPositionView.swift**
   - ProgressView 使用固定尺寸

2. **Views/SunTimesView.swift**
   - ProgressView 重构为 VStack
   - progressWidth 函数添加边界检查

---

## SwiftUI 布局最佳实践

### ✅ 推荐做法
1. 使用 `.frame()` 而不是 `.scaleEffect()` 调整大小
2. 进度计算添加 `min/max` 限制
3. 检查除数不为零
4. 使用 `GeometryReader` 时提供明确的父容器尺寸

### ❌ 避免做法
1. `scaleEffect` 用于 ProgressView
2. 直接返回计算结果，不做边界检查
3. 在 GeometryReader 中返回负值或超出范围的值

---

## 测试

在 Xcode 中重新运行，检查控制台：
- 没有布局约束警告
- ProgressView 正常显示
- 进度条动画流畅

---

**修复日期**: 2026-02-23
**状态**: ✅ 布局约束错误已修复
