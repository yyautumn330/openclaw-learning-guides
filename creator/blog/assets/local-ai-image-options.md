# 🖼️ 本地 AI 图片生成方案 (无需 API Key)

> **研究时间**: 2026-03-04  
> **目标**: 免费、本地运行、无需 API

---

## 🎯 方案对比

| 方案 | 难度 | 速度 | 质量 | 推荐度 |
|------|------|------|------|--------|
| Draw Things (App) | ⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐⭐ |
| Stable Diffusion WebUI | ⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Diffusion Bee | ⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| Keynote+Emoji | ⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐ | ⭐⭐⭐ |
| 免费图库 | ⭐ | ⭐⭐⭐⭐⭐ | ⭐⭐⭐⭐ | ⭐⭐⭐ |

---

## 🏆 方案 1: Draw Things (最推荐)

### 应用信息

- **平台**: macOS / iOS / iPadOS
- **价格**: 免费 (有内购)
- **下载**: Mac App Store
- **特点**: 本地运行、无需网络、速度快

### 安装步骤

1. **打开 Mac App Store**
2. **搜索**: "Draw Things"
3. **下载安装** (约 200MB)
4. **首次启动** 会下载模型 (约 2-4GB)

### 使用方法

```
1. 打开 Draw Things
2. 选择模型 (推荐 SDXL Turbo)
3. 输入提示词
4. 调整尺寸 (1024×1024 或自定义)
5. 点击生成
6. 导出图片
```

### 提示词示例

**封面图**:
```
Technology background, blue gradient, AI assistant robot, 
futuristic, clean modern design, title text "5 分钟搭建 AI 助手", 
glowing effects, high resolution, 3:4 aspect ratio
```

**功能图**:
```
Icon set, 6 technology icons, weather, search, github, 
PDF, memory, automation, flat design, blue theme, 
white background, minimalist
```

### 优点

- ✅ 完全本地运行，无需网络
- ✅ 无需 API Key
- ✅ 生成速度快 (SDXL Turbo 几秒)
- ✅ 质量高
- ✅ 免费使用

### 缺点

- ❌ 首次需要下载模型 (2-4GB)
- ❌ 占用磁盘空间
- ❌ M 系列芯片优化最好 (Intel 较慢)

### 下载链接

- Mac App Store: 搜索 "Draw Things: AI Generation"
- 开发者：Lukas Holzbeierlein

---

## 🥈 方案 2: Diffusion Bee

### 应用信息

- **平台**: macOS (Apple Silicon)
- **价格**: 免费
- **下载**: https://diffusionbee.com/
- **特点**: 一键安装、简单易用

### 安装步骤

1. **访问官网**: https://diffusionbee.com/
2. **下载 macOS 版本**
3. **拖拽到 Applications**
4. **首次启动自动下载模型**

### 使用方法

```
1. 打开 Diffusion Bee
2. 选择 Text to Image
3. 输入提示词
4. 选择风格
5. 点击 Generate
```

### 优点

- ✅ 完全免费
- ✅ 安装简单
- ✅ 界面友好
- ✅ 本地运行

### 缺点

- ❌ 仅支持 Apple Silicon (M1/M2/M3)
- ❌ 功能相对简单
- ❌ 更新较慢

---

## 🥉 方案 3: Stable Diffusion WebUI (Automatic1111)

### 应用信息

- **平台**: macOS / Linux / Windows
- **价格**: 免费开源
- **GitHub**: https://github.com/AUTOMATIC1111/stable-diffusion-webui
- **特点**: 功能最强、插件丰富

### 安装步骤

```bash
# 1. 安装 Homebrew (如果未安装)
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

# 2. 安装 Python
brew install python@3.10

# 3. 克隆项目
cd ~
git clone https://github.com/AUTOMATIC1111/stable-diffusion-webui.git

# 4. 运行
cd stable-diffusion-webui
./webui.sh --mac
```

### 使用方法

```
1. 运行 ./webui.sh
2. 浏览器访问 http://localhost:7860
3. 输入提示词
4. 调整参数
5. 生成图片
```

### 优点

