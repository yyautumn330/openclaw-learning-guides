#!/bin/bash
# 每周完整备份 (优化版 - 排除大型文件)
# 运行时间：每周日凌晨 3:00

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
LOG_FILE="/Users/autumn/.openclaw/logs/workspace-backup.log"
BACKUP_DIR="/Users/autumn/.openclaw/workspace/.backup"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "🔄 开始每周完整备份 (优化版)..."

# 确保备份目录存在
mkdir -p "$BACKUP_DIR"

cd "$WORKSPACE"

# 备份重要文件
log "📦 备份重要配置文件..."

# 备份 AGENTS.md
cp "AGENTS.md" "$BACKUP_DIR/AGENTS_${TIMESTAMP}.md" 2>/dev/null || true

# 备份 HEARTBEAT.md
cp "HEARTBEAT.md" "$BACKUP_DIR/HEARTBEAT_${TIMESTAMP}.md" 2>/dev/null || true

# 备份 IDENTITY.md
cp "IDENTITY.md" "$BACKUP_DIR/IDENTITY_${TIMESTAMP}.md" 2>/dev/null || true

# 备份 SOUL.md
cp "SOUL.md" "$BACKUP_DIR/SOUL_${TIMESTAMP}.md" 2>/dev/null || true

# 备份 TOOLS.md
cp "TOOLS.md" "$BACKUP_DIR/TOOLS_${TIMESTAMP}.md" 2>/dev/null || true

# 备份 memory 目录
if [ -d "memory" ]; then
    log "📁 备份记忆文件..."
    cp -r "memory" "$BACKUP_DIR/memory_${TIMESTAMP}/" 2>/dev/null || true
fi

# 备份 coder 目录 (排除大型文件)
if [ -d "coder" ]; then
    log "📁 备份 coder 工作区 (排除大型文件)..."
    
    # 创建排除列表
    cat > /tmp/backup-exclude.txt << EOF
# AI 模型文件
coder/ComfyUI/models/checkpoints/*.safetensors
coder/ComfyUI/models/checkpoints/*.ckpt
coder/ComfyUI/models/checkpoints/*.pth
coder/ComfyUI/models/*.safetensors

# Python 虚拟环境
coder/ComfyUI/venv/
coder/venv/
coder/.venv/
coder/**/venv/
coder/**/.venv/

# 缓存文件
coder/**/__pycache__/
coder/**/*.pyc
coder/**/*.pyo

# 生成的输出
coder/ComfyUI/output/
coder/ComfyUI/temp/

# Node modules
coder/**/node_modules/

# 构建输出
coder/**/build/
coder/**/dist/
coder/**/.hvigor/
EOF

    # 使用 tar 排除大型文件
    tar --exclude-from=/tmp/backup-exclude.txt \
        -czf "$BACKUP_DIR/coder_${TIMESTAMP}.tar.gz" \
        "coder/" 2>/dev/null || true
    
    rm -f /tmp/backup-exclude.txt
fi

# 备份 projects 目录 (单独备份，不含 ComfyUI)
if [ -d "coder/projects" ]; then
    log "📁 备份项目代码..."
    tar -czf "$BACKUP_DIR/projects_${TIMESTAMP}.tar.gz" \
        --exclude="coder/projects/XiaoBaiRun/entry/build" \
        --exclude="coder/projects/XiaoBaiPomodoro/entry/build" \
        --exclude="coder/projects/FocusForest/entry/build" \
        "coder/projects/" 2>/dev/null || true
fi

# 清理旧备份（保留 4 周）
log "🧹 清理 4 周前的备份..."
find "$BACKUP_DIR" -name "*.tar.gz" -mtime +28 -delete 2>/dev/null || true
find "$BACKUP_DIR" -name "*.md" -mtime +28 -delete 2>/dev/null || true

# 统计备份大小
BACKUP_SIZE=$(du -sh "$BACKUP_DIR" 2>/dev/null | cut -f1)
log "📊 备份目录大小：$BACKUP_SIZE"

# 显示最新备份大小
if [ -f "$BACKUP_DIR/coder_${TIMESTAMP}.tar.gz" ]; then
    CODE_SIZE=$(du -h "$BACKUP_DIR/coder_${TIMESTAMP}.tar.gz" | cut -f1)
    log "📦 coder 备份大小：$CODE_SIZE"
fi

if [ -f "$BACKUP_DIR/projects_${TIMESTAMP}.tar.gz" ]; then
    PROJECTS_SIZE=$(du -h "$BACKUP_DIR/projects_${TIMESTAMP}.tar.gz" | cut -f1)
    log "📦 projects 备份大小：$PROJECTS_SIZE"
fi

log "✅ 每周备份完成 - 已备份到 $BACKUP_DIR"
