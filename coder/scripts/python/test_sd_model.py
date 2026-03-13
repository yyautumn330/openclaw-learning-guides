#!/usr/bin/env python3
"""
Stable Diffusion v1.5 模型诊断脚本
测试模型是否能正常文生图
"""

import torch
import os
import sys
import numpy as np
from PIL import Image

def check_environment():
    """检查环境"""
    print("=" * 60)
    print("🔍 Stable Diffusion v1.5 模型诊断")
    print("=" * 60)
    
    print("\n1️⃣  环境检查:")
    print(f"   PyTorch 版本：{torch.__version__}")
    print(f"   MPS 可用：{torch.backends.mps.is_available()}")
    print(f"   CUDA 可用：{torch.cuda.is_available()}")
    
    device = "mps" if torch.backends.mps.is_available() else "cpu"
    print(f"   使用设备：{device}")
    return device

def check_model_cache():
    """检查模型缓存"""
    print("\n2️⃣  模型缓存检查:")
    cache_path = os.path.expanduser(
        "~/.cache/huggingface/models--runwayml--stable-diffusion-v1-5/"
        "snapshots/451f4fe16113bff5a5d2269ed5ad43b0592e9a14"
    )
    
    if os.path.exists(cache_path):
        print(f"   ✅ 模型路径存在：{cache_path}")
        
        # 检查关键文件
        files_to_check = [
            "text_encoder", "unet", "vae", "scheduler",
            "tokenizer", "model_index.json"
        ]
        
        for f in files_to_check:
            path = os.path.join(cache_path, f)
            exists = os.path.exists(path)
            status = "✅" if exists else "❌"
            print(f"   {status} {f}")
        
        # 计算总大小
        total_size = 0
        for root, dirs, files in os.walk(cache_path):
            for f in files:
                fp = os.path.join(root, f)
                if os.path.exists(fp) and not os.path.islink(fp):
                    total_size += os.path.getsize(fp)
        
        print(f"   📦 模型大小：{total_size / 1024 / 1024 / 1024:.2f} GB")
        return cache_path
    else:
        print(f"   ❌ 模型路径不存在：{cache_path}")
        return None

def test_generation(cache_path, device):
    """测试文生图"""
    print("\n3️⃣  文生图测试:")
    
    from diffusers import StableDiffusionPipeline
    
    print("   📥 加载模型...")
    try:
        pipe = StableDiffusionPipeline.from_pretrained(
            cache_path,
            torch_dtype=torch.float16,
            local_files_only=True,
            safety_checker=None,
            requires_safety_checker=False,
        )
        pipe.safety_checker = None
        pipe = pipe.to(device)
        
        if device == "mps":
            pipe.enable_attention_slicing()
        
        print("   ✅ 模型加载成功")
    except Exception as e:
        print(f"   ❌ 模型加载失败：{e}")
        return False
    
    # 测试提示词 - 使用非常简单的内容
    test_prompts = [
        ("简单测试", "a red apple on a white table"),
        ("风景测试", "a blue sky with white clouds"),
        ("用户请求", "person walking on desert road, back view, sunset"),
    ]
    
    results = []
    
    for name, prompt in test_prompts:
        print(f"\n   测试：{name}")
        print(f"   提示词：{prompt}")
        
        try:
            generator = torch.Generator(device=device).manual_seed(42)
            result = pipe(
                prompt=prompt,
                num_inference_steps=20,
                guidance_scale=7.0,
                generator=generator,
                width=512,
                height=512,
            )
            
            image = result.images[0]
            img_array = np.array(image)
            brightness = img_array.mean()
            
            # 保存图片
            output_path = f"test_{name.replace(' ', '_')}.png"
            image.save(output_path)
            
            status = "✅" if brightness > 50 else "⚠️"
            print(f"   {status} 亮度：{brightness:.1f} (正常应>50)")
            print(f"   📁 已保存：{output_path}")
            
            results.append((name, brightness > 50, brightness))
            
        except Exception as e:
            print(f"   ❌ 生成失败：{e}")
            results.append((name, False, 0))
    
    return results

def main():
    """主函数"""
    device = check_environment()
    cache_path = check_model_cache()
    
    if not cache_path:
        print("\n❌ 模型未找到，请先下载模型")
        print("   运行：huggingface-cli download runwayml/stable-diffusion-v1-5")
        sys.exit(1)
    
    results = test_generation(cache_path, device)
    
    # 总结
    print("\n" + "=" * 60)
    print("📊 诊断结果总结")
    print("=" * 60)
    
    passed = sum(1 for _, ok, _ in results if ok)
    total = len(results)
    
    for name, ok, brightness in results:
        status = "✅ 通过" if ok else f"❌ 失败 (亮度:{brightness:.1f})"
        print(f"   {name}: {status}")
    
    print(f"\n总计：{passed}/{total} 测试通过")
    
    if passed == total:
        print("\n🎉 模型工作正常！")
    elif passed > 0:
        print("\n⚠️  模型部分工作，但安全过滤器可能拦截了某些提示词")
    else:
        print("\n❌ 模型无法生成有效图片")
        print("\n💡 建议:")
        print("   1. 安全过滤器过于严格，尝试使用在线服务")
        print("   2. 或下载无安全过滤的模型版本")
        print("   3. 或使用更简单、中性的提示词")
    
    print("\n" + "=" * 60)

if __name__ == "__main__":
    main()
