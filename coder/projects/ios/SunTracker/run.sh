#!/bin/bash

# SunTracker 快速启动脚本

echo "🌅 SunTracker - 太阳轨迹跟踪 App"
echo "================================"
echo ""

PROJECT_DIR="/Users/autumn/.openclaw/workspace/SunTracker"
PROJECT_FILE="$PROJECT_DIR/SunTracker.xcodeproj"

# 检查项目是否存在
if [ ! -d "$PROJECT_FILE" ]; then
    echo "❌ 项目文件不存在：$PROJECT_FILE"
    exit 1
fi

echo "✅ 项目路径：$PROJECT_DIR"
echo ""

# 检测系统
if [[ "$OSTYPE" == "darwin"* ]]; then
    echo "🍎 macOS 检测到，使用 Xcode 打开..."
    open "$PROJECT_FILE"
    echo ""
    echo "📱 下一步："
    echo "   1. 在 Xcode 中选择目标设备（iPhone/Mac）"
    echo "   2. 点击 ▶️ 运行"
    echo "   3. 首次运行需要授予定位权限"
else
    echo "⚠️  非 macOS 系统，无法直接运行 iOS/macOS 项目"
    echo "   请在 Mac 上使用 Xcode 打开项目"
fi

echo ""
echo "📖 开发文档：$PROJECT_DIR/DEVELOPMENT.md"
echo ""
