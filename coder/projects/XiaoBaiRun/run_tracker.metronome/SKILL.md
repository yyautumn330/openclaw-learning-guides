# 智能节拍器技能包 (run_tracker.metronome)

> **技能 ID**: `run_tracker.metronome`  
> **版本**: v1.0.0  
> **平台**: 鸿蒙 (HarmonyOS) + iOS  
> **类型**: 专业跑步节拍器技能

---

## 📋 技能概述

### 核心功能

| 功能 | 描述 | 优先级 |
|------|------|--------|
| BPM 控制 | 60-200 BPM 范围，默认 180 BPM | P0 |
| 节奏模式 | 匀速、渐进加速、间歇训练 | P0 |
| 声音类型 | 电子音、鼓点、人声提示 | P0 |
| 自定义计划 | BPM 曲线导入 | P1 |
| 后台播放 | 锁屏状态下正常工作 | P0 |
| 数据联动 | 根据配速自动调整 BPM | P1 |
| 语音提示 | 节奏/配速语音同步 | P1 |
| 蓝牙耳机 | 蓝牙耳机连接支持 | P1 |

---

## 🏗️ 技能结构

```
run_tracker.metronome/
├── SKILL.md                 # 技能主文档
├── package.json            # npm 配置
├── README.md               # 使用说明
├── common/                 # 跨平台通用代码
│   ├── models/           # 数据模型
│   │   ├── MetronomeConfig.ts
│   │   ├── RhythmPattern.ts
│   │   ├── BPMCurve.ts
│   │   └── AudioType.ts
│   ├── constants/        # 常量定义
│   │   ├── RhythmMode.ts
│   │   ├── AudioType.ts
│   │   └── BPMRange.ts
│   └── interfaces/       # 接口定义
│       ├── IMetronomeService.ts
│       ├── IAudioPlayer.ts
│       └── IBluetoothManager.ts
├── platforms/              # 平台适配层
│   ├── harmonyos/          # 鸿蒙平台
│   │   ├── services/      # 服务层
│   │   │   ├── MetronomeService.ts
│   │   │   ├── AudioPlayer.ts
│   │   │   ├── BluetoothManager.ts
│   │   │   └── VoiceEngine.ts
│   │   ├── pages/         # 页面组件
│   │   │   ├── MetronomePage.ets
│   │   │   ├── BPMAdjustPage.ets
│   │   │   ├── RhythmPatternPage.ets
│   │   │   └── SettingsPage.ets
│   │   ├── components/   # 通用组件
│   │   │   ├── BPMSlider.ets
│   │   │   ├── RhythmModeSelector.ets
│   │   │   ├── AudioTypeSelector.ets
│   │   └── BPMCurveEditor.ets
│   │   └── resources/     # 资源文件
│   │       ├── audio/
│   │       │   ├── electronic_beep.mp3
│   │   │   ├── drum_beat.mp3
│   │   │   ├── human_voice.mp3
│   │   │   ├── tempo_120.mp3 ~ tempo_200.mp3
│   │   │   └── voice_prompts/
│   │   └── module.json5
│   └── ios/              # iOS 平台
│       ├── Services/
│       │   ├── MetronomeService.swift
│       │   ├── AudioPlayer.swift
│       │   ├── BluetoothManager.swift
│       │   └── VoiceEngine.swift
│       ├── Views/
│       │   ├── MetronomeViewController.swift
│       │   ├── BPMAdjustViewController.swift
│       │   ├── RhythmPatternViewController.swift
│       │   └── SettingsViewController.swift
│       ├── ViewModels/
│       │   └── MetronomeViewModel.swift
│       └── Resources/
│           ├── audio/
│           │   ├── electronic_beep.mp3
│           │   ├── drum_beat.mp3
           │   ├── human_voice.mp3
│           │   └── voice_prompts/
│           └── Info.plist
├── config/                 # 配置文件
│   ├── skill-config.json  # 技能配置
│   ├── audio-config.json   # 音频配置
│   └── rhythm-patterns.json # 节奏模式预设
└── docs/                   # 文档
    ├── API.md            # API 文档
    ├── AUDIO.md         # 音频制作指南
    ├── RHYTHM.md        # 节奏模式设计
    └── BLUETOOTH.md      # 蓝牙耳机配置
```

