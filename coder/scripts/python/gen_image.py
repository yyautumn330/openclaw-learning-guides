#!/usr/bin/env python3
"""使用阿里云万相 API 生成图片"""

import requests
import json
import time

API_KEY = "sk-sp-b84c4b4844224c46961078d6a658c0e3"
PROMPT = "a beautiful sunset over mountains, digital art, vibrant colors"

print(f"🎨 生成图片：{PROMPT}")

# 创建任务
headers = {
    "Authorization": f"Bearer {API_KEY}",
    "Content-Type": "application/json",
    "X-DashScope-Async": "enable"
}

payload = {
    "model": "wanx-v1",
    "input": {
        "prompt": PROMPT
    },
    "parameters": {
        "style": "<auto>",
        "size": "1024*1024",
        "n": 1
    }
}

try:
    # 提交任务
    resp = requests.post(
        "https://dashscope.aliyuncs.com/api/v1/services/aigc/text2image/image-synthesis",
        headers=headers,
        json=payload
    )
    
    result = resp.json()
    print(f"提交响应：{json.dumps(result, indent=2, ensure_ascii=False)}")
    
    if resp.status_code != 200:
        print(f"❌ 提交失败：{resp.status_code}")
        exit(1)
    
    task_id = result.get("output", {}).get("task_id")
    if not task_id:
        print("❌ 未获取到 task_id")
        exit(1)
    
    print(f"⏳ 任务 ID: {task_id}")
    
    # 轮询任务状态
    for i in range(30):
        time.sleep(2)
        
        status_resp = requests.get(
            f"https://dashscope.aliyuncs.com/api/v1/tasks/{task_id}",
            headers={"Authorization": f"Bearer {API_KEY}"}
        )
        
        status = status_resp.json()
        task_status = status.get("output", {}).get("task_status", "")
        
        print(f"📊 状态：{task_status}")
        
        if task_status == "SUCCEEDED":
            img_url = status["output"]["results"][0]["url"]
            print(f"✅ 生成成功！")
            print(f"📷 URL: {img_url}")
            
            # 下载图片
            img_data = requests.get(img_url).content
            output_path = "/Users/autumn/.openclaw/workspace/generated_image.png"
            with open(output_path, "wb") as f:
                f.write(img_data)
            print(f"💾 已保存：{output_path}")
            break
        elif task_status in ["FAILED", "CANCELED"]:
            print(f"❌ 任务失败：{status}")
            break
    else:
        print("⏰ 等待超时")
        
except Exception as e:
    print(f"❌ 错误：{e}")
