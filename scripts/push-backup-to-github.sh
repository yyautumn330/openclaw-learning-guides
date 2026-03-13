#!/bin/bash
# 推送备份到 GitHub
# 使用 GitHub Releases 存储大型备份文件

set -e

BACKUP_DIR="/Users/autumn/.openclaw/workspace/.backup"
LATEST_BACKUP="coder_20260313_191822.tar.gz"
REPO="yyautumn330/openclaw-workspace-backup"
RELEASE_TAG="backup-$(date +%Y%m%d-%H%M%S)"

echo "🔄 开始推送备份到 GitHub..."
echo "📦 备份文件：$LATEST_BACKUP"
echo "📁 仓库：$REPO"

# 检查备份文件
if [ ! -f "$BACKUP_DIR/$LATEST_BACKUP" ]; then
    echo "❌ 备份文件不存在：$BACKUP_DIR/$LATEST_BACKUP"
    exit 1
fi

# 获取文件大小（MB）
FILE_SIZE=$(du -m "$BACKUP_DIR/$LATEST_BACKUP" | cut -f1)
echo "📊 文件大小：${FILE_SIZE}MB"

# GitHub Releases 单个文件限制 2GB
if [ "$FILE_SIZE" -gt 2048 ]; then
    echo "⚠️  文件超过 2GB，需要拆分..."
    echo "📦 正在拆分文件..."
    
    # 拆分成 1GB 的片段
    split -b 1G "$BACKUP_DIR/$LATEST_BACKUP" "$BACKUP_DIR/${LATEST_BACKUP}.part."
    
    # 创建 Release
    echo "🏷️  创建 Release: $RELEASE_TAG"
    gh release create "$RELEASE_TAG" \
        --repo "$REPO" \
        --title "Workspace Backup $(date +%Y-%m-%d)" \
        --notes "自动备份 - $(date +%Y-%m-%d %H:%M)" \
        "$BACKUP_DIR/${LATEST_BACKUP}.part."* \
        || true
    
    echo "✅ 已上传到 GitHub Releases"
else
    # 直接上传
    echo "🏷️  创建 Release: $RELEASE_TAG"
    gh release create "$RELEASE_TAG" \
        --repo "$REPO" \
        --title "Workspace Backup $(date +%Y-%m-%d)" \
        --notes "自动备份 - $(date +%Y-%m-%d %H:%M)" \
        "$BACKUP_DIR/$LATEST_BACKUP" \
        || true
    
    echo "✅ 已上传到 GitHub Releases"
fi

echo ""
echo "🔗 查看 Release: https://github.com/$REPO/releases/tag/$RELEASE_TAG"
echo "✅ 备份推送完成"
