# 📱 小红书 MCP 安装指南

## ✅ 工具确认

**工具名称：** xiaohongshu-mcp
**GitHub：** https://github.com/xpzouying/xiaohongshu-mcp
**功能：** 可以自动发布图文/视频到小红书

---

## 🚀 三种安装方式

### 方式 A：Docker 安装（最简单 ⭐）

**前提：** 需要安装 Docker Desktop

**步骤：**

1. **安装 Docker Desktop**
   ```bash
   # 访问下载
   https://www.docker.com/products/docker-desktop/
   ```

2. **拉取镜像并启动**
   ```bash
   cd /Users/autumn/Projects
   docker pull xpzouying/xiaohongshu-mcp
   docker run -d -p 18060:18060 --name xiaohongshu-mcp xpzouying/xiaohongshu-mcp
   ```

3. **验证运行**
   ```bash
   docker ps | grep xiaohongshu-mcp
   ```

---

### 方式 B：下载二进制文件（推荐）

**步骤：**

1. **下载最新版本**
   ```bash
   cd /Users/autumn/Projects
   curl -LO https://github.com/xpzouying/xiaohongshu-mcp/releases/latest/download/xiaohongshu-mcp-darwin-arm64
   curl -LO https://github.com/xpzouying/xiaohongshu-mcp/releases/latest/download/xiaohongshu-login-darwin-arm64
   ```

2. **添加执行权限**
   ```bash
   chmod +x xiaohongshu-mcp-darwin-arm64
   chmod +x xiaohongshu-login-darwin-arm64
   ```

3. **运行登录工具**
   ```bash
   ./xiaohongshu-login-darwin-arm64
   ```
   - 扫码登录小红书
   - 登录成功后会保存 cookies

4. **启动 MCP 服务**
   ```bash
   ./xiaohongshu-mcp-darwin-arm64
   ```
   - 服务运行在：http://localhost:18060/mcp

---

### 方式 C：源码编译

**前提：** 需要安装 Go

**步骤：**

1. **安装 Go**
   ```bash
   brew install go
   ```

2. **克隆代码**
   ```bash
   cd /Users/autumn/Projects
   git clone https://github.com/xpzouying/xiaohongshu-mcp.git
   cd xiaohongshu-mcp
   ```

3. **编译运行**
   ```bash
   go run cmd/login/main.go  # 登录
   go run .                  # 启动服务
   ```

---

## 🔌 接入 OpenClaw/Claude

安装完成后，添加 MCP 配置：

### Claude Desktop 配置

编辑 `~/Library/Application Support/Claude/claude_desktop_config.json`：

```json
{
  "mcpServers": {
    "xiaohongshu-mcp": {
      "url": "http://localhost:18060/mcp",
      "type": "http"
    }
  }
}
```

### Claude Code 配置

```bash
claude mcp add --transport http xiaohongshu-mcp http://localhost:18060/mcp
```

### 验证连接

```bash
claude mcp list
```

---

## 📝 使用示例

### 发布图文

```
帮我发布一篇关于 AI 学习的图文到小红书：
- 标题：0 基础！3 分钟搞懂 AI
- 内容：[正文内容]
- 图片：/path/to/cover.jpg
```

### 检查登录状态

```
检查小红书登录状态
```

### 搜索内容

```
搜索小红书上关于"AI 学习"的内容
```

---

## ⚠️ 注意事项

1. **首次需要登录** - 运行登录工具扫码
2. **一个账号只能登录一个网页端** - 登录后不要在其他网页登录
3. **实名认证** - 新号可能需要实名认证
4. **内容限制**：
   - 标题 ≤ 20 字
   - 正文 ≤ 1000 字
5. **每日限额** - 每天最多发 50 篇

---

## 🐛 常见问题

### Q: 下载速度慢？
A: 使用国内镜像或代理

### Q: 登录失败？
A: 检查网络，或使用非无头模式

### Q: 发布失败？
A: 检查图片路径、内容是否违规

### Q: Cookies 过期？
A: 重新运行登录工具

---

## 📞 下一步

**选择一种安装方式，然后：**

1. **安装工具**
2. **运行登录**
3. **启动服务**
4. **告诉我完成了**，我帮你配置接入

---

**推荐：方式 B（二进制文件）** - 最简单，不需要额外依赖！
