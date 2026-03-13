#!/bin/bash
# 打开免费 AI 绘画网站

echo "🌐 打开 AI 绘画网站..."

# 检测系统
if [[ "$OSTYPE" == "darwin"* ]]; then
    open https://liblib.art       # 中文界面，推荐
    sleep 1
    open https://seaart.ai        # 免费，支持中文
    sleep 1
    open https://bing.com/images/create  # 微软免费
else
    echo "请在浏览器中打开以下网站："
    echo "  https://liblib.art"
    echo "  https://seaart.ai"
    echo "  https://bing.com/images/create"
fi

echo ""
echo "📝 提示词（复制使用）："
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo "英文（推荐）:"
echo "person walking on desert highway, back view, desolate landscape,"
echo "cinematic photography, dramatic sky, sunset lighting, realistic, 8k"
echo ""
echo "中文:"
echo "一个人在荒漠公路上行走，背影，荒凉景色，电影感，"
echo "戏剧性天空，日落光线，写实，8K"
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
