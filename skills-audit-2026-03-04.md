# 📊 OpenClaw 技能审计报告

> **审计时间**: 2026-03-04 22:30  
> **技能总数**: 54 个  
> **审计人**: 小白 (XiaoBai)

---

## 📈 技能分类统计

### 按功能分类

| 分类 | 数量 | 技能列表 |
|------|------|----------|
| **📝 笔记集成** | 5 个 | apple-notes, apple-reminders, bear-notes, obsidian, notion |
| **💬 通讯社交** | 7 个 | discord, imsg, slack, wacli, bluebubbles, blucli, voice-call |
| **🎨 创意媒体** | 7 个 | nano-banana-pro, nano-pdf, openai-image-gen, openai-whisper, openai-whisper-api, sag, sherpa-onnx-tts, video-frames |
| **🛠️ 开发工具** | 6 个 | github, gh-issues, coding-agent, mcporter, skill-creator, canvas |
| **🏠 智能家居** | 5 个 | sonoscli, openhue, spotify-player, songsee, ordercli |
| **📱 系统工具** | 8 个 | 1password, camsnap, eightctl, goplaces, healthcheck, peekaboo, things-mac, tmux |
| **📊 数据办公** | 6 个 | gog, trello, oracle, himalaya, session-logs, model-usage |
| **🔧 核心技能** | 5 个 | clawhub, find-skills, self-improving-agent, gemini, weather |
| **🌐 网络工具** | 2 个 | gifgrep, xurl |
| **⏳ 待评估** | 3 个 | blogwatcher |

---

## ✅ 推荐保留 (核心技能)

### 🏆 必装技能 (15 个)

这些技能实用性强，建议保留：

| 技能 | 用途 | 推荐度 | 使用频率 |
|------|------|--------|----------|
| weather | 天气查询 | ⭐⭐⭐⭐⭐ | 高 |
| github | GitHub 操作 | ⭐⭐⭐⭐⭐ | 高 |
| summarize | 内容总结 | ⭐⭐⭐⭐⭐ | 高 |
| nano-pdf | PDF 编辑 | ⭐⭐⭐⭐⭐ | 高 |
| nano-banana-pro | AI 绘画 | ⭐⭐⭐⭐⭐ | 中 |
| openai-whisper | 语音转文字 | ⭐⭐⭐⭐⭐ | 中 |
| gog | Google 集成 | ⭐⭐⭐⭐ | 中 |
| notion | 知识库 | ⭐⭐⭐⭐ | 中 |
| obsidian | 笔记管理 | ⭐⭐⭐⭐ | 中 |
| find-skills | 技能发现 | ⭐⭐⭐⭐⭐ | 高 |
| self-improvement | 自我改进 | ⭐⭐⭐⭐⭐ | 高 |
| mcporter | MCP 管理 | ⭐⭐⭐⭐ | 中 |
| skill-creator | 技能创建 | ⭐⭐⭐⭐ | 中 |
| video-frames | 视频处理 | ⭐⭐⭐⭐ | 中 |
| healthcheck | 安全检查 | ⭐⭐⭐⭐ | 低 |

---

## ⚠️ 可能冗余 (需要评估)

### 🤔 功能重叠 (3 组)

**1. 语音转文字 (2 个)**
- `openai-whisper` - 本地 Whisper
- `openai-whisper-api` - API 版本
- **建议**: 保留 `openai-whisper` (本地免费)，删除 API 版本

**2. TTS 语音合成 (2 个)**
- `sag` - ElevenLabs TTS
- `sherpa-onnx-tts` - 本地 TTS
- **建议**: 都保留 (不同场景)

**3. 图片生成 (2 个)**
- `nano-banana-pro` - Gemini Image
- `openai-image-gen` - DALL-E 3
- **建议**: 都保留 (不同风格)

---

## ❌ 可能不需要 (考虑删除)

### 🗑️ 低频技能 (10 个)

这些技能使用频率低，可以考虑删除：

