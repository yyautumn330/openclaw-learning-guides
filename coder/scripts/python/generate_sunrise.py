#!/usr/bin/env python3
"""Generate sunrise lake image using Stable Diffusion locally"""

import torch
from diffusers import StableDiffusionPipeline
import os
from datetime import datetime

# Prompt based on user request
prompt = "Sunrise over a peaceful lake, flock of birds flying in the sky, golden hour light, reflection on water, serene landscape, photorealistic, detailed, cinematic, warm colors, orange and pink sky"
negative_prompt = "ugly, blurry, low quality, distorted, deformed, extra limbs, bad anatomy, dark, night"

# Output path with timestamp
output_dir = "/Users/autumn/.openclaw/workspace/generated_images"
os.makedirs(output_dir, exist_ok=True)
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
output_path = os.path.join(output_dir, f"sunrise_lake_{timestamp}.png")

print(f"🎨 Loading model...")
print(f"📝 Prompt: {prompt}")

try:
    # Try to load model with cache
    pipe = StableDiffusionPipeline.from_pretrained(
        "runwayml/stable-diffusion-v1-5",
        torch_dtype=torch.float32,
        cache_dir="/Users/autumn/.cache/huggingface",
        local_files_only=False,
    )
    
    # Use MPS for Apple Silicon
    device = "mps" if torch.backends.mps.is_available() else "cpu"
    print(f"💻 Using device: {device}")
    pipe = pipe.to(device)
    
    # Generate image
    print(f"🖼️  Generating image (this may take a few minutes)...")
    image = pipe(
        prompt=prompt,
        negative_prompt=negative_prompt,
        num_inference_steps=25,
        guidance_scale=7.5,
        width=512,
        height=512
    ).images[0]
    
    # Save image
    image.save(output_path)
    print(f"✅ Image saved to: {output_path}")
    
    # Also copy to workspace root for easy access
    import shutil
    workspace_path = "/Users/autumn/.openclaw/workspace/sunrise_lake_latest.png"
    shutil.copy(output_path, workspace_path)
    print(f"📂 Also saved to: {workspace_path}")
    
except Exception as e:
    print(f"❌ Error: {e}")
    print("Model download failed. Please check network connection.")
    raise
