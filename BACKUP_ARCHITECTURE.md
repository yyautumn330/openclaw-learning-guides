# 🏗️ OpenClaw 三仓库备份架构

> **创建时间**: 2026-03-04  
> **作者**: 小白 (CodeMaster)

---

## 📊 仓库架构总览

我们使用**三个独立的 GitHub 仓库**分别备份不同类型的内容：

```
┌─────────────────────────────────────────────────────────┐
│  仓库 1: openclaw-learning-guides                       │
│  用途：学习指南与总结文档归档                            │
│  频率：每日更新                                          │
│  内容：guides/ 目录                                      │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│  仓库 2: openclaw-memory-backup                         │
│  用途：核心记忆文件备份                                  │
│  频率：每日更新                                          │
│  内容：SOUL.md, MEMORY.md, AGENTS.md 等                 │
└─────────────────────────────────────────────────────────┘
                            ↓
┌─────────────────────────────────────────────────────────┐
│  仓库 3: openclaw-workspace-backup                      │
│  用途：完整 Workspace 压缩包备份                         │
│  频率：每周更新                                          │
│  内容：workspace_*.tar.gz                               │
└─────────────────────────────────────────────────────────┘
```

---

## 📁 仓库详情

### 1. openclaw-learning-guides 📚

**仓库地址**: https://github.com/yyautumn330/openclaw-learning-guides

**用途**: 学习指南与总结文档的官方归档

**内容**:
```
guides/
├── README.md                        # 索引文档
├── GUIDE_INSTALLATION.md            # 安装指南
├── GUIDE_FEISHU_INTEGRATION.md      # 飞书集成
├── GUIDE_BACKUP_STRATEGY.md         # 备份策略
├── OPENCLAW_MONTHLY_SUMMARY.md      # 月度总结
└── REPOSITORY_INFO.md               # 仓库说明
```

**更新频率**: 每日 23:00 自动更新

**脚本**: `scripts/daily-summary-update.sh`

**Cron 配置**:
```bash
0 23 * * * /Users/autumn/.openclaw/workspace/scripts/daily-summary-update.sh
```

---

### 2. openclaw-memory-backup 💾

**仓库地址**: https://github.com/yyautumn330/openclaw-memory-backup

**用途**: 核心记忆文件备份

**内容**:
```
.backup/
├── SOUL.md                          # AI 人格定义
├── MEMORY.md                        # 长期记忆
├── AGENTS.md                        # 工作规则
├── IDENTITY.md                      # 身份信息
├── USER.md                          # 用户信息
└── SOUL_*.md                        # 带时间戳的历史版本
```

**更新频率**: 每日 2:00 AM 自动更新

**脚本**: `scripts/backup-to-github.sh`

**Cron 配置**:
```bash
0 2 * * * /Users/autumn/.openclaw/workspace/scripts/backup-to-github.sh >> /Users/autumn/.openclaw/workspace/logs/backup.log 2>&1
```

---

### 3. openclaw-workspace-backup 📦

**仓库地址**: https://github.com/yyautumn330/openclaw-workspace-backup

**用途**: 完整 Workspace 压缩包备份

**内容**:
```
github-repo/
├── README.md                        # 备份说明
└── workspace_YYYYMMDD_HHMMSS.tar.gz # 压缩包（保留 12 周）
```

**更新频率**: 每周日 3:00 AM 自动更新

**脚本**: `scripts/backup-workspace-weekly.sh`

**Cron 配置**:
```bash
0 3 * * 0 /Users/autumn/.openclaw/workspace/scripts/backup-workspace-weekly.sh >> /Users/autumn/.openclaw/logs/workspace-backup.log 2>&1
```

**保留策略**: 自动清理，保留最近 12 周的备份

---

## ⚙️ 配置文件

### .gitignore (Workspace 主目录)

```bash
# 排除三个独立仓库
.backup/
guides/

# 其他排除项
logs/
*.log
build/
node_modules/
.DS_Store
```

### Crontab 完整配置

```bash
# 查看当前配置
crontab -l

# 应该包含以下三行：
0 2 * * * /Users/autumn/.openclaw/workspace/scripts/backup-to-github.sh >> /Users/autumn/.openclaw/workspace/logs/backup.log 2>&1
0 3 * * 0 /Users/autumn/.openclaw/workspace/scripts/backup-workspace-weekly.sh >> /Users/autumn/.openclaw/logs/workspace-backup.log 2>&1
0 23 * * * /Users/autumn/.openclaw/workspace/scripts/daily-summary-update.sh >> /Users/autumn/.openclaw/logs/daily-update.log 2>&1
```

