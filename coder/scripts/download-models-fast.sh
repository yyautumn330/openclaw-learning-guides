#!/bin/bash
# ComfyUI 模型下载 - 国内镜像加速版
# 使用多个镜像源，自动选择最快的

set -e

CHECKPOINTS_DIR="/Users/autumn/.openclaw/workspace/coder/ComfyUI/models/checkpoints"
MODEL_FILE="sd_xl_base_1.0.safetensors"

mkdir -p "$CHECKPOINTS_DIR"
cd "$CHECKPOINTS_DIR"

echo "🚀 开始下载 SDXL Base 1.0 (6.5GB)"
echo "====================================="
echo ""

# 镜像源列表 (按优先级)
MIRRORS=(
    # 国内镜像
    "https://hf-mirror.com/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/$MODEL_FILE"
    # 官方源
    "https://huggingface.co/stabilityai/stable-diffusion-xl-base-1.0/resolve/main/$MODEL_FILE"
)

for i in "${!MIRRORS[@]}"; do
    url="${MIRRORS[$i]}"
    echo "尝试镜像 $((i+1))/${#MIRRORS[@]}: $url"
    
    if curl -L -C - -o "$MODEL_FILE" "$url" 2>&1; then
        if [ -f "$MODEL_FILE" ] && [ -s "$MODEL_FILE" ]; then
            echo ""
            echo "✅ 下载成功!"
            ls -lh "$MODEL_FILE"
            echo ""
            
            # 验证文件大小 (SDXL 约 6.5GB)
            size=$(stat -f%z "$MODEL_FILE" 2>/dev/null || stat -c%s "$MODEL_FILE" 2>/dev/null || echo 0)
            size_gb=$((size / 1024 / 1024 / 1024))
            echo "📦 文件大小：${size_gb}GB"
            
            if [ $size_gb -gt 5 ]; then
                echo "✅ 文件大小正常，下载完成!"
                exit 0
            else
                echo "⚠️  文件大小异常，可能下载不完整"
                rm -f "$MODEL_FILE"
            fi
        fi
    fi
    
    echo "❌ 失败，尝试下一个镜像..."
    echo ""
done

echo "❌ 所有镜像源都失败，请检查网络连接"
echo ""
echo "备选方案:"
echo "  1. 使用代理: export https_proxy=http://your-proxy:port"
echo "  2. 手动下载后放入：$CHECKPOINTS_DIR"
echo "  3. 使用其他下载工具 (aria2c, wget 等)"
exit 1
