# 小白快跑技能包 - 跑步数据采集与分析

> **版本**: v2.0  
> **平台**: 鸿蒙 (HarmonyOS) + iOS  
> **类型**: 跨平台移动应用技能  
> **状态**: 设计阶段

---

## 📋 技能概述

### 核心功能

| 功能 | 描述 | 优先级 |
|------|------|--------|
| GPS 轨迹记录 | 实时记录跑步轨迹，支持暂停/继续 | P0 |
| 数据采集 | 距离、时间、配速、步频、心率、卡路里 | P0 |
| 智能节拍器 | 自定义 BPM，语音提示，节拍同步 | P0 |
| 社交分享 | 多平台分享，运动报告图片生成 | P1 |
| 历史数据 | 存储、查询、分析跑步记录 | P1 |
| 跑步计划 | 基于数据生成个性化训练方案 | P2 |

---

## 🏗️ 技能结构

```
running-tracker-skill/
├── SKILL.md                 # 技能主文档
├── package.json            # npm 配置
├── README.md               # 使用说明
├── platforms/              # 平台适配层
│   ├── harmonyos/          # 鸿蒙平台
│   │   ├── services/      # 服务层
│   │   │   ├── LocationService.ts
│   │   │   ├── MetricsService.ts
│   │   │   ├── MetronomeService.ts
│   │   │   ├── HeartRateService.ts
│   │   │   └── StorageService.ts
│   │   ├── pages/         # 页面组件
│   │   │   ├── HomePage.ets
│   │   │   ├── TrackingPage.ets
│   │   │   ├── HistoryPage.ets
│   │   │   ├── PlanPage.ets
│   │   │   └── ProfilePage.ets
│   │   ├── components/   # 通用组件
│   │   │   ├── MapView.ets
│   │   │   ├── StatsCard.ets
│   │   │   ├── ShareDialog.ets
│   │   │   └── ReportGenerator.ts
│   │   ├── utils/         # 工具类
│   │   │   ├── GPSTracker.ts
│   │   │   ├── CaloriesCalculator.ts
│   │   │   └── SocialShare.ts
│   │   └── module.json5  # 模块配置
│   └── ios/              # iOS 平台
│       ├── Services/
│       ├── Views/
│       ├── ViewModels/
│       └── Info.plist
├── common/                 # 跨平台通用代码
│   ├── models/           # 数据模型
│   │   ├── RunRecord.ts
│   │   ├── TrackPoint.ts
│   │   ├── Metrics.ts
│   │   └── TrainingPlan.ts
│   ├── constants/        # 常量定义
│   │   ├── AppConfig.ts
│   │   ├── SportTypes.ts
│   │   └── SharePlatforms.ts
│   └── utils/           # 通用工具
│       ├── MathUtils.ts
│       ├── DateUtils.ts
│       └── Validator.ts
├── config/                 # 配置文件
│   ├── skill-config.json  # 技能配置
│   └── api-config.json    # API 配置
└── docs/                   # 文档
    ├── API.md            # API 文档
    ├── ARCHITECTURE.md   # 架构文档
    └── PLATFORMS.md      # 平台适配指南
```

---

## 🎯 核心服务设计

### 1. LocationService - GPS 定位服务

#### 功能
- 实时 GPS 定位（1Hz 采样率）
- 轨迹点平滑处理
- GPS 漂移过滤
- 后台定位支持

