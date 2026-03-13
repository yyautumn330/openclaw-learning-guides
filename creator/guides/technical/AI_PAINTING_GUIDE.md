# AI 绘画工具使用说明

## 问题诊断

本地 Stable Diffusion v1.5 模型的安全过滤器过于严格，即使禁用 `safety_checker` 仍然会生成黑图。

## 解决方案

### 方案 1：使用在线 AI 绘图（推荐 ⭐）

以下免费网站可以直接使用：

| 网站 | 网址 | 特点 |
|------|------|------|
| **LiblibAI** | https://liblib.art | 中文界面，免费额度充足 |
| **SeaArt** | https://seaart.ai | 免费，支持中文提示词 |
| **Bing Image Creator** | https://bing.com/images/create | 微软免费服务 |
| **Playground AI** | https://playgroundai.com | 每日免费 500 张 |

**提示词示例：**
```
a lonely traveler walking on empty desert road, back view, 
vast barren landscape, dramatic cloudy sky, warm sunset lighting, 
cinematic photography, photorealistic, 8k
```

### 方案 2：使用不同的本地模型

SD v1.5 的安全过滤器太严格，可以尝试：

```bash
# 下载无安全过滤的版本
# 需要更多磁盘空间（约 7GB）
```

### 方案 3：使用 ComfyUI（高级用户）

ComfyUI 允许更精细地控制生成流程，可以完全绕过安全过滤。

```bash
brew install comfyui
comfyui
```

## 当前脚本位置

`/Users/autumn/.openclaw/workspace/generate_image.py`

## 快速使用在线工具

我可以帮你打开浏览器并访问这些网站：

```bash
open https://liblib.art
open https://seaart.ai
open https://bing.com/images/create
```

---

**建议：** 对于快速生成，使用在线工具是最简单可靠的方法。本地部署适合需要隐私或大量生成的场景。
