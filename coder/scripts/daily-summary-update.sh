#!/bin/bash
# OpenClaw 每日总结更新脚本
# 每天自动刷新总结文档并推送到 GitHub

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
GUIDES_DIR="$WORKSPACE/guides"
SUMMARY_FILE="$GUIDES_DIR/OPENCLAW_MONTHLY_SUMMARY.md"
TODAY=$(date +%Y-%m-%d)

echo "🔄 开始更新 OpenClaw 每日总结..."
echo "📅 日期：$TODAY"

# 1. 统计今日新增文件
echo "📊 统计今日变更..."
NEW_FILES=$(find "$WORKSPACE" -type f -name "*.md" -newermt "$TODAY 00:00" ! -path "*/.git/*" | wc -l | tr -d ' ')
NEW_CODE=$(find "$WORKSPACE" -type f \( -name "*.swift" -o -name "*.ets" -o -name "*.kt" -o -name "*.ts" -o -name "*.js" \) -newermt "$TODAY 00:00" ! -path "*/.git/*" | wc -l | tr -d ' ')

# 2. 检查 Git 提交（workspace）
cd "$WORKSPACE"
TODAY_COMMITS=$(git log --since="$TODAY 00:00" --oneline 2>/dev/null | wc -l | tr -d ' ')

# 3. 更新总结文档的更新时间
if [ -f "$SUMMARY_FILE" ]; then
    echo "📝 更新总结文档..."
    
    # 添加今日更新记录（如果还没有今日的记录）
    if ! grep -q "## 📅 今日更新 ($TODAY)" "$SUMMARY_FILE"; then
        # 在文件末尾添加今日更新
        cat >> "$SUMMARY_FILE" << EOF

---

## 📅 今日更新 ($TODAY)

### 新增内容
- 新增文档：$NEW_FILES 个
- 新增代码：$NEW_CODE 个文件
- Git 提交：$TODAY_COMMITS 次

### 工作重点
$(git log --since="$TODAY 00:00" --pretty=format:"- %s" 2>/dev/null | head -10 || echo "- 暂无记录")

### 明日计划
- [ ] 继续完善文档
- [ ] 代码优化
- [ ] 问题修复

---
*最后更新：$TODAY*
EOF
    fi
fi

# 4. 提交到 guides 仓库
cd "$GUIDES_DIR"
git add -A

if ! git diff --staged --quiet; then
    echo "💾 提交变更到 guides 仓库..."
    git commit -m "📝 每日更新 $TODAY - 新增$NEW_FILES 个文档，$NEW_CODE 个代码文件"
    
    echo "🚀 推送到 GitHub..."
    git -c credential.helper='!gh auth git-credential' push origin main 2>/dev/null || {
        echo "⚠️ GitHub 推送失败，将稍后重试"
    }
    
    echo "✅ 更新完成！"
else
    echo "✅ 没有变更，跳过提交"
fi

# 5. 记录日志
echo "[$TODAY] 更新完成 - 文档:$NEW_FILES 代码:$NEW_CODE 提交:$TODAY_COMMITS" >> /Users/autumn/.openclaw/logs/daily-update.log

# 6. 发送到飞书（如已配置）
if command -v openclaw &> /dev/null && [ -f ~/.openclaw/config.json ]; then
    echo "📱 发送通知到飞书..."
    openclaw feishu send "📊 OpenClaw 每日更新
日期：$TODAY
新增文档：$NEW_FILES 个
新增代码：$NEW_CODE 个
Git 提交：$TODAY_COMMITS 次
    
查看详情：https://github.com/yyautumn330/openclaw-learning-guides" 2>/dev/null || echo "⚠️ 飞书通知失败"
fi

echo ""
echo "📊 今日统计:"
echo "  - 新增文档：$NEW_FILES 个"
echo "  - 新增代码：$NEW_CODE 个文件"
echo "  - Git 提交：$TODAY_COMMITS 次"
echo "🔗 Guides 仓库：https://github.com/yyautumn330/openclaw-learning-guides"
