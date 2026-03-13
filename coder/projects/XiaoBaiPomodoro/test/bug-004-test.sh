#!/bin/bash

# BUG-004 修复快速测试脚本
# 用于在模拟器或真机上快速验证修复效果

set -e

PROJECT_PATH="/Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro"
cd "$PROJECT_PATH"

echo "🍅 小白番茄专注钟 - BUG-004 修复测试脚本"
echo "=========================================="
echo ""

# 检查项目是否存在
if [ ! -d "entry" ]; then
    echo "❌ 错误：项目目录不存在"
    exit 1
fi

echo "✅ 项目目录检查通过"

# 检查修复文件是否存在
echo ""
echo "📋 检查修复文件..."

FILES_TO_CHECK=(
    "entry/src/main/ets/services/BackgroundTaskService.ts"
    "entry/src/main/ets/entryability/EntryAbility.ets"
    "entry/src/main/ets/pages/Index.ets"
    "entry/src/main/module.json5"
)

for file in "${FILES_TO_CHECK[@]}"; do
    if [ -f "$file" ]; then
        echo "  ✅ $file"
    else
        echo "  ❌ $file (缺失)"
        exit 1
    fi
done

echo ""
echo "✅ 所有修复文件存在"

# 检查权限配置
echo ""
echo "🔐 检查权限配置..."
if grep -q "ohos.permission.KEEP_BACKGROUND_RUNNING" "entry/src/main/module.json5"; then
    echo "  ✅ 后台运行权限已添加"
else
    echo "  ❌ 后台运行权限缺失"
    exit 1
fi

if grep -q "keep_background_running_reason" "entry/src/main/resources/base/element/string.json"; then
    echo "  ✅ 权限说明已添加"
else
    echo "  ❌ 权限说明缺失"
    exit 1
fi

# 构建项目
echo ""
echo "🔨 构建项目..."
if command -v hvigorw &> /dev/null; then
    ./hvigorw assembleHap || {
        echo "⚠️  构建失败，请检查 DevEco Studio 配置"
        exit 1
    }
    echo "✅ 构建成功"
else
    echo "⚠️  hvigorw 未找到，请在 DevEco Studio 中构建项目"
fi

# 显示测试说明
echo ""
echo "=========================================="
echo "📱 测试说明"
echo "=========================================="
echo ""
echo "1️⃣  在 DevEco Studio 中运行项目"
echo "2️⃣  点击「开始」按钮启动计时器"
echo "3️⃣  切换到后台（按 Home 键）"
echo "4️⃣  等待 1 分钟"
echo "5️⃣  切回前台，检查时间是否正确减少"
echo ""
echo "✅ 预期结果：计时器在后台继续运行，时间准确"
echo ""
echo "📖 详细测试步骤请查看："
echo "   test/BUG-004-VERIFICATION.md"
echo ""
echo "🔍 查看运行日志："
echo "   hdc shell hilog | grep -E 'BackgroundTask|EntryAbility|Timer'"
echo ""
echo "=========================================="
echo "✨ 修复完成！准备测试"
echo "=========================================="
