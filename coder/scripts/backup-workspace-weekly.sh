#!/bin/bash
# OpenClaw Workspace 每周备份脚本
# 压缩整个 workspace 并推送到 GitHub

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
BACKUP_DIR="/Users/autumn/.openclaw/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
WEEK_NUM=$(date +%Y-W%V)
BACKUP_FILE="$BACKUP_DIR/workspace_$TIMESTAMP.tar.gz"
REPO_DIR="$BACKUP_DIR/github-repo"

echo "🔄 开始备份 OpenClaw Workspace..."
echo "📁 工作目录：$WORKSPACE"
echo "📦 备份文件：$BACKUP_FILE"

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 排除的文件和目录
EXCLUDES=(
    ".git"
    ".backup"
    "backups"
    "logs"
    "*.log"
    "node_modules"
    ".hvigor"
    "build"
    ".DS_Store"
)

# 构建排除参数
EXCLUDE_ARGS=""
for pattern in "${EXCLUDES[@]}"; do
    EXCLUDE_ARGS="$EXCLUDE_ARGS --exclude=$pattern"
done

# 压缩 workspace（排除不必要的文件）
echo "🗜️ 压缩文件中..."
cd /Users/autumn/.openclaw
tar -czf "$BACKUP_FILE" $EXCLUDE_ARGS -C /Users/autumn/.openclaw workspace

echo "✅ 压缩完成：$(du -h "$BACKUP_FILE" | cut -f1)"

# 准备 GitHub 仓库
echo "📂 准备 GitHub 仓库..."
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR"
cd "$REPO_DIR"

# 初始化 git
if [ ! -d ".git" ]; then
    git init
    git remote add origin git@github.com:yyautumn330/openclaw-workspace-backup.git
fi

# 复制最新备份
cp "$BACKUP_FILE" "$REPO_DIR/"

# 创建/更新 README
cat > README.md << EOF
# OpenClaw Workspace Backup

自动备份 OpenClaw 工作空间。

## 📅 备份策略

- **频率**: 每周一次（每周日 凌晨 3:00）
- **格式**: tar.gz 压缩包
- **保留**: 最近 12 周的备份

## 📦 最新备份

$(ls -lt *.tar.gz 2>/dev/null | head -5 | awk '{print "- " $9 " (" $5 ")"}')

## 🔧 恢复备份

\`\`\`bash
# 下载备份文件
gh release download <tag>

# 解压到 workspace
tar -xzf workspace_YYYYMMDD_HHMMSS.tar.gz -C /Users/autumn/.openclaw/
\`\`\`

## ⚙️ 自动备份

通过 cron 定时任务自动执行：
\`\`\`
0 3 * * 0 /Users/autumn/.openclaw/workspace/scripts/backup-workspace-weekly.sh
\`\`\`

---
*最后更新：$(date '+%Y-%m-%d %H:%M:%S')*
EOF

# Git 操作
git add -A

# 检查是否有变更
if git diff --staged --quiet; then
    echo "✅ 没有变更，跳过提交"
else
    echo "💾 提交变更..."
    git commit -m "📦 每周备份 $WEEK_NUM ($TIMESTAMP)"
    
    echo "🚀 推送到 GitHub..."
    git push -u origin main 2>/dev/null || git push origin main
fi

# 清理旧备份（保留最近 12 周）
echo "🧹 清理旧备份..."
cd "$BACKUP_DIR"
ls -t workspace_*.tar.gz | tail -n +13 | xargs -r rm -f

echo ""
echo "✅ 备份完成！"
echo "📊 备份大小：$(du -h "$BACKUP_FILE" | cut -f1)"
echo "🔗 GitHub: https://github.com/yyautumn330/openclaw-workspace-backup"
echo "📁 备份位置：$BACKUP_DIR"
