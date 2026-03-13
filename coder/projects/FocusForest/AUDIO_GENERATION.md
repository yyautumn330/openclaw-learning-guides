# 专注森林 - 白噪音音频生成方案

**创建日期**: 2026-03-11

---

## 🎯 需求分析

需要生成 6 种白噪音音效：
1. 雨声 (Rain)
2. 咖啡馆 (Café)
3. 海浪 (Waves)
4. 森林鸟鸣 (Forest)
5. 篝火 (Campfire)
6. 夜雨 (Night Rain)

**要求**:
- 格式：MP3
- 时长：每首 30 秒 -1 分钟 (循环播放)
- 质量：128kbps 或以上
- 版权：可商用 (CC0 或自己生成)

---

## 🔧 方案 A: 使用 ffmpeg 生成 (推荐)

### 优势
- ✅ 本地生成，无需网络
- ✅ 完全免费
- ✅ 可商用
- ✅ 快速生成

### 生成方法

#### 1. 白噪音 (粉红噪音/布朗噪音)
```bash
# 生成 30 秒粉红噪音 (类似雨声)
ffmpeg -f lavfi -i "color=c=black:s=320x240:d=30" -f lavfi -i "pinknoise=0.5" \
  -c:v libx264 -c:a libmp3lame -b:a 128k -t 30 \
  rawfile/sounds/rain.mp3

# 生成布朗噪音 (更深沉，类似海浪)
ffmpeg -f lavfi -i "color=c=black:s=320x240:d=30" -f lavfi -i "brownnoise=0.5" \
  -c:v libx264 -c:a libmp3lame -b:a 128k -t 30 \
  rawfile/sounds/waves.mp3
```

#### 2. 使用现有音频样本混合
如果有自然声音样本，可以循环和混合：
```bash
# 循环短音频样本到 30 秒
ffmpeg -stream_loop -1 -i rain_sample.wav -t 30 -c:a libmp3lame -b:a 128k rain.mp3

# 混合多个音轨 (雨声 + 雷声)
ffmpeg -i rain.mp3 -i thunder.mp3 -filter_complex amix=inputs=2:duration=longest mixed.mp3
```

---

## 🎵 方案 B: 使用免费音效库

### 推荐资源

#### 1. Freesound.org
- 网址：https://freesound.org
- 版权：CC0 (可商用)
- 搜索关键词：
  - `rain white noise`
  - `cafe ambience`
  - `ocean waves loop`
  - `forest birds ambient`
  - `campfire crackling`
  - `night rain`

#### 2. Pixabay Sound Effects
- 网址：https://pixabay.com/sound-effects/
- 版权：Pixabay License (可商用)
- 高质量，无需署名

#### 3. ZapSplat
- 网址：https://www.zapsplat.com
- 版权：免费 (需署名或付费免署名)
- 专业音效库

---

## 🤖 方案 C: AI 生成工具

### 在线 AI 音频生成

#### 1. Stable Audio
- 网址：https://www.stableaudio.com
- 免费额度：每月 20 次
- 提示词示例：
  ```
  "Natural rain sounds for focus and relaxation, 
   loopable ambient sound, 30 seconds, high quality"
  ```

#### 2. AudioLDM (Hugging Face)
- 网址：https://huggingface.co/spaces/haoheliu/AudioLDM
- 免费开源
- 文本生成音频

#### 3. Riffusion
- 网址：https://www.riffusion.com
- 免费使用
- AI 音乐生成

---

## 🎯 推荐方案

### 最佳实践 (组合方案)

**步骤 1**: 从 Freesound.org 下载 CC0 音效样本
```bash
# 示例下载 (需要手动下载)
# https://freesound.org/people/InspectorJ/sounds/348999/ (雨声)
# https://freesound.org/people/Leszek_Szary/sounds/173677/ (咖啡馆)
# https://freesound.org/people/InspectorJ/sounds/348847/ (海浪)
```

