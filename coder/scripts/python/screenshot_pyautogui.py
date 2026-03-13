#!/usr/bin/env python3
"""使用 pyautogui 截图"""

import pyautogui

output_path = "/Users/autumn/.openclaw/workspace/desktop_screenshot.png"

try:
    screenshot = pyautogui.screenshot()
    screenshot.save(output_path)
    print(f"✅ 截图成功：{output_path}")
    print(f"📏 尺寸：{screenshot.size}")
except Exception as e:
    print(f"❌ 错误：{e}")