---

## 🔧 手动操作指南

### 手动更新 Learning Guides

```bash
# 1. 进入 guides 目录
cd /Users/autumn/.openclaw/workspace/guides

# 2. 查看状态
git status

# 3. 提交变更
git add -A
git commit -m "📝 更新文档说明"

# 4. 推送到 GitHub
git push origin main

# 如果 HTTPS 失败，使用 SSH
git remote set-url origin git@github.com:yyautumn330/openclaw-learning-guides.git
git push origin main
```

### 手动更新 Memory Backup

```bash
# 1. 运行备份脚本
/Users/autumn/.openclaw/workspace/scripts/backup-to-github.sh

# 2. 或手动操作
cd /Users/autumn/.openclaw/workspace/.backup
git add -A
git commit -m "📝 手动备份"
git push origin main
```

### 手动更新 Workspace Backup

```bash
# 1. 运行备份脚本
/Users/autumn/.openclaw/workspace/scripts/backup-workspace-weekly.sh

# 2. 或手动操作
cd /Users/autumn/.openclaw/backups/github-repo
git add -A
git commit -m "📦 手动备份"
git push origin main
```

---

## 📊 验证备份状态

### 检查 Learning Guides

```bash
cd /Users/autumn/.openclaw/workspace/guides
git log --oneline -5
git remote -v
```

### 检查 Memory Backup

```bash
cd /Users/autumn/.openclaw/workspace/.backup
git log --oneline -5
ls -la *.md
```

### 检查 Workspace Backup

```bash
cd /Users/autumn/.openclaw/backups
ls -lh workspace_*.tar.gz
cd github-repo
git log --oneline -5
```

### 查看日志

```bash
# 记忆文件备份日志
tail -f /Users/autumn/.openclaw/workspace/logs/backup.log

# Workspace 备份日志
tail -f /Users/autumn/.openclaw/logs/workspace-backup.log

# 每日更新日志
tail -f /Users/autumn/.openclaw/logs/daily-update.log
```

---

## ⚠️ 常见问题

### 问题 1: GitHub 推送失败

**错误**: `Failed to connect to github.com port 443`

**解决方案**:
```bash
# 1. 检查网络连接
ping github.com

# 2. 使用 SSH 代替 HTTPS
git remote set-url origin git@github.com:user/repo.git

# 3. 测试 SSH 连接
ssh -T git@github.com

# 4. 稍后重试
```

### 问题 2: Cron 任务不执行

**排查步骤**:
```bash
# 1. 检查 crontab
crontab -l

# 2. 查看 cron 日志
tail -f /var/log/system.log | grep cron

# 3. 确保脚本有执行权限
chmod +x /Users/autumn/.openclaw/workspace/scripts/*.sh

# 4. 手动测试脚本
/Users/autumn/.openclaw/workspace/scripts/daily-summary-update.sh
```

### 问题 3: 仓库内容混淆

**解决**: 确保每个仓库的 `.gitignore` 正确配置：

**Workspace 主目录**:
```bash
.backup/
guides/
logs/
```

**Guides 仓库**: 不需要特殊忽略

**Memory Backup**: 不需要特殊忽略

**Workspace Backup**: 不需要特殊忽略

---

## 📈 备份统计

### 查看各仓库大小

```bash
# Memory Backup
cd /Users/autumn/.openclaw/workspace/.backup
du -sh .

# Workspace Backup
cd /Users/autumn/.openclaw/backups
du -sh .

# Learning Guides
cd /Users/autumn/.openclaw/workspace/guides
du -sh .
```

### 查看提交历史

```bash
# Memory Backup
cd /Users/autumn/.openclaw/workspace/.backup
git log --oneline | wc -l

# Workspace Backup
cd /Users/autumn/.openclaw/backups/github-repo
git log --oneline | wc -l

# Learning Guides
cd /Users/autumn/.openclaw/workspace/guides
git log --oneline | wc -l
```

---

## 🔗 相关链接

| 仓库 | URL |
|------|-----|
| **Learning Guides** | https://github.com/yyautumn330/openclaw-learning-guides |
| **Memory Backup** | https://github.com/yyautumn330/openclaw-memory-backup |
| **Workspace Backup** | https://github.com/yyautumn330/openclaw-workspace-backup |
| **Plane War** | https://github.com/yyautumn330/plane-war-harmonyos |

---

*最后更新：2026-03-04*  
*维护者：小白 (CodeMaster) 👨‍💻*
