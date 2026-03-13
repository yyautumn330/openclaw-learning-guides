# 🗂️ Workspace 重组方案

> **目标**: 将不同 Agent 身份的 workspace 分离，实现清晰的职责划分和文件归档  
> **创建时间**: 2026-03-05  
> **状态**: 📋 规划中

---

## 📐 设计原则

1. **职责分离**: 编程归程序员，创作归创作者
2. **路径稳定**: 已使用的文件路径需要保持或提供迁移指引
3. **易于导航**: 目录结构清晰，文件按类型归档
4. **可扩展**: 未来新增身份时易于扩展

---

## 🏗️ 新 Workspace 架构

### 主工作区 (`~/.openclaw/workspace/`)

```
~/.openclaw/workspace/
├── AGENTS.md                 # 总控文档（保留）
├── HEARTBEAT.md              # 心跳任务（保留）
├── README.md                 # 总览说明
│
├── config/                   # 配置文件
│   ├── .gitignore
│   └── [其他全局配置]
│
├── memory/                   # 记忆系统（共享）
│   ├── MEMORY.md             # 长期记忆
│   └── YYYY-MM-DD.md         # 每日日志
│
├── shared/                   # 共享资源（所有身份可用）
│   ├── resources/            # 参考资料
│   ├── templates/            # 模板文件
│   └── assets/               # 通用素材
│
├── coder/                    # 👨‍💻 程序员工作区
│   ├── IDENTITY.md           # 程序员身份
│   ├── SOUL.md               # 程序员人格
│   ├── TOOLS.md              # 程序员工具
│   ├── README.md             # 使用说明
│   │
│   ├── projects/             # 开发项目
│   │   ├── [project-name]/
│   │   └── README.md
│   │
│   ├── scripts/              # 脚本工具
│   │   ├── python/
│   │   ├── shell/
│   │   └── README.md
│   │
│   ├── snippets/             # 代码片段
│   │   ├── ios/
│   │   ├── android/
│   │   ├── harmonyos/
│   │   └── README.md
│   │
│   ├── learning/             # 学习笔记
│   │   ├── tutorials/
│   │   ├── docs/
│   │   └── README.md
│   │
│   └── tools/                # 开发工具配置
│       ├── linters/
│       ├── formatters/
│       └── README.md
│
└── creator/                  # 🎨 创作者工作区
    ├── IDENTITY.md           # 创作者身份
    ├── SOUL.md               # 创作者人格
    ├── TOOLS.md              # 创作者工具
    ├── README.md             # 使用说明
    │
    ├── articles/             # 文章创作
    │   ├── drafts/           # 草稿
    │   ├── published/        # 已发布
    │   └── README.md
    │
    ├── blog/                 # 博客内容
    │   ├── posts/
    │   ├── series/
    │   └── README.md
    │
    ├── guides/               # 教程指南
    │   ├── technical/
    │   ├── howto/
    │   └── README.md
    │
    ├── media/                # 媒体资源
    │   ├── images/           # 生成的图片
    │   ├── videos/           # 视频文件
    │   └── README.md
    │
    └── research/             # 创作调研
        ├── topics/
        ├── references/
        └── README.md
```

---

## 📦 文件迁移计划

### 根目录文件归类

| 当前文件 | 迁移目标 | 说明 |
|---------|---------|------|
| `IDENTITY.md` | `coder/IDENTITY.md` | 程序员身份 |
| `SOUL.md` | `coder/SOUL.md` | 程序员人格 |
| `TOOLS.md` | `coder/TOOLS.md` | 程序员工具 |
| `USER.md` | `shared/USER.md` | 用户信息（共享） |
| `BOOTSTRAP.md` | `config/BOOTSTRAP.md` | 启动配置 |
| `AGENTS.md` | 保留根目录 | 总控文档 |
| `HEARTBEAT.md` | 保留根目录 | 心跳任务 |
| `README.md` | 保留根目录 + 各子目录 | 分层说明 |
| `2026-ai-trends-summary.md` | `creator/research/` | AI 趋势分析 |
| `harmonyos-kids-tutorial.md` | `creator/guides/technical/` | 教程文档 |
| `AI_PAINTING_GUIDE.md` | `creator/guides/technical/` | AI 绘画指南 |
| `*.py` (图像生成) | `coder/scripts/python/` | Python 脚本 |
| `*.txt` (临时文件) | `config/tmp/` 或删除 | 清理临时文件 |
| `*.png` (截图) | `creator/media/images/` | 图片资源 |

### 现有目录迁移

