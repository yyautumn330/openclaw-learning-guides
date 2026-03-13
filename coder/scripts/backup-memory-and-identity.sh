#!/bin/bash
# OpenClaw Memory 和身份配置备份脚本
# 备份到 .backup 目录并推送到 GitHub

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
BACKUP_DIR="$WORKSPACE/.backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
TODAY=$(date +%Y-%m-%d)

echo "🔄 开始备份 OpenClaw Memory 和身份配置..."
echo "📁 工作目录：$WORKSPACE"
echo "📦 备份目录：$BACKUP_DIR"
echo ""

# 创建 memory 备份目录
mkdir -p "$BACKUP_DIR/memory"

# 1. 备份 memory 文件
echo "📝 备份 memory 文件..."
if [ -d "$WORKSPACE/memory" ]; then
    cp -v "$WORKSPACE/memory"/*.md "$BACKUP_DIR/memory/" 2>/dev/null || echo "  无 memory 文件"
else
    echo "  memory 目录不存在，创建空目录"
    mkdir -p "$BACKUP_DIR/memory"
fi

# 2. 备份身份配置文件
echo ""
echo "🎭 备份身份配置文件..."
for file in IDENTITY.md IDENTITY-coder.md IDENTITY-creator.md IDENTITY-manager.md IDENTITY-tester.md IDENTITY-SWITCH.md; do
    if [ -f "$WORKSPACE/$file" ]; then
        cp -v "$WORKSPACE/$file" "$BACKUP_DIR/${file%.md}_$TIMESTAMP.md"
        cp -v "$WORKSPACE/$file" "$BACKUP_DIR/$file"
    fi
done

# 3. 备份其他核心配置
echo ""
echo "📋 备份核心配置文件..."
for file in AGENTS.md SOUL.md USER.md MEMORY.md HEARTBEAT.md; do
    if [ -f "$WORKSPACE/$file" ]; then
        cp -v "$WORKSPACE/$file" "$BACKUP_DIR/${file%.md}_$TIMESTAMP.md"
        cp -v "$WORKSPACE/$file" "$BACKUP_DIR/$file"
    fi
done

# 4. 更新 README
echo ""
echo "📄 更新 README..."
cat > "$BACKUP_DIR/README.md" <<EOF
# OpenClaw Memory Backup

自动备份 OpenClaw 工作空间的核心配置和记忆文件。

## 📅 备份策略

- **频率**: 每次变更时手动触发
- **范围**: memory 文件、身份配置、核心配置
- **GitHub**: https://github.com/yyautumn330/openclaw-memory-backup

## 📁 备份内容

### Memory 文件
- memory/YYYY-MM-DD.md - 每日记忆
- MEMORY.md - 长期记忆

### 身份配置
- IDENTITY.md - 默认身份
- IDENTITY-coder.md - 程序员身份
- IDENTITY-creator.md - 创作者+UX 设计师身份
- IDENTITY-manager.md - 项目经理身份
- IDENTITY-tester.md - 测试工程师身份
- IDENTITY-SWITCH.md - 身份切换说明

### 核心配置
- AGENTS.md - Agent 配置
- SOUL.md - Agent 灵魂定义
- USER.md - 用户信息
- HEARTBEAT.md - 心跳任务配置

## 📊 最新备份

$(ls -lt *_$TIMESTAMP.md 2>/dev/null | head -10 | awk '{print "- " $9 " (" $5 ")"}')

## 🔧 恢复备份

\`\`\`bash
# 从 .backup 目录恢复
cp ~/.openclaw/workspace/.backup/*.md ~/.openclaw/workspace/
cp ~/.openclaw/workspace/.backup/memory/*.md ~/.openclaw/workspace/memory/
\`\`\`

## 🚀 推送到 GitHub

\`\`\`bash
cd ~/.openclaw/workspace/.backup
git add -A
git commit -m "📝 备份 $TIMESTAMP"
git push origin main
\`\`\`

---
*最后更新：$TODAY*
*备份时间：$TIMESTAMP*
EOF

# 5. Git 操作
echo ""
echo "💾 提交到 Git..."
cd "$BACKUP_DIR"
git add -A

# 检查是否有变更
if git diff --staged --quiet; then
    echo "✅ 没有变更，跳过提交"
else
    echo "📝 提交变更..."
    git commit -m "📝 备份 $TIMESTAMP - 包含新增身份配置"
    
    echo "🚀 推送到 GitHub..."
    git push origin main
fi

# 6. 显示备份统计
echo ""
echo "=== 备份完成 ==="
echo ""
echo "📊 备份统计:"
echo "  Memory 文件：$(ls -1 "$BACKUP_DIR/memory"/*.md 2>/dev/null | wc -l | tr -d ' ') 个"
echo "  身份配置：$(ls -1 "$BACKUP_DIR"/IDENTITY*.md 2>/dev/null | wc -l | tr -d ' ') 个"
echo "  核心配置：$(ls -1 "$BACKUP_DIR"/*.md 2>/dev/null | wc -l | tr -d ' ') 个"
echo ""
echo "🔗 GitHub: https://github.com/yyautumn330/openclaw-memory-backup"
echo "📁 备份目录：$BACKUP_DIR"
echo ""
echo "✅ 备份完成！"
