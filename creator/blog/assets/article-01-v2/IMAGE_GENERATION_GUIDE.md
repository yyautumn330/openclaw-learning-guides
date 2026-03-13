# 文章配图生成指南

## 任务说明

为文章《5 分钟搭建你的第一个 AI 助手》生成 6 张配图 (16:9 比例)

## 图片需求

| 序号 | 文件名 | 描述 | Prompt |
|------|--------|------|--------|
| 1 | `01-cover.png` | 封面图 | Modern AI assistant concept, friendly robot helper, clean minimalist design, blue and white color scheme, technology background, professional illustration style |
| 2 | `02-install-flow.png` | 安装流程图 | Terminal command line interface, code installation steps, clean dark theme, developer tools, programming aesthetic |
| 3 | `03-architecture-comparison.png` | 架构对比图 | Comparison diagram, traditional AI vs modern AI agent, split screen visualization, clean infographic style |
| 4 | `04-skills-system.png` | 技能系统图 | Plugin system concept, modular blocks connecting, puzzle pieces, technology ecosystem, isometric illustration |
| 5 | `05-memory-system.png` | 记忆系统图 | Digital memory concept, file folders with glowing data, knowledge base visualization, blue purple gradient |
| 6 | `06-multi-platform.png` | 多平台接入图 | Multiple messaging apps icons connected, WeChat Feishu Telegram, network hub concept, clean modern design |

## 使用方法

### 方式一：使用 inference.sh CLI (推荐)

1. **登录 inference.sh**
   ```bash
   infsh login
   ```
   或直接使用 API key:
   ```bash
   infsh login --key YOUR_API_KEY
   ```

2. **运行生成脚本**
   ```bash
   cd ~/.openclaw/workspace/creator/blog/assets/article-01-v2/
   bash generate-images.sh
   ```

3. **提取图片**
   每个命令会生成一个 JSON 文件，包含图片 URL。从 JSON 中提取 `image_url` 或 `url` 字段，下载图片并重命名。

### 方式二：使用 Web 界面

1. 访问 https://app.inference.sh/apps
2. 选择 `xai/grok-imagine-image` 或其他图像生成模型
3. 输入上述 prompt，设置 aspect_ratio 为 `16:9`
4. 生成后下载图片

### 方式三：使用其他 AI 图像生成工具

可以使用以下替代方案:
- **Gemini 3 Pro Image**: https://app.inference.sh/apps/google/gemini-3-pro-image-preview
- **FLUX Dev LoRA**: https://app.inference.sh/apps/falai/flux-dev-lora
- **Seedream 4.5**: https://app.inference.sh/apps/bytedance/seedream-4-5

## 推荐模型

对于这类概念图和插图，推荐使用:
- **Grok Imagine** - 适合概念艺术和插图
- **FLUX.2 Klein** - 快速且质量好
- **Gemini 3 Pro** - Google 的最新模型，质量优秀

## 输出目录

所有图片应保存到:
```
~/.openclaw/workspace/creator/blog/assets/article-01-v2/
```

文件名:
- `01-cover.png`
- `02-install-flow.png`
- `03-architecture-comparison.png`
- `04-skills-system.png`
- `05-memory-system.png`
- `06-multi-platform.png`

## 注意事项

1. 所有图片使用 16:9 宽高比
2. 保持风格一致性 (建议使用同一模型)
3. 图片分辨率建议 1920x1080 或更高
4. PNG 格式，便于后续编辑

---

*生成于 2026-03-07*
