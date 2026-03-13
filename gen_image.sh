#!/bin/bash
# 使用阿里云万相 API 生成图片

API_KEY="sk-sp-b84c4b4844224c46961078d6a658c0e3"
PROMPT="a beautiful sunset over mountains, digital art, vibrant colors"

# 创建任务
RESPONSE=$(curl -s -X POST "https://dashscope.aliyuncs.com/api/v1/services/aigc/text2image/image-synthesis" \
  -H "Authorization: Bearer $API_KEY" \
  -H "Content-Type: application/json" \
  -d "{
    \"model\": \"wanx-v1\",
    \"input\": {
      \"prompt\": \"$PROMPT\"
    },
    \"parameters\": {
      \"style\": \"<auto>\",
      \"size\": \"1024*1024",
      \"n\": 1
    }
  }")

echo "API 响应："
echo "$RESPONSE" | python3 -m json.tool 2>/dev/null || echo "$RESPONSE"
