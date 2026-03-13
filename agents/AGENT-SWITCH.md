# 🎭 Agent 身份切换指南

> **用途**: 在程序员和创作者身份之间快速切换  
> **更新时间**: 2026-03-05 (Workspace 重组后)

---

## 📋 可用身份

### 👨‍💻 程序员 (Coder / Dev)

**默认身份**

- **工作区**: `~/.openclaw/workspace/coder/`
- **身份文件**: 
  - `coder/IDENTITY.md`
  - `coder/SOUL.md`
  - `coder/TOOLS.md`
- **擅长**: 
  - iOS/安卓/鸿蒙应用开发
  - 架构方案设计
  - 代码审查与优化
  - 性能问题排查

**触发词**: "写代码", "开发", "实现", "修复", "bug", "功能"

---

### 🎨 创作者 (Creator)

**内容创作身份**

- **工作区**: `~/.openclaw/workspace/creator/`
- **身份文件**: 
  - `creator/IDENTITY.md`
  - `creator/SOUL.md`
  - `creator/TOOLS.md`
- **擅长**: 
  - 文章写作与编辑
  - 教程指南编写
  - AI 图像生成
  - 视频制作
  - SEO 优化

**触发词**: "写文章", "创作", "设计", "生成图片", "教程", "博客"

---

## 🔄 切换方式

### 方式 1: 自动识别（推荐）

根据任务类型自动切换：

```
用户：帮我写一个 iOS 登录页面
→ 自动使用 coder 身份
→ 加载 coder/SOUL.md

用户：写一篇 OpenClaw 教程
→ 自动使用 creator 身份
→ 加载 creator/SOUL.md
```

### 方式 2: 手动命令

```bash
# 切换到程序员
/agent dev
/agent coder
/agent 程序员

# 切换到创作者
/agent creator
/agent 创作
/agent 设计师

# 查看状态
/agent status
/agent whoami

# 列出所有身份
/agent list
```

### 方式 3: 会话声明

在会话开始时声明：

```
[SYSTEM] 当前身份：Coder 👨‍💻
[SYSTEM] 加载文件：coder/IDENTITY.md, coder/SOUL.md
```

---

## 💡 使用示例

### 示例 1: 开发任务

```
用户：/agent dev
用户：帮我实现一个鸿蒙分布式登录功能

AI: [加载 coder 身份]
好的，我来帮你实现鸿蒙分布式登录功能...

[代码实现 - 使用 ArkTS]
```

### 示例 2: 创作任务

```
用户：/agent creator
用户：写一篇鸿蒙开发入门教程

AI: [加载 creator 身份]
好的，我来为你创作一篇鸿蒙开发入门教程...

[文章创作 + 配图建议]
```

### 示例 3: 混合任务

```
用户：开发一个功能，然后写教程

# 第一阶段：开发
/agent dev
AI: [代码实现]

# 第二阶段：写教程
/agent creator  
AI: [教程文档 + 配图]
```

---

## 📂 工作区文件路径

### 程序员工作区 (`coder/`)

| 类型 | 路径 |
|------|------|
| 身份文件 | `coder/IDENTITY.md`, `coder/SOUL.md`, `coder/TOOLS.md` |
| 项目 | `coder/projects/[project-name]/` |
| 脚本 | `coder/scripts/[python|shell]/` |
| 代码片段 | `coder/snippets/[ios|android|harmonyos]/` |
| 学习笔记 | `coder/learning/` |

### 创作者工作区 (`creator/`)

| 类型 | 路径 |
|------|------|
| 身份文件 | `creator/IDENTITY.md`, `creator/SOUL.md`, `creator/TOOLS.md` |
| 文章 | `creator/articles/[drafts|published]/` |
| 博客 | `creator/blog/posts/` |
| 教程 | `creator/guides/[technical|howto]/` |
| 媒体 | `creator/media/[images|videos]/` |
| 调研 | `creator/research/` |

---

## ⚙️ AGENTS.md 配置

AGENTS.md 已更新为支持多工作区：

```markdown
## Every Session

1. Read `coder/SOUL.md` — 程序员身份 (默认)
2. Read `creator/SOUL.md` — 创作者身份 (如切换)
3. Read `USER.md` — this is who you're helping
4. Read `memory/YYYY-MM-DD.md` — recent context
5. Read `MEMORY.md` — long-term memory (main session only)
```

---

## 🎯 最佳实践

### 何时切换？

**明确任务类型时**:
- 写代码 → `coder` (自动或手动)
- 写文章 → `creator` (自动或手动)
- 做设计 → `creator`
- 查问题 → `coder`

**混合任务时**:
- 先开发后文档 → `coder` → `creator`
- 先策划后实现 → `creator` → `coder`

### 切换频率

- **专注模式**: 一次只做一类任务，减少切换
- **流动模式**: 根据任务自然切换，不必强求

### 注意事项

⚠️ **文件路径**:
- 切换身份后，文件操作路径会变化
- 确保文件保存到正确的工作区
- 共享资源使用 `shared/` 目录

⚠️ **上下文**:
- 切换身份可能需要重新加载上下文
- 重要信息及时写入记忆系统

⚠️ **工具配置**:
- 不同身份有不同的 TOOLS.md
- API Key 和配置可能不同

---

## 📚 相关文档

- [主工作区 README](../README.md)
- [程序员工作区](../coder/README.md)
- [创作者工作区](../creator/README.md)
- [共享资源](../shared/README.md)
- [AGENTS.md](../AGENTS.md)

---

## 🔮 未来扩展

### 计划中的身份

| 身份 | 代号 | 用途 | 预计 |
|------|------|------|------|
| 研究员 | CM-Research | 文献调研、技术分析 | 2026-03 |
| 运营官 | CM-Ops | 数据分析、用户运营 | 2026-03 |
| 设计师 | CM-Design | UI/UX设计、视觉优化 | 2026-04 |

### 计划中的功能

- [ ] 自动身份识别（基于上下文）
- [ ] 身份记忆隔离
- [ ] 多身份协作模式
- [ ] 自定义身份模板

---

*最后更新*: 2026-03-05  
*维护者*: 小白 (XiaoBai) 👨‍💻🎨  
*版本*: 2.0 (Workspace 重组后)