| 当前目录 | 迁移目标 | 说明 |
|---------|---------|------|
| `agents/` | `config/agents-archive/` | 归档旧身份配置 |
| `blog/` | `creator/blog/` | 博客内容 |
| `programming/` | `coder/` (合并) | 编程内容合并 |
| `projects/` | `coder/projects/` | 开发项目 |
| `resources/` | `shared/resources/` | 共享资源 |
| `guides/` | `creator/guides/` | 教程指南 |
| `memory/` | 保留 | 记忆系统（共享） |
| `scripts/` | `coder/scripts/` | 脚本工具 |
| `skills/` | `config/skills/` | 技能配置 |
| `generated_images/` | `creator/media/images/` | 生成图片 |
| `logs/` | `config/logs/` | 日志文件 |
| `.backup/` | 保留 | 备份目录 |
| `.clawhub/` | 保留 | ClawHub 配置 |
| `.openclaw/` | 保留 | OpenClaw 配置 |
| `.pi/` | 保留 | Pi 配置 |

---

## 🔧 路径调整清单

### 需要更新的引用路径

| 原路径 | 新路径 | 影响范围 |
|-------|-------|---------|
| `/workspace/IDENTITY.md` | `/workspace/coder/IDENTITY.md` | 程序员会话 |
| `/workspace/SOUL.md` | `/workspace/coder/SOUL.md` | 程序员会话 |
| `/workspace/TOOLS.md` | `/workspace/coder/TOOLS.md` | 程序员会话 |
| `/workspace/agents/IDENTITY-Creator.md` | `/workspace/creator/IDENTITY.md` | 创作者会话 |
| `/workspace/agents/SOUL-Creator.md` | `/workspace/creator/SOUL.md` | 创作者会话 |
| `/workspace/agents/TOOLS-Creator.md` | `/workspace/creator/TOOLS.md` | 创作者会话 |
| `/workspace/blog/` | `/workspace/creator/blog/` | 博客相关 |
| `/workspace/programming/` | `/workspace/coder/` | 编程相关 |
| `/workspace/generated_images/` | `/workspace/creator/media/images/` | 图片生成 |
| `/workspace/scripts/` | `/workspace/coder/scripts/` | 脚本执行 |

### AGENTS.md 更新

需要更新 `AGENTS.md` 中的路径引用：

```markdown
## 每一会话

1. Read `coder/SOUL.md` — 程序员身份
2. Read `creator/SOUL.md` — 创作者身份
3. Read `memory/YYYY-MM-DD.md` — 日常记忆
4. Read `memory/MEMORY.md` — 长期记忆（主会话）
```

---

## 🎯 实施步骤

### 阶段 1: 准备 (5 分钟)

1. ✅ 创建新的目录结构
2. ✅ 创建各目录的 README.md
3. ✅ 备份当前 workspace

### 阶段 2: 迁移文件 (10 分钟)

1. 移动身份文件 (IDENTITY, SOUL, TOOLS)
2. 迁移现有目录
3. 清理临时文件

### 阶段 3: 更新配置 (5 分钟)

1. 更新 AGENTS.md 路径引用
2. 更新 HEARTBEAT.md
3. 更新身份切换文档

### 阶段 4: 验证 (5 分钟)

1. 测试程序员身份加载
2. 测试创作者身份加载
3. 验证文件路径正确性

---

## ⚠️ 注意事项

### 向后兼容

- 旧路径创建符号链接（可选）
- 在 README 中提供迁移指南
- 保留 `.backup/` 至少 7 天

### 会话连续性

- 迁移前提交所有更改
- 通知用户 workspace 重组
- 提供回滚方案

### 文件冲突

- 检查重复文件
- 合并相似内容
- 删除过时文件

---

## 📋 检查清单

### 目录结构

- [ ] 创建 `coder/` 目录树
- [ ] 创建 `creator/` 目录树
- [ ] 创建 `shared/` 目录树
- [ ] 创建 `config/` 目录树
- [ ] 各目录 README.md 就位

### 文件迁移

- [ ] 身份文件迁移 (IDENTITY, SOUL, TOOLS)
- [ ] 脚本文件迁移 (*.py)
- [ ] 文档迁移 (*.md)
- [ ] 媒体文件迁移 (*.png, *.jpg)
- [ ] 临时文件清理

### 配置更新

- [ ] 更新 AGENTS.md
- [ ] 更新 HEARTBEAT.md
- [ ] 更新身份切换文档
- [ ] 更新 .gitignore

### 验证测试

- [ ] 程序员身份正常加载
- [ ] 创作者身份正常加载
- [ ] 文件路径正确
- [ ] 脚本可正常执行

---

## 🔮 未来扩展

### 新增身份工作区

```
├── researcher/           # 🔬 研究员
│   ├── papers/
│   ├── surveys/
│   └── data/
│
├── operator/           # 📊 运营官
│   ├── analytics/
│   ├── reports/
│   └── metrics/
│
└── designer/           # 🎨 设计师
    ├── ui/
    ├── ux/
    └── assets/
```

### 共享机制

- 跨工作区文件引用
- 统一资源库管理
- 身份间协作流程

---

*创建时间*: 2026-03-05  
*维护者*: 小白 (XiaoBai) 👨‍💻🎨