---

## 🎯 核心服务设计

### 1. MetronomeService - 节拍器服务

#### 功能
- BPM 控制（60-200）
- 节奏模式（匀速、渐进加速、间歇训练）
- 声音播放（电子音、鼓点、人声）
- 后台播放支持
- 与跑步数据联动

#### HarmonyOS 实现
```typescript
// platforms/harmonyos/services/MetronomeService.ts
import media from '@ohos.multimedia.media';

export class MetronomeService {
  private avPlayer: media.AVPlayer;
  private isPlaying: boolean = false;
  private beatInterval: number = -1;
  private beatCount: number = 0;
  
  // 配置
  private bpm: number = 180;
  private rhythmMode: RhythmMode = RhythmMode.STEADY;
  private audioType: AudioType = AudioType.ELECTRONIC;
  private voiceEnabled: boolean = true;
  private voiceIntervalKm: number = 1; // 每公里语音提示
  
  async start(config: MetronomeConfig): Promise<void> {
    this.bpm = config.bpm;
    this.rhythmMode = config.rhythmMode;
    this.audioType = config.audioType;
    this.voiceEnabled = config.voiceEnabled;
    
    this.avPlayer = await media.createAVPlayer.setVolume(config.volume);
    this.isPlaying = true;
    
    const intervalMs = this.calculateInterval(this.bpm, this.rhythmMode);
    
    const playBeat = async () => {
      if (!this.isPlaying) return;
      
      this.beatCount++;
      
      // 根据节奏模式调整间隔
      const adjustedInterval = this.adjustInterval(this.beatCount, this.rhythmMode);
      if (adjustedInterval !== intervalMs) {
        clearInterval(this.beatInterval);
        this.beatInterval = setInterval(playBeat, adjustedInterval);
        return;
      }
      
      // 播放音频
      await this.playAudio(this.audioType);
      
      // 语音提示
      if (this.voiceEnabled) {
        await this.checkVoicePrompt();
      }
    };
    
    playBeat();
    this.beatInterval = setInterval(playBeat, intervalMs);
  }
  
  private calculateInterval(bpm: number, mode: RhythmMode): number {
    const baseInterval = 60000 / bpm;
    
    switch (mode) {
      case RhythmMode.STEADY:
        return baseInterval;
      
      case RhythmMode.GRADUAL_ACCEL:
        // 渐进加速：从 80% 速度开始，20 秒后加速到 100%
        const accelerationPhase = Math.min(this.beatCount / (60 / bpm), 0.33); // 20 秒
        return baseInterval * (0.8 + 0.2 * accelerationPhase);
      
      case RhythmMode.INTERVAL_TRAINING:
        // 间歇训练：快跑 30 秒，慢跑 30 秒
        const cyclePosition = this.beatCount % (60000 / bpm / 2);
        return cyclePosition < (60000 / bpm / 2) ? baseInterval * 0.8 : baseInterval * 1.25;
      
      default:
        return baseInterval;
    }
  }
}
```

---

### 2. AudioPlayer - 音频播放服务

#### 功能
- 多种音频类型支持
- 音量控制
- 后台播放
- 蓝牙音频路由

#### 音频类型
```typescript
export enum AudioType {
  ELECTRONIC = 'electronic',      // 电子音效
  DRUM = 'drum',                 // 鼓点
  HUMAN = 'human'                 // 人声提示
}
```

---

### 3. BluetoothManager - 蓝牙管理服务

#### 功能
- 蓝牙耳机连接检测
- 音频路由到蓝牙
- 延迟补偿
- 断线重连

