#!/usr/bin/env python3
"""
AI 绘画脚本 - 绕过安全过滤器版本
使用 Stable Diffusion 生成本地图片
"""

import torch
import sys
import os
from PIL import Image
import numpy as np

def check_environment():
    """检查环境"""
    print("🔍 检查环境...")
    print(f"  PyTorch: {torch.__version__}")
    print(f"  MPS 可用：{torch.backends.mps.is_available()}")
    print(f"  CUDA 可用：{torch.cuda.is_available()}")
    
    device = "mps" if torch.backends.mps.is_available() else "cpu"
    print(f"  使用设备：{device}")
    return device

def load_model(device):
    """加载模型（绕过安全过滤）"""
    from diffusers import StableDiffusionPipeline
    
    cache_path = os.path.expanduser(
        "~/.cache/huggingface/models--runwayml--stable-diffusion-v1-5/"
        "snapshots/451f4fe16113bff5a5d2269ed5ad43b0592e9a14"
    )
    
    print(f"📂 模型路径：{cache_path}")
    print("🔧 加载模型（禁用安全过滤）...")
    
    # 关键：使用 safety_checker=None 并设置 requires_safety_checker=False
    pipe = StableDiffusionPipeline.from_pretrained(
        cache_path,
        torch_dtype=torch.float16,
        local_files_only=True,
        safety_checker=None,
        requires_safety_checker=False,
    )
    
    # 确保 safety_checker 被完全移除
    pipe.safety_checker = None
    pipe.requires_safety_checker = False
    
    pipe = pipe.to(device)
    
    if device == "mps":
        pipe.enable_attention_slicing()
    
    print("✅ 模型加载完成")
    return pipe

def generate(pipe, prompt, device, seed=42, steps=25, guidance=7.0):
    """生成图片"""
    print(f"🎨 提示词：{prompt}")
    print(f"⏳ 开始生成（{steps} 步）...")
    
    generator = torch.Generator(device=device).manual_seed(seed)
    
    # 生成
    result = pipe(
        prompt=prompt,
        num_inference_steps=steps,
        guidance_scale=guidance,
        generator=generator,
        width=512,
        height=512,
    )
    
    image = result.images[0]
    
    # 检查图片质量
    img_array = np.array(image)
    brightness = img_array.mean()
    
    print(f"📊 图片亮度：{brightness:.1f}")
    
    if brightness < 20:
        print("⚠️  图片过暗，可能是安全过滤器拦截")
        print("💡 尝试使用更简单的提示词或在线服务")
    
    return image, brightness

def main():
    """主函数"""
    print("=" * 50)
    print("🎨 AI 绘画工具 - 本地 Stable Diffusion")
    print("=" * 50)
    
    device = check_environment()
    
    # 默认提示词 - 使用更中性的描述
    default_prompt = (
        "person walking on desert road, back view, "
        "barren landscape, cloudy sky, sunset, "
        "photography style, realistic"
    )
    
    prompt = sys.argv[1] if len(sys.argv) > 1 else default_prompt
    
    try:
        pipe = load_model(device)
        image, brightness = generate(pipe, prompt, device)
        
        # 保存
        output_path = "desert_walker.png"
        image.save(output_path)
        print(f"✅ 图片已保存：{os.path.abspath(output_path)}")
        
        # 打开
        os.system(f'open "{output_path}"')
        print("🖼️  已打开图片")
        
    except Exception as e:
        print(f"❌ 错误：{e}")
        print("\n💡 建议：")
        print("   1. 尝试在线服务：open https://liblib.art")
        print("   2. 检查模型缓存是否存在")
        print("   3. 使用更简单的提示词")

if __name__ == "__main__":
    main()
