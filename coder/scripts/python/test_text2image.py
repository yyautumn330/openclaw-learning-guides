#!/usr/bin/env python3
"""测试文生图模型"""

import os
# 设置使用本地缓存，不联网下载
os.environ["HF_HUB_OFFLINE"] = "1"

from diffusers import StableDiffusionPipeline
import torch

# 使用本地缓存的模型
model_id = "/Users/autumn/Library/Caches/huggingface/hub/models--runwayml--stable-diffusion-v1-5/snapshots"

# 找到最新的 snapshot
import glob
snapshots = glob.glob(f"{model_id}/*")
if snapshots:
    model_path = sorted(snapshots)[-1]
    print(f"📦 使用本地模型：{model_path}")
else:
    print("❌ 未找到本地模型缓存")
    exit(1)

print("⏳ 加载模型中...")
pipe = StableDiffusionPipeline.from_pretrained(
    model_path,
    torch_dtype=torch.float32,
    safety_checker=None,
    local_files_only=True
)

# 如果有 MPS 就用 MPS (Mac)，否则用 CPU
if torch.backends.mps.is_available():
    pipe = pipe.to("mps")
    print("🚀 使用 MPS (Apple Silicon) 加速")
elif torch.cuda.is_available():
    pipe = pipe.to("cuda")
    print("🚀 使用 CUDA 加速")
else:
    pipe = pipe.to("cpu")
    print("⚠️ 使用 CPU (较慢)")

prompt = "a beautiful sunset over mountains, digital art, vibrant colors"
print(f"🎨 生成图片：{prompt}")

image = pipe(prompt, num_inference_steps=20, height=512, width=512).images[0]

output_path = "/Users/autumn/.openclaw/workspace/generated_image.png"
image.save(output_path)
print(f"✅ 图片已保存：{output_path}")
