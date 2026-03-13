#!/usr/bin/env python3
"""
ComfyUI API 客户端 - 批量生成工具
适用于 M4 Max 优化配置
"""

import requests
import json
import time
from pathlib import Path
from datetime import datetime

COMFYUI_URL = "http://127.0.0.1:8188"

class ComfyUIClient:
    def __init__(self, base_url=COMFYUI_URL):
        self.base_url = base_url
        self.client_id = f"openclaw-{int(time.time())}"
    
    def check_status(self):
        """检查 ComfyUI 是否运行"""
        try:
            resp = requests.get(f"{self.base_url}/system_stats", timeout=5)
            return resp.status_code == 200
        except:
            return False
    
    def queue_prompt(self, workflow):
        """提交工作流到队列"""
        payload = {
            "prompt": workflow,
            "client_id": self.client_id
        }
        resp = requests.post(f"{self.base_url}/prompt", json=payload)
        return resp.json()
    
    def get_history(self, prompt_id):
        """获取生成历史"""
        resp = requests.get(f"{self.base_url}/history/{prompt_id}")
        return resp.json()
    
    def batch_generate(self, prompts, workflow_template):
        """
        批量生成
        
        Args:
            prompts: 提示词列表
            workflow_template: 工作流模板路径
        
        Returns:
            生成的图片路径列表
        """
        with open(workflow_template) as f:
            workflow = json.load(f)
        
        results = []
        for i, prompt in enumerate(prompts):
            # 更新提示词
            workflow["3"]["inputs"]["text"] = prompt
            
            # 提交任务
            result = self.queue_prompt(workflow)
            prompt_id = result.get("prompt_id")
            
            print(f"✅ 任务 {i+1}/{len(prompts)} 已提交: {prompt_id}")
            results.append(prompt_id)
            
            # 等待完成
            time.sleep(0.5)
        
        return results
    
    def generate_single(self, prompt, negative_prompt="", 
                       width=1024, height=1024, steps=20, seed=None):
        """
        单图快速生成
        
        Args:
            prompt: 正向提示词
            negative_prompt: 负向提示词
            width/height: 分辨率
            steps: 采样步数
            seed: 随机种子 (None 为随机)
        
        Returns:
            图片路径
        """
        workflow = {
            "3": {
                "class_type": "CLIPTextEncode",
                "inputs": {
                    "clip": ["1", 1],
                    "text": prompt
                }
            },
            "4": {
                "class_type": "CLIPTextEncode",
                "inputs": {
                    "clip": ["1", 1],
                    "text": negative_prompt or "worst quality, low quality"
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
                    "model": ["1", 0],
                    "negative": ["4", 0],
                    "positive": ["3", 0],
                    "sampler_name": "euler",
                    "scheduler": "normal",
                    "seed": seed or int(time.time() * 1000) % (2**32),
                    "steps": steps
                }
            },
            "7": {
                "class_type": "CheckpointLoaderSimple",
                "inputs": {
                    "ckpt_name": "SDXL/sd_xl_base_1.0.safetensors"
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
                    "filename_prefix": "ComfyUI/output",
                    "images": ["8", 0]
                }
            }
        }
        
        result = self.queue_prompt(workflow)
        prompt_id = result.get("prompt_id")
        print(f"✅ 任务已提交：{prompt_id}")
        
        # 等待完成
        while True:
            history = self.get_history(prompt_id)
            if prompt_id in history:
                output = history[prompt_id].get("outputs", {})
                for node_output in output.values():
                    if "images" in node_output:
                        for img in node_output["images"]:
                            print(f"✅ 生成完成：{img.get('filename')}")
                            return img.get("filename")
            time.sleep(1)


def main():
    import argparse
    parser = argparse.ArgumentParser(description="ComfyUI 批量生成工具")
    parser.add_argument("--check", action="store_true", help="检查 ComfyUI 状态")
    parser.add_argument("--prompt", type=str, help="单个提示词")
    parser.add_argument("--batch", type=str, help="批量提示词文件 (每行一个)")
    parser.add_argument("--workflow", type=str, default="config/comfyui-batch-workflow.json",
                       help="工作流模板路径")
    
    args = parser.parse_args()
    
    client = ComfyUIClient()
    
    if args.check:
        status = client.check_status()
        print(f"ComfyUI 状态：{'✅ 运行中' if status else '❌ 未运行'}")
        return
    
    if args.prompt:
        client.generate_single(args.prompt)
    
    if args.batch:
        with open(args.batch) as f:
            prompts = [line.strip() for line in f if line.strip()]
        client.batch_generate(prompts, args.workflow)


if __name__ == "__main__":
    main()
