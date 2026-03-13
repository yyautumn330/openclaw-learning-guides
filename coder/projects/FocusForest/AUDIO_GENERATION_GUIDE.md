# 专注森林 - AI 音频生成指南

**生成日期**: 2026-03-10  
**生成工具**: AI 音频生成 (Stable Audio / AudioLDM / Riffusion)  
**目标**: 6 种白噪音音效，每种 30 分钟循环

---

## 🎵 需要生成的音效清单

| # | 音效名称 | 文件名 | 时长 | 用途 |
|---|---------|--------|------|------|
| 1 | 雨声 | rain.mp3 | 30min | 专注/放松 |
| 2 | 咖啡馆 | cafe.mp3 | 30min | 工作氛围 |
| 3 | 海浪声 | waves.mp3 | 30min | 放松/冥想 |
| 4 | 森林鸟鸣 | forest.mp3 | 30min | 自然氛围 |
| 5 | 篝火声 | campfire.mp3 | 30min | 温暖氛围 |
| 6 | 夜雨声 | night_rain.mp3 | 30min | 助眠/放松 |

---

## 🤖 AI 音频生成工具推荐

### 首选：Stable Audio
**网址**: https://www.stableaudio.com

**优点**:
- ✅ 专业音频生成质量
- ✅ 支持长音频生成
- ✅ 可商用授权
- ✅ 循环无缝衔接

**免费额度**: 每月 20 次生成

---

### 备选 1: AudioLDM
**网址**: https://audioldm.github.io

**优点**:
- ✅ 开源免费
- ✅ 质量不错
- ✅ 可本地部署

---

### 备选 2: Riffusion
**网址**: https://www.riffusion.com

**优点**:
- ✅ 免费使用
- ✅ 生成快速
- ✅ 可商用

---

## 📝 音频生成提示词 (Prompts)

### 1. 雨声 (Rain)

**英文 Prompt**:
```
Natural rain sounds falling on roof, gentle rainfall for focus 
and relaxation, no thunder, no lightning, consistent rain, 
loopable ambient sound, high quality field recording, 
30 minutes continuous, calming white noise
```

**中文说明**: 自然的雨声落在屋顶上，温柔的降雨用于专注和放松，无雷声，无闪电，持续的雨声，可循环的环境音，高质量实地录音，30 分钟连续，平静的白噪音

**参数建议**:
- Duration: 30 minutes
- Style: Ambient, Field Recording
- BPM: N/A
- Key: N/A

---

### 2. 咖啡馆 (Café)

**英文 Prompt**:
```
Coffee shop ambience, background chatter of customers, coffee 
machine sounds, cups clinking, soft murmuring, relaxing café 
atmosphere for work and study, loopable ambient sound, 
30 minutes continuous, warm cozy environment
```

**中文说明**: 咖啡馆环境音，顾客的背景聊天声，咖啡机声音，杯子碰撞声，柔和的交谈声，适合工作和学习的放松咖啡馆氛围，可循环的环境音，30 分钟连续，温暖舒适的环境

**参数建议**:
- Duration: 30 minutes
- Style: Ambient, Environmental
- Volume: Low-Medium (background)

---

### 3. 海浪声 (Ocean Waves)

**英文 Prompt**:
```
Ocean waves gently rolling onto sandy beach, calm surf sounds, 
soothing water waves, peaceful seaside atmosphere, loopable 
nature sounds, 30 minutes continuous, relaxing white noise 
for meditation and sleep
```

**中文说明**: 海浪轻轻拍打着沙滩，平静的冲浪声，舒缓的水波，宁静的海边氛围，可循环的自然声音，30 分钟连续，用于冥想和睡眠的放松白噪音

**参数建议**:
- Duration: 30 minutes
- Style: Nature, Ambient
- Intensity: Gentle

---

### 4. 森林鸟鸣 (Forest Birds)

**英文 Prompt**:
```
Forest ambience with gentle bird songs, peaceful nature sounds, 
distant birds chirping, rustling leaves in breeze, tranquil 
woodland atmosphere, loopable natural soundscape, 30 minutes 
continuous, calming meditation background
```

