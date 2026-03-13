#!/usr/bin/env python3
"""使用 mss 截图"""

try:
    import mss
    import mss.tools
    
    with mss.mss() as sct:
        # 捕获主显示器
        monitor = sct.monitors[1]  # 主显示器
        screenshot = sct.grab(monitor)
        
        output_path = "/Users/autumn/.openclaw/workspace/desktop_screenshot.png"
        mss.tools.to_png(screenshot.rgb, screenshot.size, output=output_path)
        
        print(f"✅ 截图成功：{output_path}")
        print(f"📏 尺寸：{screenshot.size}")
except Exception as e:
    print(f"❌ 错误：{e}")