#### HarmonyOS 实现
```typescript
// platforms/harmonyos/services/BluetoothManager.ts
import audio from '@ohos.multimedia.audio';

export class BluetoothManager {
  private isConnected: boolean = false;
  private bluetoothDevice: string = '';
  
  async checkConnection(): Promise<boolean> {
    try {
      // 检查蓝牙连接状态
      const devices = await audio.getAudioDevices();
      const bluetoothDevices = devices.filter(d => 
        d.deviceRole === audio.AudioDeviceRole.OUTPUT_BLUETOOTH
      );
      
      if (bluetoothDevices.length > 0) {
        this.isConnected = true;
        this.bluetoothDevice = bluetoothDevices[0].id;
        console.info('Bluetooth device connected:', this.bluetoothDevice);
        return true;
      }
      
      this.isConnected = false;
      return false;
    } catch (error) {
      console.error('Bluetooth check error:', error);
      return false;
    }
  }
  
  async routeAudioToBluetooth(): Promise<void> {
    if (!this.isConnected) {
      console.warn('No bluetooth device connected');
      return;
    }
    
    try {
      await audio.setPreferredOutputDevice({
        deviceType: audio.AudioDeviceType.OUTPUT_BLUETOOTH,
        deviceId: this.bluetoothDevice
      });
      console.info('Audio routed to bluetooth:', this.beatBluetoothDevice);
    } catch (error) {
      console.error('Route to bluetooth error:', error);
    }
  }
}
```

---

### 4. VoiceEngine - 语音引擎

#### 功能
- TTS 语音播放
- 动态语音提示
- 多语言支持
- 音量控制

#### 语音提示内容
```typescript
const VOICE_PROMPTS = {
  START: '开始跑步，目标配速%d分%d秒',
  KEEP_PACE: '保持节奏，当前%d步/分钟',
  HALFWAY: '已经一半，加油！',
  FINAL_KM: '最后1公里，冲刺！',
  FINISHED: '跑步完成，总距离%d公里，用时%d分%d秒',
  SPEED_UP: '加速，目标配速%d分%d秒',
  SLOW_DOWN: '减速，目标配速%d分%d秒'
};
```

#### HarmonyOS 实现
```typescript
// platforms/harmonyos/services/VoiceEngine.ts
import { textToSpeech } from '@kit.CoreFileKit';

export class VoiceEngine {
  private ttsEngine: textToSpeech;
  
  async initialize(): Promise<void> {
    this.ttsEngine = textToSpeech.createEngine();
    const voices = this.ttsEngine.getAllVoices();
    console.info('Available voices:', voices.length);
  }
  
  async speak(text: string, language: string = 'zh-CN'): Promise<void> {
    const speakParams: textToSpeech.SpeakParams = {
      language: language,
      rate: 1.0,
      pitch: 1.0,
      volume: 0.7,
      requestNormalDialogId: 'metronome'
    };
    
    await this.ttsEngine.speak(text, speakParams);
  }
}
```

---

## 🎵 节奏模式设计

### 1. 匀速模式
- 固定 BPM
- 等间隔播放
- 适合：日常训练

### 2. 渐进加速模式
- 从 80% 速度开始
- 20 秒后加速到 100%
- 适合：长距离慢跑、速度训练

### 3. 间歇训练模式
- 快跑 30 秒（+20% BPM）
- 慢跑 30 秒（-20% BPM）
- 适合：间歇跑、HIIT 训练

```typescript
export enum RhythmMode {
  STEADY = 'steady',           // 匀速
  GRADUAL_ACCEL = 'gradual_accel', // 渐进加速
  INTERVAL_TRAINING = 'interval_training' // 间歇训练
}
```

---

## 📊 数据联动逻辑

### 与跑步数据联动