#### HarmonyOS 实现
```typescript
// platforms/harmonyos/services/LocationService.ts
import geolocationManager from '@ohos.geoLocationManager';

export class LocationService {
  private tracking: boolean = false;
  private trackPoints: TrackPoint[] = [];
  
  async startTracking(callback: (point: TrackPoint) => void): Promise<void> {
    const request = {
      priority: geolocationManager.LocationRequestPriority.ACCURACY,
      interval: 1000,
      distanceInterval: 5 // 至少 5 米才记录
    };
    
    geolocationManager.on('locationChange', request, (location) => {
      const point = this.filterGPSDrift({
        latitude: location.latitude,
        longitude: location.longitude,
        altitude: location.altitude,
        accuracy: location.accuracy,
        speed: location.speed,
        timestamp: Date.now()
      });
      
      if (point) {
        callback(point);
        this.trackPoints.push(point);
      }
    });
  }
  
  private filterGPSDrift(rawPoint: TrackPoint): TrackPoint | null {
    // 过滤 GPS 漂移
    if (rawPoint.accuracy > 50) return null; // 精度太低
    
    const lastPoint = this.trackPoints[this.trackPoints.length - 1];
    if (lastPoint) {
      const distance = this.calculateDistance(lastPoint, rawPoint);
      const timeDiff = rawPoint.timestamp - lastPoint.timestamp;
      
      // 速度异常检测
      const speed = distance / (timeDiff / 1000);
      if (speed > 20) return null; // 超过 20m/s 不合理
    }
    
    return rawPoint;
  }
  
  async stopTracking(): Promise<void> {
    geolocationManager.off('locationChange');
    this.tracking = false;
  }
}
```

#### iOS 实现
```swift
// platforms/ios/Swift/LocationService.swift
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var trackPoints: [TrackPoint] = []
    
    func startTracking(callback: @escaping (TrackPoint) -> Void) {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 5.0
        locationManager.allowsBackgroundLocationUpdates = true
        locationManager.startUpdatingLocation()
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let point = self.filterGPSDrift(location)
        callback(point)
    }
}
```

---

### 2. MetricsService - 数据采集服务

#### 功能
- 距离计算（Haversine 公式）
- 配速计算（时间/距离）
- 步频计算（步数/时间）
- 心率监测
- 卡路里消耗计算

#### 跨平台模型
```typescript
// common/models/Metrics.ts
export interface Metrics {
  distance: number;        // 米
  duration: number;        // 秒
  pace: number;           // 秒/公里
  cadence: number;        // 步/分钟
  heartRate: number;      // BPM
  calories: number;       // 卡路里
  elevationGain: number;   // 爬升高度（米）
}

export class MetricsService {
  calculateMetrics(trackPoints: TrackPoint[], steps: number): Metrics {
    const distance = this.calculateTotalDistance(trackPoints);
    const duration = trackPoints.length > 0 
      ? (trackPoints[trackPoints.length - 1].timestamp - trackPoints[0].timestamp) / 1000 
      : 0;
    
    return {
      distance,
      duration,
      pace: duration > 0 && distance > 0 ? duration / (distance / 1000) : 0,
      cadence: duration > 0 ? (steps / duration) * 60 : 0,
      heartRate: this.getAverageHeartRate(),
      calories: this.calculateCalories(distance, duration),
      elevationGain: this.calculateElevationGain(trackPoints)
    };
  }
  
  private calculateCalories(distance: number, duration: number): number {
    // 跑步卡路里公式：距离(km) × 体重(kg) × 1.036
    // 假设体重 65kg
    return (distance / 1000) * 65 * 1.036;
  }
}
```

---

### 3. MetronomeService - 智能节拍器

#### 功能
- 自定义 BPM（120-200）
- 节拍音频播放
- 语音提示（每公里/配速提醒）
- 后台播放支持

#### HarmonyOS 实现
```typescript
// platforms/harmonyos/services/MetronomeService.ts
import media from '@ohos.multimedia.media';

export class MetronomeService {
  private avPlayer: media.AVPlayer;
  private isPlaying: boolean = false;
  private beatInterval: number = -1;
  
  async start(bpm: number, voicePrompt: boolean = false): Promise<void> {
    this.avPlayer = await media.createAVPlayer();
    this.isPlaying = true;
    
    const intervalMs = 60000 / bpm;
    let beatCount = 0;
    
    const playBeat = async () => {
      if (!this.isPlaying) return;
      
      // 播放节拍音效
      this.avPlayer.url = 'resource://rawfile/metronome_beep.mp3';
      await this.avPlayer.play();
      
      // 语音提示（每公里）
      if (voicePrompt && beatCount % Math.floor(60000 / intervalMs) === 0) {
        this.playVoicePrompt(beatCount);
      }
      
      beatCount++;
    };
    
    playBeat();
    this.beatInterval = setInterval(playBeat, intervalMs);
  }
  
  async playVoicePrompt(km: number): Promise<void> {
    // 使用 TTS 播报当前距离和配速
    const text = `已跑${km}公里，保持配速`;
    await this.ttsSpeak(text);
  }
}
```

