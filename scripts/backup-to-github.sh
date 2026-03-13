#!/bin/bash
# 每日备份到 GitHub
# 运行时间：每天凌晨 2:00

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
LOG_FILE="/Users/autumn/.openclaw/logs/backup.log"
BACKUP_DIR="/Users/autumn/.openclaw/workspace/.backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "🔄 开始每日备份到 GitHub..."

cd "$WORKSPACE"

# 检查 Git 仓库
if [ ! -d ".git" ]; then
    log "❌ 错误：不是 Git 仓库"
    exit 1
fi

# 添加变更
log "📝 添加文件变更..."
git add -A

# 检查是否有变更
if git diff-index --quiet HEAD --; then
    log "✅ 没有变更，跳过提交"
else
    # 提交变更
    log "💾 提交变更..."
    git commit -m "📦 每日自动备份 $(date '+%Y-%m-%d %H:%M')"
    
    # 推送到 GitHub
    log "🚀 推送到 GitHub..."
    if git push origin main 2>&1 | tee -a "$LOG_FILE"; then
        log "✅ 备份成功"
    else
        log "❌ 推送失败，可能是网络问题"
        exit 1
    fi
fi

# 清理旧备份（保留 7 天）
log "🧹 清理旧备份..."
find "$BACKUP_DIR" -name "*.md" -mtime +7 -delete 2>/dev/null || true

log "✅ 每日备份完成"
