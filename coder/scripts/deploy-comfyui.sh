#!/bin/bash
# ComfyUI 部署脚本 - M4 Max 优化版
# 适用于 macOS Apple Silicon (MPS 加速)

set -e

WORKSPACE="/Users/autumn/.openclaw/workspace/coder"
COMFYUI_DIR="$WORKSPACE/ComfyUI"
VENV_DIR="$COMFYUI_DIR/venv"

echo "🚀 开始部署 ComfyUI (M4 Max 优化版)"
echo "====================================="

# 1. 检查依赖
echo "📦 检查依赖..."
if ! command -v python3 &> /dev/null; then
    echo "❌ Python3 未安装，请先运行：brew install python@3.11"
    exit 1
fi

if ! command -v git &> /dev/null; then
    echo "❌ Git 未安装，请先运行：brew install git"
    exit 1
fi

PYTHON_VERSION=$(python3 --version | awk '{print $2}')
echo "✅ Python 版本：$PYTHON_VERSION"

# 2. 克隆 ComfyUI
echo "📥 克隆 ComfyUI..."
cd "$WORKSPACE"
if [ -d "ComfyUI" ]; then
    echo "⚠️  ComfyUI 已存在，跳过克隆"
else
    # 尝试多个镜像源
    for repo in \
        "https://github.com/comfyanonymous/ComfyUI.git" \
        "https://gitee.com/mirrors/ComfyUI.git" \
        "https://gitclone.com/github.com/comfyanonymous/ComfyUI.git"; do
        echo "尝试克隆：$repo"
        if git clone --depth 1 "$repo" 2>/dev/null; then
            echo "✅ 克隆成功"
            break
        fi
        echo "❌ 失败，尝试下一个..."
    done
    
    if [ ! -d "ComfyUI" ]; then
        echo "❌ 所有镜像源都失败，请检查网络"
        exit 1
    fi
fi

# 3. 创建虚拟环境
echo "🐍 创建虚拟环境..."
cd "$COMFYUI_DIR"
if [ ! -d "venv" ]; then
    python3 -m venv venv
fi

# 4. 激活虚拟环境并安装依赖
echo "📦 安装依赖 (使用 MPS 加速配置)..."
source "$VENV_DIR/bin/activate"
pip install --upgrade pip
pip install -r requirements.txt

# 5. 安装 MPS 优化依赖
echo "⚡ 安装 MPS 优化依赖..."
pip install torch torchvision torchaudio --index-url https://download.pytorch.org/whl/nightly/cpu

# 6. 创建启动脚本
echo "📝 创建启动脚本..."
cat > "$COMFYUI_DIR/start-comfyui.sh" << 'EOF'
#!/bin/bash
# ComfyUI 启动脚本 - M4 Max 优化

COMFYUI_DIR="$(cd "$(dirname "$0")" && pwd)"
VENV_DIR="$COMFYUI_DIR/venv"

echo "🚀 启动 ComfyUI (MPS 加速)..."
echo "====================================="

source "$VENV_DIR/bin/activate"

# M4 Max 优化参数
python main.py \
    --device mps \
    --listen 127.0.0.1 \
    --port 8188 \
    --disable-auto-launch \
    --fast \
    --optimise-attention \
    "$@"
EOF

chmod +x "$COMFYUI_DIR/start-comfyui.sh"

# 7. 创建批量生成脚本
echo "📦 创建批量生成脚本..."
cat > "$COMFYUI_DIR/batch-generate.sh" << 'EOF'
#!/bin/bash
# 批量文生图脚本

COMFYUI_DIR="$(cd "$(dirname "$0")" && pwd)"
source "$COMFYUI_DIR/venv/bin/activate"

# API 调用示例
curl -X POST "http://127.0.0.1:8188/prompt" \
    -H "Content-Type: application/json" \
    -d @workflow.json

echo "✅ 批量任务已提交"
EOF

chmod +x "$COMFYUI_DIR/batch-generate.sh"

echo ""
echo "✅ ComfyUI 部署完成!"
echo "====================================="
echo "📍 安装位置：$COMFYUI_DIR"
echo "🚀 启动命令：cd $COMFYUI_DIR && ./start-comfyui.sh"
echo "🌐 Web 界面：http://127.0.0.1:8188"
echo ""
echo "📚 下一步:"
echo "  1. 启动 ComfyUI: cd $COMFYUI_DIR && ./start-comfyui.sh"
echo "  2. 下载模型：放入 ComfyUI/models/checkpoints/"
echo "  3. 导入工作流：Web 界面拖入 JSON 文件"
echo ""
