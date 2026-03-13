#!/usr/bin/env python3
"""使用 Pollinations AI 生成图片（免费，无需 API key）"""

import requests
import urllib.parse

PROMPT = "a beautiful sunset over mountains, digital art, vibrant colors"
WIDTH = 1024
HEIGHT = 1024
SEED = 42

# Pollinations API URL
encoded_prompt = urllib.parse.quote(PROMPT)
img_url = f"https://image.pollinations.ai/prompt/{encoded_prompt}?width={WIDTH}&height={HEIGHT}&seed={SEED}&nologo=true"

print(f"🎨 生成图片：{PROMPT}")
print(f"📷 请求 URL: {img_url}")

try:
    # 下载图片
    response = requests.get(img_url, timeout=60)
    
    if response.status_code == 200 and len(response.content) > 0:
        output_path = "/Users/autumn/.openclaw/workspace/generated_image.png"
        with open(output_path, "wb") as f:
            f.write(response.content)
        print(f"✅ 生成成功！")
        print(f"💾 已保存：{output_path}")
        print(f"📏 文件大小：{len(response.content)} bytes")
    else:
        print(f"❌ 生成失败：{response.status_code}")
except Exception as e:
    print(f"❌ 错误：{e}")
