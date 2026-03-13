# 🐍 SnakeGame - 项目设置指南

## 问题说明

当前项目**缺少 Xcode 项目文件** (`.xcodeproj` / `.xcworkspace`)，只有 Swift 源文件。

## 解决方案

### 方案 A：用 Xcode 重新创建项目 (推荐)

1. **打开 Xcode**
2. **File → New → Project**
3. **选择 App** (iOS 模板)
4. **配置项目：**
   - Product Name: `SnakeGame`
   - Team: 选择你的开发团队
   - Organization Identifier: `com.yourname`
   - Interface: `SwiftUI`
   - Language: `Swift`
   - Minimum Deployment Target: `iOS 15.0`

5. **保存项目**到当前目录 (`projects/ios/SnakeGame/`)

6. **替换源文件：**
   - 删除 Xcode 自动生成的 `ContentView.swift`
   - 将现有的 `ContentView.swift`、`GameEngine.swift`、`GameModels.swift` 拖入项目
   - 确保 `SnakeGameApp.swift` 作为应用入口

7. **验证编译：**
   ```bash
   cd projects/ios/SnakeGame
   xcodebuild -scheme SnakeGame -configuration Debug build
   ```

### 方案 B：从备份恢复

如果有 `.xcodeproj` 备份，直接复制到项目根目录。

### 方案 C：创建最小项目文件

如果需要，我可以帮你生成一个基本的 `project.pbxproj` 文件。

---

## 项目结构

```
SnakeGame/
├── SnakeGameApp.swift      # 应用入口
├── ContentView.swift       # 主游戏界面
├── GameEngine.swift        # 游戏逻辑引擎
├── GameModels.swift        # 数据模型
├── Info.plist             # 应用配置
├── PROJECT_SETUP.md       # 本文件
└── [需要创建]
    └── SnakeGame.xcodeproj/
        └── project.pbxproj
```

---

## 依赖检查

- ✅ SwiftUI (系统框架)
- ✅ 无第三方依赖

---

*创建时间：2026-03-04*
