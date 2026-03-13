#!/bin/bash

# ComfyUI 文章配图生成脚本 (修正版)
# 文章：5 分钟搭建你的第一个 AI 助手

OUTPUT_DIR=~/.openclaw/workspace/creator/blog/assets/article-01-v2
COMFYUI_URL="http://localhost:8188"
MODEL="sd_xl_base_1.0.safetensors"

mkdir -p "$OUTPUT_DIR"

echo "🎨 使用 ComfyUI 生成文章配图..."
echo "   模型：$MODEL"
echo ""

# 检查 ComfyUI 是否可用
echo "📡 检查 ComfyUI 连接..."
if ! curl -s --connect-timeout 3 "$COMFYUI_URL/system_stats" > /dev/null; then
  echo "❌ ComfyUI 无响应，请确保已启动"
  exit 1
fi
echo "✅ ComfyUI 连接正常"
echo ""

# 图片需求列表
declare -a IMAGES=(
  "01-cover:Modern AI assistant concept, friendly robot helper, clean minimalist design, blue and white color scheme, technology background, professional illustration style"
  "02-install-flow:Terminal command line interface, code installation steps, clean dark theme, developer tools, programming aesthetic"
  "03-architecture-comparison:Comparison diagram, traditional AI vs modern AI agent, split screen visualization, clean infographic style"
  "04-skills-system:Plugin system concept, modular blocks connecting, puzzle pieces, technology ecosystem, isometric illustration"
  "05-memory-system:Digital memory concept, file folders with glowing data, knowledge base visualization, blue purple gradient"
  "06-multi-platform:Multiple messaging apps icons connected, WeChat Feishu Telegram, network hub concept, clean modern design"
)

# 生成每张图片
for i in "${!IMAGES[@]}"; do
  IFS=':' read -r filename prompt <<< "${IMAGES[$i]}"
  
  echo "[$((i+1))/6] 生成：$filename.png"
  
  # 创建 ComfyUI 工作流 (SDXL)
  cat > /tmp/workflow_$filename.json <<EOF
{
  "prompt": {
    "3": {
      "class_type": "KSampler",
      "inputs": {
        "cfg": 7,
        "denoise": 1,
        "latent_image": ["5", 0],
        "model": ["4", 0],
        "negative": ["7", 0],
        "positive": ["6", 0],
        "sampler_name": "euler",
        "scheduler": "normal",
        "seed": $((RANDOM + i)),
        "steps": 20
      }
    },
    "4": {
      "class_type": "CheckpointLoaderSimple",
      "inputs": {
        "ckpt_name": "$MODEL"
      }
    },
    "5": {
      "class_type": "EmptyLatentImage",
      "inputs": {
        "batch_size": 1,
        "height": 576,
        "width": 1024
      }
    },
    "6": {
      "class_type": "CLIPTextEncode",
      "inputs": {
        "clip": ["4", 1],
        "text": "$prompt, high quality, detailed, professional, 8k"
      }
    },
    "7": {
      "class_type": "CLIPTextEncode",
      "inputs": {
        "clip": ["4", 1],
        "text": "low quality, blurry, distorted, ugly, bad anatomy, watermark, text"
      }
    },
    "8": {
      "class_type": "VAEDecode",
      "inputs": {
        "samples": ["3", 0],
        "vae": ["4", 2]
      }
    },
    "9": {
      "class_type": "SaveImage",
      "inputs": {
        "filename_prefix": "$filename",
        "images": ["8", 0]
      }
    }
  }
}
EOF

  # 发送工作流到 ComfyUI
  RESPONSE=$(curl -s -X POST "$COMFYUI_URL/prompt" \
    -H "Content-Type: application/json" \
    -d @/tmp/workflow_$filename.json)
  
  PROMPT_ID=$(echo "$RESPONSE" | python3 -c "import sys,json; d=json.load(sys.stdin); print(d.get('prompt_id', ''))" 2>/dev/null)
  
  if [ -n "$PROMPT_ID" ]; then
    echo "    ✅ 任务已提交 (ID: $PROMPT_ID)"
  else
    echo "    ❌ 提交失败：$RESPONSE"
  fi
  
  # 等待一下
  sleep 2
done

echo ""
echo "🎉 所有图片生成任务已提交!"
echo ""
echo "📁 ComfyUI 输出目录：~/ComfyUI/output/"
echo "⏳ 等待 ComfyUI 完成渲染..."
echo ""
echo "   查看进度：$COMFYUI_URL/history"
echo ""
echo "💡 提示：SDXL 生成较慢，每张图约需 1-2 分钟"
echo ""
