#!/usr/bin/env python3
"""使用本地 Stable Diffusion 生成剑士图片"""

import sys
import os

# 设置国内镜像
os.environ['HF_ENDPOINT'] = 'https://hf-mirror.com'

def generate():
    try:
        import torch
        from diffusers import StableDiffusionPipeline
        
        prompt = """A majestic swordsman hovering in mid-air, holding a sword with one hand pointing to the sky, 
surrounded by thousands of flying swords forming a magnificent sword formation. 
Cinematic realistic style, epic fantasy, wearing ornate silver armor, flowing cape, 
determined eyes, heroic pose. Thousands of long swords dancing in spiral formation, 
gleaming blades, tyndall effect, divine light streaming through clouds. 
Cool tones, silver white, deep blue, golden accents. Low angle shot, 8K ultra HD, 
extreme detail, ray tracing, cinematic lighting, photorealistic, movie quality."""
        
        negative_prompt = "ugly, deformed, noisy, blurry, low quality, distorted, watermark, text"
        
        print(f"🎨 提示词：{prompt[:100]}...")
        print(f"📥 加载模型中...")
        
        # 使用 MPS 加速
        device = "mps" if torch.backends.mps.is_available() else "cpu"
        print(f"💻 设备：{device}")
        
        # 加载模型
        pipe = StableDiffusionPipeline.from_pretrained(
            "runwayml/stable-diffusion-v1-5",
            torch_dtype=torch.float32,
            use_safetensors=True
        )
        pipe = pipe.to(device)
        
        print(f"🚀 开始生成...")
        
        # 生成图片
        image = pipe(
            prompt=prompt,
            negative_prompt=negative_prompt,
            num_inference_steps=30,
            guidance_scale=7.5,
            width=1024,
            height=1024
        ).images[0]
        
        # 保存图片
        output_path = "/Users/autumn/.openclaw/workspace/swordsman_cinematic.png"
        image.save(output_path)
        
        print(f"✅ 生成成功！")
        print(f"💾 已保存：{output_path}")
        print(f"📏 文件大小：{os.path.getsize(output_path)} bytes")
        
        return True
        
    except Exception as e:
        print(f"❌ 错误：{e}")
        import traceback
        traceback.print_exc()
        return False

if __name__ == "__main__":
    success = generate()
    sys.exit(0 if success else 1)
