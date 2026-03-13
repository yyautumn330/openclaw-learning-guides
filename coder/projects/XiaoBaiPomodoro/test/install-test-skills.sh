#!/bin/bash

# 小白番茄专注钟 - 测试技能安装脚本
# 用于快速安装推荐的 UI 测试/视觉测试技能

set -e

echo "🍅 小白番茄专注钟 - 测试技能安装脚本"
echo "=========================================="
echo ""

# 检查 npx 是否可用
if ! command -v npx &> /dev/null; then
    echo "❌ 错误：npx 未找到，请先安装 Node.js"
    exit 1
fi

echo "✅ Node.js 环境检查通过"
echo ""

# 创建技能安装目录
SKILL_DIR="/Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro/test/skills"
mkdir -p "$SKILL_DIR"

echo "📦 开始安装测试技能..."
echo ""

# P0 必装技能
echo "🔴 安装 P0 必装技能..."
echo ""

echo "1️⃣  安装 Web 应用 UI 自动化测试 (webapp-testing)..."
npx skills add anthropics/skills@webapp-testing -g -y
echo "   ✅ webapp-testing 安装完成"
echo ""

echo "2️⃣  安装视觉回归测试 (visual-regression-testing)..."
npx skills add aj-geddes/useful-ai-prompts@visual-regression-testing -g -y
echo "   ✅ visual-regression-testing 安装完成"
echo ""

# P1 推荐技能
echo "🟡 安装 P1 推荐技能..."
echo ""

echo "3️⃣  安装移动应用测试 (mobile-app-testing)..."
npx skills add aj-geddes/useful-ai-prompts@mobile-app-testing -g -y
echo "   ✅ mobile-app-testing 安装完成"
echo ""

echo "4️⃣  安装 Playwright 最佳实践 (playwright-best-practices)..."
npx skills add currents-dev/playwright-best-practices-skill@playwright-best-practices -g -y
echo "   ✅ playwright-best-practices 安装完成"
echo ""

# P2 可选技能
echo "🟢 安装 P2 可选技能..."
echo ""

echo "5️⃣  安装 E2E 测试模式 (e2e-testing-patterns)..."
npx skills add wshobson/agents@e2e-testing-patterns -g -y
echo "   ✅ e2e-testing-patterns 安装完成"
echo ""

# 验证安装
echo ""
echo "=========================================="
echo "✅ 技能安装完成！"
echo "=========================================="
echo ""

echo "📋 已安装技能列表:"
echo ""
npx skills list | grep -E "webapp-testing|visual-regression|mobile-app|playwright|e2e-testing" || echo "   (技能列表查看失败，请手动运行 npx skills list)"
echo ""

echo "=========================================="
echo "📖 使用指南"
echo "=========================================="
echo ""
echo "1️⃣  UI 自动化测试:"
echo "   对 Agent 说：'使用 webapp-testing 技能测试登录页面'"
echo ""
echo "2️⃣  视觉回归测试:"
echo "   对 Agent 说：'使用 visual-regression-testing 对比首页截图'"
echo ""
echo "3️⃣  移动应用测试:"
echo "   对 Agent 说：'使用 mobile-app-testing 设计测试用例'"
echo ""
echo "4️⃣  Playwright 最佳实践:"
echo "   对 Agent 说：'使用 playwright-best-practices 编写测试脚本'"
echo ""
echo "5️⃣  E2E 测试模式:"
echo "   对 Agent 说：'使用 e2e-testing-patterns 设计完整流程测试'"
echo ""

echo "=========================================="
echo "📚 参考文档"
echo "=========================================="
echo ""
echo "- 测试流程分析报告：test/测试流程分析报告.md"
echo "- 推荐测试技能列表：test/推荐测试技能列表.md"
echo "- 改进后的测试检查清单：test/改进后的测试检查清单.md"
echo ""

echo "=========================================="
echo "✨ 安装完成！开始使用新技能改进测试流程吧！"
echo "=========================================="
