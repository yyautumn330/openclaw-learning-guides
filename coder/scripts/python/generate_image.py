#!/usr/bin/env python3
"""Generate image using Stable Diffusion locally"""

import torch
from diffusers import StableDiffusionPipeline
import os

# Prompt based on user request
prompt = "A person walking alone on a desert highway, viewed from behind, desolate landscape, barren desert on both sides, lonely atmosphere, cinematic shot, muted colors, sense of isolation, photorealistic, detailed"
negative_prompt = "ugly, blurry, low quality, distorted, deformed, extra limbs, bad anatomy"

# Output path
output_dir = "/Users/autumn/.openclaw/workspace/generated_images"
os.makedirs(output_dir, exist_ok=True)
output_path = os.path.join(output_dir, "desert_highway.png")

print(f"🎨 Loading Stable Diffusion model...")
print(f"📝 Prompt: {prompt}")

# Load model - using smaller model for faster generation
pipe = StableDiffusionPipeline.from_pretrained(
    "CompVis/stable-diffusion-v1-4",
    torch_dtype=torch.float32,
    use_safetensors=True,
    low_cpu_mem_usage=True
)

# Move to GPU if available
device = "cuda" if torch.cuda.is_available() else "mps" if torch.backends.mps.is_available() else "cpu"
print(f"💻 Using device: {device}")
pipe = pipe.to(device)

# Generate image
print(f"🖼️  Generating image...")
image = pipe(
    prompt=prompt,
    negative_prompt=negative_prompt,
    num_inference_steps=30,
    guidance_scale=7.5,
    width=512,
    height=768
).images[0]

# Save image
image.save(output_path)
print(f"✅ Image saved to: {output_path}")
print(f"📂 Opening image...")

# Open the image
os.system(f"open '{output_path}'")
