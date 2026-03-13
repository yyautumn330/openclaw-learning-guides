#!/usr/bin/env python3
"""使用 macOS Quartz 框架截图"""

import Quartz
import CoreGraphics
import sys

# 获取主显示器
main_display = CGMainDisplayID()

# 获取屏幕尺寸
width = int(CGDisplayPixelsWide(main_display))
height = int(CGDisplayPixelsHigh(main_display))

print(f"📺 屏幕尺寸：{width}x{height}")

# 创建屏幕截图
screenshot = CGDisplayCreateImage(main_display)

if screenshot:
    # 保存为 PNG
    output_path = "/Users/autumn/.openclaw/workspace/desktop_screenshot.png"
    
    # 创建 CGImageDestination
    destination = CGImageDestinationCreateWithURL(
        output_path,
        'public.png',
        1,
        None
    )
    
    if destination:
        CGImageDestinationAddImage(destination, screenshot, None)
        if CGImageDestinationFinalize(destination):
            print(f"✅ 截图成功：{output_path}")
            sys.exit(0)
    
    print("❌ 保存失败")
    sys.exit(1)
else:
    print("❌ 无法创建截图")
    sys.exit(1)
