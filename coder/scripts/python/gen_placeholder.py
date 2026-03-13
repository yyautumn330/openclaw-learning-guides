#!/usr/bin/env python3
"""生成一个测试占位图"""

from PIL import Image, ImageDraw, ImageFont
import os

# 创建 1024x1024 图片
width, height = 1024, 1024
img = Image.new('RGB', (width, height), color=(70, 130, 180))  # 钢蓝色背景

draw = ImageDraw.Draw(img)

# 画一个太阳（圆形）
sun_x, sun_y = width // 2, height // 3
sun_radius = 150
draw.ellipse([sun_x - sun_radius, sun_y - sun_radius, 
              sun_x + sun_radius, sun_y + sun_radius], 
             fill=(255, 200, 0), outline=(255, 100, 0), width=5)

# 画山（三角形）
mountain_points = [
    (0, height),
    (width * 0.3, height * 0.5),
    (width * 0.5, height),
    (width * 0.7, height * 0.4),
    (width, height)
]
draw.polygon(mountain_points, fill=(139, 90, 43))

# 添加文字
text = "文生图测试 - 本地生成"
# 尝试使用系统字体
font_paths = [
    "/System/Library/Fonts/Supplemental/Arial.ttf",
    "/System/Library/Fonts/Helvetica.ttc",
    "/Library/Fonts/Arial.ttf"
]

font = None
for fp in font_paths:
    if os.path.exists(fp):
        font = ImageFont.truetype(fp, 48)
        break

if font:
    # 获取文字边界框
    bbox = draw.textbbox((0, 0), text, font=font)
    text_width = bbox[2] - bbox[0]
    text_height = bbox[3] - bbox[1]
    
    x = (width - text_width) // 2
    y = height - text_height - 50
    
    # 画文字阴影
    draw.text((x+2, y+2), text, fill=(0, 0, 0), font=font)
    # 画文字
    draw.text((x, y), text, fill=(255, 255, 255), font=font)

output_path = "/Users/autumn/.openclaw/workspace/generated_image.png"
img.save(output_path)
print(f"✅ 图片已生成：{output_path}")
print(f"📏 尺寸：{width}x{height}")
