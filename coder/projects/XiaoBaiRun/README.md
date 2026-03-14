# 小白快跑技能包 - 使用指南

> **版本**: v2.0.0  
> **平台**: 鸿蒙 (HarmonyOS) + iOS  
> **最后更新**: 2026-03-14

---

## 🚀 快速开始

### HarmonyOS 平台

#### 1. 初始化项目
```typescript
import { LocationService } from './services/LocationService';
import { MetricsService } from './services/MetricsService';
import { MetronomeService } from './services/MetronomeService';
import { StorageService } from './services/StorageService';

// 初始化服务
const locationService = new LocationService();
const metricsService = new MetricsService();
const metronomeService = new MetronomeService();
const storageService = new StorageService();

// 初始化存储
await storageService.initialize();
```

#### 2. 开始跑步
```typescript
// 开始跑步
async startRun() {
  // 启动 GPS 定位
  await locationService.startTracking((point) => {
    console.info('GPS:', point);
    
    // 更新 UI 显示
    this.updateDistance(metricsService.calculateTotalDistance(this.trackPoints));
  });
  
  // 启动节拍器
  await metronomeService.start(160, true); // 160 BPM, 开启语音提示
  
  // 开始计时
  this.startTimer();
  
  ToastComponent.success('开始跑步', 2000);
}
```

#### 3. 完成跑步
```typescript
async finishRun() {
  // 停止定位
  await locationService.stopTracking();
  
  // 停止节拍器
  await metronomeService.stop();
  
  // 计算最终数据
  const metrics = metricsService.calculateMetrics(
    this.trackPoints, 
    this.steps
  );
  
  // 保存记录
  const record: RunRecord = {
    id: generateUUID(),
    startTime: this.startTime,
    endTime: Date.now(),
    trackPoints: this.trackPoints,
    metrics,
    synced: false
  };
  
  await storageService.saveRun(record);
  
  // 显示总结页面
  router.pushUrl('pages/SummaryPage', {
    record: JSON.stringify(record)
  });
}
```

#### 4. 查看历史记录
```typescript
async loadHistory() {
  const records = await storageService.getAllRuns();
  
  this.records = records.map(record => ({
    ...record,
    date: formatDate(record.startTime),
    distanceKm: (record.metrics.distance / 1000).toFixed(2),
    paceMin: Math.floor(record.metrics.pace / 60),
    paceSec: Math.floor(record.metrics.pace % 60)
  }));
}
```

---

### iOS 平台

#### 1. 初始化项目
```swift
import LocationService
import MetricsService
import MetronomeService
import StorageService

// 初始化服务
let locationService = LocationService()
let metricsService = MetricsService()
let metronomeService = MetronomeService()
let storageService = StorageService()

// 初始化 Core Data
storageService.initialize()
```

#### 2. 开始跑步
```swift
func startRun() {
    // 启动 GPS 定位
    locationService.startTracking { point in
        print("GPS: \(point)")
        
        DispatchQueue.main.async {
            self.updateDistance(metricsService.calculateTotalDistance(self.trackPoints))
        }
    }
    
    // 启动节拍器
    metronomeService.start(bpm: 160, voicePrompt: true)
    
    // 开始计时
    startTimer()
}
```

---

## 📊 功能使用示例

### GPS 轨迹记录

#### 基础用法
```typescript
// 高精度定位
await locationService.startTracking((point) => {
  console.info('GPS Update:', {
    lat: point.latitude,
    lng: point.longitude,
    acc: point.accuracy
  });
});
```

#### 自定义配置
```typescript
// 自定义定位参数
await locationService.startTracking((point) => {
  // 处理定位回调
}, {
  interval: 2000,        // 2秒间隔
  distanceInterval: 10, // 至少 10 米才记录
  accuracy: 'high',      // 高精度模式
  backgroundMode: true   // 支持后台
});
```

---

### 数据采集

#### 完整指标计算
```typescript
// 采集所有指标
async collectMetrics() {
  const trackPoints = await this.getTrackPoints();
  const steps = await this.getSteps();
  const heartRate = await this.getHeartRate();
  
  const metrics = metricsService.calculateMetrics(
    trackPoints,
    steps,
    heartRate
  );
  
  return {
    distance: metrics.distance,
    duration: metrics.duration,
    pace: metrics.pace,
    cadence: metrics.cadence,
    heartRate: metrics.heartRate,
    calories: metrics.calories,
    elevationGain: metrics.elevationGain
  };
}
```

---

### 智能节拍器

#### 自定义 BPM
```typescript
// 根据配速自动计算 BPM
function calculateBPM(pace: number): number {
  const paceMin = pace / 60;
  const paceSec = pace % 60;
  
  // 估算 BPM：180 / (分钟数 + 秒数/60)
  return Math.round(180 / (paceMin + paceSec / 60));
}

// 使用自动 BPM
const pace = 360; // 6分钟/公里
const bpm = calculateBPM(pace);
await metronomeService.start(bpm, true);
```

