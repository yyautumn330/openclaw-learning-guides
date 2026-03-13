#!/bin/bash
# 每日总结更新
# 运行时间：每天 23:00

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
LOG_FILE="/Users/autumn/.openclaw/logs/daily-update.log"
MEMORY_DIR="$WORKSPACE/memory"
TODAY=$(date +"%Y-%m-%d")
TODAY_FILE="$MEMORY_DIR/${TODAY}.md"

log() {
    echo "[$(date '+%Y-%m-%d %H:%M:%S')] $1" | tee -a "$LOG_FILE"
}

log "🔄 开始更新 OpenClaw 每日总结..."
log "📅 日期：$TODAY"

# 确保 memory 目录存在
mkdir -p "$MEMORY_DIR"

# 检查今日记忆文件是否存在
if [ ! -f "$TODAY_FILE" ]; then
    log "📝 创建今日记忆文件..."
    cat > "$TODAY_FILE" << EOF
# $TODAY - 工作日志

## 📋 今日完成

### 上午
- [ ] 

### 下午
- [ ] 

### 晚上
- [ ] 

## 🐛 问题与解决

## 💡 学到的东西

## 📅 明日计划

---
*记录时间：$(date '+%Y-%m-%d %H:%M')*
EOF
    log "✅ 已创建 $TODAY_FILE"
else
    log "ℹ️  今日记忆文件已存在"
fi

# 统计今日 Git 变更
cd "$WORKSPACE"

if git log --since="00:00" --until="23:59" --oneline 2>/dev/null | head -1 > /dev/null; then
    DOC_COUNT=$(git log --since="00:00" --until="23:59" --name-only --pretty=format: 2>/dev/null | grep -E '\.(md|txt)$' | wc -l)
    CODE_COUNT=$(git log --since="00:00" --until="23:59" --name-only --pretty=format: 2>/dev/null | grep -E '\.(ts|ets|js|swift|kt)$' | wc -l)
    COMMIT_COUNT=$(git log --since="00:00" --until="23:59" --oneline 2>/dev/null | wc -l)
    
    log "📊 今日统计:"
    log "  - 新增文档：$DOC_COUNT 个"
    log "  - 新增代码：$CODE_COUNT 个文件"
    log "  - Git 提交：$COMMIT_COUNT 次"
else
    log "ℹ️  今天没有 Git 提交"
fi

log "✅ [$TODAY] 更新完成 - 文档:$DOC_COUNT 代码:$CODE_COUNT 提交:$COMMIT_COUNT"
