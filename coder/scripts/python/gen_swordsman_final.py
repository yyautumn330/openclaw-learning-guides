#!/usr/bin/env python3
"""使用本地 Stable Diffusion 生成剑士图片 - 修复版"""

import sys
import os

# 设置国内镜像
os.environ['HF_ENDPOINT'] = 'https://hf-mirror.com'

def generate():
    try:
        import torch
        from diffusers import StableDiffusionPipeline
        
        # 优化后的提示词
        prompt = """masterpiece, best quality, ultra-detailed, a majestic swordsman hovering in mid-air, 
holding a sword with one hand pointing to the sky, surrounded by thousands of flying swords, 
magnificent sword formation, cinematic realistic style, epic fantasy, ornate silver armor, 
flowing cape, determined eyes, heroic pose, spiral sword formation, gleaming blades, 
tyndall effect, divine light, clouds, cool tones, silver white, deep blue, golden accents, 
low angle shot, 8K, extreme detail, ray tracing, cinematic lighting, photorealistic, movie quality"""
        
        negative_prompt = """ugly, deformed, noisy, blurry, low quality, distorted, watermark, text, 
signature, bad anatomy, extra limbs, missing limbs, mutation, mutated hands, bad hands"""
        
        print(f"🎨 提示词：{prompt[:150]}...")
        print(f"📥 加载模型中（首次需要下载约 4GB）...")
        
        # 使用 MPS 加速
        device = "mps" if torch.backends.mps.is_available() else "cpu"
        print(f"💻 设备：{device}")
        
        # 加载模型 - 使用更稳定的版本
        pipe = StableDiffusionPipeline.from_pretrained(
            "runwayml/stable-diffusion-v1-5",
            torch_dtype=torch.float32,
            safety_checker=None,
            requires_safety_checker=False
        )
        pipe = pipe.to(device)
        pipe.enable_attention_slicing()
        
        print(f"🚀 开始生成（约需 2-5 分钟）...")
        
        # 生成图片
        image = pipe(
            prompt=prompt,
            negative_prompt=negative_prompt,
            num_inference_steps=30,
            guidance_scale=7.5,
            width=1024,
            height=1024,
            generator=torch.Generator(device=device).manual_seed(12345)
        ).images[0]
        
        # 保存图片
        output_path = "/Users/autumn/.openclaw/workspace/swordsman_cinematic.png"
        image.save(output_path, "PNG")
        
        print(f"\n✅ 生成成功！")
        print(f"💾 已保存：{output_path}")
        print(f"📏 文件大小：{os.path.getsize(output_path) / 1024 / 1024:.2f} MB")
        
        return output_path
        
    except Exception as e:
        print(f"\n❌ 错误：{e}")
        import traceback
        traceback.print_exc()
        return None

if __name__ == "__main__":
    output_path = generate()
    if output_path:
        print(f"\n📤 准备发送到飞书...")
        # 自动打开图片
        os.system(f"open {output_path}")
    sys.exit(0 if output_path else 1)
