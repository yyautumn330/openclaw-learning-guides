#!/bin/bash
# 文章备份脚本 - 备份 creator/blog 到 GitHub

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
BACKUP_DIR="$WORKSPACE/.backup-articles"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "📝 备份文章到 GitHub..."

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 复制文章文件
cp -r "$WORKSPACE/creator/blog" "$BACKUP_DIR/"

# Git 操作
cd "$BACKUP_DIR"
git init 2>/dev/null || true
git remote set-url origin git@github.com:yyautumn330/openclaw-articles-backup.git 2>/dev/null || git remote add origin git@github.com:yyautumn330/openclaw-articles-backup.git 2>/dev/null || true

git add -A
if git diff --staged --quiet; then
    echo "✅ 没有变更"
else
    git commit -m "📝 文章备份 $TIMESTAMP"
    git push -u origin main 2>/dev/null || git push origin main
fi

echo "✅ 备份完成！"