---

### 4. StorageService - 数据存储服务

#### 功能
- 跑步记录持久化
- 历史数据查询
- 数据统计分析
- 云端同步（可选）

#### HarmonyOS 实现
```typescript
// platforms/harmonyos/services/StorageService.ts
import { preferences } from '@kit.ArkData';

export class StorageService {
  private pref: preferences.Preferences;
  
  async initialize(): Promise<void> {
    this.pref = await preferences.getPreferences(getContext(), 'running_tracker');
  }
  
  async saveRun(record: RunRecord): Promise<void> {
    const records = await this.getAllRuns();
    records.unshift(record);
    
    const recordsJson = JSON.stringify(records);
    this.pref.put('run_records', recordsJson);
    await this.pref.flush();
  }
  
  async getAllRuns(): Promise<RunRecord[]> {
    const recordsJson = this.pref.get('run_records', '[]') as string;
    return JSON.parse(recordsJson);
  }
  
  async getStatistics(days: number = 7): Promise<Statistics> {
    const records = await this.getAllRuns();
    const recentRecords = records.filter(r => 
      Date.now() - r.startTime < days * 24 * 60 * 60 * 1000
    );
    
    return {
      totalRuns: recentRecords.length,
      totalDistance: recentRecords.reduce((sum, r) => sum + r.metrics.distance, 0),
      totalDuration: recentRecords.reduce((sum, r) => sum + r.metrics.duration, 0),
      averagePace: this.calculateAverage(recentantRecords.map(r => r.metrics.pace)),
      averageHeartRate: this.calculateAverage(recentantRecords.map(r => r.metrics.heartRate))
    };
  }
}
```

---

### 5. TrainingPlanService - 跑步计划制定

#### 功能
- 分析历史数据
- 生成个性化训练计划
- 进度追踪

#### 训练计划算法
```typescript
// common/models/TrainingPlan.ts
export interface TrainingPlan {
  weeklyGoal: number;        // 周目标（公里）
  schedule: WorkoutSchedule[];
  tips: string[];
}

export class TrainingPlanService {
  generatePlan(userLevel: string, history: RunRecord[]): TrainingPlan {
    const avgDistance = this.getAverageDistance(history);
    
    return {
      weeklyGoal: this.calculateGoal(userLevel, avgDistance),
      schedule: this.createSchedule(userLevel, avgDistance),
      tips: this.generateTips(userLevel)
    };
  }
  
  private calculateGoal(level: string, avgDistance: number): number {
    const baseGoals = {
      'beginner': 10,    // 新手 10km/周
      'intermediate': 20, // 中级 20km/周
      'advanced': 40      // 高级 40km/周
    };
    
    const goal = baseGoals[level] || 20;
    return Math.max(goal, avgDistance * 1.2); // 目标比当前提高 20%
  }
  
  private createSchedule(level: string, avgDistance: number): WorkoutSchedule[] {
    // 根据水平生成周计划
    const runsPerWeek = level === 'beginner' ? 3 : 4;
    const distancePerRun = avgDistance * 1.1;
    
    const schedule: WorkoutSchedule[] = [];
    const days = ['周一', '周三', '周五', '周日'];
    
    for (let i = 0; i < runsPerWeek; i++) {
      schedule.push({
        day: days[i],
        type: i % 2 === 0 ? 'steady' : 'interval',
        distance: distancePerRun,
        warmup: 10,
        cooldown: 10
      });
    }
    
    return schedule;
  }
}
```

