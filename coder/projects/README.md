# 📁 项目目录

按平台分类的移动应用项目集合。

## 目录结构

```
projects/
├── ios/              # 🍎 iOS 项目 (Swift/SwiftUI/ObjC)
├── android/          # 🤖 安卓项目 (Kotlin/Java)
├── harmonyos/        # 🌈 鸿蒙项目 (ArkTS/ArkUI)
└── cross-platform/   # 🌐 跨平台项目 (Flutter/React Native)
```

## 现有项目

### 🌈 HarmonyOS
| 项目 | 状态 | SDK 版本 | 说明 |
|------|------|---------|------|
| [PlaneWarHarmonyOS](harmonyos/PlaneWarHarmonyOS) | ⚠️ 需 DevEco | API 22 | 飞机大战游戏 |

### 🍎 iOS
| 项目 | 状态 | 最低版本 | 说明 |
|------|------|---------|------|
| [SunTracker](ios/SunTracker) | ⚠️ 需 Xcode | iOS 15+ | 太阳轨迹追踪器 |
| [SnakeGame](ios/SnakeGame) | ⚠️ 缺项目文件 | iOS 15+ | 贪吃蛇游戏 (SwiftUI) |

### 🤖 Android
_暂无项目_

### 🌐 Cross-Platform
_暂无项目_

## ⚠️ 编译环境配置

当前环境**未配置完整**，需要安装：

1. **Xcode** (iOS 开发) - 从 Mac App Store 安装
2. **DevEco Studio** (鸿蒙开发) - 从 [华为开发者联盟](https://developer.harmonyos.com/) 下载

详细配置指南见：[COMPILE_STATUS.md](COMPILE_STATUS.md)

## 快速开始

### iOS 项目编译
```bash
cd projects/ios/<项目名>
xcodebuild -scheme <Scheme 名> -configuration Release archive
```

### 鸿蒙项目编译
```bash
cd projects/harmonyos/<项目名>
hvigorw assembleHap
```

### 安卓项目编译
```bash
cd projects/android/<项目名>
./gradlew assembleRelease
```

## 新增项目规范

1. **命名**: 使用 PascalCase (如 `MyAwesomeApp`)
2. **文档**: 每个项目必须包含 `README.md`
3. **构建**: 确保能独立编译
4. **版本控制**: 每个项目独立 Git 仓库

---
*最后更新：2026-03-04*
