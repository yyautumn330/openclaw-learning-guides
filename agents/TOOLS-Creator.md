# TOOLS.md - 创作者工具配置

> **身份**: CM-Creator 🎨  
> **创建时间**: 2026-03-04  
> **用途**: 创作型 Agent 的工具配置和使用指南

---

## 🎨 核心工具链

### 文档创作类

| 工具 | 用途 | 配置 | 状态 |
|------|------|------|------|
| `feishu_doc` | 飞书文档 | 已配置 | ✅ 可用 |
| `notion` | Notion 集成 | 需 Token | ⚠️ 待配置 |
| `obsidian` | Obsidian 管理 | 需路径 | ⚠️ 待配置 |
| `blog` | 博客系统 | 本地目录 | ✅ 可用 |

**博客目录**:
```
/Users/autumn/.openclaw/workspace/blog/
├── drafts/        # 草稿
├── published/     # 已发布
└── assets/        # 配图
```

---

### 图片生成类

| 工具 | 用途 | 配置 | 状态 |
|------|------|------|------|
| `nano-banana-pro` | Gemini 图像 | 需 API Key | ⚠️ 待配置 |
| `openai-image-gen` | DALL-E 3 | 需 API Key | ⚠️ 待配置 |

**配置方法**:

```bash
# Nano Banana Pro (Gemini)
openclaw config set tools.nano-banana-pro.api_key "你的 Gemini API Key"

# OpenAI Image (DALL-E 3)
openclaw config set tools.openai-image-gen.api_key "你的 OpenAI API Key"
```

**使用示例**:

```bash
# 生成封面图
openclaw "生成科技感封面图，蓝色主题，OpenClaw 标志，16:9"

# 编辑图片
openclaw "给这张图片添加文字标题'OpenClaw 入门指南'"

# 生成插图
openclaw "生成流程图，展示 OpenClaw 架构，简洁风格"
```

---

### 音频处理类

| 工具 | 用途 | 配置 | 状态 |
|------|------|------|------|
| `openai-whisper` | 语音转文字 | 本地运行 | ✅ 可用 |
| `sag` | ElevenLabs TTS | 需 API Key | ⚠️ 待配置 |
| `sherpa-onnx-tts` | 本地 TTS | 已安装 | ✅ 可用 |

**使用示例**:

```bash
# 语音转文字
openclaw "/transcribe meeting-recording.mp3"

# 文字转语音
openclaw "/tts 你好，欢迎观看本教程"

# 生成播客
openclaw "将这篇文章转成双人对话播客脚本"
```

---

### 视频处理类

| 工具 | 用途 | 配置 | 状态 |
|------|------|------|------|
| `video-frames` | 视频帧提取 | FFmpeg | ✅ 可用 |
| `summarize` | 视频总结 | 支持 YouTube | ✅ 可用 |

**使用示例**:

```bash
# 提取视频帧
openclaw "/video-frames input.mp4 --fps 1 --output frames/"

# 剪辑视频
openclaw "剪辑这个视频，保留 0:30-1:00 和 2:15-3:00 片段"

# 添加字幕
openclaw "为这个视频添加中文字幕，白色字体，黑色描边"

# 视频总结
openclaw "/summarize https://youtube.com/watch?v=XXX"
```

---

### 发布运营类

| 工具 | 用途 | 配置 | 状态 |
|------|------|------|------|
| 半自动发布 | 人工审核发布 | 本地工作流 | ✅ 可用 |
| 知乎 API | 自动发布 | 需申请 | 📋 计划中 |
| 小红书 | 手动发布 | 无 API | ⚠️ 手动 |

**发布工作流**:

```
1. 生成文章 → blog/drafts/
2. 生成配图 → blog/assets/
3. 人工审核
4. 手动发布到平台
5. 记录发布状态 → blog/published/
```

---

## 🛠️ 创作模板

### 文章模板

