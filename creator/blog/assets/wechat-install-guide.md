# 📱 WeChatPadPro + OpenClaw 微信接入完整指南

> **作者**: 小白 (XiaoBai)  
> **创建时间**: 2026-03-04  
> **状态**: 🔄 配置中

---

## 📦 当前状态

### ✅ 已完成

- [x] WeChatPadPro 下载完成
- [x] WeChatPadPro 解压到 `/Applications/WeChatPadPro`
- [x] Docker Desktop 已安装

### ⏳ 进行中

- [ ] Docker Desktop 完全启动
- [ ] 配置 docker-compose
- [ ] 启动 WeChatPadPro 服务
- [ ] 获取 Token
- [ ] 配置 OpenClaw 微信插件

---

## 🚀 部署步骤

### 步骤 1: 等待 Docker 完全启动

Docker Desktop 首次启动需要 2-5 分钟。

**检查 Docker 是否就绪**:

```bash
# 方法 1: 检查命令行
docker --version

# 方法 2: 检查进程
ps aux | grep docker

# 方法 3: 检查 Docker Desktop
open -a Docker
```

**预计时间**: 3-5 分钟

---

### 步骤 2: 配置 WeChatPadPro

**进入目录**:

```bash
cd /Applications/WeChatPadPro
```

**创建 .env 配置文件**:

```bash
cat > .env << 'EOF'
# 管理员密钥（用于获取 Token）
ADMIN_KEY=99999

# 服务器配置
HOST=0.0.0.0
PORT=1239
API_VERSION=
DEBUG=true

# Redis 配置
REDIS_HOST=wechatpadpro_redis
REDIS_PORT=6379
REDIS_DB=1
REDIS_PASS=123456

# MySQL 配置
MYSQL_CONNECT_STR=wechatpadpro:123456@tcp(wechatpadpro_mysql:3306)/wechatpadpro?charset=utf8mb4&parseTime=true&loc=Local
EOF
```

**创建 docker-compose.yml**:

```bash
cat > docker-compose.yml << 'EOF'
version: '3.8'

services:
  wechatpadpro:
    image: wechatpadpro/wechatpadpro:latest
    container_name: wechatpadpro
    restart: unless-stopped
    ports:
      - "1239:1239"
    volumes:
      - wechatpadpro_data:/app/data
      - wechatpadpro_logs:/app/logs
      - wechatpadpro_static:/app/static
      - ./assets:/app/assets
      - ./.env:/app/.env
    environment:
      - DEBUG=true
      - ADMIN_KEY=99999
      - REDIS_HOST=redis
      - REDIS_PASS=123456
      - MYSQL_CONNECT_STR=wechatpadpro:123456@tcp(mysql:3306)/wechatpadpro?charset=utf8mb4&parseTime=true&loc=Local
      - PORT=1239
      - HOST=0.0.0.0
      - TZ=Asia/Shanghai
    depends_on:
      - redis
      - mysql

  redis:
    image: redis:7-alpine
    container_name: wechatpadpro_redis
    restart: unless-stopped
    command: redis-server --requirepass 123456
    volumes:
      - redis_data:/data

  mysql:
    image: mysql:8.0
    container_name: wechatpadpro_mysql
    restart: unless-stopped
    environment:
      - MYSQL_ROOT_PASSWORD=123456
      - MYSQL_DATABASE=wechatpadpro
      - MYSQL_USER=wechatpadpro
      - MYSQL_PASSWORD=123456
    volumes:
      - mysql_data:/var/lib/mysql
    command: --default-authentication-plugin=mysql_native_password

volumes:
  wechatpadpro_data:
  wechatpadpro_logs:
  wechatpadpro_static:
  redis_data:
  mysql_data:
EOF
```

---

### 步骤 3: 启动 WeChatPadPro

```bash
cd /Applications/WeChatPadPro
docker-compose up -d
```

**检查状态**:

```bash
docker-compose ps
```

应该看到 3 个服务都在运行：
- wechatpadpro
- wechatpadpro_redis
- wechatpadpro_mysql

---

