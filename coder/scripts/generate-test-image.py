#!/usr/bin/env python3
"""
ComfyUI 快速测试生成脚本
"""

import requests
import json
import time

COMFYUI_URL = "http://127.0.0.1:8188"

def generate_image(prompt, negative_prompt="worst quality, low quality, blurry, ugly", 
                   width=1024, height=1024, steps=20, seed=None):
    """生成单张图片"""
    
    # 构建工作流
    workflow = {
        "3": {
            "class_type": "CLIPTextEncode",
            "inputs": {
                "clip": ["7", 1],
                "text": prompt
            }
        },
        "4": {
            "class_type": "CLIPTextEncode",
            "inputs": {
                "clip": ["7", 1],
                "text": negative_prompt
            }
        },
        "5": {
            "class_type": "EmptyLatentImage",
            "inputs": {
                "batch_size": 1,
                "height": height,
                "width": width
            }
        },
        "6": {
            "class_type": "KSampler",
            "inputs": {
                "cfg": 8,
                "denoise": 1,
                "latent_image": ["5", 0],
                "model": ["7", 0],
                "negative": ["4", 0],
                "positive": ["3", 0],
                "sampler_name": "euler",
                "scheduler": "normal",
                "seed": seed if seed else int(time.time() * 1000) % (2**32),
                "steps": steps
            }
        },
        "7": {
            "class_type": "CheckpointLoaderSimple",
            "inputs": {
                "ckpt_name": "sd_xl_base_1.0.safetensors"
            }
        },
        "8": {
            "class_type": "VAEDecode",
            "inputs": {
                "samples": ["6", 0],
                "vae": ["7", 2]
            }
        },
        "9": {
            "class_type": "SaveImage",
            "inputs": {
                "filename_prefix": "ComfyUI/output/test",
                "images": ["8", 0]
            }
        }
    }
    
    # 提交任务
    payload = {
        "prompt": workflow,
        "client_id": "openclaw-test"
    }
    
    print("📤 提交任务到 ComfyUI...")
    resp = requests.post(f"{COMFYUI_URL}/prompt", json=payload)
    result = resp.json()
    prompt_id = result.get("prompt_id")
    
    if not prompt_id:
        print(f"❌ 提交失败：{result}")
        return None
    
    print(f"✅ 任务已提交：{prompt_id}")
    print("⏳ 正在生成，请稍候...")
    
    # 等待完成
    while True:
        try:
            history_resp = requests.get(f"{COMFYUI_URL}/history/{prompt_id}")
            history = history_resp.json()
            
            if prompt_id in history:
                output = history[prompt_id].get("outputs", {})
                for node_output in output.values():
                    if "images" in node_output:
                        for img in node_output["images"]:
                            filename = img.get("filename")
                            print(f"\n✅ 生成完成！")
                            print(f"📁 文件：{filename}")
                            print(f"📂 路径：/Users/autumn/.openclaw/workspace/coder/ComfyUI/output/{filename}")
                            return filename
            time.sleep(1)
        except Exception as e:
            print(f"等待中... {e}")
            time.sleep(1)


if __name__ == "__main__":
    # 测试提示词
    prompt = "a beautiful sunset over mountains, golden hour, dramatic lighting, masterpiece, best quality, highly detailed, 8k"
    
    print("🎨 ComfyUI 测试生成")
    print("=" * 50)
    print(f"提示词：{prompt}")
    print("=" * 50)
    
    result = generate_image(prompt)
    
    if result:
        print("\n🎉 成功！")
    else:
        print("\n❌ 失败")
