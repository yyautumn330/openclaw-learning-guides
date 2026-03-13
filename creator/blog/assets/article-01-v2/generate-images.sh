#!/bin/bash

# Image generation script for article: 5 分钟搭建你的第一个 AI 助手
# Output directory
OUTPUT_DIR=~/.openclaw/workspace/creator/blog/assets/article-01-v2

# Ensure output directory exists
mkdir -p "$OUTPUT_DIR"

echo "Generating 6 images for the article..."

# 1. 封面图
echo "1/6 Generating cover image..."
infsh app run xai/grok-imagine-image --input '{
  "prompt": "Modern AI assistant concept, friendly robot helper, clean minimalist design, blue and white color scheme, technology background, professional illustration style",
  "aspect_ratio": "16:9"
}' --save "$OUTPUT_DIR/01-cover-result.json"

# 2. 安装流程图
echo "2/6 Generating installation flow image..."
infsh app run xai/grok-imagine-image --input '{
  "prompt": "Terminal command line interface, code installation steps, clean dark theme, developer tools, programming aesthetic",
  "aspect_ratio": "16:9"
}' --save "$OUTPUT_DIR/02-install-flow-result.json"

# 3. 架构对比图
echo "3/6 Generating architecture comparison image..."
infsh app run xai/grok-imagine-image --input '{
  "prompt": "Comparison diagram, traditional AI vs modern AI agent, split screen visualization, clean infographic style",
  "aspect_ratio": "16:9"
}' --save "$OUTPUT_DIR/03-architecture-comparison-result.json"

# 4. 技能系统图
echo "4/6 Generating skills system image..."
infsh app run xai/grok-imagine-image --input '{
  "prompt": "Plugin system concept, modular blocks connecting, puzzle pieces, technology ecosystem, isometric illustration",
  "aspect_ratio": "16:9"
}' --save "$OUTPUT_DIR/04-skills-system-result.json"

# 5. 记忆系统图
echo "5/6 Generating memory system image..."
infsh app run xai/grok-imagine-image --input '{
  "prompt": "Digital memory concept, file folders with glowing data, knowledge base visualization, blue purple gradient",
  "aspect_ratio": "16:9"
}' --save "$OUTPUT_DIR/05-memory-system-result.json"

# 6. 多平台接入图
echo "6/6 Generating multi-platform image..."
infsh app run xai/grok-imagine-image --input '{
  "prompt": "Multiple messaging apps icons connected, WeChat Feishu Telegram, network hub concept, clean modern design",
  "aspect_ratio": "16:9"
}' --save "$OUTPUT_DIR/06-multi-platform-result.json"

echo ""
echo "All images generated! Check the result JSON files in $OUTPUT_DIR"
echo "Extract the image URLs from the JSON files to get the actual images."
