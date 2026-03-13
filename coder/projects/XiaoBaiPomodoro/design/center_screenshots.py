#!/usr/bin/env python3
"""
小白番茄专注钟 - 截图居中调整优化版
分析截图内容并真正居中显示
"""

from PIL import Image
import os

def analyze_and_center(screenshot_path, output_path):
    """分析截图并居中内容"""
    img = Image.open(screenshot_path)
    width, height = img.size
    print(f'  原始尺寸：{width}x{height}')
    
    # 创建新画布（白色背景）
    new_img = Image.new('RGBA', (1080, 1920), (255, 255, 255, 255))
    
    # 如果原图已经是 1080x1920，直接分析内容区域
    if width == 1080 and height == 1920:
        # 转换为灰度图分析内容边界
        gray = img.convert('L')
        pixels = list(gray.getdata())
        
        # 找到非白色区域的边界
        min_x, max_x = width, 0
        min_y, max_y = height, 0
        
        for y in range(height):
            for x in range(width):
                pixel = pixels[y * width + x]
                if pixel < 250:  # 非白色
                    min_x = min(min_x, x)
                    max_x = max(max_x, x)
                    min_y = min(min_y, y)
                    max_y = max(max_y, y)
        
        content_width = max_x - min_x
        content_height = max_y - min_y
        
        print(f'  内容区域：x={min_x}-{max_x}, y={min_y}-{max_y}')
        print(f'  内容尺寸：{content_width}x{content_height}')
        
        # 计算居中偏移量
        if content_width < width:
            offset_x = (width - content_width) // 2 - min_x
            print(f'  水平偏移：{offset_x}px')
            
            # 裁剪内容区域
            content = img.crop((min_x, min_y, max_x + 1, max_y + 1))
            
            # 粘贴到居中位置
            new_img.paste(content, (offset_x, min_y))
        else:
            # 内容已经占满宽度，直接复制
            new_img.paste(img, (0, 0))
    else:
        # 调整尺寸并居中
        img = img.resize((1080, 1920), Image.Resampling.LANCZOS)
        new_img.paste(img, (0, 0))
    
    # 保存
    new_img.save(output_path, 'PNG')
    print(f'  ✓ 已保存：{output_path}')

def main():
    print('📱 开始调整截图布局...\n')
    
    screenshots = [
        'screen-1-main.png',
        'screen-2-stats.png',
        'screen-3-achievements.png',
        'screen-4-settings.png',
        'screen-5-widgets.png',
    ]
    
    for src in screenshots:
        if os.path.exists(src):
            base_name = src.replace('.png', '-fixed.png')
            print(f'处理：{src}')
            analyze_and_center(src, base_name)
            print()
        else:
            print(f'⚠️ 文件不存在：{src}')
    
    print('✅ 截图布局调整完成！')

if __name__ == '__main__':
    main()
