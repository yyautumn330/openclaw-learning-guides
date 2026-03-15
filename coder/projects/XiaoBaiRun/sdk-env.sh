#!/bin/bash
# 小白快跑 SDK 环境变量配置
# source sdk-env.sh 加载环境变量
# 
# 重要：DEVECO_SDK_HOME 必须指向 sdk 目录，不是 sdk/default！

# SDK 路径（注意：不要加 /default 后缀！）
export DEVECO_SDK_HOME="/Applications/DevEco-Studio.app/Contents/sdk"
export NODE_HOME="/Applications/DevEco-Studio.app/Contents/tools/node"
export JAVA_HOME="/Applications/DevEco-Studio.app/Contents/jbr/Contents/Home"

# 添加到 PATH
export PATH="$NODE_HOME/bin:$JAVA_HOME/bin:$PATH"

# 可选：设置 npm 镜像
export npm_config_registry="https://repo.harmonyos.com/npm/"

echo "✅ SDK 环境已加载:"
echo "  DEVECO_SDK_HOME=$DEVECO_SDK_HOME"
echo "  NODE_HOME=$NODE_HOME"
echo "  JAVA_HOME=$JAVA_HOME"
echo ""
echo "编译命令: cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiRun && hvigorw assembleHap"