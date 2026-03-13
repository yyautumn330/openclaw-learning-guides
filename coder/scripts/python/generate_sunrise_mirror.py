#!/usr/bin/env python3
"""Generate sunrise lake image using Stable Diffusion with mirror"""

import os
import torch
from diffusers import StableDiffusionPipeline
from datetime import datetime

# Set mirror endpoint
os.environ['HF_ENDPOINT'] = 'https://hf-mirror.com'

# Prompt
prompt = "Sunrise over a peaceful lake, flock of birds flying in the sky, golden hour light, reflection on water, serene landscape, photorealistic, detailed, cinematic, warm colors, orange and pink sky"
negative_prompt = "ugly, blurry, low quality, distorted, deformed, dark, night"

# Output path
output_dir = "/Users/autumn/.openclaw/workspace/generated_images"
os.makedirs(output_dir, exist_ok=True)
timestamp = datetime.now().strftime("%Y%m%d_%H%M%S")
output_path = os.path.join(output_dir, f"sunrise_lake_{timestamp}.png")

print(f"🌐 Using mirror: {os.environ['HF_ENDPOINT']}")
print(f"🎨 Loading model from mirror...")
print(f"📝 Prompt: {prompt}")

try:
    # Load model using mirror
    pipe = StableDiffusionPipeline.from_pretrained(
        "runwayml/stable-diffusion-v1-5",
        torch_dtype=torch.float32,
        use_safetensors=True,
    )
    
    # Use MPS for Apple Silicon
    device = "mps" if torch.backends.mps.is_available() else "cpu"
    print(f"💻 Using device: {device}")
    pipe = pipe.to(device)
    
    # Generate image
    print(f"🖼️  Generating image (this may take 2-5 minutes)...")
    image = pipe(
        prompt=prompt,
        negative_prompt=negative_prompt,
        num_inference_steps=30,
        guidance_scale=7.5,
        width=512,
        height=512
    ).images[0]
    
    # Save image
    image.save(output_path)
    print(f"✅ Image saved to: {output_path}")
    
    # Also save as latest
    latest_path = "/Users/autumn/.openclaw/workspace/sunrise_lake_latest.png"
    image.save(latest_path)
    print(f"📂 Also saved to: {latest_path}")
    
    # Open the image
    os.system(f"open '{output_path}'")
    print("🖼️  Image opened!")
    
except Exception as e:
    print(f"❌ Error: {e}")
    raise