**步骤 2**: 使用 ffmpeg 处理和循环
```bash
# 将短样本循环到 30 秒
ffmpeg -stream_loop -1 -i input.wav -t 30 -c:a libmp3lame -b:a 128k output.mp3

# 淡入淡出 (避免循环痕迹)
ffmpeg -i input.mp3 -af "afade=t=in:st=0:d=2,afade=t=out:st=28:d=2" output_faded.mp3
```

**步骤 3**: 音量标准化
```bash
# 标准化音量到 -3dB
ffmpeg -i input.mp3 -af "loudnorm=I=-3" normalized.mp3
```

---

## 📋 执行计划

### 方法 1: 快速生成 (使用 ffmpeg 噪音生成)

```bash
cd ~/.openclaw/workspace/coder/projects/FocusForest/entry/src/main/resources/rawfile/sounds

# 1. 雨声 (粉红噪音)
ffmpeg -f lavfi -i "pinknoise=0.5" -t 60 -c:a libmp3lame -b:a 128k -y rain.mp3

# 2. 咖啡馆 (需要真实样本或 AI 生成)
# 建议使用 Freesound 下载

# 3. 海浪 (布朗噪音)
ffmpeg -f lavfi -i "brownnoise=0.4" -t 60 -c:a libmp3lame -b:a 128k -y waves.mp3

# 4. 森林 (需要鸟鸣样本)
# 建议使用 Freesound 下载

# 5. 篝火 (需要火焰样本)
# 建议使用 Freesound 下载

# 6. 夜雨 (粉红噪音 + 低通滤波)
ffmpeg -f lavfi -i "pinknoise=0.5" -af "lowpass=f=1000" -t 60 -c:a libmp3lame -b:a 128k -y night_rain.mp3
```

### 方法 2: 下载免费音效 (推荐)

1. 访问 https://freesound.org
2. 搜索并下载以下音效 (CC0 许可):
   - Rain: https://freesound.org/search/?q=rain+noise+loop
   - Café: https://freesound.org/search/?q=cafe+ambience
   - Waves: https://freesound.org/search/?q=ocean+waves+loop
   - Forest: https://freesound.org/search/?q=forest+birds+ambient
   - Campfire: https://freesound.org/search/?q=campfire+crackling
   - Night Rain: https://freesound.org/search/?q=night+rain

3. 下载后使用 ffmpeg 处理:
```bash
# 循环到 60 秒
ffmpeg -stream_loop -1 -i downloaded.wav -t 60 -c:a libmp3lame -b:a 128k output.mp3

# 淡入淡出
ffmpeg -i output.mp3 -af "afade=t=in:st=0:d=2,afade=t=out:st=58:d=2" final.mp3
```

---

## ⚡ 快速执行命令

### 使用 ffmpeg 生成基础白噪音

```bash
# 进入音效目录
cd ~/.openclaw/workspace/coder/projects/FocusForest/entry/src/main/resources/rawfile/sounds

# 生成 6 种音效 (每种 60 秒，128kbps)

# 1. 雨声 (粉红噪音)
ffmpeg -f lavfi -i "pinknoise=0.5" -t 60 -c:a libmp3lame -b:a 128k -y rain.mp3

# 2. 海浪 (布朗噪音)
ffmpeg -f lavfi -i "brownnoise=0.4" -t 60 -c:a libmp3lame -b:a 128k -y waves.mp3

# 3. 夜雨 (粉红噪音 + 低通滤波)
ffmpeg -f lavfi -i "pinknoise=0.5" -af "lowpass=f=800" -t 60 -c:a libmp3lame -b:a 128k -y night_rain.mp3

# 4-6. 咖啡馆/森林/篝火需要真实样本
# 建议从 Freesound.org 下载 CC0 音效后处理
```

---

## 📝 注意事项

1. **版权问题**: 确保使用的音效是 CC0 或可商用
2. **循环无缝**: 使用淡入淡出避免循环痕迹
3. **音量一致**: 标准化所有音效到相同音量 (-3dB)
4. **文件大小**: 60 秒 128kbps MP3 约 1MB/文件

---

*创建时间*: 2026-03-11  
*版本*: 1.0