```typescript
export class DataLinkageService {
  private metronomeService: MetronomeService;
  private metricsService: MetricsService;
  
  /**
   * 根据配速自动调整 BPM
   */
  async autoAdjustBPM(currentPace: number): Promise<void> {
    const targetPace = currentPace;
    
    // 根据配速计算 BPM
    const targetBPM = this.calculateBPMFromPace(targetPace);
    
    // 检查 BPM 是否在合理范围内
    if (targetBPM >= 60 && targetBPM <= 200) {
      const currentBPM = metronomeService.getCurrentBPM();
      
      // 差异超过 10 BPM 才调整
      if (Math.abs(targetBPM - currentBPM) > 10) {
        const direction = targetBPM > currentBPM ? '加速' : '减速';
        
        // 语音提示
        await voiceEngine.speak(
          VOICE_PROMPTS.SPEED_UP,
          this.formatPace(targetBPM)
        );
        
        // 调整 BPM
        await metronomeService.setBPM(targetBPM);
      }
    }
  }
  
  /**
   * 根据配速计算 BPM
   * 公式：BPM = 180 / (分钟数 + 秒数/60)
   */
  private calculateBPMFromPace(pace: number): number {
    const paceMin = pace / 60;
    const paceSec = pace % 60;
    
    return Math.round(180 / (paceMin + paceSec / 60));
  }
  
  /**
   * 格式化配速
   */
  private formatPace(pace: number): string {
    const min = Math.floor(pace / 60);
    const sec = Math.floor(pace % 60);
    return `${min}'${sec.toString().padStart(2, '0')}"`;
  }
}
```

---

## 🔌 API 接口规范

### 数据模型
```typescript
export interface MetronomeConfig {
  bpm: number;           // BPM (60-200)
  rhythmMode: RhythmMode;  // 节奏模式
  audioType: AudioType;     // 音频类型
  volume: number;         // 音量 (0-1)
  voiceEnabled: boolean;  // 语音提示
  voiceIntervalKm: number; // 语音提示间隔（公里）
  bluetoothEnabled: boolean; // 蓝牙耳机
  backgroundPlay: boolean; // 后台播放
}

export interface RhythmPattern {
  id: string;
  name: string;
  bpmCurve: BPMPoint[];  // BPM 曲线
  description: string;
}

export interface BPMPoint {
  time: number;        // 时间（秒）
  bpm: number;        // BPM
}
```

---

## 🔋 电池优化策略

### 1. 后台播放优化
- 使用 `audio.setInterruptNotification(true)` 允许后台播放
- 低功耗音频解码
- 暂停不必要的动画

### 2. 蓝牙优化
- 减少蓝牙扫描频率
- 使用低功耗蓝牙协议
- 断线自动暂停播放

### 3. 屏幕管理
- 跑步时允许屏幕关闭
- 仅音频 + 语音播放
- 最小化 UI 刷新

---

## 📱 用户交互流程

### 节拍器页面流程

```
1. 打开节拍器页面
   ↓
2. 选择节拍模式
   ├── 匀速（固定 BPM）
   ├── 渐进加速（自动加速）
   └── 间歇训练（快慢交替）
   ↓
3. 设置 BPM
   ├── 滑块调节（60-200）
   ├── 快速选择（120/140/160/180）
   └── 自定义 BPM 曲线
   ↓
4. 选择音频类型
   ├── 电子音（短促）
   ├── 鼓点（清脆）
   └── 人声（语音提示）
   ↓
5. 启用语音提示
   ├── 每公里提示
   ├── 半程提醒
   ├── 最终冲刺
   └── 自定义
   ↓
6. 连接蓝牙耳机（可选）
   ↓
7. 开始跑步
   ├── 节拍器启动
   ├── 后台播放
   ├── 语音提示
   └── 配速联动
