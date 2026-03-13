# 📱 小红书 MCP - 手动安装指南

## ⚠️ 网络问题说明

由于 GitHub 下载速度慢，建议手动下载安装。

---

## 🎯 方案：手动下载 + 自动配置

### 第 1 步：手动下载（2 个文件）

**方式 A：浏览器下载（推荐）**

1. **打开浏览器，访问：**
   ```
   https://github.com/xpzouying/xiaohongshu-mcp/releases/latest
   ```

2. **下载以下 2 个文件：**
   - `xiaohongshu-mcp-darwin-arm64`（主程序）
   - `xiaohongshu-login-darwin-arm64`（登录工具）

3. **保存到：**
   ```
   /Users/autumn/Projects/xiaohongshu-mcp/
   ```

**方式 B：使用下载工具**

如果你有代理或下载加速器，可以用：
```bash
cd /Users/autumn/Projects
mkdir -p xiaohongshu-mcp
cd xiaohongshu-mcp

# 下载主程序
curl -L -o xiaohongshu-mcp https://github.com/xpzouying/xiaohongshu-mcp/releases/latest/download/xiaohongshu-mcp-darwin-arm64

# 下载登录工具
curl -L -o xiaohongshu-login https://github.com/xpzouying/xiaohongshu-mcp/releases/latest/download/xiaohongshu-login-darwin-arm64
```

---

### 第 2 步：添加执行权限

打开终端，运行：

```bash
cd /Users/autumn/Projects/xiaohongshu-mcp
chmod +x xiaohongshu-mcp
chmod +x xiaohongshu-login
ls -la
```

应该看到两个可执行文件。

---

### 第 3 步：登录小红书

```bash
cd /Users/autumn/Projects/xiaohongshu-mcp
./xiaohongshu-login
```

- 会自动打开浏览器
- 用小红书 App 扫码登录
- 登录成功后会显示 "登录成功"
- Cookies 会自动保存到 `~/.xiaohongshu-mcp/`

---

### 第 4 步：启动 MCP 服务

```bash
./xiaohongshu-mcp
```

服务会运行在：`http://localhost:18060/mcp`

**保持这个终端窗口打开！**

---

### 第 5 步：接入 Claude

打开**新的**终端窗口，运行：

```bash
claude mcp add --transport http xiaohongshu-mcp http://localhost:18060/mcp
claude mcp list
```

看到 `xiaohongshu-mcp` 就说明配置成功了！

---

### 第 6 步：测试发布

现在你可以对我说：

```
帮我发布一篇关于 AI 学习的图文到小红书
```

我会自动调用 xiaohongshu-mcp 发布！

---

## 📊 文件结构

```
/Users/autumn/Projects/xiaohongshu-mcp/
├── xiaohongshu-mcp          # 主程序（服务）
├── xiaohongshu-login        # 登录工具
└── (cookies 保存在 ~/.xiaohongshu-mcp/)
```

---

## 🔄 日常使用

### 启动服务

每次使用前需要启动：

```bash
cd /Users/autumn/Projects/xiaohongshu-mcp
./xiaohongshu-mcp
```

### 检查登录状态

```bash
# 在另一个终端
curl http://localhost:18060/mcp \
  -H "Content-Type: application/json" \
  -d '{"jsonrpc":"2.0","method":"check_login_status","id":1}'
```

### 重新登录

如果 cookies 过期：

```bash
./xiaohongshu-login  # 重新扫码登录
```

---

## ⚠️ 注意事项

1. **一个账号只能登录一个网页端**
   - 登录后不要在其他网页登录小红书
   - 可以用手机 App 查看

2. **实名认证**
   - 新号可能需要实名认证才能发布

3. **内容限制**
   - 标题 ≤ 20 字
   - 正文 ≤ 1000 字

4. **每日限额**
   - 每天最多发 50 篇

---

## 🐛 常见问题

### Q: 下载失败？
A: 使用浏览器手动下载，或检查网络

### Q: 启动失败？
A: 检查端口是否被占用：`lsof -i :18060`

### Q: 登录失败？
A: 清除 cookies 重新登录：`rm -rf ~/.xiaohongshu-mcp/`

### Q: 发布失败？
A: 检查图片路径、内容是否违规

---

## 📞 需要帮助？

**下载完成后，告诉我：**
- ✅ 已下载
- ✅ 已登录
- ✅ 服务已启动

然后我帮你配置接入并发布第一篇内容！

---

**现在去下载吧！下载完成后告诉我！** 🚀
