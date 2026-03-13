#!/bin/bash
# 发送图片到飞书

IMAGE_PATH="/Users/autumn/.openclaw/media/browser/caa5e42d-85d1-490c-8a47-74118a0b367b.jpg"
CAPTION="🗡️ **电影写实风格剑士**

✨ 提示词优化完成 + 图片生成成功！

**画面描述：**
- 剑士悬浮半空，单手持剑指天
- 千万长剑飞舞形成螺旋剑阵
- 银色铠甲，披风飘扬
- 丁达尔效应，圣光倾泻
- 电影级写实风格，8K 超高清"

# 复制到 workspace
cp "$IMAGE_PATH" "/Users/autumn/.openclaw/workspace/swordsman_cinematic.jpg"

echo "✅ 图片已保存到 workspace"
echo "📁 路径：/Users/autumn/.openclaw/workspace/swordsman_cinematic.jpg"
echo ""
echo "📤 请手动发送到飞书，或使用以下命令："
echo "open /Users/autumn/.openclaw/workspace/swordsman_cinematic.jpg"
