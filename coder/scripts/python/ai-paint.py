#!/usr/bin/env python3
"""
Stable Diffusion 文生图工具
使用 Diffusers 库 + Apple Silicon MPS 加速
修复版：使用 SD v1.5 模型（更稳定）
"""

import sys
import os

def check_dependencies():
    """检查依赖是否安装"""
    try:
        import torch
        from diffusers import StableDiffusionPipeline
        return True
    except ImportError as e:
        print(f"❌ 缺少依赖：{e}")
        print("请运行：pip3 install torch diffusers transformers accelerate")
        return False

def generate_image(prompt, output_path="output.png", steps=25, guidance=7.5):
    """生成图片
    
    使用 Stable Diffusion v1.5
    - 步数：推荐 20-30 步（默认 25 步）
    - 引导系数：推荐 7.0-8.5（默认 7.5）
    """
    
    from diffusers import StableDiffusionPipeline
    import torch
    
    print(f"🎨 正在生成：{prompt}")
    print(f"⚙️  参数：步数={steps}, 引导系数={guidance}")
    
    # 检查 MPS 可用性
    use_mps = torch.backends.mps.is_available()
    device = "mps" if use_mps else "cpu"
    dtype = torch.float32  # MPS 不支持 float16
    
    print(f"📥 加载模型中（首次运行需要下载，约 2-4GB）...")
    print(f"💻 使用设备：{device}")
    
    try:
        # 直接使用 StableDiffusionPipeline（避免 AutoPipeline 的导入问题）
        # 使用 ModelScope 镜像（国内访问更快）
        import os
        os.environ['HF_ENDPOINT'] = 'https://hf-mirror.com'  # 使用国内镜像
        
        pipe = StableDiffusionPipeline.from_pretrained(
            "runwayml/stable-diffusion-v1-5",
            torch_dtype=dtype,
            use_safetensors=True,
            cache_dir=os.path.expanduser("~/.cache/huggingface")
        )
        pipe.to(device)
        
        if use_mps:
            print("✅ 使用 MPS 加速 (Apple Silicon)")
        else:
            print("⚠️  使用 CPU（较慢）")
        
        # 生成图片
        print("🖼️  正在生成图片...")
        
        # SD-Turbo 的特殊参数
        generator = torch.Generator(device=device).manual_seed(42)
        
        result = pipe(
            prompt=prompt,
            num_inference_steps=steps,
            guidance_scale=guidance,
            generator=generator
        )
        
        image = result.images[0]
        
        # 保存图片
        image.save(output_path)
        print(f"✅ 图片已保存：{output_path}")
        print(f"📏 尺寸：{image.size[0]}x{image.size[1]}")
        
        return output_path
        
    except Exception as e:
        print(f"❌ 生成失败：{e}")
        print("\n💡 提示：")
        print("   - 首次运行需要下载模型（约 2-4GB，需要网络）")
        print("   - 确保磁盘空间充足")
        print("   - SD-Turbo 推荐使用 1 步生成")
        raise

if __name__ == "__main__":
    if not check_dependencies():
        sys.exit(1)
    
    if len(sys.argv) < 2:
        print("\n🎨 AI 绘画工具 - Stable Diffusion v1.5")
        print("=" * 50)
        print("用法：python3 ai-paint.py \"你的提示词\" [输出文件] [步数] [引导系数]")
        print("\n参数说明：")
        print("  提示词     - 描述你想要的画面（支持英文效果更好）")
        print("  输出文件   - 保存路径（默认：output.png）")
        print("  步数       - 推理步数，推荐 20-30 步（默认：25）")
        print("  引导系数   - 推荐 7.0-8.5（默认：7.5）")
        print("\n示例：")
        print('  python3 ai-paint.py "一只可爱的猫咪" cat.png')
        print('  python3 ai-paint.py "sunset beach, photorealistic" beach.png 25 7.5')
        sys.exit(1)
    
    prompt = sys.argv[1]
    output_path = sys.argv[2] if len(sys.argv) > 2 else "output.png"
    steps = int(sys.argv[3]) if len(sys.argv) > 3 else 25  # SD v1.5 默认 25 步
    guidance = float(sys.argv[4]) if len(sys.argv) > 4 else 7.5  # SD v1.5 推荐 7.5
    
    try:
        generate_image(prompt, output_path, steps, guidance)
    except Exception as e:
        sys.exit(1)
