#!/bin/bash
# WeChatPadPro 自动配置脚本
# 创建时间：2026-03-04

set -e

echo "🔧 开始配置 WeChatPadPro..."

# 检查 Docker
echo "⏳ 检查 Docker 状态..."
if ! command -v docker &> /dev/null; then
    echo "❌ Docker 未找到，请等待 Docker Desktop 完全启动"
    echo "💡 提示：打开 Docker Desktop 应用，等待 3-5 分钟"
    exit 1
fi

echo "✅ Docker 已就绪：$(docker --version)"

# 进入目录
cd /Applications/WeChatPadPro

# 创建 .env
echo "📝 创建 .env 配置文件..."
cat > .env << 'EOF'
ADMIN_KEY=99999
HOST=0.0.0.0
PORT=1239
DEBUG=true
REDIS_HOST=wechatpadpro_redis
REDIS_PORT=6379
REDIS_PASS=123456
MYSQL_CONNECT_STR=wechatpadpro:123456@tcp(wechatpadpro_mysql:3306)/wechatpadpro?charset=utf8mb4&parseTime=true&loc=Local
EOF

# 创建 docker-compose.yml
echo "📝 创建 docker-compose.yml..."
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

# 启动服务
echo "🚀 启动 WeChatPadPro 服务..."
docker-compose up -d

# 等待服务启动
echo "⏳ 等待服务启动..."
sleep 30

# 检查状态
echo "📊 服务状态:"
docker-compose ps

echo ""
echo "✅ WeChatPadPro 配置完成！"
echo ""
echo "📱 下一步:"
echo "1. 访问 http://localhost:1239 获取 Token"
echo "2. 告诉我 Token，我帮你配置 OpenClaw"
echo ""
echo "🔧 管理命令:"
echo "  查看日志：docker-compose logs -f"
echo "  重启服务：docker-compose restart"
echo "  停止服务：docker-compose down"
