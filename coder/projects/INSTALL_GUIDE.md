# 🛠️ 基础包安装指南

## ✅ 已安装的工具

| 工具 | 版本 | 状态 |
|------|------|------|
| Homebrew | 5.0.16 | ✅ |
| Node.js | v25.6.1 | ✅ |
| npm | (随 Node.js) | ✅ |
| **skills CLI** | v1.4.3 | ✅ |

---

## ✅ 已安装的 Agent Skills

| 技能 | 用途 | 状态 |
|------|------|------|
| swiftui-expert-skill | SwiftUI 专家 | ✅ |
| swift-concurrency | Swift 并发 | ✅ |
| mobile-ios-design | iOS 设计 | ✅ |
| mobile-android-design | 安卓设计 | ✅ |
| harmonyos-app | 鸿蒙开发 | ✅ |

详见：[SKILLS_INSTALLED.md](SKILLS_INSTALLED.md)

## ⚠️ 需要手动安装的工具

### 1. CocoaPods (iOS 依赖管理)

**需要 sudo 权限，请手动执行：**

```bash
sudo gem install cocoapods
pod setup
```

**或者使用 Homebrew (推荐，无需 sudo)：**
```bash
brew install cocoapods
pod setup
```

**验证安装：**
```bash
pod --version
```

---

### 2. Xcode Command Line Tools

**如果未安装，执行：**
```bash
xcode-select --install
```

**然后设置正确的 Xcode 路径：**
```bash
# 查看 Xcode 安装路径
ls -d /Applications/Xcode*.app

# 设置路径 (根据实际情况调整)
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# 验证
xcode-select -p
```

---

### 3. DevEco Studio (鸿蒙开发)

**手动下载安装：**
1. 访问：https://developer.harmonyos.com/
2. 下载 DevEco Studio
3. 安装后配置环境变量：

```bash
# 添加到 ~/.zshrc
export PATH="$PATH:/Applications/DevEco-Studio.app/Contents/tools/hvigorw"

# 或临时使用
alias hvigorw="/Applications/DevEco-Studio.app/Contents/tools/hvigorw/hvigorw"
```

---

### 4. 其他推荐工具

```bash
# Git LFS (大文件管理)
brew install git-lfs

# SwiftLint (代码规范)
brew install swiftlint

# Watchman (文件监听)
brew install watchman

# jq (JSON 处理)
brew install jq
```

---

## 📋 快速安装脚本

复制以下命令到终端执行：

```bash
#!/bin/bash

echo "🔧 开始安装基础开发工具..."

# 1. CocoaPods
echo "📦 安装 CocoaPods..."
brew install cocoapods
pod setup

# 2. 开发工具
echo "📦 安装辅助工具..."
brew install git-lfs swiftlint watchman jq

# 3. 验证
echo "✅ 验证安装..."
pod --version
git-lfs --version
swiftlint version

echo "🎉 安装完成！"
```

---

## 🎯 下一步

安装完成后执行：

```bash
# iOS 项目
cd projects/ios/SunTracker
pod install  # 如果有 Podfile

# 鸿蒙项目
cd projects/harmonyos/PlaneWarHarmonyOS
hvigorw assembleHap
```

---

*创建时间：2026-03-04*
