#!/bin/bash
# 发送消息到飞书群组
# 用法: ./send-to-feishu.sh "你的消息内容"

WEBHOOK_URL="https://open.feishu.cn/open-apis/bot/v2/hook/a0857dd7-d8d5-4597-b094-807aef61337a"

if [ $# -eq 0 ]; then
    echo "用法: $0 \"消息内容\""
    exit 1
fi

MESSAGE="$1"

curl -X POST "$WEBHOOK_URL" \
  -H "Content-Type: application/json" \
  -d '{
    "msg_type": "text",
    "content": {
      "text": "'"$MESSAGE"'"
    }
  }'