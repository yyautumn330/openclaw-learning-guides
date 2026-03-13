#!/bin/bash

# SunTracker 编译检查脚本

echo "╔═══════════════════════════════════════════╗"
echo "║  🌅 SunTracker - 编译检查                 ║"
echo "╚═══════════════════════════════════════════╝"
echo ""

PROJECT_DIR="/Users/autumn/.openclaw/workspace/SunTracker"
PROJECT_FILE="$PROJECT_DIR/SunTracker.xcodeproj"

# 检查项目文件
if [ ! -d "$PROJECT_FILE" ]; then
    echo "❌ 项目文件不存在：$PROJECT_FILE"
    exit 1
fi

echo "✅ 项目文件存在"
echo ""

# 检查 Xcode
if [ ! -d "/Applications/Xcode.app" ]; then
    echo "❌ 未找到 Xcode"
    echo "   请安装 Xcode 后重试"
    exit 1
fi

echo "✅ Xcode 已安装"
echo ""

# 检查 Swift 文件语法
echo "📋 检查 Swift 文件语法..."
echo ""

errors=0

# ContentView.swift
if swift -frontend -parse "$PROJECT_DIR/SunTracker/Views/ContentView.swift" 2>/dev/null; then
    echo "✅ ContentView.swift 语法正确"
else
    echo "❌ ContentView.swift 语法错误"
    errors=$((errors + 1))
fi

# SolarPositionView.swift
if swift -frontend -parse "$PROJECT_DIR/SunTracker/Views/SolarPositionView.swift" 2>/dev/null; then
    echo "✅ SolarPositionView.swift 语法正确"
else
    echo "❌ SolarPositionView.swift 语法错误"
    errors=$((errors + 1))
fi

# SunTimesView.swift
if swift -frontend -parse "$PROJECT_DIR/SunTracker/Views/SunTimesView.swift" 2>/dev/null; then
    echo "✅ SunTimesView.swift 语法正确"
else
    echo "❌ SunTimesView.swift 语法错误"
    errors=$((errors + 1))
fi

# ARTrackingView.swift
if swift -frontend -parse "$PROJECT_DIR/SunTracker/Views/ARTrackingView.swift" 2>/dev/null; then
    echo "✅ ARTrackingView.swift 语法正确"
else
    echo "❌ ARTrackingView.swift 语法错误"
    errors=$((errors + 1))
fi

# LocationService.swift
if swift -frontend -parse "$PROJECT_DIR/SunTracker/Services/LocationService.swift" 2>/dev/null; then
    echo "✅ LocationService.swift 语法正确"
else
    echo "❌ LocationService.swift 语法错误"
    errors=$((errors + 1))
fi

# MotionService.swift
if swift -frontend -parse "$PROJECT_DIR/SunTracker/Services/MotionService.swift" 2>/dev/null; then
    echo "✅ MotionService.swift 语法正确"
else
    echo "❌ MotionService.swift 语法错误"
    errors=$((errors + 1))
fi

echo ""
echo "═══════════════════════════════════════════"

if [ $errors -eq 0 ]; then
    echo "✅ 所有文件语法检查通过！"
    echo ""
    echo "🚀 可以在 Xcode 中编译运行："
    echo "   open $PROJECT_FILE"
    echo ""
    exit 0
else
    echo "❌ 发现 $errors 个语法错误"
    echo ""
    echo "请在 Xcode 中查看详细错误信息："
    echo "   open $PROJECT_FILE"
    echo ""
    exit 1
fi