---

## 📱 用户交互流程

### 跑步流程

```
1. 打开应用
   ↓
2. 查看今日目标（首页）
   ↓
3. 点击"开始跑步"
   ├── 请求 GPS 权限
   ├── 启动定位服务
   ├── 启动节拍器（可选）
   └── 进入跑步页面
   ↓
4. 跑步中
   ├── 实时显示：距离、时间、配速、心率
   ├── 地图显示轨迹
   ├── 节拍器播放
   └── 语音提示
   ↓
5. 完成/暂停
   ├── 暂停：保存当前状态
   └── 完成：结束跑步，保存记录
   ↓
6. 跑步总结
   ├── 显示本次数据
   ├── 生成绩效图表
   └── 提供分享选项
   ↓
7. 后续操作
   ├── 查看历史记录
   ├── 分享到社交平台
   ├── 更新跑步计划
   └── 分析进步
```

---

## 🔧 配置文件

### 技能配置
```json
// config/skill-config.json
{
  "name": "小白快跑",
  "version": "2.0.0",
  "platforms": ["harmonyos", "ios"],
  "features": {
    "gps_tracking": {
      "enabled": true,
      "accuracy": "high",
      "interval_ms": 1000,
      "background_support": true
    },
    "metrics": {
      "distance": true,
      "duration": true,
      "pace": true,
      "cadence": true,
      "heart_rate": true,
      "calories": true,
      "elevation": true
    },
    "metronome": {
      "bpm_range": [120, 200],
      "voice_prompt": true,
      "background_play": true
    },
    "sharing": {
      "platforms": ["wechat", "weibo", "qq", "instagram", "strava"],
      "report_image": true
    },
    "training": {
      "auto_plan": true,
      "weekly_goal": true,
      "progress_tracking": true
    }
  },
  "permissions": {
    "harmonyos": [
      "ohos.permission.LOCATION",
      "ohos.permission.APPROXIMATELY_LOCATION",
      "ohos.permission.ACTIVITY_MOTION",
      "ohos.permission.INTERNET",
      "ohos.permission.NOTIFICATION_CONTROLLER"
    ],
    "ios": [
      "NSLocationWhenInUseUsageDescription",
      "NSLocationAlwaysAndWhenInUseUsageDescription",
      "NSMotionUsageDescription"
    ]
  },
  "battery_optimization": {
    "gps_mode": "adaptive",
    "screen_off": true,
    "location_interval": "dynamic"
  }
}
```

---

## 🔌 API 调用逻辑

### 1. GPS 定位 API

#### HarmonyOS
```typescript
import geolocationManager from '@ohos.geoLocationManager';

// 高精度定位
const request = {
  priority: geolocationManager.LocationRequestPriority.ACCURACY,
  interval: 1000,
  distanceInterval: 5
};

geolocationManager.on('locationChange', request, callback);
```

#### iOS
```swift
let locationManager = CLLocationManager()
locationManager.desiredAccuracy = kCLLocationAccuracyBest
locationManager.distanceFilter = 5.0
locationManager.startUpdatingLocation()
```

### 2. 心率监测 API

#### HarmonyOS
```typescript
import sensor from '@ohos.sensor';

// 健康传感器（心率）
sensor.on(sensor.SensorId.HEART_RATE, (data) => {
  console.log('Heart rate:', data.heartRate);
});
```

#### iOS
```swift
import HealthKit

let healthStore = HKHealthStore()
let heartRateType = HKObjectType.quantityType(forIdentifier: HKQuantityTypeIdentifierHeartRate)

healthStore.query([heartRateType], HKQueryOptionNone) { samples, error in
    // 处理心率数据
}
```

---

## 🗄️ 数据存储方案

### 本地存储

