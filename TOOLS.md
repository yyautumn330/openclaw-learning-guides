# TOOLS.md - 开发环境配置

## 本地开发环境

### iOS 开发
- Xcode 15+
- Swift 5.9+
- CocoaPods / SPM

### 鸿蒙开发
- DevEco Studio 4.0+
- ArkTS / ArkUI
- HarmonyOS SDK API 10+

### 安卓开发
- Android Studio Hedgehog+
- Kotlin 1.9+
- Gradle 8.0+

## 常用命令

```bash
# iOS 构建
xcodebuild -scheme MyApp -configuration Release archive

# 鸿蒙构建
hvigorw assembleHap

# 安卓构建
./gradlew assembleRelease
```

## 代码规范

- iOS: SwiftLint
- 鸿蒙: ArkTS Lint
- 安卓: Detekt + Ktlint

---

_环境配置如有变更，及时更新此文件。_
