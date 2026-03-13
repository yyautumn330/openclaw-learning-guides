#!/bin/bash

# ComfyUI 文章配图生成脚本 (最终版)
# 文章：5 分钟搭建你的第一个 AI 助手

OUTPUT_DIR=~/.openclaw/workspace/coder/ComfyUI/output
COMFYUI_URL="http://localhost:8188"
MODEL="sd_xl_base_1.0.safetensors"

echo "🎨 使用 ComfyUI 生成文章配图..."
echo "   模型：$MODEL"
echo "   输出：$OUTPUT_DIR"
echo ""

# 检查 ComfyUI 是否可用
echo "📡 检查 ComfyUI 连接..."
if ! curl -s --connect-timeout 3 "$COMFYUI_URL/system_stats" > /dev/null; then
  echo "❌ ComfyUI 无响应"
  exit 1
fi
echo "✅ ComfyUI 连接正常"
echo ""

# 图片需求列表 (16:9 比例 = 1024x576)
declare -a IMAGES=(
  "article01_01_cover:Modern AI assistant concept, friendly robot helper, clean minimalist design, blue and white color scheme, technology background, professional illustration style"
  "article01_02_install:Terminal command line interface, code installation steps, clean dark theme, developer tools, programming aesthetic"
  "article01_03_architecture:Comparison diagram, traditional AI vs modern AI agent, split screen visualization, clean infographic style"
  "article01_04_skills:Plugin system concept, modular blocks connecting, puzzle pieces, technology ecosystem, isometric illustration"
  "article01_05_memory:Digital memory concept, file folders with glowing data, knowledge base visualization, blue purple gradient"
  "article01_06_platform:Multiple messaging apps icons connected, WeChat Feishu Telegram, network hub concept, clean modern design"
)

# 生成每张图片
for i in "${!IMAGES[@]}"; do
  IFS=':' read -r filename prompt <<< "${IMAGES[$i]}"
  
  echo "[$((i+1))/6] 生成：$filename.png"
  
  # 创建 ComfyUI 工作流
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
        "seed": $((RANDOM + i * 1000)),
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
        "text": "$prompt, high quality, detailed, professional, 8k, masterpiece"
      }
    },
    "7": {
      "class_type": "CLIPTextEncode",
      "inputs": {
        "clip": ["4", 1],
        "text": "low quality, blurry, distorted, ugly, bad anatomy, watermark, text, signature"
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
    
    # 等待完成 (SDXL 约 1-2 分钟/张)
    echo "    ⏳ 生成中..."
    for j in {1..60}; do
      sleep 2
      STATUS=$(curl -s "$COMFYUI_URL/history/$PROMPT_ID" | python3 -c "import sys,json; d=json.load(sys.stdin); v=list(d.values())[0] if d else {}; print(v.get('status',{}).get('status_str','running'))" 2>/dev/null)
      if [ "$STATUS" = "success" ]; then
        echo "    ✅ 完成!"
        break
      elif [ "$STATUS" = "error" ]; then
        echo "    ❌ 生成失败"
        break
      fi
      if [ $j -eq 60 ]; then
        echo "    ⏰ 超时 (仍在后台处理)"
      fi
    done
  else
    echo "    ❌ 提交失败：$RESPONSE"
  fi
  
  echo ""
done

echo "🎉 所有图片生成任务已完成!"
echo ""
echo "📁 输出目录：$OUTPUT_DIR"
echo ""
echo "📋 生成的文件:"
ls -lh "$OUTPUT_DIR"/article01_*.png 2>/dev/null
echo ""