```

---

## 🔧 配置文件

### 音频配置
```json
// config/audio-config.json
{
  "audio_types": {
    "electronic": {
      "beep_file": "electronic_beep.mp3",
      "frequency": "880Hz",
      "duration": "0.1s",
      "volume": 0.7
    },
    "drum": {
      "beat_file": "drum_beat.mp3",
      "frequency": "440Hz",
      "duration": "0.15s",
      "volume": 0.8"
    },
    "human": {
      "voice_file": "human_voice.mp3",
      "voice_engine": "zh-CN",
      "rate": 1.0,
      "pitch": 1.0",
      "volume": 0.7
    }
  },
  "bpm_presets": [
    120, 130, 140, 150, 160, 170, 180, 190, 200
  ],
  "tempo_presets": {
    "easy_run": { "bpm": 140, "duration": "30min", "description": "轻松跑" },
    "long_run": { "bpm": 160, "duration": "60min", "description": "长距离" },
    "speed_workout": { "bpm": 180, "duration": "20min", "description": "速度训练" }
  }
}
```

### 节奏模式预设
```json
// config/rhythm-patterns.json
{
  "patterns": [
    {
      "id": "steady_160",
      "name": "匀速 160 BPM",
      "rhythm_mode": "steady",
      "bpm": 160,
      "description": "适合日常训练"
    },
    {
      "id": "gradual_accel",
      "name": "渐进加速",
      "rhythm_mode": "gradual_accel",
      "bpm_curve": [
        { "time": 0, "bpm": 144 },
        { "time": 300, "bpm": 160 },
        { "time": 600, "bpm": 176 },
        { "time": 1200, "bpm": 180 },
        { "time": 1800, "bpm": 180 }
      ],
      "description": "20分钟从 144 加速到 180"
    },
    {
      "id": "interval_hiit",
      "name": "间歇训练",
      "rhythm_mode": "interval_training",
      "cycle_duration": 60,
      "fast_phase": {
        "bpm": 180,
        "duration": 30
      },
      "slow_phase": {
        "bpm": 140,
        "duration": 30
      },
      "description": "30秒快跑 + 30秒慢跑"
    }
  ]
}
```

---

## 🚀 快速开始

### HarmonyOS

```typescript
// 1. 初始化节拍器
import { metronomeService } from './services/MetronomeService';

// 2. 配置节拍器
const config: MetronomeConfig = {
  bpm: 160,
  rhythmMode: RhythmMode.STEADY,
  audioType: AudioType.ELECTRONIC,
  volume: 0.7,
  voiceEnabled: true,
  voiceIntervalKm: 1,
  bluetoothEnabled: true,
  backgroundPlay: true
};

// 3. 启动节拍器
await metronomeService.start(config);

// 4. 开始跑步
await locationService.startTracking(...);

// 5. 数据联动（配速变化时自动调整 BPM）
await dataLinkageService.autoAdjustBpm(currentPace);
```

### iOS

```swift
// 1. 初始化节拍器
let metronomeService = MetronomeService()

// 2. 配置节拍器
let config = MetronomeConfig(
  bpm: 160,
  rhythmMode: .steady,
  audioType: .electronic,
  volume: 0.7,
  voiceEnabled: true,
  voiceIntervalKm: 1,
  bluetoothEnabled: true,
  backgroundPlay: true
)

// 3. 启动节拍器
metronomeService.start(config: config)

// 4. 开始跑步
locationService.startTracking { point in
    print("GPS: \(point)")
}

// 5. 数据联动
dataLinkageService.autoAdjustBpm(currentPace: currentPace)
```

---

## 📚 更多文档

- `README.md` - 使用指南
- `docs/API.md` - API 接口文档
- `docs/AUDIO.md` - 音频制作指南
- `docs/RHYTHM.md` - 节奏模式设计
- `docs/BLUETOOTH.md` - 蓝牙耳机配置

---

## 🎯 性能目标

| 指标 | 目标 | 说明 |
|------|------|------|
| GPS 精度 | < 5m | 高精度定位 |
| 电池消耗 | < 5%/hour | 后台播放模式 |
| 延迟 | < 50ms | 音频播放延迟 |
| 内存占用 | < 50MB | 运行时内存 |

---

**技能包设计完成！** 🎉

所有核心功能均已详细设计，包括 BPM 控制、节奏模式、音频播放、语音提示、蓝牙支持和与跑步数据联动。技能包兼容鸿蒙/iOS 双平台，支持后台播放，优化电池消耗。

---

**最后更新**: 2026-03-14  
**作者**: 小白  
**版本**: v1.0.0