| 技能 | 用途 | 删除建议 | 理由 |
|------|------|----------|------|
| 1password | 1Password 集成 | ⚠️ 可选 | 需要 1Password 订阅 |
| apple-notes | Apple Notes | ⚠️ 可选 | 不用 Apple Notes 可删 |
| apple-reminders | Apple 提醒事项 | ⚠️ 可选 | 不用可删 |
| bear-notes | Bear 笔记 | ⚠️ 可选 | 不用 Bear 可删 |
| blucli | Bluesky 客户端 | ❌ 建议删除 | 国内用不到 |
| bluebubbles | BlueBubbles 短信 | ❌ 建议删除 | 需要特定硬件 |
| camsnap | 相机快照 | ⚠️ 可选 | 使用频率低 |
| eightctl | 8 号控制器 | ❌ 建议删除 | 特定硬件 |
| gifgrep | GIF 搜索 | ⚠️ 可选 | 使用频率低 |
| goplaces | 位置服务 | ⚠️ 可选 | 隐私考虑 |

---

## 📦 建议安装 (缺失技能)

### 🔍 强烈推荐 (3 个)

| 技能 | 用途 | 推荐度 | 安装命令 |
|------|------|--------|----------|
| brave-search | Web 搜索 | ⭐⭐⭐⭐⭐ | `npx clawhub@latest install brave-search` |
| auto-updater | 自动更新 | ⭐⭐⭐⭐⭐ | `npx clawhub@latest install auto-updater` |
| proactive-agent | 主动模式 | ⭐⭐⭐⭐ | `npx clawhub@latest install proactive-agent` |

### 🎯 按需安装 (5 个)

| 技能 | 用途 | 适用场景 |
|------|------|----------|
| discord | Discord 集成 | 用 Discord 可装 |
| telegram | Telegram 机器人 | 用 Telegram 可装 |
| feishu | 飞书集成 | ✅ 已配置 |
| wechat | 微信接入 | ⚠️ 配置复杂 |
| trello | 任务看板 | 用 Trello 可装 |

---

## 🎯 优化建议

### 立即行动

**1. 安装缺失核心技能**
```bash
# 优先级最高
npx clawhub@latest install brave-search
npx clawhub@latest install auto-updater

# 优先级中等
npx clawhub@latest install proactive-agent
```

**2. 清理冗余技能**
```bash
# 删除 openai-whisper-api (保留本地版)
rm -rf /opt/homebrew/lib/node_modules/openclaw/skills/openai-whisper-api

# 删除不用的技能
rm -rf /opt/homebrew/lib/node_modules/openclaw/skills/blucli
rm -rf /opt/homebrew/lib/node_modules/openclaw/skills/bluebubbles
rm -rf /opt/homebrew/lib/node_modules/openclaw/skills/eightctl
```

**3. 整理笔记技能**
- 如果只用 Obsidian: 删除 apple-notes, bear-notes
- 如果只用 Notion: 删除其他笔记技能

---

## 📊 技能使用频率评估

### 高频使用 (每天)
- weather
- github
- summarize
- find-skills
- self-improvement

### 中频使用 (每周)
- nano-pdf
- nano-banana-pro
- openai-whisper
- gog
- notion
- obsidian
- mcporter

### 低频使用 (每月)
- video-frames
- skill-creator
- healthcheck
- sag
- trello

### 极少使用 (几乎不用)
- 1password
- apple-notes
- apple-reminders
- bear-notes
- blucli
- bluebubbles
- camsnap
- eightctl
- gifgrep
- goplaces

---

## 🎯 最终推荐配置

### 精简版 (25 个技能)

保留最核心的 25 个技能：

```
weather, github, summarize, nano-pdf, nano-banana-pro,
openai-whisper, gog, notion, obsidian, find-skills,
self-improvement, mcporter, skill-creator, video-frames,
healthcheck, brave-search, auto-updater, proactive-agent,
sag, sherpa-onnx-tts, openai-image-gen, discord,
session-logs, model-usage, clawhub
```

### 完整版 (当前 54 个)

如果磁盘空间充足，可以全部保留。

---

## 📝 行动计划

### 今天完成

- [x] 技能审计
- [ ] 安装 brave-search
- [ ] 安装 auto-updater
- [ ] 删除冗余技能

### 本周完成

- [ ] 安装 proactive-agent
- [ ] 整理笔记技能
- [ ] 清理低频技能

### 下周完成

- [ ] 配置微信接入 (可选)
- [ ] 配置 Discord/Telegram (可选)

---

*审计时间*: 2026-03-04 22:30  
*下次审计*: 2026-04-04 (月度审计)
