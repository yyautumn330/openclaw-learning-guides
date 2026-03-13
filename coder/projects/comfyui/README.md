# ComfyUI 本地部署指南 - M4 Max 优化版

## 📋 系统要求

- **芯片**: Apple Silicon (M1/M2/M3/M4)
- **内存**: 建议 32GB+ (你的是 128GB ✅)
- **系统**: macOS 13.0+
- **Python**: 3.10 - 3.13

## 🚀 快速部署

### 1. 运行部署脚本

```bash
cd /Users/autumn/.openclaw/workspace/coder
chmod +x scripts/deploy-comfyui.sh
./scripts/deploy-comfyui.sh
```

### 2. 下载模型

```bash
# 创建模型目录
mkdir -p ComfyUI/models/checkpoints

# 推荐模型 (任选其一或全部):
# - SDXL Base 1.0 (通用，高质量)
# - FLUX.1-dev (最新，文字渲染强)
# - Stable Diffusion 1.5 (快速，生态丰富)

# 使用 huggingface-cli 下载 (需安装: pip install huggingface_hub)
huggingface-cli download stabilityai/stable-diffusion-xl-base-1.0 \
    sd_xl_base_1.0.safetensors \
    --local-dir ComfyUI/models/checkpoints
```

### 3. 启动 ComfyUI

```bash
cd ComfyUI
./start-comfyui.sh
```

访问：http://127.0.0.1:8188

## 📦 批量生成

### 方式一：Python API 客户端

```bash
# 检查状态
python scripts/comfyui-api.py --check

# 单图生成
python scripts/comfyui-api.py --prompt "a beautiful sunset over mountains"

# 批量生成 (准备 prompts.txt，每行一个提示词)
python scripts/comfyui-api.py --batch prompts.txt
```

### 方式二：直接 API 调用

```bash
# 提交工作流
curl -X POST "http://127.0.0.1:8188/prompt" \
    -H "Content-Type: application/json" \
    -d @config/comfyui-batch-workflow.json
```

## ⚡ M4 Max 优化参数

启动时已包含以下优化：

```bash
--device mps              # Apple Silicon MPS 加速
--fast                    # 快速模式
--optimise-attention      # 注意力优化
```

**预期性能** (M4 Max 128G):
- SDXL 1024x1024: ~3-5 秒/图
- 批量生成：支持并发队列
- 内存占用：约 8-16GB (你有 128GB，非常充裕)

## 🔗 与 OpenClaw 集成

### 在 OpenClaw 中调用

```python
# 在 OpenClaw 技能或脚本中
import subprocess

def generate_image(prompt):
    result = subprocess.run([
        "python", "scripts/comfyui-api.py",
        "--prompt", prompt
    ], capture_output=True, text=True)
    return result.stdout
```

### 工作流模板

已提供基础模板：`config/comfyui-batch-workflow.json`

可在 Web 界面导入后自定义，然后导出为 JSON。

## 📁 目录结构

```
coder/
├── ComfyUI/                    # ComfyUI 主程序
│   ├── models/                 # 模型文件
│   │   ├── checkpoints/        # 主模型
│   │   ├── loras/              # LoRA 模型
│   │   └── controlnet/         # ControlNet 模型
│   ├── output/                 # 输出目录
│   ├── start-comfyui.sh        # 启动脚本
│   └── batch-generate.sh       # 批量脚本
├── scripts/
│   ├── deploy-comfyui.sh       # 部署脚本
│   └── comfyui-api.py          # API 客户端
└── config/
    └── comfyui-batch-workflow.json  # 工作流模板
```

## 🎯 推荐工作流

### 快速出图场景
1. 使用预设工作流
2. 调整提示词和参数
3. 批量提交队列
4. 后台生成，完成后通知

### 复杂工作流场景
1. Web 界面可视化编排
2. 添加 ControlNet/LoRA/IPAdapter
3. 测试单图效果
4. 保存为模板
5. 批量执行

## 🔧 故障排查

### ComfyUI 启动失败
```bash
# 检查 Python 版本
python3 --version

# 重新安装依赖
cd ComfyUI
source venv/bin/activate
pip install -r requirements.txt --force-reinstall
```

### MPS 加速未生效
```bash
# 确认使用 MPS 设备
python main.py --device mps
```

### 内存不足
```bash
# 降低并发数
# 或减小分辨率
# 或使用 --lowvram 参数
```

## 📚 资源

- **官方文档**: https://comfyanonymous.github.io/ComfyUI_documentation/
- **工作流分享**: https://openart.ai/workflows
- **模型下载**: https://civitai.com/
- **中文教程**: https://github.com/ComfyUI-Org/ComfyUI-Docs

---

*最后更新：2026-03-06 | M4 Max 128G 优化版*