#### HarmonyOS
```typescript
// 使用 Preferences API
import { preferences } from '@kit.ArkData';

const pref = await preferences.getPreferences(context, 'running_tracker');
pref.put('run_records', JSON.stringify(records));
await pref.flush();
```

#### iOS
```swift
// 使用 Core Data
import CoreData

let context = (UIApplication.shared.delegate as? AppDelegate)?.persistentContainer.viewContext
let entity = NSEntityDescription.entity(forEntityName: "RunRecord", in: context)
```

### 云端同步（可选）

```typescript
// 支持华为云 + iCloud
export class CloudSyncService {
  async syncToCloud(record: RunRecord): Promise<void> {
    // HarmonyOS: 华为云
    if (platform === 'harmonyos') {
      await this.syncToHuaweiCloud(record);
    }
    // iOS: iCloud
    else if (platform === 'ios') {
      await this.syncToICloud(record);
    }
  }
}
```

---

## 🔋 电池优化策略

### 1. 自适应 GPS 采样
- 室内：降低采样频率到 5Hz
- 室外：正常采样 1Hz
- 暂停时：完全停止定位

### 2. 屏幕管理
- 跑步时：允许屏幕关闭
- 显示：关键数据（距离、时间、配速）
- 后台：仅音频提示

### 3. 传感器管理
- 根据需要启用/禁用传感器
- 心率传感器仅在跑步时启用
- 步频传感器持续运行（低功耗）

---

## 📊 数据分析功能

### 统计分析
```typescript
export class AnalyticsService {
  async getWeeklyStats(): Promise<WeeklyStats> {
    const records = await storageService.getWeeklyRuns();
    
    return {
      totalDistance: records.reduce((sum, r) => sum + r.metrics.distance, 0),
      totalDuration: records.reduce((sum, r) => sum + r.metrics.duration, 0),
      averagePace: this.calculateAverage(records.map(r => r.metrics.pace)),
      bestPace: Math.min(...records.map(r => r.metrics.pace)),
      longestRun: Math.max(...records.map(r => r.metrics.distance)),
      totalCalories: records.reduce((sum, r) => sum + r.metrics.calories, 0)
    };
  }
  
  async getMonthlyProgress(): Promise<Progress> {
    // 月度进度分析
    const thisMonth = await this.getRunsInMonth(new Date());
    const lastMonth = await this.getRunsInMonth(
      new Date(new Date().setMonth(new Date().getMonth() - 1))
    );
    
    return {
      distance: this.calculateGrowth(thisMonth, lastMonth),
      pace: this.calculateImprovement(thisMonth, lastMonth),
      consistency: this.calculateConsistency(thisMonth)
    };
  }
}
```

---

## 🤖 智能推荐算法

### 个性化训练计划生成

```typescript
export class RecommendationService {
  generatePlan(user: UserProfile, history: RunRecord[]): TrainingPlan {
    const userLevel = this.assessLevel(user, history);
    const goals = this.setGoals(userLevel, history);
    const schedule = this.createSchedule(goals);
    
    return {
      weeklyGoal: goals.weekly,
      schedule,
      tips: this.generateTips(userLevel),
      milestones: this.setMilestones(goals)
    };
  }
  
  private assessLevel(user: UserProfile, history: RunRecord[]): string {
    const avgDistance = this.getAverageDistance(history);
    
    if (avgDistance < 5) return 'beginner';
    if (avgDistance < 15) return 'intermediate';
    return 'advanced';
  }
}
```

---

## 📤 社交分享功能

### 分享平台
```typescript
export enum SharePlatform {
  WECHAT = 'wechat',
  WEIBO = 'weibo',
  QQ = 'qq',
  INSTAGRAM = 'instagram',
  STRAVA = 'strava'
}

export class SocialShareService {
  async share(platform: SharePlatform, data: ShareData): Promise<void> {
    switch (platform) {
      case SharePlatform.WECHAT:
        await this.shareToWeChat(data);
        break;
      case SharePlatform.STRAVA:
        await this.shareToStrava(data);
        break;
      // ... 其他平台
    }
  }
  
  async generateReportImage(run: RunRecord): Promise<string> {
    // 生成跑步报告图片
    return ReportGenerator.generate(run);
  }
}
```

