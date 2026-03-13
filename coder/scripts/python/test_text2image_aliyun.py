#!/usr/bin/env python3
"""使用阿里云 DashScope API 测试文生图"""

import dashscope
from dashscope import ImageSynthesis
import os

# 使用配置中的 API key
dashscope.api_key = "sk-sp-b84c4b4844224c46961078d6a658c0e3"

prompt = "a beautiful sunset over mountains, digital art, vibrant colors"
print(f"🎨 生成图片：{prompt}")

try:
    rsp = ImageSynthesis.call(
        model=ImageSynthesis.Models.wanx_v1,
        prompt=prompt,
        n=1,
        size='1024*1024'
    )
    
    if rsp.status_code == 200:
        print("✅ 生成成功!")
        for result in rsp.output.results:
            print(f"📷 图片 URL: {result.url}")
            # 保存图片到本地
            import requests
            img_data = requests.get(result.url).content
            output_path = "/Users/autumn/.openclaw/workspace/generated_image.png"
            with open(output_path, 'wb') as f:
                f.write(img_data)
            print(f"💾 已保存到：{output_path}")
    else:
        print(f"❌ 生成失败：{rsp.code} - {rsp.message}")
except Exception as e:
    print(f"❌ 错误：{e}")
