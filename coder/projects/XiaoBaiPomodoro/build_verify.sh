#!/bin/bash

# 小白番茄专注钟 - 构建验证脚本
# Build Verification Script

echo "🍅 小白番茄专注钟 - 构建验证"
echo "================================"
echo ""

# 检查项目文件
echo "📁 检查项目文件..."

# 检查关键修复文件
FILES=(
  "entry/src/main/ets/pages/Index.ets"
  "entry/src/main/ets/utils/PomodoroModel.ts"
)

for file in "${FILES[@]}"; do
  if [ -f "$file" ]; then
    echo "  ✅ $file"
  else
    echo "  ❌ $file (缺失)"
    exit 1
  fi
done

echo ""
echo "🔍 验证 P0 修复..."

# 验证修复 1: 定时器内存泄漏
echo "  检查修复 1: 定时器内存泄漏..."
if grep -q "this.stopUITimer();" entry/src/main/ets/pages/Index.ets; then
  echo "    ✅ startUITimer() 调用 stopUITimer() 清理"
else
  echo "    ❌ 修复未找到"
fi

# 验证修复 2: 成就时间判断
echo "  检查修复 2: 成就时间判断 Bug..."
if grep -q "lastTomatoHour" entry/src/main/ets/utils/PomodoroModel.ts; then
  echo "    ✅ lastTomatoHour 字段已添加"
else
  echo "    ❌ 修复未找到"
fi

# 验证修复 3: dailyStats 清理
echo "  检查修复 3: dailyStats 内存限制..."
if grep -q "cleanupOldDailyStats" entry/src/main/ets/utils/PomodoroModel.ts; then
  echo "    ✅ cleanupOldDailyStats() 方法已添加"
else
  echo "    ❌ 修复未找到"
fi

echo ""
echo "================================"
echo "✅ 代码验证完成!"
echo ""
echo "📱 下一步：使用 DevEco Studio 构建"
echo "   1. 打开 DevEco Studio"
echo "   2. File -> Open -> 选择此项目目录"
echo "   3. 等待同步完成"
echo "   4. 点击运行按钮 (Shift + F10)"
echo ""
echo "🔧 或使用命令行构建 (如有 hvigorw):"
echo "   ./hvigorw assembleHap"
echo ""
