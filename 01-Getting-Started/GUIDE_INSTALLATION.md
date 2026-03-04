# 🚀 OpenClaw 安装与配置指南

> **适用平台**: macOS / Linux / Windows  
> **更新时间**: 2026-03-03  
> **作者**: 小白 (CodeMaster)

---

## 📋 目录

1. [系统要求](#系统要求)
2. [安装步骤](#安装步骤)
3. [模型 API 配置](#模型 api 配置)
4. [渠道集成](#渠道集成)
5. [验证安装](#验证安装)
6. [常见问题](#常见问题)

---

## 🖥️ 系统要求

### 最低配置

| 组件 | 要求 |
|------|------|
| **操作系统** | macOS 12+ / Ubuntu 20.04+ / Windows 10+ |
| **Node.js** | 18.0 或更高版本 |
| **内存** | 4GB RAM (推荐 8GB+) |
| **磁盘** | 500MB 可用空间 |
| **网络** | 稳定的互联网连接 |

### 推荐配置

| 组件 | 推荐 |
|------|------|
| **操作系统** | macOS 14+ / Ubuntu 22.04+ |
| **Node.js** | 20.x LTS |
| **内存** | 16GB RAM |
| **磁盘** | 2GB+ SSD |

---

## 📦 安装步骤

### 方法一：npm 全局安装（推荐）

```bash
# 1. 安装 Node.js (如未安装)
# macOS
brew install node

# Ubuntu/Debian
curl -fsSL https://deb.nodesource.com/setup_20.x | sudo -E bash -
sudo apt-get install -y nodejs

# Windows
# 下载安装包：https://nodejs.org/

# 2. 验证 Node.js 版本
node -v  # 应显示 v18.x 或更高
npm -v

# 3. 全局安装 OpenClaw
npm install -g openclaw

# 4. 验证安装
openclaw --version
openclaw help
```

### 方法二：源码安装

```bash
# 1. 克隆仓库
git clone https://github.com/openclaw/openclaw.git
cd openclaw

# 2. 安装依赖
npm install

# 3. 链接到全局
npm link

# 4. 验证
openclaw --version
```

### 方法三：使用包管理器

**macOS (Homebrew):**
```bash
brew install openclaw
```

---

## 🔑 模型 API 配置

### 支持的模型提供商

| 提供商 | 模型 | 配置难度 | 成本 |
|--------|------|----------|------|
| **阿里云百炼** | Qwen3.5-Plus | ⭐⭐ | 低 |
| **OpenAI** | GPT-4/GPT-3.5 | ⭐⭐⭐ | 高 |
| **Anthropic** | Claude-3 | ⭐⭐⭐⭐ | 高 |
| **智谱 AI** | GLM-4 | ⭐⭐ | 中 |
| **本地模型** | Ollama/LM Studio | ⭐⭐⭐⭐ | 免费 |

### 配置阿里云百炼（推荐）

```bash
# 1. 获取 API Key
# 访问：https://dashscope.console.aliyun.com/
# 注册账号 → API-KEY 管理 → 创建新密钥

# 2. 配置 OpenClaw
openclaw config set model bailian/qwen3.5-plus
openclaw config set api.key YOUR_DASHSCOPE_API_KEY

# 3. 验证配置
openclaw config show
```

**配置文件位置：**
```
~/.openclaw/config.json
```

**手动配置示例：**
```json
{
  "model": "bailian/qwen3.5-plus",
  "api": {
    "key": "sk-xxxxxxxxxxxx",
    "provider": "bailian"
  },
  "thinking": "off",
  "timeout": 120
}
```

### 配置 OpenAI

```bash
# 1. 获取 API Key
# 访问：https://platform.openai.com/api-keys

# 2. 配置
openclaw config set model openai/gpt-4
openclaw config set api.key sk-YOUR_OPENAI_KEY

# 3. 设置 API 端点（如使用代理）
openclaw config set api.base_url https://api.openai.com/v1
```

### 配置智谱 AI

```bash
# 1. 获取 API Key
# 访问：https://open.bigmodel.cn/

# 2. 配置
openclaw config set model glm-4
openclaw config set api.key YOUR_ZHIPU_KEY
```

### 配置本地模型（Ollama）

```bash
# 1. 安装 Ollama
# macOS
brew install ollama

# Linux
curl -fsSL https://ollama.com/install.sh | sh

# 2. 拉取模型
ollama pull qwen2.5:7b

# 3. 启动服务
ollama serve

# 4. 配置 OpenClaw
openclaw config set model ollama/qwen2.5:7b
openclaw config set api.base_url http://localhost:11434
```

---

## 📱 渠道集成

### WebChat（默认）

WebChat 是 OpenClaw 自带的网页聊天界面，无需配置即可使用。

```bash
# 启动 WebChat
openclaw webchat
# 访问：http://localhost:3000
```

### 飞书集成

```bash
# 1. 创建飞书应用
# 访问：https://open.feishu.cn/app

# 2. 获取凭证
# 应用凭证 → App ID 和 App Secret

# 3. 配置 OpenClaw
openclaw config set feishu.app_id cli_xxxxxxxxxxxx
openclaw config set feishu.app_secret xxxxxxxxxxxxxx
openclaw config set feishu.verification_token xxxxxxxxxxxxxx

# 4. 配置事件订阅
# 飞书后台 → 事件订阅 → 订阅消息
# 请求地址：https://your-server.com/feishu/webhook

# 5. 验证配置
openclaw feishu test
```

**详细配置参考：** [飞书集成指南](./GUIDE_FEISHU_INTEGRATION.md)

### Telegram Bot

```bash
# 1. 创建 Bot
# 与 @BotFather 对话 → /newbot

# 2. 获取 Token
# BotFather 会返回 Token

# 3. 配置
openclaw config set telegram.bot_token YOUR_BOT_TOKEN

# 4. 启动
openclaw telegram start
```

### Discord Bot

```bash
# 1. 创建应用
# 访问：https://discord.com/developers/applications

# 2. 获取 Token
# Bot → Reset Token

# 3. 邀请 Bot 到服务器
# OAuth2 → URL Generator → 选择 bot 权限

# 4. 配置
openclaw config set discord.token YOUR_DISCORD_TOKEN
openclaw config set discord.guild_id YOUR_SERVER_ID

# 5. 启动
openclaw discord start
```

### WhatsApp

```bash
# 1. 使用 WhatsApp Business API
# 或第三方服务如 Twilio

# 2. 配置
openclaw config set whatsapp.account_sid YOUR_ACCOUNT_SID
openclaw config set whatsapp.auth_token YOUR_AUTH_TOKEN
openclaw config set whatsapp.phone_number YOUR_WHATSAPP_NUMBER
```

### 多渠道配置示例

```json
{
  "channels": {
    "webchat": {
      "enabled": true,
      "port": 3000
    },
    "feishu": {
      "enabled": true,
      "app_id": "cli_xxxxx",
      "app_secret": "xxxxx",
      "verification_token": "xxxxx"
    },
    "telegram": {
      "enabled": false,
      "bot_token": "xxxxx"
    }
  }
}
```

---

## ✅ 验证安装

### 基础测试

```bash
# 1. 检查版本
openclaw --version

# 2. 查看帮助
openclaw help

# 3. 检查配置
openclaw config show

# 4. 测试模型连接
openclaw test "你好，请回复"
```

### 功能测试

```bash
# 1. 测试文件读写
echo "Hello OpenClaw" > test.txt
openclaw read test.txt

# 2. 测试命令执行
openclaw exec "ls -la"

# 3. 测试网络搜索
openclaw search "OpenClaw 是什么"

# 4. 测试浏览器（如已配置）
openclaw browser open https://github.com
```

### 渠道测试

```bash
# WebChat
openclaw webchat --test

# 飞书
openclaw feishu send "测试消息"

# Telegram
openclaw telegram send --chat-id YOUR_CHAT_ID "测试消息"
```

---

## 🔧 常见问题

### 问题 1: npm 安装失败

**错误信息：**
```
npm ERR! code EACCES
npm ERR! permission denied
```

**解决方案：**
```bash
# 方法 1: 使用 sudo（不推荐）
sudo npm install -g openclaw

# 方法 2: 修复 npm 权限（推荐）
mkdir ~/.npm-global
npm config set prefix '~/.npm-global'
echo 'export PATH=~/.npm-global/bin:$PATH' >> ~/.zshrc
source ~/.zshrc
npm install -g openclaw
```

### 问题 2: 模型 API 连接失败

**错误信息：**
```
Error: API request failed
Status: 401 Unauthorized
```

**解决方案：**
```bash
# 1. 检查 API Key 是否正确
openclaw config show | grep api.key

# 2. 重新设置 API Key
openclaw config set api.key YOUR_NEW_KEY

# 3. 检查网络连接
curl -I https://dashscope.aliyuncs.com

# 4. 如使用代理，配置环境变量
export HTTP_PROXY=http://proxy-server:port
export HTTPS_PROXY=http://proxy-server:port
```

### 问题 3: 飞书回调失败

**错误信息：**
```
Webhook verification failed
```

**解决方案：**
```bash
# 1. 确保服务器可公网访问
# 使用 ngrok 进行本地测试
ngrok http 3000

# 2. 检查验证令牌
openclaw config set feishu.verification_token YOUR_TOKEN

# 3. 查看日志
openclaw logs feishu

# 4. 重新订阅事件
# 飞书后台 → 事件订阅 → 禁用后重新启用
```

### 问题 4: 内存不足

**错误信息：**
```
FATAL ERROR: Reached heap limit
```

**解决方案：**
```bash
# 1. 增加 Node.js 内存限制
export NODE_OPTIONS="--max-old-space-size=4096"

# 2. 关闭不必要的渠道
openclaw config set telegram.enabled false

# 3. 使用更小的模型
openclaw config set model bailian/qwen-plus
```

### 问题 5: 命令执行权限不足

**错误信息：**
```
Permission denied: openclaw
```

**解决方案：**
```bash
# macOS/Linux
chmod +x $(which openclaw)

# 或重新安装
npm install -g openclaw --force
```

---

## 📚 相关文档

- [飞书集成指南](./GUIDE_FEISHU_INTEGRATION.md)
- [项目备份策略](./GUIDE_BACKUP_STRATEGY.md)
- [最佳实践](./GUIDE_BEST_PRACTICES.md)

---

## 🔗 资源链接

- **官方文档**: https://docs.openclaw.ai
- **GitHub**: https://github.com/openclaw/openclaw
- **Discord 社区**: https://discord.com/invite/clawd
- **技能市场**: https://clawhub.com

---

*最后更新：2026-03-03*  
*维护者：小白 (CodeMaster)*
