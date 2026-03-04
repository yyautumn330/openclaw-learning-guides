# 💾 OpenClaw 备份策略指南

> **适用场景**: 个人/团队工作空间备份  
> **更新时间**: 2026-03-03  
> **作者**: 小白 (CodeMaster)

---

## 📋 目录

1. [备份架构](#备份架构)
2. [记忆文件备份](#记忆文件备份)
3. [Workspace 备份](#workspace 备份)
4. [项目代码备份](#项目代码备份)
5. [恢复流程](#恢复流程)
6. [监控与告警](#监控与告警)

---

## 🏗️ 备份架构

### 三级备份体系

```
┌─────────────────────────────────────────────────────────┐
│                    第一级：记忆文件                       │
│  内容：SOUL.md, MEMORY.md, AGENTS.md 等核心配置          │
│  频率：每日 2:00 AM                                      │
│  仓库：openclaw-memory-backup                           │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│                   第二级：完整 Workspace                   │
│  内容：整个 workspace 目录（压缩）                        │
│  频率：每周日 3:00 AM                                    │
│  仓库：openclaw-workspace-backup                        │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│                    第三级：项目代码                       │
│  内容：各个项目源代码                                    │
│  频率：实时提交                                          │
│  仓库：plane-war-harmonyos 等项目仓库                    │
└─────────────────────────────────────────────────────────┘
```

### 备份对比

| 级别 | 内容 | 频率 | 大小 | 保留策略 |
|------|------|------|------|----------|
| L1 | 核心配置 | 每日 | <1MB | 永久 |
| L2 | 完整空间 | 每周 | 50-200MB | 12 周 |
| L3 | 项目代码 | 实时 | 可变 | 永久 |

---

## 📝 记忆文件备份

### 备份内容

```
workspace/
├── SOUL.md              # AI 人格定义
├── IDENTITY.md          # 身份信息
├── AGENTS.md            # 工作规则
├── MEMORY.md            # 长期记忆
├── USER.md              # 用户信息
├── TOOLS.md             # 工具配置
└── HEARTBEAT.md         # 心跳任务
```

### 备份脚本

**位置：** `/Users/autumn/.openclaw/workspace/scripts/backup-to-github.sh`

```bash
#!/bin/bash
# OpenClaw Memory Backup Script

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
BACKUP_DIR="$WORKSPACE/.backup"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)

echo "🔄 开始备份 OpenClaw 记忆文件..."

# 创建备份目录
mkdir -p "$BACKUP_DIR"

# 复制关键文件
cp "$WORKSPACE/SOUL.md" "$BACKUP_DIR/SOUL_$TIMESTAMP.md" 2>/dev/null || true
cp "$WORKSPACE/MEMORY.md" "$BACKUP_DIR/MEMORY_$TIMESTAMP.md" 2>/dev/null || true
cp "$WORKSPACE/AGENTS.md" "$BACKUP_DIR/AGENTS_$TIMESTAMP.md" 2>/dev/null || true
cp "$WORKSPACE/IDENTITY.md" "$BACKUP_DIR/IDENTITY_$TIMESTAMP.md" 2>/dev/null || true
cp "$WORKSPACE/USER.md" "$BACKUP_DIR/USER_$TIMESTAMP.md" 2>/dev/null || true

# 更新最新文件
cp "$WORKSPACE/SOUL.md" "$BACKUP_DIR/SOUL.md" 2>/dev/null || true
cp "$WORKSPACE/MEMORY.md" "$BACKUP_DIR/MEMORY.md" 2>/dev/null || true
cp "$WORKSPACE/AGENTS.md" "$BACKUP_DIR/AGENTS.md" 2>/dev/null || true
cp "$WORKSPACE/IDENTITY.md" "$BACKUP_DIR/IDENTITY.md" 2>/dev/null || true
cp "$WORKSPACE/USER.md" "$BACKUP_DIR/USER.md" 2>/dev/null || true

# Git 操作
cd "$BACKUP_DIR"

if [ ! -d ".git" ]; then
    git init
    git remote add origin git@github.com:yyautumn330/openclaw-memory-backup.git
fi

git add -A

if ! git diff --staged --quiet; then
    git commit -m "📝 自动备份 $TIMESTAMP"
    git push -u origin main 2>/dev/null || git push origin main
fi

echo "✅ 备份完成！"
```

### Cron 配置

```bash
# 编辑 crontab
crontab -e

# 添加任务（每天凌晨 2 点）
0 2 * * * /Users/autumn/.openclaw/workspace/scripts/backup-to-github.sh >> /Users/autumn/.openclaw/workspace/logs/backup.log 2>&1
```

### 验证备份

```bash
# 查看备份历史
cd /Users/autumn/.openclaw/workspace/.backup
git log --oneline

# 手动触发备份
/Users/autumn/.openclaw/workspace/scripts/backup-to-github.sh

# 查看备份日志
tail -f /Users/autumn/.openclaw/workspace/logs/backup.log
```

---

## 📦 Workspace 备份

### 备份内容

整个 workspace 目录，排除：
- `.git` 目录
- `build` 构建产物
- `node_modules` 依赖
- `logs` 日志文件
- `backups` 备份目录本身

### 备份脚本

**位置：** `/Users/autumn/.openclaw/workspace/scripts/backup-workspace-weekly.sh`

```bash
#!/bin/bash
# OpenClaw Workspace Weekly Backup

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace"
BACKUP_DIR="/Users/autumn/.openclaw/backups"
TIMESTAMP=$(date +%Y%m%d_%H%M%S)
WEEK_NUM=$(date +%Y-W%V)
BACKUP_FILE="$BACKUP_DIR/workspace_$TIMESTAMP.tar.gz"
REPO_DIR="$BACKUP_DIR/github-repo"

echo "🔄 开始备份 OpenClaw Workspace..."

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

# 压缩 workspace
echo "🗜️ 压缩文件中..."
cd /Users/autumn/.openclaw
tar -czf "$BACKUP_FILE" $EXCLUDE_ARGS -C /Users/autumn/.openclaw workspace

echo "✅ 压缩完成：$(du -h "$BACKUP_FILE" | cut -f1)"

# 准备 GitHub 仓库
echo "📂 准备 GitHub 仓库..."
rm -rf "$REPO_DIR"
mkdir -p "$REPO_DIR"
cd "$REPO_DIR"

if [ ! -d ".git" ]; then
    git init
    git remote add origin git@github.com:yyautumn330/openclaw-workspace-backup.git
fi

# 复制最新备份
cp "$BACKUP_FILE" "$REPO_DIR/"

# 更新 README
cat > README.md << EOF
# OpenClaw Workspace Backup

自动备份 OpenClaw 工作空间。

## 📅 备份策略

- **频率**: 每周一次（每周日 凌晨 3:00）
- **格式**: tar.gz 压缩包
- **保留**: 最近 12 周的备份

## 📦 最新备份

$(ls -lt *.tar.gz 2>/dev/null | head -5 | awk '{print "- " $9 " (" $5 ")"}')

---
*最后更新：$(date '+%Y-%m-%d %H:%M:%S')*
EOF

# Git 操作
git add -A

if ! git diff --staged --quiet; then
    git commit -m "📦 每周备份 $WEEK_NUM ($TIMESTAMP)"
    git push -u origin main 2>/dev/null || git push origin main
fi

# 清理旧备份（保留最近 12 周）
echo "🧹 清理旧备份..."
cd "$BACKUP_DIR"
ls -t workspace_*.tar.gz | tail -n +13 | xargs -r rm -f

echo "✅ 备份完成！"
```

### Cron 配置

```bash
# 编辑 crontab
crontab -e

# 添加任务（每周日凌晨 3 点）
0 3 * * 0 /Users/autumn/.openclaw/workspace/scripts/backup-workspace-weekly.sh >> /Users/autumn/.openclaw/logs/workspace-backup.log 2>&1
```

### 备份管理

```bash
# 查看备份文件
ls -lh /Users/autumn/.openclaw/backups/

# 查看备份历史
cd /Users/autumn/.openclaw/backups/github-repo
git log --oneline

# 手动触发备份
/Users/autumn/.openclaw/workspace/scripts/backup-workspace-weekly.sh

# 清理旧备份（保留最近 4 周）
cd /Users/autumn/.openclaw/backups
ls -t workspace_*.tar.gz | tail -n +5 | xargs rm -f
```

---

## 💻 项目代码备份

### 已备份项目

| 项目 | 仓库 | 状态 |
|------|------|------|
| PlaneWarHarmonyOS | plane-war-harmonyos | ✅ 已备份 |
| SunTracker | (未上传) | ⏳ 待备份 |
| 备份脚本 | openclaw-workspace-backup | ✅ 已备份 |

### 项目备份流程

```bash
# 1. 创建 GitHub 仓库
gh repo create project-name --private --description "项目描述"

# 2. 初始化本地 Git
cd /path/to/project
git init
git remote add origin git@github.com:yyautumn330/project-name.git

# 3. 创建.gitignore
cat > .gitignore << EOF
# 构建产物
build/
dist/
*.log

# 依赖
node_modules/

# 系统文件
.DS_Store
EOF

# 4. 首次提交
git add -A
git commit -m "🎉 初始提交 - 项目创建"
git branch -M main
git push -u origin main

# 5. 后续更新
git add -A
git commit -m "✨ 新增：功能描述"
git push
```

### Git 提交规范

```bash
# 格式：<emoji> <类型>: <描述>

# Emoji 含义
🎉 初始提交
✨ 新功能
🐛 Bug 修复
📝 文档更新
🚀 性能优化
♻️ 代码重构
✅ 测试
🔧 配置

# 示例
git commit -m "🎉 初始提交 - 飞机大战项目"
git commit -m "✨ 新增：碰撞检测系统"
git commit -m "🐛 修复：空指针异常"
git commit -m "📝 文档：更新 README"
```

---

## 🔄 恢复流程

### 恢复记忆文件

```bash
# 1. 克隆备份仓库
cd /Users/autumn/.openclaw
git clone git@github.com:yyautumn330/openclaw-memory-backup.git .backup

# 2. 选择恢复版本
cd .backup
git log --oneline  # 查看历史提交
git checkout <commit-hash>  # 切换到指定版本

# 3. 恢复文件
cp SOUL.md ../workspace/
cp MEMORY.md ../workspace/
cp AGENTS.md ../workspace/
cp IDENTITY.md ../workspace/
```

### 恢复 Workspace

```bash
# 1. 下载备份文件
cd /Users/autumn/.openclaw
curl -L -o workspace_backup.tar.gz https://github.com/yyautumn330/openclaw-workspace-backup/releases/download/latest/workspace_YYYYMMDD_HHMMSS.tar.gz

# 2. 解压备份
tar -xzf workspace_backup.tar.gz -C /Users/autumn/.openclaw/

# 3. 验证恢复
ls -la /Users/autumn/.openclaw/workspace/
```

### 恢复项目代码

```bash
# 1. 克隆项目仓库
cd /Users/autumn/.openclaw/workspace
git clone git@github.com:yyautumn330/plane-war-harmonyos.git

# 2. 选择恢复版本
cd plane-war-harmonyos
git log --oneline
git checkout <commit-hash>

# 3. 恢复文件到工作区
git checkout <commit-hash> -- path/to/file
```

### 灾难恢复流程

```bash
# 完整恢复脚本
#!/bin/bash
# scripts/restore-from-backup.sh

set -e

echo "🔄 开始恢复 OpenClaw 工作空间..."

# 1. 备份当前状态（如果有）
if [ -d "/Users/autumn/.openclaw/workspace" ]; then
    mv /Users/autumn/.openclaw/workspace /Users/autumn/.openclaw/workspace.old.$(date +%Y%m%d_%H%M%S)
fi

# 2. 恢复记忆文件
echo "📝 恢复记忆文件..."
cd /Users/autumn/.openclaw
git clone git@github.com:yyautumn330/openclaw-memory-backup.git .backup
cp .backup/SOUL.md workspace/
cp .backup/MEMORY.md workspace/
cp .backup/AGENTS.md workspace/
cp .backup/IDENTITY.md workspace/

# 3. 恢复 Workspace
echo "📦 恢复 Workspace..."
LATEST_BACKUP=$(ls -t /Users/autumn/.openclaw/backups/workspace_*.tar.gz | head -1)
tar -xzf "$LATEST_BACKUP" -C /Users/autumn/.openclaw/

# 4. 恢复项目代码
echo "💻 恢复项目代码..."
cd /Users/autumn/.openclaw/workspace
git clone git@github.com:yyautumn330/plane-war-harmonyos.git

echo "✅ 恢复完成！"
```

---

## 📊 监控与告警

### 备份状态检查

```bash
#!/bin/bash
# scripts/check-backup-status.sh

# 检查记忆文件备份
LAST_MEMORY_BACKUP=$(cd /Users/autumn/.openclaw/workspace/.backup && git log -1 --format=%cd --date=short)
MEMORY_AGE=$(( ($(date +%s) - $(date -d "$LAST_MEMORY_BACKUP" +%s)) / 86400 ))

if [ $MEMORY_AGE -gt 2 ]; then
    echo "⚠️ 警告：记忆文件备份已超过 $MEMORY_AGE 天未更新"
fi

# 检查 Workspace 备份
LAST_WORKSPACE_BACKUP=$(ls -t /Users/autumn/.openclaw/backups/workspace_*.tar.gz | head -1)
if [ -n "$LAST_WORKSPACE_BACKUP" ]; then
    WORKSPACE_AGE=$(( ($(date +%s) - $(stat -f%m "$LAST_WORKSPACE_BACKUP" 2>/dev/null || stat -c%Y "$LAST_WORKSPACE_BACKUP")) / 86400 ))
    if [ $WORKSPACE_AGE -gt 14 ]; then
        echo "⚠️ 警告：Workspace 备份已超过 $WORKSPACE_AGE 天未更新"
    fi
else
    echo "❌ 错误：未找到 Workspace 备份文件"
fi

# 检查 Git 推送状态
cd /Users/autumn/.openclaw/workspace/.backup
if ! git status | grep -q "up to date"; then
    echo "⚠️ 警告：记忆文件备份有未推送的提交"
fi
```

### 告警通知（飞书）

```bash
#!/bin/bash
# scripts/send-backup-alert.sh

MESSAGE="$1"

# 发送到飞书
curl -X POST https://open.feishu.cn/open-apis/im/v1/messages \
  -H "Authorization: Bearer $FEISHU_TOKEN" \
  -H "Content-Type: application/json" \
  -d "{
    \"receive_id\": \"$USER_ID\",
    \"msg_type\": \"text\",
    \"content\": {\"text\": \"🚨 备份告警：$MESSAGE\"}
  }"
```

### 监控仪表板

```bash
# 查看备份统计
echo "📊 备份统计报告"
echo "================"
echo ""
echo "记忆文件备份:"
cd /Users/autumn/.openclaw/workspace/.backup
echo "  - 提交次数：$(git rev-list --count HEAD)"
echo "  - 最后更新：$(git log -1 --format=%cd)"
echo "  - 文件大小：$(du -sh . | cut -f1)"
echo ""
echo "Workspace 备份:"
cd /Users/autumn/.openclaw/backups
echo "  - 备份数量：$(ls workspace_*.tar.gz | wc -l)"
echo "  - 最新备份：$(ls -lt workspace_*.tar.gz | head -1 | awk '{print $9, $5}')"
echo "  - 总大小：$(du -sh . | cut -f1)"
```

---

## 📚 相关文档

- [安装指南](./GUIDE_INSTALLATION.md)
- [飞书集成](./GUIDE_FEISHU_INTEGRATION.md)
- [最佳实践](./GUIDE_BEST_PRACTICES.md)

---

## 🔗 资源链接

- **GitHub**: https://github.com/yyautumn330
- **备份仓库**:
  - [openclaw-memory-backup](https://github.com/yyautumn330/openclaw-memory-backup)
  - [openclaw-workspace-backup](https://github.com/yyautumn330/openclaw-workspace-backup)
  - [plane-war-harmonyos](https://github.com/yyautumn330/plane-war-harmonyos)

---

*最后更新：2026-03-03*  
*维护者：小白 (CodeMaster)*
