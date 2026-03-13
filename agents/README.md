# 🎭 OpenClaw 多身份切换系统

> **作者**: 小白 (XiaoBai)  
> **创建时间**: 2026-03-04  
> **用途**: 在不同场景下切换不同的 Agent 身份

---

## 📋 可用身份

| 身份 | 代号 | 表情 | 适用场景 | 切换命令 |
|------|------|------|----------|----------|
| **程序员** | CM-Dev | 👨‍💻 | 代码开发、架构设计、调试优化 | `/agent dev` |
| **创作者** | CM-Creator | 🎨 | 文档创作、音视频、图片生成 | `/agent creator` |

---

## 🔄 切换方法

### 方法 1: 命令切换 (推荐)

```bash
# 切换到开发模式
/agent dev

# 切换到创作模式
/agent creator

# 查看当前身份
/agent status
```

### 方法 2: 手动加载

```bash
# 加载开发身份
read /Users/autumn/.openclaw/workspace/IDENTITY.md
read /Users/autumn/.openclaw/workspace/SOUL.md

# 加载创作身份
read /Users/autumn/.openclaw/workspace/agents/IDENTITY-Creator.md
read /Users/autumn/.openclaw/workspace/agents/SOUL-Creator.md
```

### 方法 3: 配置文件切换

编辑 `~/.openclaw/workspace/ACTIVE_AGENT.md`:

```markdown
# 当前激活的身份
# dev     - 程序员 (默认)
# creator - 创作者

active_agent: creator
```

---

## 📁 文件结构

```
workspace/
├── IDENTITY.md              # 默认身份 (程序员)
├── SOUL.md                  # 默认人格
├── AGENTS.md                # 工作规则
├── TOOLS.md                 # 工具配置
│
└── agents/                  # 多身份目录
    ├── README.md            # 本文件
    ├── IDENTITY-Dev.md      # 程序员身份 (备份)
    ├── SOUL-Dev.md          # 程序员人格 (备份)
    ├── IDENTITY-Creator.md  # 创作者身份
    ├── SOUL-Creator.md      # 创作者人格
    └── TOOLS-Creator.md     # 创作者工具配置
```

---

## 🎯 身份能力对比

### 程序员 (CM-Dev) 👨‍💻

**核心能力**:
- 🏗️ 架构设计
- 💻 代码编写
- 🐛 调试优化
- 🚀 发布部署

**适用场景**:
- iOS/鸿蒙/安卓开发
- 代码审查
- 性能优化
- 技术方案设计

**常用工具**:
- `github` - GitHub 操作
- `mcporter` - MCP 服务器
- `coding-agent` - 代码代理
- `gh-issues` - GitHub Issues

---

### 创作者 (CM-Creator) 🎨

**核心能力**:
- ✍️ 内容创作
- 🎨 图片生成
- 🎤 音频处理
- 🎬 视频制作
- 📱 发布运营

**适用场景**:
- 技术文章撰写
- 教程编写
- 封面图设计
- 短视频脚本
- 多平台发布

**常用工具**:
- `nano-banana-pro` - 图像生成/编辑
- `openai-whisper` - 语音转文字
- `sag` - ElevenLabs TTS
- `video-frames` - 视频帧提取
- `feishu_doc` - 飞书文档
- `summarize` - 内容总结

---

## 🧬 创作基因详解

### 文档创作 ✍️

```bash
# 技术文章
openclaw "写一篇 OpenClaw 入门指南，3000 字，适合新手"

# 教程编写
openclaw "编写微信接入教程，包含截图位置说明"

# 文案策划
openclaw "为这篇文章写 5 个小红书风格的标题"
```

### 图片生成 🎨

```bash
# 封面图
openclaw "生成科技感封面图，蓝色主题，OpenClaw 标志"

# 插图
openclaw "生成流程图，展示 OpenClaw 架构"

# 信息图
openclaw "生成对比图，52 个技能分类展示"
```

### 音频处理 🎤

```bash
# 语音转文字
openclaw "/transcribe meeting-recording.mp3"

# 文字转语音
openclaw "/tts 你好，欢迎观看本教程"

# 播客制作
openclaw "将这篇文章转成播客脚本，双人对话风格"
```

### 视频制作 🎬

```bash
# 视频帧提取
openclaw "/video-frames input.mp4 --fps 1"

# 短视频剪辑
openclaw "剪辑一个 30 秒的 OpenClaw 介绍视频"

# 字幕添加
openclaw "为这个视频添加中文字幕"
```

---

## 📊 工作流示例

### 创作一篇技术文章

```
1. /agent creator          # 切换到创作模式
2. 选题策划 → 大纲设计
3. 内容创作 → 配图生成
4. 人工审核 → 平台适配
5. 发布追踪 → 数据复盘
```

### 开发一个功能

```
1. /agent dev              # 切换到开发模式
2. 需求分析 → 架构设计
3. 代码编写 → 单元测试
4. 代码审查 → 性能优化
5. 部署发布 → 监控运维
```

---

## ⚙️ 高级配置

### 自动切换 (基于上下文)

在 `AGENTS.md` 中添加：

```markdown
## 自动身份切换

- 提到"代码"、"开发"、"调试" → 自动切换到 dev
- 提到"文章"、"图片"、"视频" → 自动切换到 creator
```

### 混合模式

某些任务需要两个身份协作：

```
1. /agent dev      # 开发模式：编写代码
2. /agent creator  # 创作模式：写教程
3. 最终产出：代码 + 文档
```

---

## 📝 使用建议

### 何时切换身份？

**切换到开发模式**:
- 需要写代码
- 调试问题
- 架构设计
- 代码审查

**切换到创作模式**:
- 写文章/教程
- 生成图片
- 处理音视频
- 策划内容

### 身份切换频率？

- **专注模式**: 一次只做一类任务，减少切换
- **混合模式**: 根据任务自然切换，不必强求

---

## 🔮 未来扩展

### 计划新增身份

| 身份 | 代号 | 用途 | 状态 |
|------|------|------|------|
| 研究员 | CM-Research | 文献调研、技术分析 | 📋 计划中 |
| 运营官 | CM-Ops | 数据分析、用户运营 | 📋 计划中 |
| 设计师 | CM-Design | UI/UX设计、视觉优化 | 📋 计划中 |

### 高级功能

- [ ] 身份记忆隔离 (不同身份独立记忆)
- [ ] 身份协作模式 (多个身份同时工作)
- [ ] 自动身份识别 (根据上下文自动切换)
- [ ] 身份自定义 (用户创建自己的身份)

---

*最后更新*: 2026-03-04  
*维护者*: 小白 (XiaoBai) 👨‍💻🎨
