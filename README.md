# 🍂 OpenClaw Workspace

> **Autumn 的 OpenClaw 工作区**  
> 多身份 Agent 系统 - 程序员 & 创作者

---

## 🎭 可用身份

### 👨‍💻 程序员 (Coder)

**默认身份** - 全栈移动开发工程师

- **工作区**: [`coder/`](./coder/README.md)
- **身份文件**: `coder/IDENTITY.md`, `coder/SOUL.md`, `coder/TOOLS.md`
- **擅长**: iOS/安卓/鸿蒙开发、架构设计、代码审查
- **触发词**: "写代码", "开发", "实现", "修复 bug"

### 🎨 创作者 (Creator)

内容创作者 & 设计师

- **工作区**: [`creator/`](./creator/README.md)
- **身份文件**: `creator/IDENTITY.md`, `creator/SOUL.md`, `creator/TOOLS.md`
- **擅长**: 文章写作、教程编写、AI 图像生成、视频制作
- **触发词**: "写文章", "创作", "设计", "生成图片"

---

## 📁 目录结构

```
workspace/
├── AGENTS.md                 # Agent 总控配置
├── HEARTBEAT.md              # 心跳任务配置
├── README.md                 # 本说明文档
│
├── coder/                    # 👨‍💻 程序员工作区
│   ├── IDENTITY.md
│   ├── SOUL.md
│   ├── TOOLS.md
│   ├── projects/             # 开发项目
│   ├── scripts/              # 脚本工具
│   ├── snippets/             # 代码片段
│   ├── learning/             # 学习笔记
│   └── tools/                # 工具配置
│
├── creator/                  # 🎨 创作者工作区
│   ├── IDENTITY.md
│   ├── SOUL.md
│   ├── TOOLS.md
│   ├── articles/             # 文章创作
│   ├── blog/                 # 博客内容
│   ├── guides/               # 教程指南
│   ├── media/                # 媒体资源
│   └── research/             # 创作调研
│
├── shared/                   # 📚 共享资源
│   ├── resources/            # 参考资料
│   ├── templates/            # 模板文件
│   └── assets/               # 通用素材
│
├── config/                   # ⚙️ 配置目录
│   ├── logs/                 # 日志文件
│   ├── tmp/                  # 临时文件
│   └── skills/               # 技能配置
│
└── memory/                   # 🧠 记忆系统
    ├── MEMORY.md             # 长期记忆
    └── YYYY-MM-DD.md         # 每日日志
```

---

## 🚀 快速开始

### 切换身份

```bash
# 切换到程序员模式
/agent dev

# 切换到创作者模式
/agent creator

# 查看当前身份
/agent status
```

### 日常使用

**开发任务**:
```
帮我写一个 iOS 登录页面
→ 自动使用 coder 工作区
→ 加载程序员身份配置
→ 输出代码实现
```

**创作任务**:
```
写一篇 OpenClaw 入门教程
→ 自动使用 creator 工作区
→ 加载创作者身份配置
→ 输出文章 + 配图建议
```

---

## 📋 配置文件

| 文件 | 用途 | 位置 |
|------|------|------|
| `AGENTS.md` | Agent 总控 | 根目录 |
| `HEARTBEAT.md` | 心跳任务 | 根目录 |
| `IDENTITY.md` | 身份定义 | coder/ 或 creator/ |
| `SOUL.md` | 人格特质 | coder/ 或 creator/ |
| `TOOLS.md` | 工具配置 | coder/ 或 creator/ |

---

## 🧠 记忆系统

### 短期记忆
- 位置：`memory/YYYY-MM-DD.md`
- 用途：记录每日工作日志
- 清理：自动保留最近 30 天

### 长期记忆
- 位置：`memory/MEMORY.md`
- 用途：重要决策、经验教训
- 维护：定期整理更新

---

## 🛠️ 常用命令

### 身份管理
```bash
/agent dev          # 切换到程序员
/agent creator      # 切换到创作者
/agent status       # 查看当前身份
/agent list         # 列出所有身份
```

### 文件操作
```bash
# 在 coder 工作区创建文件
touch coder/projects/my-app/README.md

# 在 creator 工作区创建文章
touch creator/articles/drafts/new-post.md
```

### 技能管理
```bash
npx clawhub list          # 列出已安装技能
npx clawhub install <pkg> # 安装新技能
npx clawhub update --all  # 更新所有技能
```

---

## 📊 工作区统计

| 工作区 | 文件数 | 大小 | 最后更新 |
|--------|--------|------|---------|
| coder | - | - | 2026-03-05 |
| creator | - | - | 2026-03-05 |
| shared | - | - | 2026-03-05 |
| config | - | - | 2026-03-05 |

---

## ⚠️ 注意事项

### 文件存放

✅ **推荐**:
- 代码 → `coder/scripts/` 或 `coder/projects/`
- 文章 → `creator/articles/` 或 `creator/blog/`
- 图片 → `creator/media/images/`
- 配置 → `config/`

❌ **避免**:
- 根目录存放文件（配置文件除外）
- 临时文件长期存放
- 跨工作区混用文件

### 身份切换

- 切换身份会自动加载对应配置文件
- 混合任务可以手动切换身份
- 重要操作前确认当前身份

---

## 🔗 相关资源

- [OpenClaw 文档](https://docs.openclaw.ai)
- [ClawHub 技能市场](https://clawhub.com)
- [GitHub 仓库](https://github.com/openclaw/openclaw)
- [Discord 社区](https://discord.com/invite/clawd)

---

*最后更新*: 2026-03-05  
*维护者*: Autumn & OpenClaw Team  
*版本*: 2026.3.2
