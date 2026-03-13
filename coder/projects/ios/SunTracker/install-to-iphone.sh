#!/bin/bash

# SunTracker - 安装到 iPhone 脚本
# 使用方法：./install-to-iphone.sh

set -e

PROJECT_DIR="/Users/autumn/.openclaw/workspace/SunTracker"
ARCHIVE_PATH="$PROJECT_DIR/build/SunTracker.xcarchive"
IPA_PATH="$PROJECT_DIR/build/SunTracker.ipa"

echo "╔═══════════════════════════════════════════╗"
echo "║  🌅 SunTracker - iPhone 安装工具          ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

# 检查 Xcode
if [ ! -d "/Applications/Xcode.app" ]; then
    echo "❌ 未找到 Xcode"
    echo ""
    echo "请先安装 Xcode："
    echo "   1. 从 App Store 下载 Xcode"
    echo "   2. 或访问：https://apps.apple.com/app/xcode/id497799835"
    echo ""
    exit 1
fi

# 切换 Xcode 路径（需要密码）
echo "🔧 切换到完整 Xcode..."
echo "   需要输入密码以设置 Xcode 路径"
sudo xcode-select -s /Applications/Xcode.app/Contents/Developer

echo ""
echo "✅ Xcode 路径设置完成"
echo ""

# 检查 Apple ID
echo "📋 请确认以下事项："
echo "   1. iPhone 已通过 USB 连接到 Mac"
echo "   2. iPhone 已信任此电脑"
echo "   3. Xcode 中已登录 Apple ID"
echo ""
read -p "按回车继续，或 Ctrl+C 取消..."

# 清理旧构建
echo ""
echo "🧹 清理旧构建..."
rm -rf "$ARCHIVE_PATH" "$IPA_PATH"

# 构建 Archive
echo ""
echo "📦 构建 Archive..."
cd "$PROJECT_DIR"

xcodebuild -scheme SunTracker \
  -configuration Release \
  -destination 'generic/platform=iOS' \
  -archivePath "$ARCHIVE_PATH" \
  archive

if [ $? -eq 0 ]; then
    echo "✅ Archive 创建成功"
else
    echo "❌ Archive 创建失败"
    echo ""
    echo "可能的原因："
    echo "   1. 签名配置问题"
    echo "   2. 需要在 Xcode 中选择 Team"
    echo "   3. Bundle ID 冲突"
    echo ""
    echo "请在 Xcode 中手动配置："
    echo "   1. 打开 SunTracker.xcodeproj"
    echo "   2. 选择 Target → Signing & Capabilities"
    echo "   3. 选择你的 Team"
    echo "   4. 修改 Bundle Identifier 为唯一值"
    exit 1
fi

# 导出 IPA
echo ""
echo "📱 导出 IPA..."

# 创建 ExportOptions
cat > "$PROJECT_DIR/ExportOptions.plist" << 'EOF'
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>method</key>
    <string>development</string>
    <key>uploadBitcode</key>
    <false/>
    <key>uploadSymbols</key>
    <true/>
    <key>signingStyle</key>
    <string>automatic</string>
</dict>
</plist>
EOF

xcodebuild -exportArchive \
  -archivePath "$ARCHIVE_PATH" \
  -exportPath "$PROJECT_DIR/build/" \
  -exportOptionsPlist "$PROJECT_DIR/ExportOptions.plist"

if [ $? -eq 0 ]; then
    echo "✅ IPA 导出成功"
else
    echo "❌ IPA 导出失败"
    exit 1
fi

# 复制到桌面
echo ""
echo "📋 复制到桌面..."
cp "$IPA_PATH" ~/Desktop/SunTracker.ipa

echo ""
echo "╔═══════════════════════════════════════════╗"
echo "║           ✅ 构建完成！                   ║"
echo "╚═══════════════════════════════════════════╝"
echo ""
echo "📦 IPA 文件位置:"
echo "   桌面：~/Desktop/SunTracker.ipa"
echo "   项目：$IPA_PATH"
echo ""
echo "📱 安装到 iPhone:"
echo "   方法 1: 使用 AltStore (https://altstore.io)"
echo "   方法 2: 使用 Sideloadly (https://sideloadly.io)"
echo "   方法 3: 拖到 Finder/iTunes"
echo ""
echo "⚠️  注意:"
echo "   - 免费 Apple ID: 7 天过期，只能安装到自己设备"
echo "   - 需要在 iPhone 上信任开发者"
echo ""