```markdown
# 标题

> **作者**: 小白 (XiaoBai)  
> **发布时间**: 2026-XX-XX  
> **难度**: ⭐/⭐⭐/⭐⭐⭐  
> **预计阅读**: X 分钟

---

## 🎯 文章亮点

- ✅ 亮点 1
- ✅ 亮点 2
- ✅ 亮点 3

---

## 正文内容

...

---

**标签**: #标签 1 #标签 2 #标签 3

*最后更新*: 2026-XX-XX
```

### 封面图提示词模板

```
科技感，蓝色主题，{主题} 标志，简洁现代，16:9 比例，高分辨率

清新风格，{主题} 相关元素，温暖色调，小红书风格

专业范，{主题} 架构图，深色背景，知乎风格
```

### 视频脚本模板

```
[0:00-0:05] 开场
- 画面：封面图 + 标题
- 配音：欢迎来到本期教程...

[0:05-0:30] 引入
- 画面：问题场景展示
- 配音：你是否遇到过...

[0:30-2:00] 主体
- 画面：操作步骤演示
- 配音：第一步...第二步...

[2:00-2:30] 总结
- 画面：要点回顾
- 配音：今天我们学习了...

[2:30-3:00] 结尾
- 画面：二维码 + 关注
- 配音：喜欢请点赞关注...
```

---

## 📊 内容日历

### 发布计划表

| 日期 | 平台 | 文章标题 | 状态 | 配图 |
|------|------|----------|------|------|
| 3.5 | 小红书 | 5 分钟搭建 AI 助手 | 📝 草稿 | 🎨 待生成 |
| 3.6 | 知乎 | 技能安装指南 | 📝 草稿 | 🎨 待生成 |
| 3.8 | 公众号 | 心跳任务配置 | 📋 待写 | - |
| 3.10 | 小红书 | 飞书集成教程 | 📋 待写 | - |

### 数据追踪

| 平台 | 文章数 | 阅读量 | 点赞 | 收藏 | 评论 |
|------|--------|--------|------|------|------|
| 小红书 | 0 | 0 | 0 | 0 | 0 |
| 知乎 | 0 | 0 | 0 | 0 | 0 |
| 公众号 | 0 | 0 | 0 | 0 | 0 |

---

## 🎯 创作工作流

### 完整流程

```
1. 选题策划 (30min)
   ↓
2. 大纲设计 (30min)
   ↓
3. 内容创作 (2-4h)
   ↓
4. 配图生成 (1h)
   ↓
5. 人工审核 (30min)
   ↓
6. 平台适配 (1h)
   ↓
7. 发布追踪 (持续)
   ↓
8. 数据复盘 (每周)
```

### 快速流程 (短文)

```
1. 确定主题 (10min)
   ↓
2. 直接创作 (1h)
   ↓
3. 生成封面 (15min)
   ↓
4. 审核发布 (15min)
```

---

## ⚙️ 配置检查清单

### 必配项

- [ ] Feishu 文档 (已配置 ✅)
- [ ] 博客目录 (已创建 ✅)
- [ ] FFmpeg (需安装)
- [ ] Nano Banana Pro API Key

### 可选项

- [ ] Notion API Token
- [ ] Obsidian 仓库路径
- [ ] ElevenLabs API Key
- [ ] OpenAI API Key (DALL-E 3)
- [ ] 知乎开发者资质

---

## 📚 学习资源

- **Nano Banana Pro**: https://clawhub.ai/steipete/nano-banana-pro
- **Whisper**: https://clawhub.ai/steipete/openai-whisper
- **视频处理**: https://clawhub.ai/steipete/video-frames
- **Feishu 集成**: /Users/autumn/.openclaw/workspace/guides/03-Integration/GUIDE_FEISHU_INTEGRATION.md

---

*最后更新*: 2026-03-04  
*身份*: CM-Creator 🎨  
*切换回开发模式*: `/agent dev`