### 步骤 4: 获取 Token

**访问管理界面**:

```
http://localhost:1239
```

**获取 Token**:

1. 打开浏览器访问 `http://localhost:1239`
2. 输入管理员密钥：`99999`
3. 在管理界面生成 Token
4. 复制 Token 备用

**或使用 API**:

```bash
curl -X POST http://localhost:1239/api/auth/login \
  -H "Content-Type: application/json" \
  -d '{"adminKey":"99999"}'
```

---

### 步骤 5: 配置 OpenClaw

**获取 Token 后**，执行以下命令配置 OpenClaw：

```bash
# 启用微信通道
openclaw config set channels.wechat.enabled true

# 设置 WeChatPadPro 服务地址
openclaw config set channels.wechat.serverUrl http://localhost:1239

# 设置 Token（替换成你的实际 Token）
openclaw config set channels.wechat.token YOUR_TOKEN_HERE

# 设置触发前缀（避免 AI 响应所有消息）
openclaw config set channels.wechat.triggerPrefix "@ai"

# 设置回复前缀（方便识别 AI 回复）
openclaw config set channels.wechat.replyPrefix "🤖 "
```

---

### 步骤 6: 重启 OpenClaw Gateway

```bash
openclaw gateway restart
```

---

### 步骤 7: 扫码登录

重启后，终端会显示 **微信二维码**：

1. 打开微信扫描二维码
2. 确认登录
3. 登录成功后，微信就接入 OpenClaw 了！

---

## 💬 测试对话

登录成功后，在微信中测试：

```
@ai 你好
```

AI 应该回复：

```
🤖 你好！有什么可以帮你的吗？
```

---

## ⚠️ 常见问题

### Q1: Docker 命令找不到

**解决**:
```bash
# Docker Desktop 首次启动需要时间
# 等待 3-5 分钟后重试

# 或者重启 Docker Desktop
open -a Docker
```

### Q2: docker-compose 找不到

**解决**:
```bash
# Docker Desktop 自带 compose
docker compose version

# 如果还不行，安装 docker-compose
brew install docker-compose
```

### Q3: WeChatPadPro 启动失败

**检查日志**:
```bash
cd /Applications/WeChatPadPro
docker-compose logs wechatpadpro
```

**常见原因**:
- 端口被占用
- .env 配置错误
- assets 文件不完整

### Q4: 无法获取 Token

**解决**:
1. 检查 ADMIN_KEY 是否正确
2. 检查服务是否正常运行
3. 尝试直接访问 http://localhost:1239

### Q5: 微信扫码后掉线

**原因**: iPad 协议稳定性问题

**解决**:
- 重新扫码登录
- 避免频繁操作
- 建议使用小号测试

---

## 🛡️ 安全提醒

### 封号风险

⚠️ **重要**: 使用 iPad 协议存在被微信官方检测的风险！

**建议**:
- ✅ 使用不重要的账号测试
- ✅ 不要用于营销/骚扰
- ✅ 控制消息频率
- ✅ 定期检查账号状态

### 数据安全

- 所有数据本地存储
- Token 妥善保管
- 不要泄露 ADMIN_KEY

---

## 📊 服务状态检查

```bash
# 检查 Docker 容器
docker-compose ps

# 查看日志
docker-compose logs -f

# 重启服务
docker-compose restart

# 停止服务
docker-compose down

# 重新启动
docker-compose up -d
```

---

## 🎯 下一步行动

### 立即可做

1. **等待 Docker 完全启动** (3-5 分钟)
2. **执行步骤 2** (创建配置文件)
3. **执行步骤 3** (启动服务)
4. **获取 Token** (访问管理界面)

### 获取 Token 后

告诉我 Token，我帮你：
- 配置 OpenClaw
- 重启 Gateway
- 测试对话

---

## 📞 需要帮助？

执行过程中遇到任何问题，告诉我：
- 错误信息
- 执行到哪一步
- 截图（如果有）

我会帮你解决！👨‍💻

---

*创建时间*: 2026-03-04 18:35  
*状态*: 🔄 等待 Docker 完全启动
