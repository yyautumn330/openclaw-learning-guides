# 5 分钟搭建你的第一个 AI 助手 - OpenClaw 入门指南

> **作者**: 小白 (XiaoBai)  
> **发布时间**: 2026-03-04  
> **难度**: ⭐ 新手友好  
> **预计阅读**: 5 分钟

![封面图：AI 助手概念图](../assets/article-01-final/article1_01_cover_00001_.png)
*图 1: OpenClaw AI 助手 - 友好、现代、易用*

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

![功能展示：OpenClaw 核心功能](../assets/article-01-final/article1_03_features_00001_.png)
*图 2: OpenClaw 核心功能 - 多平台支持、技能系统、记忆系统、自动化引擎*

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

![安装步骤：终端安装界面](../assets/article-01-final/article1_02_install_00001_.png)
*图 3: 使用 npm 安装 OpenClaw - 简单快速*

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
/help            # 获取帮助
/weather 北京     # 查询天气
/github trending # 查看 GitHub 趋势
/search AI 教程   # 搜索 AI 教程
```

---

## 🔌 接入聊天平台

OpenClaw 支持多平台接入：

### 飞书集成

1. 创建飞书机器人
2. 获取 Webhook URL
3. 配置到 OpenClaw

### 微信集成

1. 使用微信协议库
2. 扫码登录
3. 自动回复消息

### Telegram 集成

1. 通过 BotFather 创建机器人
2. 获取 Token
3. 配置到 OpenClaw

![使用场景：多平台工作环境](../assets/article-01-final/article1_04_usage_00001_.png)
*图 4: 多平台使用场景 - 电脑、手机、平板同时在线*

---

## 🎯 下一步

完成基础配置后，你可以：

1. **安装技能** - 阅读 [技能安装指南](./02-skills-install-guide.md)
2. **学习进阶** - 阅读 [OpenClaw 学习指南](./03-openclaw-learning-guide.md)
3. **加入社区** - Discord: https://discord.com/invite/clawd

---

## 📚 相关资源

- **官方文档**: https://docs.openclaw.ai
- **技能市场**: https://clawhub.com
- **GitHub**: https://github.com/openclaw/openclaw
- **社区**: https://discord.com/invite/clawd

---

## ❓ 常见问题

**Q: 需要编程基础吗？**
A: 不需要！OpenClaw 设计为零基础可用，复制粘贴命令即可。

**Q: 免费吗？**
A: 完全免费！OpenClaw 是开源项目，无订阅费。

**Q: 支持哪些平台？**
A: 支持 macOS、Linux、Windows。聊天平台支持飞书、微信、Telegram 等。

**Q: 数据安全吗？**
A: 非常安全！所有数据本地存储，不会上传到云端。

---

## 💡 小贴士

- 使用免费模型开始，熟悉后再考虑付费模型
- 先安装必装技能 (weather, github, brave-search)
- 加入社区获取帮助和最新信息
- 定期更新 OpenClaw 和技能

---

**🎉 恭喜你完成 5 分钟快速入门！现在你拥有了自己的 AI 助手！**

---

*最后更新*: 2026-03-06  
*作者*: 小白 (XiaoBai) 🦞  
*配图*: ComfyUI (SD XL Base 1.0)
