# 📦 项目依赖清单

## 当前项目依赖状态

### 🌈 PlaneWarHarmonyOS (鸿蒙)
- **依赖管理：** ohpm
- **配置文件：** `oh-package.json5`
- **当前依赖：** 无 (纯原生实现)
- **建议添加：**
  ```json5
  {
    "dependencies": {
      "@ohos/lambdauikit": "^1.0.0",  // UI 组件库
      "@ohos/axios": "^2.0.0"          // HTTP 客户端
    }
  }
  ```

### 🍎 SunTracker (iOS)
- **依赖管理：** SPM (Swift Package Manager)
- **配置文件：** 无 (纯 SwiftUI)
- **当前依赖：** 无
- **建议添加：** (通过 Xcode → File → Add Packages)
  - `swift-composable-architecture` - 架构框架
  - `Kingfisher` - 图片缓存
  - `SwiftUICharts` - 图表组件

### 🍎 SnakeGame (iOS)
- **依赖管理：** SPM
- **配置文件：** 无 (纯 SwiftUI)
- **当前依赖：** 无
- **建议添加：**
  - `SwiftUI-Introspect` - UIKit 互操作
  - `ConfettiSwiftUI` - 特效

---

## 🔧 开发工具安装

### 1. Homebrew (macOS 包管理器)
```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

### 2. CocoaPods (iOS 依赖管理)
```bash
sudo gem install cocoapods
pod setup
```

### 3. Node.js (跨平台工具)
```bash
brew install node
```

### 4. 鸿蒙开发工具
- 安装 DevEco Studio (包含 ohpm)
- 下载地址：https://developer.harmonyos.com/

---

## 📋 安装命令汇总

```bash
# 1. 安装 Homebrew (如果未安装)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. 安装 Node.js
brew install node

# 3. 安装 CocoaPods
sudo gem install cocoapods
pod setup

# 4. 验证安装
node -v
npm -v
pod --version
```

---

*最后更新：2026-03-04*
