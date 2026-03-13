#!/usr/bin/env python3
"""
小白番茄专注钟 - 应用图标生成器
使用 PIL/Pillow 生成分层图标
"""

from PIL import Image, ImageDraw, ImageFilter
import math

# 颜色定义
TOMATO_RED = '#FF6B6B'
LEAF_GREEN = '#4CAF50'
LEAF_GREEN_ALT = '#4ECDC4'
BACKGROUND_WHITE = '#FFFFFF'
BACKGROUND_LIGHT_GRAY = '#F5F5F5'
HIGHLIGHT = '#FFAAAA'
SHADOW = '#CC5555'

def create_tomato_icon(size=512, output_path='app-icon-512.png'):
    """
    创建番茄图标
    分层设计：
    1. 背景层
    2. 主体层（番茄）
    3. 装饰层（叶子）
    4. 效果层（高光、阴影）
    """
    
    # 创建透明背景的图像
    img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    draw = ImageDraw.Draw(img)
    
    center = size // 2
    tomato_radius = int(size * 0.35)
    
    # === 第 1 层：背景（圆形浅色背景）===
    bg_radius = int(size * 0.45)
    draw.ellipse(
        [center - bg_radius, center - bg_radius, center + bg_radius, center + bg_radius],
        fill=BACKGROUND_WHITE
    )
    
    # === 第 2 层：番茄主体（红色圆形）===
    # 主番茄形状
    draw.ellipse(
        [center - tomato_radius, center - tomato_radius + 20, 
         center + tomato_radius, center + tomato_radius + 40],
        fill=TOMATO_RED
    )
    
    # === 第 3 层：番茄顶部凹陷 ===
    # 创建番茄顶部的自然凹陷效果
    top_indent_y = center - tomato_radius + 20
    draw.ellipse(
        [center - int(tomato_radius * 0.6), top_indent_y - 15,
         center + int(tomato_radius * 0.6), top_indent_y + 15],
        fill=TOMATO_RED
    )
    
    # === 第 4 层：绿叶（多片叶子）===
    leaf_positions = [
        (center - 30, center - tomato_radius, -30),  # 左叶
        (center + 30, center - tomato_radius, 30),   # 右叶
        (center, center - tomato_radius - 20, 0),    # 顶叶
    ]
    
    for leaf_x, leaf_y, rotation in leaf_positions:
        create_leaf(draw, leaf_x, leaf_y, rotation)
    
    # === 第 5 层：效果层（高光）===
    # 左上角高光
    highlight_x = center - int(tomato_radius * 0.4)
    highlight_y = center - int(tomato_radius * 0.2)
    highlight_radius = int(tomato_radius * 0.25)
    
    highlight = Image.new('RGBA', (highlight_radius * 2, highlight_radius * 2), (0, 0, 0, 0))
    highlight_draw = ImageDraw.Draw(highlight)
    highlight_draw.ellipse(
        [0, 0, highlight_radius * 2, highlight_radius * 2],
        fill=(255, 255, 255, 100)
    )
    highlight = highlight.filter(ImageFilter.GaussianBlur(3))
    img.paste(highlight, (highlight_x - highlight_radius, highlight_y - highlight_radius), highlight)
    
    # === 第 6 层：效果层（阴影）===
    # 底部阴影增加立体感
    shadow_y = center + tomato_radius + 35
    shadow = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(shadow)
    shadow_draw.ellipse(
        [center - int(tomato_radius * 0.8), shadow_y - 10,
         center + int(tomato_radius * 0.8), shadow_y + 10],
        fill=(0, 0, 0, 50)
    )
    shadow = shadow.filter(ImageFilter.GaussianBlur(5))
    img.paste(shadow, (0, 0), shadow)
    
    # 保存图标
    img.save(output_path, 'PNG')
    print(f"✓ 图标已保存：{output_path}")
    return img

def create_leaf(draw, x, y, rotation, size=60):
    """
    创建一片叶子
    """
    leaf_img = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    leaf_draw = ImageDraw.Draw(leaf_img)
    
    # 绘制叶子形状（椭圆形）
    leaf_points = [
        (size // 2, 0),  # 叶尖
        (size // 4, size // 3),
        (0, size // 2),  # 叶底左
        (size // 4, size * 2 // 3),
        (size // 2, size),  # 叶柄
        (size * 3 // 4, size * 2 // 3),
        (size, size // 2),  # 叶底右
        (size * 3 // 4, size // 3),
    ]
    
    leaf_draw.polygon(leaf_points, fill=LEAF_GREEN)
    
    # 旋转叶子
    leaf_img = leaf_img.rotate(rotation, expand=True, resample=Image.BICUBIC)
    
    # 计算粘贴位置
    paste_x = x - leaf_img.width // 2
    paste_y = y - leaf_img.height // 2
    
    # 粘贴叶子
    draw.bitmap((paste_x, paste_y), leaf_img.convert('1'), fill=LEAF_GREEN)

def create_square_version(input_path='app-icon-512.png', output_path='app-icon-512-square.png'):
    """
    创建正方形版本（带圆角边框）
    """
    # 打开原始图标
    img = Image.open(input_path)
    img = img.convert('RGBA')
    
    # 创建正方形背景
    square = Image.new('RGBA', (512, 512), (255, 255, 255, 255))
    
    # 创建圆角蒙版
    mask = Image.new('L', (512, 512), 0)
    mask_draw = ImageDraw.Draw(mask)
    corner_radius = 80
    mask_draw.rounded_rectangle(
        [0, 0, 512, 512],
        radius=corner_radius,
        fill=255
    )
    
    # 将图标粘贴到正方形背景上
    square.paste(img, (0, 0), mask)
    
    # 保存
    square.save(output_path, 'PNG')
    print(f"✓ 正方形版本已保存：{output_path}")

if __name__ == '__main__':
    print("🍅 开始生成小白番茄专注钟图标...")
    
    # 生成主图标
    create_tomato_icon(512, 'app-icon-512.png')
    
    # 生成正方形版本
    create_square_version('app-icon-512.png', 'app-icon-512-square.png')
    
    print("\n✅ 图标生成完成！")
    print("📁 文件位置:")
    print("   - app-icon-512.png (主图标)")
    print("   - app-icon-512-square.png (正方形版本)")
