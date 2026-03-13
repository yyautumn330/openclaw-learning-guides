# 5 分钟搭建你的第一个 AI 助手 - OpenClaw 入门指南

> **作者**: 小白 (XiaoBai)  
> **发布时间**: 2026-03-04  
> **难度**: ⭐ 新手友好  
> **预计阅读**: 5 分钟

---

## 🎯 你能学到什么

- ✅ 5 分钟快速部署个人 AI 助手
- ✅ 无需编程基础，复制粘贴即可
- ✅ 支持微信/飞书/Telegram 多平台
- ✅ 免费模型 + 付费模型自由选择

---

## 📦 什么是 OpenClaw？

OpenClaw 是一个**开源 AI 助手框架**，让你可以：

- 🤖 拥有自己的 AI 助手 (不是 API，是真正的助手)
- 💬 接入微信、飞书、Telegram 等聊天工具
- 🔧 安装各种技能 (搜索、天气、GitHub、PDF 处理...)
- 🧠 拥有长期记忆，记住你的偏好和习惯
- ⚡ 主动帮你干活 (定时任务、自动提醒)

**核心优势**:
- 🆓 开源免费，无订阅费
- 🔒 数据本地存储，隐私安全
- 🧩 插件化设计，无限扩展
- 📱 多平台支持，随时随地

---

## 🚀 快速开始 (5 分钟)

### 步骤 1: 安装 OpenClaw (2 分钟)

打开终端，执行：

```bash
# macOS / Linux
npm install -g openclaw

# 验证安装
openclaw --version
```

看到版本号就说明安装成功了！🎉

### 步骤 2: 配置 AI 模型 (2 分钟)

OpenClaw 支持多种 AI 模型：

**免费模型** (推荐新手):
- Qwen (通义千问) - 阿里出品
- GLM (智谱 AI) - 清华系
- Kimi - 月之暗面

**付费模型** (效果更好):
- GPT-4 - OpenAI
- Claude - Anthropic
- Gemini - Google

**配置命令**:

```bash
# 启动配置向导
openclaw configure

# 选择模型提供商
# 输入 API Key (去官网申请，免费额度够用)
```

**API Key 获取**:
- Qwen: https://dashscope.console.aliyun.com/
- GLM: https://open.bigmodel.cn/
- GPT-4: https://platform.openai.com/

### 步骤 3: 启动助手 (1 分钟)

```bash
# 启动 Gateway 服务
openclaw gateway

# 看到 🦞 OpenClaw 标志就说明启动成功了!
```

启动后，你就可以在终端和 AI 对话了！

---

## 💬 第一次对话

试试这些命令：

```
/hi              # 打招呼
/help            # 查看帮助
/weather 北京    # 查询天气 (需安装 weather 技能)
/github trending # 查看 GitHub 趋势 (需安装 github 技能)
```

---

## 🧩 安装技能 (可选)

OpenClaw 有 **52+ 官方技能** 和 **14000+ 社区技能**：

**必装基础技能**:

```bash
# 天气查询
npx clawhub@latest install weather

# Web 搜索
npx clawhub@latest install brave-search

# GitHub 操作
npx clawhub@latest install github

# 内容总结
npx clawhub@latest install summarize
```

**热门技能**:
- 📧 `gog` - Google Workspace 集成
- 📝 `notion` - Notion 知识库
- 📄 `nano-pdf` - PDF 编辑
- 🎨 `nano-banana-pro` - 图像生成
- 🎤 `openai-whisper` - 语音转文字

---

## 📱 接入聊天平台

### 飞书 (推荐)

```bash
# 创建飞书应用
# 获取 AppID 和 AppSecret
# 配置到 openclaw.json

openclaw config set channels.feishu.enabled true
openclaw config set channels.feishu.appId "你的 AppID"
openclaw config set channels.feishu.appSecret "你的 AppSecret"
```

### 微信 (进阶)

需要 WeChatPadPro 服务：

```bash
# 安装微信插件
openclaw plugins install @icesword760/openclaw-wechat

# 配置 WeChatPadPro
openclaw config set channels.wechat.enabled true
openclaw config set channels.wechat.serverUrl http://localhost:8849
openclaw config set channels.wechat.token "你的 Token"
```

### Telegram

```bash
# 联系 @BotFather 创建机器人
# 获取 Token 后配置
openclaw config set channels.telegram.enabled true
openclaw config set channels.telegram.token "你的 Bot Token"
```

---

## 🧠 记忆系统

OpenClaw 的记忆系统让 AI 记住你：

```
workspace/
├── SOUL.md          # AI 人格定义
├── IDENTITY.md      # 身份信息
├── MEMORY.md        # 长期记忆
├── USER.md          # 用户信息
└── memory/          # 每日记忆
    ├── 2026-03-03.md
    └── 2026-03-04.md
```

**示例**:
```markdown
# MEMORY.md

## 用户偏好
- 喜欢简洁的代码风格
- 工作时间：9:00-18:00
- 常用技术栈：Swift, ArkTS, Kotlin

## 项目上下文
- SunTracker - iOS 太阳追踪应用
- PlaneWar - 鸿蒙飞机大战游戏
```

---

## ⚡ 主动模式

让 AI 主动帮你干活：

```bash
# 安装主动代理技能
npx clawhub@latest install proactive-agent

# 配置心跳任务
# 每 30 分钟检查一次
openclaw config set agents.defaults.heartbeat.every "30m"
```

**主动任务示例**:
- 📧 检查未读邮件
- 📅 提醒即将到来的会议
- 🌤️ 天气预报 (如果要出门)
- 📰 每日新闻摘要

---

## 🛡️ 安全与隐私

**数据安全**:
- ✅ 所有数据本地存储
- ✅ 不上传到第三方服务器
- ✅ API Key 加密存储
- ✅ 支持离线使用

**权限控制**:
- ✅ 技能沙箱隔离
- ✅ 敏感操作需要确认
- ✅ 可配置访问白名单

---

## 📚 学习资源

**官方文档**:
- 📖 https://docs.openclaw.ai
- 💻 https://github.com/openclaw/openclaw
- 💬 https://discord.com/invite/clawd

**社区技能**:
- 🔧 https://clawhub.ai (14000+ 技能)

**本系列文章**:
- 下一篇：《OpenClaw 技能安装指南 - 52 个技能评测》

---

## ❓ 常见问题

**Q: 需要编程基础吗？**  
A: 不需要！基础使用只需复制粘贴命令。想开发技能才需要编程。

**Q: 免费吗？**  
A: OpenClaw 本身免费。AI 模型有免费额度，超出后需付费 (很便宜)。

**Q: 支持 Windows 吗？**  
A: 支持 macOS、Linux、Docker。Windows 可用 WSL2 或 Docker。

**Q: 会不会被封号？**  
A: 官方渠道 (飞书、Telegram) 安全。微信使用 iPad 协议有风险，建议小号测试。

---

## 🎯 下一步

1. ✅ 完成安装和配置
2. ✅ 安装 3-5 个基础技能
3. ✅ 尝试接入一个聊天平台
4. ✅ 阅读下一篇：技能安装指南

---

**遇到问题？**  
欢迎在评论区留言，我会逐一解答！👨‍💻

**觉得有用？**  
点赞 + 收藏，让更多人看到！❤️

---

*标签*: #AI #OpenClaw #效率工具 #自动化 #AI 助手 #开源 #技术教程

*最后更新*: 2026-03-04
