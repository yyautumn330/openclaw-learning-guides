#!/bin/bash
# ComfyUI 模型下载脚本 - M4 Max 推荐配置
# 支持多种下载方式，自动选择可用源

set -e

COMFYUI_DIR="/Users/autumn/.openclaw/workspace/coder/ComfyUI"
CHECKPOINTS_DIR="$COMFYUI_DIR/models/checkpoints"
LORAS_DIR="$COMFYUI_DIR/models/loras"
CONTROLNET_DIR="$COMFYUI_DIR/models/controlnet"

# 创建目录
mkdir -p "$CHECKPOINTS_DIR" "$LORAS_DIR" "$CONTROLNET_DIR"

echo "🎯 ComfyUI 模型下载脚本"
echo "====================================="
echo "📍 模型目录：$CHECKPOINTS_DIR"
echo ""

# 检查 huggingface-cli
if command -v huggingface-cli &> /dev/null; then
    USE_HF=true
    echo "✅ 检测到 huggingface-cli"
else
    USE_HF=false
    echo "⚠️  huggingface-cli 未安装，将使用 curl 下载"
    echo "   安装命令：pip install huggingface_hub"
fi

# 模型列表 (可根据需要注释不需要的模型)
declare -A MODELS=(
    # SDXL 基础模型 (推荐首选)
    ["sd_xl_base_1.0.safetensors"]="stabilityai/stable-diffusion-xl-base-1.0"
    
    # SDXL Refiner (可选，用于提升质量)
    # ["sd_xl_refiner_1.0.safetensors"]="stabilityai/stable-diffusion-xl-refiner-1.0"
    
    # FLUX.1-dev (最新，文字渲染强，约 24GB)
    # ["flux1-dev.safetensors"]="black-forest-labs/FLUX.1-dev"
    
    # Stable Diffusion 1.5 (快速，生态丰富)
    # ["v1-5-pruned-emaonly.safetensors"]="runwayml/stable-diffusion-v1-5"
)

# 下载函数 (huggingface-cli)
download_hf() {
    local filename=$1
    local repo=$2
    local output_dir=$3
    
    echo "📥 下载：$filename (来自 $repo)"
    huggingface-cli download "$repo" "$filename" \
        --local-dir "$output_dir" \
        --resume-download
}

# 下载函数 (curl)
download_curl() {
    local filename=$1
    local repo=$2
    local output_dir=$3
    
    local url="https://huggingface.co/$repo/resolve/main/$filename"
    echo "📥 下载：$filename"
    echo "   URL: $url"
    curl -L -o "$output_dir/$filename" "$url"
}

# 主菜单
echo ""
echo "请选择要下载的模型:"
echo "  1) SDXL Base 1.0 (6.5GB) - 推荐首选 ⭐"
echo "  2) SDXL Base + Refiner (13GB) - 高质量组合"
echo "  3) FLUX.1-dev (24GB) - 最新，文字渲染强"
echo "  4) SD 1.5 (4GB) - 快速，生态丰富"
echo "  5) 全部下载 (需要约 45GB)"
echo "  0) 跳过"
echo ""
read -p "请输入选项 (默认 1): " choice
choice=${choice:-1}

case $choice in
    1)
        if [ "$USE_HF" = true ]; then
            download_hf "sd_xl_base_1.0.safetensors" "stabilityai/stable-diffusion-xl-base-1.0" "$CHECKPOINTS_DIR"
        else
            download_curl "sd_xl_base_1.0.safetensors" "stabilityai/stable-diffusion-xl-base-1.0" "$CHECKPOINTS_DIR"
        fi
        ;;
    2)
        if [ "$USE_HF" = true ]; then
            download_hf "sd_xl_base_1.0.safetensors" "stabilityai/stable-diffusion-xl-base-1.0" "$CHECKPOINTS_DIR"
            download_hf "sd_xl_refiner_1.0.safetensors" "stabilityai/stable-diffusion-xl-refiner-1.0" "$CHECKPOINTS_DIR"
        else
            download_curl "sd_xl_base_1.0.safetensors" "stabilityai/stable-diffusion-xl-base-1.0" "$CHECKPOINTS_DIR"
            download_curl "sd_xl_refiner_1.0.safetensors" "stabilityai/stable-diffusion-xl-refiner-1.0" "$CHECKPOINTS_DIR"
        fi
        ;;
    3)
        echo "⚠️  FLUX.1-dev 较大 (24GB)，下载可能需要较长时间"
        read -p "确认下载？(y/n): " confirm
        if [ "$confirm" = "y" ]; then
            if [ "$USE_HF" = true ]; then
                download_hf "flux1-dev.safetensors" "black-forest-labs/FLUX.1-dev" "$CHECKPOINTS_DIR"
            else
                download_curl "flux1-dev.safetensors" "black-forest-labs/FLUX.1-dev" "$CHECKPOINTS_DIR"
            fi
        fi
        ;;
    4)
        if [ "$USE_HF" = true ]; then
            download_hf "v1-5-pruned-emaonly.safetensors" "runwayml/stable-diffusion-v1-5" "$CHECKPOINTS_DIR"
        else
            download_curl "v1-5-pruned-emaonly.safetensors" "runwayml/stable-diffusion-v1-5" "$CHECKPOINTS_DIR"
        fi
        ;;
    5)
        echo "📦 批量下载所有模型 (约 45GB)"
        read -p "确认？(y/n): " confirm
        if [ "$confirm" = "y" ]; then
            for filename in "${!MODELS[@]}"; do
                repo="${MODELS[$filename]}"
                if [ "$USE_HF" = true ]; then
                    download_hf "$filename" "$repo" "$CHECKPOINTS_DIR"
                else
                    download_curl "$filename" "$repo" "$CHECKPOINTS_DIR"
                fi
            done
        fi
        ;;
    0)
        echo "已跳过下载"
        exit 0
        ;;
    *)
        echo "❌ 无效选项"
        exit 1
        ;;
esac

echo ""
echo "✅ 模型下载完成!"
echo ""
echo "📚 模型位置：$CHECKPOINTS_DIR"
echo ""
echo "🎯 下一步:"
echo "  1. 刷新 ComfyUI Web 界面 (http://127.0.0.1:8188)"
echo "  2. 在 CheckpointLoader 节点选择刚下载的模型"
echo "  3. 开始生成!"
echo ""

# 列出已下载的模型
echo "📦 当前可用模型:"
ls -lh "$CHECKPOINTS_DIR"/*.safetensors 2>/dev/null || echo "  (暂无)"
