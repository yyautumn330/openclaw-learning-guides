#!/bin/bash
# 小红书 AI 学习系列 - 发布脚本
# 使用方法：./publish_xiaohongshu.sh Day01

DAY=$1

if [ -z "$DAY" ]; then
    echo "❌ 请指定发布哪一天，例如：./publish_xiaohongshu.sh Day01"
    exit 1
fi

FILE="/Users/autumn/.openclaw/workspace/Xiaohongshu_Plan/${DAY}.md"

if [ ! -f "$FILE" ]; then
    echo "❌ 文件不存在：$FILE"
    exit 1
fi

echo "📱 准备发布：$DAY"
echo "📄 文件：$FILE"
echo "⏰ 发布时间：20:00"
echo ""
echo "发布步骤："
echo "1. 打开小红书 App"
echo "2. 点击 + 创建笔记"
echo "3. 上传封面图"
echo "4. 复制正文内容"
echo "5. 添加标签"
echo "6. 设置发布时间 20:00"
echo "7. 发布！"
echo ""
echo "✅ 准备就绪！"

# 打开文件
open "$FILE"

# 打开小红书（如果已安装）
# open -a "小红书" 2>/dev/null || echo "请手动打开小红书 App"

echo ""
echo "💡 提示：发布后 2 小时内记得回复评论！"
