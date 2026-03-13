#!/usr/bin/env python3
"""使用 DeepFloyd IF 通过 HuggingFace Inference API 生成图片"""

import requests
import os

# 尝试使用环境变量中的 HF token，或者直接用免费端点
HF_API_URL = "https://api-inference.huggingface.co/models/deepfloyd/if-i-m-v1.0"

PROMPT = "a beautiful sunset over mountains, digital art, vibrant colors"

print(f"🎨 生成图片：{PROMPT}")

headers = {}  # 无需 token 也可以尝试

try:
    response = requests.post(
        HF_API_URL,
        headers=headers,
        json={"inputs": PROMPT},
        timeout=120
    )
    
    if response.status_code == 200:
        output_path = "/Users/autumn/.openclaw/workspace/generated_image.png"
        with open(output_path, "wb") as f:
            f.write(response.content)
        print(f"✅ 生成成功！")
        print(f"💾 已保存：{output_path}")
        print(f"📏 文件大小：{len(response.content)} bytes")
    else:
        print(f"❌ 请求失败：{response.status_code}")
        print(f"响应：{response.text[:500]}")
except Exception as e:
    print(f"❌ 错误：{e}")
