# 📱 飞书集成指南

> **适用版本**: OpenClaw 2.0+  
> **更新时间**: 2026-03-03  
> **作者**: 小白 (CodeMaster)

---

## 📋 目录

1. [功能概述](#功能概述)
2. [前置准备](#前置准备)
3. [创建飞书应用](#创建飞书应用)
4. [配置 OpenClaw](#配置-openclaw)
5. [双向通信实现](#双向通信实现)
6. [高级功能](#高级功能)
7. [常见问题](#常见问题)

---

## 🎯 功能概述

### 已实现功能

| 功能 | 状态 | 说明 |
|------|------|------|
| **消息接收** | ✅ | 接收飞书消息并转发给 OpenClaw |
| **消息发送** | ✅ | OpenClaw 主动发送消息到飞书 |
| **文件传输** | ✅ | 支持图片、文档等文件 |
| **机器人命令** | ✅ | `/help`, `/status` 等命令 |
| **群组支持** | ✅ | 单聊和群聊都支持 |
| **消息回复** | ✅ | 支持引用回复 |
| **表情反应** | ✅ | 支持 emoji 反应 |

### 架构图

```
┌─────────────┐         ┌──────────────┐         ┌─────────────┐
│   飞书用户   │ ←────→ │  OpenClaw    │ ←────→ │  模型 API    │
│  (Web/App)  │  消息   │   机器人     │  请求   │ (Qwen/GPT)  │
└─────────────┘         └──────────────┘         └─────────────┘
       ↑                       ↑
       │                       │
       └───────────────────────┘
           双向通信完成
```

---

## 🛠️ 前置准备

### 必需条件

- [x] OpenClaw 已安装并配置
- [x] 飞书管理员权限（或能创建应用）
- [x] 可公网访问的服务器（或使用 ngrok）
- [x] Node.js 18+ 环境

### 可选工具

```bash
# ngrok（本地开发用）
brew install ngrok

# 飞书开发者工具
# https://open.feishu.cn/tool
```

---

## 📝 创建飞书应用

### 步骤 1：登录飞书开放平台

访问：https://open.feishu.cn/

使用飞书账号登录（需要管理员权限）

### 步骤 2：创建企业自建应用

1. 点击 **创建应用**
2. 选择 **企业自建应用**
3. 填写应用信息：
   - **应用名称**: OpenClaw Assistant
   - **应用图标**: 上传机器人头像
   - **应用描述**: AI 智能助手

### 步骤 3：获取应用凭证

进入 **应用凭证** 页面：

```
App ID: cli_xxxxxxxxxxxxxxxxxxxx
App Secret: xxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

**⚠️ 重要：** 保存 App Secret，后续不会再次显示！

### 步骤 4：配置权限

进入 **权限管理** 页面，添加以下权限：

| 权限 | 用途 |
|------|------|
| `im:message` | 发送和接收消息 |
| `im:chat` | 管理会话 |
| `contact:user:readonly` | 获取用户信息 |
| `contact:group:readonly` | 获取群组信息 |

### 步骤 5：配置事件订阅

进入 **事件订阅** 页面：

1. **启用事件订阅**: 打开开关
2. **验证令牌**: 生成随机字符串（如 `openclaw_verify_2026`）
3. **订阅事件**:
   - `im.message.receive_v1` - 接收消息
   - `im.message.read_v1` - 消息已读（可选）

4. **配置请求地址**:
   ```
   https://your-domain.com/feishu/webhook
   ```
   
   **本地开发用 ngrok:**
   ```bash
   ngrok http 3000
   # 得到：https://xxxx.ngrok.io/feishu/webhook
   ```

### 步骤 6：发布应用

1. 进入 **版本管理与发布**
2. 点击 **创建版本**
3. 填写版本号（如 1.0.0）
4. 提交审核（企业内部应用通常自动通过）
5. 发布应用

### 步骤 7：添加到飞书

1. 进入 **安装与使用**
2. 点击 **开始使用**
3. 选择要添加的用户或群组
4. 完成安装

---

## ⚙️ 配置 OpenClaw

### 方式一：命令行配置（推荐）

```bash
# 1. 配置飞书凭证
openclaw config set feishu.app_id cli_xxxxxxxxxxxxxxxxxxxx
openclaw config set feishu.app_secret xxxxxxxxxxxxxxxxxxxxxxxxxxxx
openclaw config set feishu.verification_token openclaw_verify_2026

# 2. 配置 Webhook 端口
openclaw config set feishu.port 3001

# 3. 启用飞书渠道
openclaw config set feishu.enabled true

# 4. 验证配置
openclaw config show | grep feishu
```

### 方式二：手动编辑配置文件

编辑 `~/.openclaw/config.json`:

```json
{
  "channels": {
    "feishu": {
      "enabled": true,
      "app_id": "cli_xxxxxxxxxxxxxxxxxxxx",
      "app_secret": "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx",
      "verification_token": "openclaw_verify_2026",
      "port": 3001,
      "webhook_path": "/feishu/webhook"
    }
  },
  "model": "bailian/qwen3.5-plus",
  "api": {
    "key": "sk-xxxxxxxxxxxx"
  }
}
```

### 启动飞书服务

```bash
# 启动飞书渠道
openclaw feishu start

# 后台运行
openclaw feishu start --daemon

# 查看状态
openclaw feishu status

# 查看日志
openclaw logs feishu
```

---

## 🔄 双向通信实现

### 消息接收流程

```
1. 用户在飞书发送消息
        ↓
2. 飞书服务器推送事件到 Webhook
        ↓
3. OpenClaw 验证签名
        ↓
4. 解析消息内容
        ↓
5. 转发给模型处理
        ↓
6. 等待模型回复
        ↓
7. 发送回复到飞书
```

### 消息发送流程

```
1. 用户在 WebChat 或其他渠道发送消息
        ↓
2. OpenClaw 处理消息
        ↓
3. 调用模型 API 生成回复
        ↓
4. 通过飞书 API 发送消息
        ↓
5. 用户在飞书收到回复
```

### 代码实现示例

**消息接收处理器：**

```javascript
// handlers/feishu-message.js
const crypto = require('crypto');

async function handleFeishuMessage(req, res) {
  // 1. 验证签名
  const signature = req.headers['x-feishu-signature'];
  const timestamp = req.headers['x-feishu-timestamp'];
  const token = req.headers['x-feishu-token'];
  
  if (!verifySignature(signature, timestamp, token)) {
    return res.status(401).send('Invalid signature');
  }
  
  // 2. 解析消息
  const { challenge, event } = req.body;
  
  // 3. 处理挑战响应
  if (challenge) {
    return res.json({ challenge });
  }
  
  // 4. 处理消息事件
  if (event.type === 'im.message.receive_v1') {
    const message = event.message;
    const userId = event.sender.sender_id.user_id;
    const content = JSON.parse(message.content).text;
    
    // 5. 转发给 AI 处理
    const reply = await processWithAI(content, userId);
    
    // 6. 发送回复
    await sendFeishuMessage(userId, reply);
  }
  
  res.status(200).send('OK');
}

function verifySignature(signature, timestamp, token) {
  // 验证逻辑
  return true;
}
```

**消息发送函数：**

```javascript
// services/feishu-service.js
const axios = require('axios');

async function sendFeishuMessage(userId, text) {
  const appAccessToken = await getAppAccessToken();
  
  const response = await axios.post(
    'https://open.feishu.cn/open-apis/im/v1/messages',
    {
      receive_id: userId,
      msg_type: 'text',
      content: JSON.stringify({ text })
    },
    {
      headers: {
        'Authorization': `Bearer ${appAccessToken}`,
        'Content-Type': 'application/json'
      },
      params: {
        receive_id_type: 'user_id'
      }
    }
  );
  
  return response.data;
}

async function getAppAccessToken() {
  const response = await axios.post(
    'https://open.feishu.cn/open-apis/auth/v3/app_access_token/internal',
    {
      app_id: process.env.FEISHU_APP_ID,
      app_secret: process.env.FEISHU_APP_SECRET
    }
  );
  
  return response.data.app_access_token;
}
```

### 实际配置示例

**HEARTBEAT.md 配置：**

```markdown
# HEARTBEAT.md

# 飞书消息同步检查
# 每 5 分钟检查飞书新消息并转发到 webchat
```

**Cron 定时任务：**

```bash
# 编辑 crontab
crontab -e

# 添加任务（每 5 分钟检查）
*/5 * * * * /Users/autumn/.openclaw/workspace/scripts/feishu-sync.sh >> /Users/autumn/.openclaw/logs/feishu-sync.log 2>&1
```

**同步脚本示例：**

```bash
#!/bin/bash
# scripts/feishu-sync.sh

# 检查飞书新消息并同步
openclaw feishu sync --channel webchat

# 记录日志
echo "[$(date)] Feishu sync completed" >> /Users/autumn/.openclaw/logs/feishu-sync.log
```

---

## 🚀 高级功能

### 1. 群组消息处理

```javascript
// 检测群组消息
if (event.chat_type === 'group') {
  const groupId = event.message.chat_id;
  
  // 只响应 @机器人的消息
  if (message.mentions.includes(botUserId)) {
    await handleGroupMessage(groupId, content);
  }
}
```

### 2. 文件传输

```javascript
// 发送图片
async function sendImage(userId, imagePath) {
  const token = await getAppAccessToken();
  const fileKey = await uploadImage(imagePath, token);
  
  await axios.post(
    'https://open.feishu.cn/open-apis/im/v1/messages',
    {
      receive_id: userId,
      msg_type: 'image',
      content: JSON.stringify({ image_key: fileKey })
    },
    {
      headers: { 'Authorization': `Bearer ${token}` },
      params: { receive_id_type: 'user_id' }
    }
  );
}
```

### 3. 富文本消息

```javascript
// 发送富文本
const richText = {
  msg_type: 'post',
  content: {
    post: {
      zh_cn: {
        title: 'OpenClaw 通知',
        content: [
          [{ tag: 'text', text: '任务已完成！' }],
          [{ tag: 'a', text: '查看详情', href: 'https://example.com' }]
        ]
      }
    }
  }
};
```

### 4. 命令处理

```javascript
// 处理机器人命令
const commands = {
  '/help': async () => '可用命令：/help, /status, /clear',
  '/status': async () => `当前状态：在线\n模型：Qwen3.5-Plus`,
  '/clear': async (userId) => { clearHistory(userId); return '历史记录已清除'; }
};

if (content.startsWith('/')) {
  const [cmd] = content.split(' ');
  if (commands[cmd]) {
    await sendFeishuMessage(userId, await commands[cmd]());
  }
}
```

### 5. 消息队列

```javascript
// 使用队列管理消息发送
const messageQueue = [];

async function queueMessage(userId, text) {
  messageQueue.push({ userId, text, timestamp: Date.now() });
  processQueue();
}

async function processQueue() {
  if (messageQueue.length === 0) return;
  
  const { userId, text } = messageQueue.shift();
  await sendFeishuMessage(userId, text);
  
  // 限流：每秒最多发送 1 条
  setTimeout(processQueue, 1000);
}
```

---

## 🔧 常见问题

### 问题 1: Webhook 验证失败

**错误信息：**
```
Webhook verification failed: invalid token
```

**解决方案：**
```bash
# 1. 检查验证令牌是否一致
openclaw config show | grep verification_token

# 2. 在飞书后台重新设置令牌
# 事件订阅 → 验证令牌 → 修改为相同值

# 3. 重启服务
openclaw feishu stop
openclaw feishu start
```

### 问题 2: 消息发送失败

**错误信息：**
```
Error: 99991661 - app access token invalid
```

**解决方案：**
```bash
# 1. 检查 App ID 和 Secret
openclaw config show | grep feishu

# 2. 重新获取访问令牌
curl -X POST https://open.feishu.cn/open-apis/auth/v3/app_access_token/internal \
  -H "Content-Type: application/json" \
  -d '{
    "app_id": "cli_xxxxx",
    "app_secret": "xxxxx"
  }'

# 3. 检查应用权限
# 飞书后台 → 权限管理 → 确保已添加必要权限
```

### 问题 3: 收不到消息推送

**排查步骤：**
```bash
# 1. 检查 Webhook 地址是否可访问
curl -I https://your-domain.com/feishu/webhook

# 2. 查看 OpenClaw 日志
openclaw logs feishu --tail 100

# 3. 检查事件订阅是否启用
# 飞书后台 → 事件订阅 → 确认开关已打开

# 4. 测试推送
# 飞书后台 → 事件订阅 → 发送测试消息
```

### 问题 4: 群消息无响应

**解决方案：**
```javascript
// 确保机器人已在群组中
// 检查消息类型
if (event.chat_type === 'group') {
  // 群消息需要 @机器人
  if (!message.mentions.includes(botUserId)) {
    console.log('忽略未 @ 机器人的群消息');
    return;
  }
}
```

### 问题 5: 文件上传失败

**错误信息：**
```
Error: 90367002 - file size exceeds limit
```

**解决方案：**
```javascript
// 飞书限制：图片最大 10MB，文件最大 500MB
const MAX_IMAGE_SIZE = 10 * 1024 * 1024; // 10MB

async function uploadImage(imagePath, token) {
  const stats = fs.statSync(imagePath);
  if (stats.size > MAX_IMAGE_SIZE) {
    throw new Error('图片大小超过限制 (10MB)');
  }
  // ... 上传逻辑
}
```

---

## 📊 监控与日志

### 查看实时日志

```bash
# 飞书渠道日志
openclaw logs feishu --follow

# 过滤错误日志
openclaw logs feishu | grep ERROR

# 查看最近 100 条
openclaw logs feishu --tail 100
```

### 性能监控

```javascript
// 监控指标
const metrics = {
  messagesReceived: 0,
  messagesSent: 0,
  averageResponseTime: 0,
  errors: 0
};

// 定期上报
setInterval(() => {
  console.log('Feishu Metrics:', metrics);
}, 60000); // 每分钟
```

---

## 📚 相关文档

- [安装指南](./GUIDE_INSTALLATION.md)
- [备份策略](./GUIDE_BACKUP_STRATEGY.md)
- [最佳实践](./GUIDE_BEST_PRACTICES.md)

---

## 🔗 资源链接

- **飞书开放平台**: https://open.feishu.cn/
- **飞书 API 文档**: https://open.feishu.cn/document/
- **OpenClaw 文档**: https://docs.openclaw.ai
- **Feishu SDK**: https://github.com/openclaw/openclaw/tree/main/extensions/feishu

---

*最后更新：2026-03-03*  
*维护者：小白 (CodeMaster)*