---

## 🔒 权限配置

### HarmonyOS 权限
```json5
// platforms/harmonyos/module.json5
{
  "module": {
    "requestPermissions": [
      {
        "name": "ohos.permission.LOCATION",
        "reason": "需要定位权限记录跑步轨迹"
      },
      {
        "name": "ohos.permission.ACTIVITY_MOTION",
        "reason": "需要传感器权限采集运动数据"
      },
      {
        "name": "ohos.permission.NOTIFICATION_CONTROLLER",
        "reason": "需要通知权限发送跑步提醒"
      },
      {
        "name": "ohos.permission.INTERNET",
        "reason": "需要网络权限同步数据和分享"
      }
    ]
  }
}
```

### iOS 权限
```xml
<!-- platforms/ios/Info.plist -->
<key>NSLocationWhenInUseUsageDescription</key>
<string>需要定位权限记录跑步轨迹</string>
<key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
<string>需要后台定位权限持续记录</string>
<key>NSMotionUsageDescription</key>
<string>需要运动传感器权限采集数据</string>
<key>NSHealthShareUsageDescription</key>
<string>需要健康数据权限同步心率信息</string>
<key>NSHealthUpdateUsageDescription</key>
<string>需要健康数据权限记录运动数据</string>
```

---

## 📐 API 接口规范

### 数据模型
```typescript
// common/models/RunRecord.ts
export interface RunRecord {
  id: string;
  startTime: number;
  endTime: number;
  trackPoints: TrackPoint[];
  metrics: Metrics;
  userSettings: UserSettings;
  deviceId: string;
  synced: boolean;
}

export interface TrackPoint {
  latitude: number;
  longitude: number;
  altitude: number;
  timestamp: number;
  accuracy: number;
  speed: number;
  heartRate?: number;
}

export interface Metrics {
  distance: number;
  duration: number;
  pace: number;
  cadence: number;
  heartRate: number;
  calories: number;
  elevationGain: number;
}
```

---

## 🚀 部署说明

### HarmonyOS 部署
1. 使用 DevEco Studio 创建项目
2. 复制 `platforms/harmonyos/` 代码
3. 配置 `module.json5` 权限
4. 构建生成 HAP 包
5. 上传到华为应用市场

### iOS 部署
1. 使用 Xcode 创建项目
2. 复制 `platforms/ios/` 代码
3. 配置 `Info.plist` 权限
4. 签名打包 IPA 文件
5. 上传到 App Store

---

## 📚 文档清单

- `SKILL.md` - 技能主文档（本文件）
- `README.md` - 使用说明
- `docs/API.md` - API 接口文档
- `docs/ARCHITECTURE.md` - 架构设计文档
- `docs/PLATFORMS.md` - 平台适配指南
- `docs/DEPLOYMENT.md` - 部署指南

---

## 🎯 快速开始

### HarmonyOS
```typescript
// 1. 初始化服务
const locationService = new LocationService();
const metricsService = new MetricsService();
const metronomeService = new MetronomeService();

// 2. 开始跑步
await locationService.startTracking((point) => {
  console.log('GPS:', point);
});

// 3. 启动节拍器
await metronomeService.start(160, true);

// 4. 采集数据
const metrics = metricsService.calculateMetrics(trackPoints, steps);

// 5. 保存记录
await storageService.saveRun(record);
```

### iOS
```swift
// 1. 初始化服务
let locationService = LocationService()
let metricsService = MetricsService()

// 2. 开始跑步
locationService.startTracking { point in
    print("GPS: \(point)")
}

// 3. 保存记录
storageService.saveRun(record: record)
```

---

**最后更新**: 2026-03-14  
**作者**: 小白  
**版本**: v2.0.0