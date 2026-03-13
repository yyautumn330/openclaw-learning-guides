# 📱 快速安装 SunTracker 到 iPhone

## 🎯 最简单方法（推荐）

### 步骤 1：打开 Xcode 项目

在终端运行：
```bash
open /Users/autumn/.openclaw/workspace/SunTracker/SunTracker.xcodeproj
```

或手动打开：
1. 打开 **Xcode**
2. 菜单 `File` → `Open...`
3. 选择 `SunTracker.xcodeproj`

---

### 步骤 2：连接 iPhone

1. 用数据线连接 iPhone 到 Mac
2. 在 iPhone 上点击"信任此电脑"
3. 输入 iPhone 密码确认

---

### 步骤 3：配置签名

在 Xcode 中：

1. **左侧选择** "SunTracker" 项目文件
2. **中间选择** "SunTracker" Target
3. **顶部选择** "Signing & Capabilities" 标签

4. **配置**:
   ```
   Automatically manage signing: ✅ 勾选
   Team: 选择你的 Apple ID
         (如果没有，点"Add an Account..."登录)
   Bundle Identifier: com.yourname.suntracker
                      (改成唯一的，yourname 替换为你的名字)
   ```

---

### 步骤 4：选择 iPhone

在 Xcode 顶部工具栏：
1. 点击设备选择器（显示 "My Mac" 或模拟器）
2. 选择你的 iPhone（会显示名称和型号）

---

### 步骤 5：运行安装

点击 ▶️ 运行按钮（或按 `Cmd + R`）

Xcode 会：
1. 编译项目
2. 自动签名
3. 安装到 iPhone

---

### 步骤 6：在 iPhone 上信任

首次安装需要信任开发者：

1. 打开 iPhone **设置**
2. **通用** → **VPN 与设备管理**
3. 找到你的 **Apple ID 邮箱**
4. 点击 **信任 "[你的邮箱]"**
5. 确认信任

---

### 步骤 7：打开应用

在 iPhone 上找到 SunTracker 图标，点击打开！

---

## 📦 导出 IPA 文件（分享给他人）

### 方法 A：Xcode 手动导出

1. **选择 "Any iOS Device"**
   - 顶部设备选择器 → "Any iOS Device (arm64)"

2. **创建 Archive**
   - 菜单 `Product` → `Archive`
   - 等待编译完成

3. **导出 IPA**
   - Archive 完成后自动打开 Organizer
   - 点击 `Distribute App`
   - 选择 `Development`
   - 选择签名证书
   - 勾选 `Export to local location`
   - 选择保存到桌面

### 方法 B：使用命令行（需要密码）

```bash
cd /Users/autumn/.openclaw/workspace/SunTracker

# 切换到完整 Xcode（需要输入密码）
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

# 清理
xcodebuild clean

# Archive
xcodebuild -scheme SunTracker \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath ./build/SunTracker.xcarchive \
  archive

# 导出 IPA
xcodebuild -exportArchive \
  -archivePath ./build/SunTracker.xcarchive \
  -exportPath ./build/ \
  -exportOptionsPlist ExportOptions.plist

# 复制到桌面
cp ./build/SunTracker.ipa ~/Desktop/
```

---

## 🔧 安装 IPA 到 iPhone

### 使用 AltStore（推荐）

1. **下载 AltStore**
   - 电脑：https://altstore.io
   - iPhone：从 App Store 下载 "AltStore"

2. **安装 AltServer**
   - 在 Mac 上安装 AltServer
   - 连接 iPhone

3. **安装 IPA**
   - 菜单 AltServer → Install AltStore → 选择 iPhone
   - 或拖拽 IPA 到 AltServer 图标

### 使用 Sideloadly

1. 下载：https://sideloadly.io
2. 打开 Sideloadly
3. 拖入 IPA 文件
4. 输入 Apple ID
5. 点击 Start

### 使用爱思助手（国内）

1. 下载爱思助手
2. 连接 iPhone
3. 应用游戏 → 导入 IPA
4. 安装

---

## ⚠️ 重要提示

### 免费 Apple ID 限制

- ✅ 可以安装到自己设备
- ✅ 可以导出 IPA
- ❌ 只能安装到注册的设备
- ❌ 7 天后过期（需重新安装）
- ❌ 最多 3 个活跃应用

### 付费开发者账号 ($99/年)

- ✅ 可以分享给任何人
- ✅ 1 年有效期
- ✅ 可以上架 App Store
- ✅ 最多 100 台测试设备

---

## 🐛 常见问题

### Q: Xcode 说 "No signing certificate"
**A**: 
1. Xcode → Settings → Accounts
2. 添加你的 Apple ID
3. 重新选择 Team

### Q: "No devices found"
**A**:
1. 确保 iPhone 已连接
2. 在 iPhone 上信任此电脑
3. 重启 Xcode

### Q: 安装后无法打开
**A**:
1. 设置 → 通用 → VPN 与设备管理
2. 信任你的 Apple ID

### Q: 7 天后显示 "已过期"
**A**:
1. 重新编译安装即可
2. 或购买付费开发者账号

### Q: Bundle ID 已被使用
**A**:
改成唯一的，如：
- `com.autumn.suntracker`
- `com.yourname.suntracker2024`

---

## 📞 需要帮助？

如果遇到问题：
1. 检查 Xcode 版本（建议 15.0+）
2. 检查 iOS 版本（建议 16.0+）
3. 重启 Xcode 和 iPhone

---

**祝你使用愉快！** 🌅🦞
