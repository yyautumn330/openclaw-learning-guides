#!/bin/bash

# 小白番茄专注钟 - 快速构建脚本
# XiaoBaiPomodoro Quick Build Script

echo "🍅 小白番茄专注钟 - 快速构建工具"
echo "================================"
echo ""

# 检查是否在项目目录
if [ ! -f "hvigorfile.ts" ]; then
    echo "❌ 错误：请在 XiaoBaiPomodoro 项目根目录运行此脚本"
    exit 1
fi

echo "✅ 项目目录确认"
echo ""

# 检查 Hvigor 是否可用
if ! command -v hvigorw &> /dev/null; then
    echo "⚠️  警告：hvigorw 命令未找到"
    echo "   请使用 DevEco Studio 打开项目进行构建"
    echo ""
    echo "📱 DevEco Studio 操作步骤:"
    echo "   1. 打开 DevEco Studio"
    echo "   2. File -> Open -> 选择当前项目目录"
    echo "   3. 等待项目同步完成"
    echo "   4. File -> Project Structure -> Signing Configs"
    echo "   5. 配置自动签名"
    echo "   6. 点击运行按钮 (Shift + F10)"
    echo ""
    exit 0
fi

echo "🔧 开始构建..."
echo ""

# 清理构建缓存
echo "🧹 清理构建缓存..."
hvigorw clean
echo ""

# 构建 HAP
echo "📦 构建 HAP 包..."
hvigorw assembleHap

echo ""
echo "================================"

# 检查构建产物
HAP_PATH="entry/build/default/outputs/default/entry-default-signed.hap"
if [ -f "$HAP_PATH" ]; then
    echo "✅ 构建成功!"
    echo ""
    echo "📍 HAP 包位置：$HAP_PATH"
    echo ""
    echo "📱 安装到设备:"
    echo "   hdc install $HAP_PATH"
    echo ""
    echo "🚀 或使用 DevEco Studio 直接运行"
else
    echo "⚠️  构建产物未找到"
    echo "   请检查构建日志或使用 DevEco Studio 构建"
fi

echo ""
echo "🍅 小白番茄专注钟 - 专注 25 分钟，休息 5 分钟"
