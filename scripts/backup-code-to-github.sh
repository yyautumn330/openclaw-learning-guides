#!/bin/bash
# 推送代码备份到 GitHub (排除大型文件)
# 只推送项目代码和配置文件

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
LOG_FILE="/Users/autumn/.openclaw/logs/github-backup.log"
REPO="git@github.com:yyautumn330/openclaw-code-backup.git"
TIMESTAMP=$(date +"%Y%m%d_%H%M%S")

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "🔄 开始推送代码备份到 GitHub..."

cd "$WORKSPACE"

# 检查 Git 仓库
if [ ! -d ".git" ]; then
    log "📝 初始化 Git 仓库..."
    git init
    git remote add origin git@github.com:yyautumn330/openclaw-code-backup.git 2>/dev/null || true
fi

# 创建 .gitignore (排除大型文件)
log "📝 创建 .gitignore..."
cat > .gitignore << 'EOF'
# AI 模型文件
*.safetensors
*.ckpt
*.pth
*.bin
*.onnx

# Python 虚拟环境
venv/
.env/
.venv/
**/venv/
**/.venv/
__pycache__/
*.pyc
*.pyo

# Node modules
node_modules/
**/node_modules/

# 构建输出
build/
**/build/
dist/
**/dist/
.hvigor/
**/.hvigor/

# 日志文件
*.log
logs/

# 备份文件
.backup/

# IDE 配置
.idea/
.vscode/
*.iml

# 系统文件
.DS_Store
Thumbs.db

# 临时文件
tmp/
temp/
*.tmp

# ComfyUI 特定
ComfyUI/models/
ComfyUI/output/
ComfyUI/input/
EOF

# 添加所有文件
log "📝 添加文件..."
git add -A

# 检查是否有变更
if git diff-index --quiet HEAD --; then
    log "✅ 没有变更，跳过提交"
else
    # 提交变更
    log "💾 提交变更..."
    git commit -m "📦 代码备份 $(date '+%Y-%m-%d %H:%M')" || true
    
    # 拉取最新代码
    log "📥 拉取远程代码..."
    git pull origin main --rebase || true
    
    # 推送到 GitHub
    log "🚀 推送到 GitHub..."
    if git push origin main 2>&1 | tee -a "$LOG_FILE"; then
        log "✅ 推送成功"
    else
        log "❌ 推送失败，可能是网络问题或需要 force push"
        exit 1
    fi
fi

# 统计仓库大小
REPO_SIZE=$(du -sh "$WORKSPACE" 2>/dev/null | grep -v "ComfyUI" | cut -f1)
log "📊 仓库大小：$REPO_SIZE"

log "✅ GitHub 备份完成"
log "🔗 查看仓库：https://github.com/yyautumn330/openclaw-code-backup"