**中文说明**: 森林环境音伴随着轻柔的鸟鸣，宁静的自然声音，远处的鸟儿啁啾，微风中沙沙作响的树叶，宁静的林地氛围，可循环的自然声景，30 分钟连续，平静的冥想背景

**参数建议**:
- Duration: 30 minutes
- Style: Nature, Field Recording
- Time: Daytime

---

### 5. 篝火声 (Campfire)

**英文 Prompt**:
```
Campfire crackling, burning wood sounds, gentle fire popping, 
warm cozy fireplace ambience, relaxing fire sounds for study 
and sleep, loopable ambient sound, 30 minutes continuous, 
peaceful evening atmosphere
```

**中文说明**: 篝火噼啪声，燃烧的木头声音，轻柔的火焰爆裂声，温暖舒适的壁炉氛围，适合学习和睡眠的放松火焰声，可循环的环境音，30 分钟连续，宁静的夜晚氛围

**参数建议**:
- Duration: 30 minutes
- Style: Ambient, Environmental
- Intensity: Gentle

---

### 6. 夜雨声 (Night Rain)

**英文 Prompt**:
```
Gentle night rain falling, soft rainfall on window, peaceful 
evening rain sounds, calming rain for sleep and relaxation, 
no thunder, loopable ambient sound, 30 minutes continuous, 
soothing white noise
```

**中文说明**: 温柔的夜雨落下，柔和的雨声打在窗户上，宁静的夜晚雨声，用于睡眠和放松的平静雨声，无雷声，可循环的环境音，30 分钟连续，舒缓的白噪音

**参数建议**:
- Duration: 30 minutes
- Style: Ambient, Nature
- Time: Night
- Intensity: Light

---

## 🎛️ 生成步骤

### Step 1: 选择工具
推荐使用 **Stable Audio** (质量最好)

### Step 2: 批量生成
按顺序生成 6 种音效：
1. 雨声
2. 咖啡馆
3. 海浪声
4. 森林鸟鸣
5. 篝火声
6. 夜雨声

**预计时间**: 每种 10-15 分钟，共 1-2 小时

### Step 3: 下载音频
- 格式：MP3 或 WAV
- 质量：高质量 (192kbps 或以上)
- 时长：30 分钟

### Step 4: 后期处理 (可选)
使用音频编辑软件 (如 Audacity):
- [ ] 裁剪至精确 30 分钟
- [ ] 淡入淡出 (1 秒)
- [ ] 音量标准化 (-3dB)
- [ ] 检查循环点是否无缝

### Step 5: 放入项目
```
FocusForest/entry/src/main/resources/rawfile/sounds/
├── rain.mp3
├── cafe.mp3
├── waves.mp3
├── forest.mp3
├── campfire.mp3
└── night_rain.mp3
```

---

## ⚠️ 注意事项

### 版权
- ✅ 确保 AI 生成内容可商用
- ✅ 保留生成记录
- ⚠️ 检查工具的使用条款

### 质量检查
- [ ] 无明显噪音/爆音
- [ ] 循环点无缝衔接
- [ ] 音量一致
- [ ] 时长准确 (30 分钟)

### 文件大小
- 单文件目标：<10MB
- 如过大，降低比特率 (128kbps 足够)

---

## 🔄 备选方案

如果 AI 生成效果不理想，可使用免费音效网站：

| 网站 | 链接 | 版权 |
|------|------|------|
| Pixabay Sound | https://pixabay.com/sound-effects/ | ✅ 可商用 |
| Freesound | https://freesound.org | CC 协议 |
| Mixkit | https://mixkit.co/free-sound-effects/ | ✅ 可商用 |

---

## 📋 生成记录

| 音效 | 生成时间 | 工具 | 状态 | 文件大小 |
|------|---------|------|------|---------|
| rain.mp3 | - | - | ⏳ 待生成 | - |
| cafe.mp3 | - | - | ⏳ 待生成 | - |
| waves.mp3 | - | - | ⏳ 待生成 | - |
| forest.mp3 | - | - | ⏳ 待生成 | - |
| campfire.mp3 | - | - | ⏳ 待生成 | - |
| night_rain.mp3 | - | - | ⏳ 待生成 | - |

---

*创建日期*: 2026-03-10  
*创建人*: 小白 (CM-Dev)  
*状态*: 准备生成
