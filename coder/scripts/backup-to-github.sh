#!/bin/bash
# OpenClaw Memory Backup Script
# 每天自动备份 SOUL.md, MEMORY.md, AGENTS.md 到 GitHub

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
BACKUP_DIR="$WORKSPACE/.backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "🔄 开始备份 OpenClaw 记忆文件..."

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 复制关键文件到备份目录
echo "📁 复制文件..."
cp "$WORKSPACE/SOUL.md" "$BACKUP_DIR/SOUL_$TIMESTAMP.md" 2>/dev/null || echo "⚠️ SOUL.md 不存在"
cp "$WORKSPACE/MEMORY.md" "$BACKUP_DIR/MEMORY_$TIMESTAMP.md" 2>/dev/null || echo "⚠️ MEMORY.md 不存在"
cp "$WORKSPACE/AGENTS.md" "$BACKUP_DIR/AGENTS_$TIMESTAMP.md" 2>/dev/null || echo "⚠️ AGENTS.md 不存在"
cp "$WORKSPACE/IDENTITY.md" "$BACKUP_DIR/IDENTITY_$TIMESTAMP.md" 2>/dev/null || echo "⚠️ IDENTITY.md 不存在"
cp "$WORKSPACE/USER.md" "$BACKUP_DIR/USER_$TIMESTAMP.md" 2>/dev/null || echo "⚠️ USER.md 不存在"

# 同时更新主文件（用于追踪最新状态）
cp "$WORKSPACE/SOUL.md" "$BACKUP_DIR/SOUL.md" 2>/dev/null || true
cp "$WORKSPACE/MEMORY.md" "$BACKUP_DIR/MEMORY.md" 2>/dev/null || true
cp "$WORKSPACE/AGENTS.md" "$BACKUP_DIR/AGENTS.md" 2>/dev/null || true
cp "$WORKSPACE/IDENTITY.md" "$BACKUP_DIR/IDENTITY.md" 2>/dev/null || true
cp "$WORKSPACE/USER.md" "$BACKUP_DIR/USER.md" 2>/dev/null || true

# 进入备份目录进行 git 操作
cd "$BACKUP_DIR"

# 初始化 git（如果还没有）
if [ ! -d ".git" ]; then
    echo "🔧 初始化 Git 仓库..."
    git init
    git remote add origin git@github.com:yyautumn330/openclaw-memory-backup.git
fi

# 添加所有文件
echo "📦 添加文件到 git..."
git add -A

# 检查是否有变更
if git diff --staged --quiet; then
    echo "✅ 没有变更，跳过提交"
    exit 0
fi

# 提交变更
echo "💾 提交变更..."
git commit -m "📝 自动备份 $TIMESTAMP"

# 推送到 GitHub
echo "🚀 推送到 GitHub..."
git push -u origin main 2>/dev/null || git push origin main

echo "✅ 备份完成！"
echo "📊 备份位置：$BACKUP_DIR"
echo "🔗 仓库地址：https://github.com/yyautumn330/openclaw-memory-backup"
