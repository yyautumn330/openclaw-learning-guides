# 时区修复说明

## 问题

**用户报告**: 东 8 区（北京时间），日出日落时间可能不正确

## 原因分析

原始代码的问题：
1. 使用 `Calendar.current` 获取日期组件，这会受到本地时区影响
2. 天文计算应该基于 **UTC 时间**（世界协调时）
3. 经度已经用于调整本地恒星时，但时间计算仍需使用 UTC

## 修复方案

### 1. 太阳位置计算
```swift
// 修复前：使用本地时区
let components = Calendar.current.dateComponents(...)

// 修复后：使用 UTC 时区
var utcCalendar = Calendar(identifier: .gregorian)
utcCalendar.timeZone = TimeZone(identifier: "UTC")!
let components = utcCalendar.dateComponents(...)
```

### 2. 日出日落计算
```swift
// 计算基于 UTC 的时间
let sunriseMinutesUTC = 720 - 4 * (longitude + ha) - eqtime

// 构建 UTC 时间
var sunriseComponents = components  // UTC 日期组件
sunriseComponents.hour = sunriseHour
sunriseComponents.minute = sunriseMinute

// 返回 UTC Date（显示时会自动转换为本地时间）
let sunriseUTC = utcCalendar.date(from: sunriseComponents)
return sunriseUTC  // Date 对象，显示时根据系统时区自动转换
```

## 时区原理

### 经度 vs 时区

- **经度**: 决定本地恒星时（Local Sidereal Time）
  - 公式：`lst = gmst + longitude`
  - 这是天文计算的核心

- **时区**: 决定时间的显示
  - 东 8 区（北京）= UTC+8
  - 由系统自动处理

### 计算流程

```
用户输入（本地时间）
    ↓
转换为 UTC（用于天文计算）
    ↓
计算儒略日、太阳位置等
    ↓
计算日出日落（UTC 分钟）
    ↓
构建 UTC Date 对象
    ↓
显示时自动转换为本地时间 ✅
```

## 验证方法

### 命令行测试
```bash
cd /Users/autumn/.openclaw/workspace/SunTrackerCLI

# 北京（东 8 区）
swift run SunTrackerCLI 39.9042 116.4074

# 上海（东 8 区）
swift run SunTrackerCLI 31.2304 121.4737

# 纽约（西 5 区）
swift run SunTrackerCLI 40.7128 -74.0060
```

### 预期结果（北京，2 月 23 日）
- 日出：约 06:50（东 8 区时间）
- 日落：约 18:00（东 8 区时间）

### 交叉验证
对比权威数据：
- [时间网 - 北京日出日落](http://www.time.ac.cn/)
- [TimeAndDate - Beijing](https://www.timeanddate.com/sun/china/beijing)

## 修复文件

- `Utilities/Astronomy.swift` - 天文计算核心
  - `calculateSolarPosition()` - 使用 UTC
  - `calculateSunTimes()` - 使用 UTC，返回本地时间

## 注意事项

### ✅ 正确做法
- 天文计算使用 UTC
- 显示使用系统本地时区
- 经度用于恒星时计算

### ❌ 错误做法
- 直接用本地时间计算儒略日
- 手动加减时区偏移
- 忽略经度对恒星时的影响

## 测试清单

- [x] 北京（东 8 区）日出日落正确
- [x] 太阳位置计算正确
- [x] 不同经度测试通过
- [ ] 跨时区测试（纽约、伦敦等）
- [ ] 极昼极夜地区测试

---

**修复日期**: 2026-02-23
**影响范围**: 所有日出日落时间计算
**兼容性**: 不影响现有功能
