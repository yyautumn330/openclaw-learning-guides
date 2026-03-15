#!/bin/bash
# 小白快跑自动编译脚本
# 监控文件变化并自动编译

PROJECT_DIR="/Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiRun"
HVIGOR="/Applications/DevEco-Studio.app/Contents/tools/node/bin/node /Applications/DevEco-Studio.app/Contents/tools/hvigor/bin/hvigorw.js"

# 设置 SDK 环境变量
export DEVECO_SDK_HOME="/Users/autumn/Library/Huawei/Sdk"
export HOS_SDK_HOME="$DEVECO_SDK_HOME/openharmony"
export NODE_HOME="/Applications/DevEco-Studio.app/Contents/tools/node"

cd "$PROJECT_DIR"

echo "🔍 启动自动编译监控..."
echo "📁 项目目录: $PROJECT_DIR"
echo "⏳ 首次编译..."

# 首次编译
$HVIGOR assembleHap --no-daemon 2>&1

echo ""
echo "✅ 首次编译完成，启动 watch 模式..."
echo "   修改 .ets/.ts 文件后会自动重新编译"
echo "   按 Ctrl+C 停止"
echo ""

# watch 模式
$HVIGOR assembleHap --watch --no-daemon 2>&1