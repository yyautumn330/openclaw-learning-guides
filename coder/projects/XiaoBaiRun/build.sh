#!/bin/bash
# 小白快跑一键编译脚本
# 用法: ./build.sh [assembleHap|assembleApp|clean]

# 加载环境变量
source "$(dirname "$0")/sdk-env.sh"

# 进入项目目录
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiRun

# 执行编译
TASK=${1:-assembleHap}
echo ""
echo "🔨 执行: hvigorw $TASK"
echo ""

/Applications/DevEco-Studio.app/Contents/tools/node/bin/node \
  /Applications/DevEco-Studio.app/Contents/tools/hvigor/bin/hvigorw.js \
  $TASK --no-daemon 2>&1

echo ""
echo "✅ 编译完成"