#### 语音提示配置
```typescript
await metronomeService.start(160, {
  voicePrompt: true,
  intervalKm: 1,
  language: 'zh-CN',
  voice: 'female',
  messages: {
    everyKm: '已跑{n}公里，保持配速',
    halfway: '已经一半，加油！',
    final: '最后1公里，冲刺！'
  }
});
```

---

### 社交分享

#### 生成报告图片
```typescript
import { ReportGenerator } from './components/ReportGenerator';

// 生成跑步报告
async generateReport(record: RunRecord): Promise<string> {
  const reportImage = await ReportGenerator.generate({
    record,
    template: 'minimal',
    includeChart: true,
    includeMap: true
  });
  
  return reportImage;
}

// 分享到微信
async shareToWeChat(record: RunRecord) {
  const reportImage = await this.generateReport(record);
  
  await SocialShareService.share(SharePlatform.WECHAT, {
    title: '我的跑步记录',
    description: `跑步 ${record.metrics.distance}米，用时 ${formatDuration(record.metrics.duration)}`,
    image: reportImage
  });
}
```

---

### 跑步计划

#### 生成个性化计划
```typescript
import { TrainingPlanService } from './services/TrainingPlanService';

// 生成训练计划
async generatePlan(userLevel: string): Promise<TrainingPlan> {
  const history = await storageService.getAllRuns();
  
  const plan = TrainingPlanService.generatePlan({
    level: userLevel,
    history
  });
  
  // 保存计划
  await storageService.savePlan(plan);
  
  return plan;
}

// 查看本周计划
async getWeeklySchedule(): Promise<WorkoutSchedule[]> {
  const plan = await storageService.getCurrentPlan();
  return plan.schedule;
}
```

---

## 🔋 电池优化

### 自适应定位模式
```typescript
// 根据电池状态调整定位频率
async optimizeGPS(batteryLevel: number) {
  if (batteryLevel < 20) {
    // 低电量模式：降低采样频率
    await locationService.updateConfig({
      interval: 5000,      // 5秒
      accuracy: 'low'
    });
  } else if (batteryLevel < 50) {
    // 中等电量：正常模式
    await locationService.updateConfig({
      interval: 2000,      // 2秒
      accuracy: 'medium'
    });
  } else {
    // 高电量：高精度模式
    await locationService.updateConfig({
      interval: 1000,      // 1秒
      accuracy: 'high'
    });
  }
}
```

---

## 📈 数据分析

### 周统计
```typescript
async getWeeklyStats() {
  const stats = await analyticsService.getWeeklyStats();
  
  console.info('本周统计:', {
    总距离: (stats.totalDistance / 1000).toFixed(2) + 'km',
    总时长: formatDuration(stats.totalDuration),
    平均配速: formatPace(stats.averagePace),
    最佳配速: formatPace(stats.bestPace),
    最长距离: (stats.longestRun / 1000).toFixed(2) + 'km',
    总卡路里: stats.totalCalories.toFixed(0) + 'kcal'
  });
  
  return stats;
}
```

### 进度追踪
```typescript
async getProgress() {
  const progress = await analyticsService.getMonthlyProgress();
  
  return {
    distanceGrowth: progress.distance > 0 ? '+' + progress.distance.toFixed(1) + '%' : progress.distance.toFixed(1) + '%',
    paceImprovement: progress.pace > 0 ? '提升' + progress.pace.toFixed(1) + '%' : '下降' + Math.abs(progress.pace).toFixed(1) + '%',
    consistency: progress.consistency + '%'
  };
}
```

---

## 🎯 常见问题

### 1. GPS 不定位
**问题**: 定位服务无法启动  
**解决**:
- 检查权限是否授予
- 检查定位服务是否开启
- 确认 `module.json5` 中声明了定位权限

### 2. 节拍器没有声音
**问题**: 节拍器播放无声音  
**解决**:
- 检查 `metronome_beep.mp3` 文件是否存在
- 检查系统音量设置
- 检查是否启用了"勿扰模式"

### 3. 心率数据不准确
**问题**: 心率数据异常  
**解决**:
- 确保佩戴了心率设备
- 检查健康权限是否授予
- 重新启动传感器

### 4. 电池消耗过快
**问题**: 跑步时电池消耗过快  
**解决**:
- 启用电池优化模式
- 降低 GPS 采样频率
- 关闭不必要的传感器

---

## 📚 更多文档

- [API 文档](./docs/API.md) - API 接口详细说明
- [架构文档](./docs/ARCHITECTURE.md) - 架构设计
- [平台适配](./docs/PLATFORMS.md) - 平台适配指南
- [部署指南](./docs/DEPLOYMENT.md) - 部署说明

---

**技术支持**: contact@xiaobai.run  
**问题反馈**: https://github.com/xiaobai/running-tracker/issues