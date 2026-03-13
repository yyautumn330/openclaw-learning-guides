#!/usr/bin/env python3
"""Generate image using smaller SD-Turbo model"""

import os
import torch
from diffusers import AutoPipelineForText2Image

# Set mirror endpoint
os.environ['HF_ENDPOINT'] = 'https://hf-mirror.com'

# Prompt
prompt = "Sunrise over a peaceful lake, flock of birds flying, golden hour, reflection on water, cinematic, warm colors, photorealistic"

# Output path
output_dir = "/Users/autumn/.openclaw/workspace/generated_images"
os.makedirs(output_dir, exist_ok=True)
output_path = os.path.join(output_dir, "sunrise_lake.png")

print(f"🌐 Using mirror: {os.environ['HF_ENDPOINT']}")
print(f"🎨 Loading SD-Turbo (faster, smaller model)...")

try:
    # SD-Turbo is much faster (1 step inference)
    pipe = AutoPipelineForText2Image.from_pretrained(
        "stabilityai/sd-turbo",
        torch_dtype=torch.float16,
        variant="fp16",
    )
    
    device = "mps" if torch.backends.mps.is_available() else "cpu"
    print(f"💻 Using device: {device}")
    pipe = pipe.to(device)
    
    print(f"🖼️  Generating image...")
    image = pipe(
        prompt=prompt,
        num_inference_steps=2,
        guidance_scale=0.0
    ).images[0]
    
    image.save(output_path)
    print(f"✅ Image saved to: {output_path}")
    
    # Also save as latest
    latest_path = "/Users/autumn/.openclaw/workspace/sunrise_lake_latest.png"
    image.save(latest_path)
    
    # Open the image
    os.system(f"open '{output_path}'")
    print("🖼️  Done!")
    
except Exception as e:
    print(f"❌ Error: {e}")
    raise