- ✅ 功能最强大
- ✅ 插件生态丰富
- ✅ 完全免费开源
- ✅ 支持多种模型

### 缺点

- ❌ 安装复杂
- ❌ 需要技术基础
- ❌ 占用资源多
- ❌ 配置繁琐

---

## 🎨 方案 4: Keynote + Emoji (最快)

### 工具

- **Keynote** (macOS 自带)
- **Emoji** (系统自带)
- **免费图标**: https://www.flaticon.com/

### 制作方法

```
1. 打开 Keynote
2. 设置尺寸 (1242×1660)
3. 渐变背景 (蓝色)
4. 添加 Emoji 图标
5. 添加文字
6. 导出 PNG
```

### Emoji 资源

- 🤖 机器人
- 💻 电脑
- ⚡ 速度
- 🆓 免费
- 📱 手机
- 🔧 工具
- 🧠 智能
- ☁️ 云端

### 优点

- ✅ 立即可用
- ✅ 无需安装
- ✅ 完全控制
- ✅ 风格统一

### 缺点

- ❌ 不是真正的 AI 生成
- ❌ 创意有限

---

## 📸 方案 5: 免费图库

### 网站推荐

| 网站 | URL | 特点 |
|------|-----|------|
| Unsplash | unsplash.com | 高质量摄影 |
| Pexels | pexels.com | 免费商用 |
| Pixabay | pixabay.com | 图片 + 矢量 |
| Freepik | freepik.com | 矢量图多 |

### 搜索关键词

- "Artificial Intelligence"
- "Technology Blue"
- "Robot Futuristic"
- "Code Programming"
- "AI Assistant"

### 优点

- ✅ 高质量
- ✅ 立即可用
- ✅ 免费商用

### 缺点

- ❌ 可能重复
- ❌ 不够定制化

---

## 🎯 我的推荐

### 最佳方案：Draw Things

**理由**:
- 本地运行，隐私安全
- 无需 API，完全免费
- 生成快速，质量高
- 界面友好，易上手

**使用场景**:
- 封面图生成
- 插图制作
- 图标设计

### 备选方案：Keynote+Emoji

**理由**:
- 立即可用
- 风格统一
- 完全控制

**使用场景**:
- 信息图表
- 命令速查
- 结束页

---

## 🚀 立即行动方案

### 方案 A: Draw Things (推荐)

```
1. 打开 Mac App Store
2. 搜索 "Draw Things"
3. 下载安装 (200MB)
4. 首次启动下载模型 (2-4GB, 30 分钟)
5. 开始生成图片
```

**预计时间**: 1 小时 (含模型下载)

### 方案 B: Keynote 快速制作

```
1. 打开 Keynote
2. 设置尺寸 1242×1660
3. 蓝色渐变背景
4. 添加 Emoji 和文字
5. 导出 PNG
```

**预计时间**: 30 分钟

### 方案 C: 混合方案

```
- 封面图：Draw Things 生成
- 内页图：Keynote 制作
- 截图：实际终端截图
```

**预计时间**: 1 小时

---

## 📊 成本对比

| 方案 | 金钱成本 | 时间成本 | 学习成本 |
|------|----------|----------|----------|
| Draw Things | ¥0 | 1 小时 | 低 |
| Diffusion Bee | ¥0 | 1 小时 | 低 |
| SD WebUI | ¥0 | 3 小时 | 高 |
| Keynote | ¥0 | 30 分钟 | 低 |
| 免费图库 | ¥0 | 15 分钟 | 低 |
| Nano Banana Pro | API 费用 | 5 分钟 | 低 |

---

## 💡 建议

**如果你**:
- 有 M 系列芯片 Mac → Draw Things
- 想立即开始 → Keynote+Emoji
- 技术能力强 → SD WebUI
- 不想折腾 → 免费图库

**我的选择**: Draw Things + Keynote 混合
- 封面用 AI 生成 (吸引眼球)
- 内页用 Keynote (信息清晰)
- 截图用实际终端 (真实可信)

---

*研究时间：2026-03-04*  
*更新：持续更新中*
