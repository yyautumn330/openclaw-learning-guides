# 构建 iPhone 可安装的 IPA 文件

## ⚠️ 重要说明

要在 iPhone 上安装应用，你需要：

1. **Apple 开发者账号**（免费或付费）
   - 免费账号：只能安装到自己设备，7 天过期
   - 付费账号（$99/年）：可以分享给他人

2. **设备 UDID 注册**（免费账号必需）
   - 在 https://developer.apple.com/account 注册设备

---

## 方法 1：Xcode 直接安装到 iPhone（最简单）

### 步骤

1. **连接 iPhone 到 Mac**
   ```bash
   # 确保手机已连接并信任此电脑
   ```

2. **在 Xcode 中打开项目**
   ```bash
   open /Users/autumn/.openclaw/workspace/SunTracker/SunTracker.xcodeproj
   ```

3. **选择你的 iPhone**
   - 点击顶部设备选择器
   - 选择你的 iPhone（不是模拟器）

4. **配置签名**
   - 点击项目文件 → "SunTracker" Target → "Signing & Capabilities"
   - Team: 选择你的 Apple ID
   - Bundle Identifier: 改为唯一标识，如 `com.yourname.suntracker`

5. **运行安装**
   - 点击 ▶️ 运行
   - Xcode 会自动编译并安装到 iPhone

---

## 方法 2：导出 IPA 文件（可分享）

### 步骤

1. **在 Xcode 中选择 "Any iOS Device"**
   - 顶部设备选择器 → "Any iOS Device (arm64)"

2. **创建 Archive**
   ```bash
   # 菜单：Product → Archive
   # 或命令行：
   cd /Users/autumn/.openclaw/workspace/SunTracker
   xcodebuild -scheme SunTracker -configuration Release archive -archivePath ./build/SunTracker.xcarchive
   ```

3. **导出 IPA**
   - Archive 完成后自动打开 Organizer
   - 点击 "Distribute App"
   - 选择：
     - **Development**（开发测试）
     - **Ad Hoc**（分享给注册设备）
     - **App Store**（上架商店）
   - 选择签名证书
   - 导出到桌面

---

## 方法 3：使用命令行（自动化）

### 创建 ExportOptions.plist

```bash
cat > /Users/autumn/.openclaw/workspace/SunTracker/ExportOptions.plist << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>teamID</key>
    <string>YOUR_TEAM_ID</string>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <true/>
    <key>signingStyle</key>
    <string>automatic</string>
</dict>
</plist>
EOF
```

### 构建命令

```bash
cd /Users/autumn/.openclaw/workspace/SunTracker

# 1. 清理
xcodebuild clean

# 2. Archive
xcodebuild -scheme SunTracker \
  -configuration Release \
  -archivePath build/SunTracker.xcarchive \
  archive

# 3. 导出 IPA
xcodebuild -exportArchive \
  -archivePath build/SunTracker.xcarchive \
  -exportPath build/ \
  -exportOptionsPlist ExportOptions.plist
```

---

## 方法 4：免费账号快速测试（推荐首次使用）

### 最简单流程

1. **在 Xcode 中添加你的 Apple ID**
   ```
   Xcode → Settings → Accounts → + → Apple ID
   ```

2. **连接 iPhone**

3. **选择 iPhone 作为运行目标**

4. **点击运行 ▶️**
   - Xcode 会自动签名并安装
   - 首次安装需要在手机上信任开发者

5. **在 iPhone 上信任开发者**
   ```
   设置 → 通用 → VPN 与设备管理
   → 选择你的 Apple ID → 信任
   ```

---

## IPA 文件位置

成功后，IPA 文件会在这里：
```
/Users/autumn/.openclaw/workspace/SunTracker/build/SunTracker.ipa
```

复制到桌面：
```bash
cp /Users/autumn/.openclaw/workspace/SunTracker/build/SunTracker.ipa ~/Desktop/
```

---

## 分享给 iPhone

### 方式 1：AirDrop
```bash
# 找到 IPA 文件，右键 → 分享 → AirDrop
```

### 方式 2：通过电脑传输
- 用数据线连接 iPhone
- 使用 Finder（macOS Catalina+）或 iTunes
- 拖入 IPA 文件

### 方式 3：云存储
- 上传到 iCloud Drive、百度网盘等
- 在 iPhone 上下载

---

## 安装 IPA 到 iPhone

### 需要第三方工具

1. **AltStore**（推荐）
   - 官网：https://altstore.io
   - 免费，支持自动续签

2. **Sideloadly**
   - 官网：https://sideloadly.io
   - 简单易用

3. **爱思助手**（国内）
   - 中文界面
   - 一键安装

---

## 常见问题

### Q: "Untrusted Developer"
A: 在 iPhone 上：设置 → 通用 → 设备管理 → 信任开发者

### Q: "Expired"（7 天后）
A: 免费证书 7 天过期，重新安装即可

### Q: "No devices found"
A: 确保 iPhone 已连接并信任此电脑

### Q: 签名失败
A: 检查：
   - Apple ID 已添加到 Xcode
   - Bundle ID 唯一
   - 设备已注册（免费账号必需）

---

## 下一步

**你想用哪种方法？**

1. **直接安装到自己 iPhone** → 方法 1 或 4
2. **导出 IPA 分享** → 方法 2 或 3
3. **需要我帮你配置** → 告诉我你的 Apple ID

---

**注意**: 没有付费开发者账号，IPA 只能安装到注册的设备，且 7 天过期。
