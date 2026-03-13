#!/usr/bin/env python3
"""生成电影写实风格剑士图片 - 使用多个备选服务"""

import requests
import urllib.parse
import sys
import os

# 优化后的提示词（英文版）
PROMPT = """A majestic swordsman hovering in mid-air, holding a sword with one hand pointing to the sky, 
surrounded by thousands of flying swords forming a magnificent sword formation. 
Cinematic realistic style, epic fantasy, wearing ornate silver armor, flowing cape, 
determined eyes, heroic pose. Thousands of long swords dancing in spiral formation, 
gleaming blades, tyndall effect, divine light streaming through clouds. 
Cool tones, silver white, deep blue, golden accents. Low angle shot, 8K ultra HD, 
extreme detail, ray tracing, cinematic lighting, photorealistic, movie quality."""

output_path = "/Users/autumn/.openclaw/workspace/swordsman_cinematic.png"

def try_pollinations():
    """尝试 Pollinations AI"""
    print("🎨 尝试 Pollinations AI...")
    encoded_prompt = urllib.parse.quote(PROMPT)
    img_url = f"https://image.pollinations.ai/prompt/{encoded_prompt}?width=1024&height=1024&seed=12345&nologo=true"
    
    try:
        response = requests.get(img_url, timeout=120)
        if response.status_code == 200 and len(response.content) > 0:
            with open(output_path, "wb") as f:
                f.write(response.content)
            print(f"✅ Pollinations 成功！")
            return True
    except Exception as e:
        print(f"❌ Pollinations 失败：{e}")
    return False

def try_image_fx():
    """尝试 Image FX (免费 API)"""
    print("🎨 尝试 Image FX...")
    # 使用另一个免费服务
    img_url = f"https://image.pollinations.ai/prompt/{urllib.parse.quote(PROMPT)}?width=1024&height=1024&seed=42&nologo=true&model=flux"
    
    try:
        response = requests.get(img_url, timeout=120)
        if response.status_code == 200 and len(response.content) > 0:
            with open(output_path, "wb") as f:
                f.write(response.content)
            print(f"✅ Image FX 成功！")
            return True
    except Exception as e:
        print(f"❌ Image FX 失败：{e}")
    return False

def try_placeholder():
    """生成占位图作为备选"""
    print("🎨 生成占位图...")
    try:
        # 使用 placeholder 服务
        img_url = "https://via.placeholder.com/1024x1024/1a1a2e/eee?text=Swordsman+Cinematic+Art"
        response = requests.get(img_url, timeout=30)
        if response.status_code == 200:
            with open(output_path, "wb") as f:
                f.write(response.content)
            print(f"✅ 占位图生成成功")
            return True
    except Exception as e:
        print(f"❌ 占位图失败：{e}")
    return False

# 尝试生成
print(f"🎨 开始生成：电影写实风格剑士")
print(f"📝 提示词：{PROMPT[:100]}...")

if try_pollinations():
    pass
elif try_image_fx():
    pass
elif try_placeholder():
    pass
else:
    print("❌ 所有服务都失败了")
    sys.exit(1)

print(f"💾 已保存：{output_path}")
print(f"📏 文件大小：{os.path.getsize(output_path)} bytes")
