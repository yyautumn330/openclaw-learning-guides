#!/bin/bash
# 小红书 MCP 一键安装脚本
# 适用于 macOS Apple Silicon

set -e

echo "🚀 开始安装小红书 MCP..."
echo ""

# 检查系统
if [[ "$(uname)" != "Darwin" ]]; then
    echo "❌ 此脚本仅适用于 macOS"
    exit 1
fi

# 检查架构
ARCH=$(uname -m)
if [[ "$ARCH" != "arm64" ]]; then
    echo "❌ 此脚本仅适用于 Apple Silicon (M1/M2/M3)"
    exit 1
fi

echo "✅ 系统检查通过：macOS Apple Silicon"
echo ""

# 创建目录
INSTALL_DIR="$HOME/Projects/xiaohongshu-mcp"
mkdir -p "$INSTALL_DIR"
cd "$INSTALL_DIR"

echo "📥 下载文件..."
echo ""

# 下载主程序
echo "1/3 下载主程序..."
curl -L -o xiaohongshu-mcp \
  https://github.com/xpzouying/xiaohongshu-mcp/releases/latest/download/xiaohongshu-mcp-darwin-arm64

# 下载登录工具
echo "2/3 下载登录工具..."
curl -L -o xiaohongshu-login \
  https://github.com/xpzouying/xiaohongshu-mcp/releases/latest/download/xiaohongshu-login-darwin-arm64

# 添加执行权限
echo "3/3 添加执行权限..."
chmod +x xiaohongshu-mcp
chmod +x xiaohongshu-login

echo ""
echo "✅ 下载完成！"
echo ""
echo "📂 安装位置：$INSTALL_DIR"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🔑 下一步：登录小红书"
echo ""
echo "运行以下命令："
echo "  cd $INSTALL_DIR"
echo "  ./xiaohongshu-login"
echo ""
echo "然后扫码登录你的小红书账号"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🚀 登录成功后，启动服务："
echo "  ./xiaohongshu-mcp"
echo ""
echo "服务地址：http://localhost:18060/mcp"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "📝 详细文档："
echo "  /Users/autumn/.openclaw/workspace/Xiaohongshu_Plan/INSTALL_GUIDE.md"
echo ""
