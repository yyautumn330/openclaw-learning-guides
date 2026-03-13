#!/bin/bash
# Draw Things 文生图快速启动脚本
# 用法：./gen-image.sh "提示词" [预设]

PROMPT="${1:-一只在太空的猫}"
PRESET="${2:-quality}"

SKILL_DIR="$HOME/.openclaw/workspace/skills/drawthings"
SCRIPT="$SKILL_DIR/scripts/generate.py"

echo "🎨 Draw Things 文生图"
echo "提示词：$PROMPT"
echo "预设：$PRESET"
echo ""

# 检查 API 是否运行
echo "🔍 检查 DrawThings API..."
if curl -s http://127.0.0.1:7860/sdapi/v1/cmd-flags > /dev/null 2>&1; then
    echo "✅ API 已启动"
else
    echo "❌ API 未响应"
    echo ""
    echo "请启动 DrawThings App 并启用 API:"
    echo "1. 打开 Draw Things.app"
    echo "2. 按 ⌘+, 打开设置"
    echo "3. 找到 API/HTTP Server 选项"
    echo "4. 勾选 Enable API"
    echo ""
    exit 1
fi

echo ""
echo "🚀 开始生成..."
cd "$SKILL_DIR"
python3 "$SCRIPT" "$PROMPT" --preset "$PRESET"

echo ""
echo "✅ 生成完成！"
echo "图片保存在：$SKILL_DIR/outputs/"
