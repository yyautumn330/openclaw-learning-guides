# 跑步轨迹记录架构设计

## 1. 整体架构

```
┌─────────────────────────────────────────────────────────────┐
│                       UI 层                                  │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐         │
│  │ RunPage     │  │ TrajectoryMap│  │ RunStats   │         │
│  │ (跑步页面)   │  │ (轨迹地图)   │  │ (运动统计)  │         │
│  └─────────────┘  └─────────────┘  └─────────────┘         │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      服务层                                  │
│  ┌──────────────────────────────────────────────────────┐   │
│  │              RunTrackerService                        │   │
│  │  - 轨迹记录控制                                        │   │
│  │  - 状态管理                                           │   │
│  │  - 事件分发                                           │   │
│  └──────────────────────────────────────────────────────┘   │
│  ┌────────────────┐  ┌────────────────┐  ┌──────────────┐   │
│  │ LocationService│  │ TrajectoryStore│  │ GPXService   │   │
│  │ (定位服务)      │  │ (轨迹存储)     │  │ (GPX导出)    │   │
│  └────────────────┘  └────────────────┘  └──────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                      数据层                                  │
│  ┌────────────────┐  ┌────────────────┐  ┌──────────────┐   │
│  │ TrajectoryModel│  │ RunRecord      │  │ TrajectoryPoint│   │
│  │ (轨迹模型)      │  │ (运动记录)     │  │ (轨迹点)      │   │
│  └────────────────┘  └────────────────┘  └──────────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                     存储层                                   │
│  ┌────────────────┐  ┌────────────────┐                    │
│  │ Preferences    │  │ 文件系统        │                    │
│  │ (配置/状态)     │  │ (GPX/JSON)     │                    │
│  └────────────────┘  └────────────────┘                    │
└─────────────────────────────────────────────────────────────┘
```

## 2. 数据模型

### 2.1 轨迹点 (TrajectoryPoint)
```typescript
interface TrajectoryPoint {
  // 基础信息
  id: string;                 // 唯一ID
  timestamp: number;          // 时间戳 (ms)
  
  // 位置信息
  latitude: number;           // 纬度
  longitude: number;          // 经度
  altitude: number;           // 海拔 (米)
  accuracy: number;           // 精度 (米)
  
  // 运动信息
  speed: number;              // 速度 (m/s)
  bearing: number;            // 方向 (度, 0-360)
  distance: number;           // 累计距离 (米)
  
  // 状态标记
  locationType: 'gps' | 'network' | 'cached';  // 定位类型
  isKeyPoint: boolean;        // 是否为关键点
  keyPointType?: KeyPointType; // 关键点类型
}

type KeyPointType = 'start' | 'end' | 'pause' | 'resume' | 'milestone' | 'turn';
```

### 2.2 运动记录 (RunRecord)
```typescript
interface RunRecord {
  id: string;                 // 记录ID
  startTime: number;          // 开始时间
  endTime: number;            // 结束时间
  duration: number;           // 时长 (秒)
  
  // 距离统计
  totalDistance: number;      // 总距离 (米)
  directDistance: number;     // 直线距离 (米)
  
  // 速度统计
  avgSpeed: number;           // 平均速度 (m/s)
  maxSpeed: number;           // 最高速度 (m/s)
  avgPace: string;            // 平均配速 (mm:ss/km)
  
  // 卡路里
  calories: number;           // 消耗卡路里
  
  // 轨迹信息
  pointCount: number;         // 轨迹点数量
  keyPoints: KeyPoint[];      // 关键点列表
  
  // 天气信息
  weather?: {
    temperature: number;      // 温度
    humidity: number;         // 湿度
    condition: string;        // 天气状况
  };
  
  // 文件路径
  gpxPath?: string;           // GPX文件路径
  jsonPath?: string;          // JSON文件路径
}
```

### 2.3 关键点 (KeyPoint)
```typescript
interface KeyPoint {
  id: string;
  type: KeyPointType;
  timestamp: number;
  location: {
    latitude: number;
    longitude: number;
  };
  
  // 类型特定数据
  milestone?: number;         // 里程碑公里数
  pauseDuration?: number;     // 暂停时长
  turnAngle?: number;         // 转弯角度
}
```

## 3. 服务设计

### 3.1 RunTrackerService (主服务)
```typescript
class RunTrackerService {
  // 状态
  private state: 'idle' | 'running' | 'paused';
  private currentRecord: RunRecord | null;
  private trajectory: TrajectoryPoint[];
  
  // 方法
  async startTracking(): Promise<void>;
  async pauseTracking(): Promise<void>;
  async resumeTracking(): Promise<void>;
  async stopTracking(): Promise<RunRecord>;
  
  // 事件
  on(event: 'locationUpdate', callback: (point: TrajectoryPoint) => void);
  on(event: 'milestone', callback: (km: number) => void);
  on(event: 'stateChange', callback: (state: State) => void);
}
```

### 3.2 LocationService (定位服务)
```typescript
class LocationService {
  // 配置
  private config: LocationConfig;
  
  // 方法
  async requestPermission(): Promise<boolean>;
  async startLocationUpdates(): Promise<void>;
  async stopLocationUpdates(): Promise<void>;
  
  // 定位策略
  private switchToNetworkLocation(): void;
  private handleSignalWeak(): void;
}
```

### 3.3 TrajectoryStore (存储服务)
```typescript
class TrajectoryStore {
  // 方法
  async savePoint(point: TrajectoryPoint): Promise<void>;
  async saveRecord(record: RunRecord): Promise<void>;
  async loadRecord(id: string): Promise<RunRecord>;
  async listRecords(): Promise<RunRecord[]>;
  async deleteRecord(id: string): Promise<void>;
  
  // 缓存
  async cacheCurrentTrajectory(): Promise<void>;
  async recoverTrajectory(): Promise<TrajectoryPoint[]>;
}
```

### 3.4 GPXService (导出服务)
```typescript
class GPXService {
  async exportGPX(record: RunRecord, trajectory: TrajectoryPoint[]): Promise<string>;
  async importGPX(filePath: string): Promise<{ record: RunRecord; trajectory: TrajectoryPoint[] }>;
}
```

## 4. 地图集成

### 4.1 高德地图轨迹渲染
```typescript
// 使用高德静态地图 API 渲染轨迹
class TrajectoryMapRenderer {
  // 生成轨迹地图图片 URL
  generateMapUrl(trajectory: TrajectoryPoint[]): string;
  
  // 计算地图边界
  calculateBounds(trajectory: TrajectoryPoint[]): BoundingBox;
  
  // 编码轨迹路径
  encodePath(trajectory: TrajectoryPoint[]): string;
}
```

### 4.2 地图 URL 生成
```
https://restapi.amap.com/v3/staticmap?
  location=116.481485,39.990464
  &zoom=15
  &size=750*350
  &paths=10,0x0000ff,1,,:116.31604,39.96491;116.320816,39.966606;...
  &key=YOUR_KEY
```

## 5. 状态机

```
         ┌──────────┐
         │   IDLE   │
         └────┬─────┘
              │ startTracking()
              ▼
         ┌──────────┐
    ┌───►│ RUNNING  │◄───┐
    │    └────┬─────┘    │
    │         │ pause()  │ resume()
    │         ▼          │
    │    ┌──────────┐    │
    └────│ PAUSED   │────┘
         └────┬─────┘
              │ stopTracking()
              ▼
         ┌──────────┐
         │   IDLE   │
         └──────────┘
```

## 6. 文件存储结构

```
/data/storage/el2/base/
└── running/
    ├── records/                    # 运动记录
    │   ├── record_20260315_153800.json
    │   └── record_20260315_153800.gpx
    ├── cache/                      # 缓存
    │   └── current_trajectory.json # 当前轨迹缓存
    └── config.json                 # 配置
```

## 7. 关键算法

### 7.1 距离计算 (Haversine 公式)
```typescript
function calculateDistance(
  lat1: number, lon1: number,
  lat2: number, lon2: number
): number {
  const R = 6371000; // 地球半径 (米)
  const dLat = (lat2 - lat1) * Math.PI / 180;
  const dLon = (lon2 - lon1) * Math.PI / 180;
  const a = Math.sin(dLat/2) * Math.sin(dLat/2) +
            Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
            Math.sin(dLon/2) * Math.sin(dLon/2);
  const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1-a));
  return R * c;
}
```

### 7.2 配速计算
```typescript
function calculatePace(distance: number, duration: number): string {
  const paceSeconds = duration / (distance / 1000); // 秒/公里
  const minutes = Math.floor(paceSeconds / 60);
  const seconds = Math.floor(paceSeconds % 60);
  return `${minutes}:${seconds.toString().padStart(2, '0')}`;
}
```

### 7.3 卡路里计算
```typescript
function calculateCalories(
  distance: number,    // 米
  duration: number,    // 秒
  weight: number = 70  // 公斤
): number {
  // MET 值：跑步约 9.1
  const MET = 9.1;
  const hours = duration / 3600;
  return MET * weight * hours;
}
```

### 7.4 轨迹点过滤
```typescript
function filterTrajectoryPoints(
  points: TrajectoryPoint[],
  minAccuracy: number = 30,   // 最大允许精度
  maxSpeed: number = 20       // 最大允许速度 (m/s)
): TrajectoryPoint[] {
  return points.filter((point, index, arr) => {
    // 过滤精度差的点
    if (point.accuracy > minAccuracy) return false;
    
    // 过滤速度异常的点
    if (index > 0) {
      const prev = arr[index - 1];
      const distance = calculateDistance(
        prev.latitude, prev.longitude,
        point.latitude, point.longitude
      );
      const timeDiff = (point.timestamp - prev.timestamp) / 1000;
      const speed = distance / timeDiff;
      if (speed > maxSpeed) return false;
    }
    
    return true;
  });
}
```

## 8. 错误处理

| 场景 | 处理 |
|------|------|
| 定位权限未授予 | 提示授权，进入"模拟模式" |
| GPS信号弱 | 自动切换网络定位 |
| 定位失败 | 使用最后位置 + 提示 |
| 存储空间不足 | 清理旧记录 |
| 应用被杀死 | 恢复缓存轨迹 |

## 9. 性能优化

- **轨迹点缓冲**: 每10个点批量写入
- **地图渲染**: 使用静态地图API，避免实时渲染
- **距离计算**: 增量计算，避免全量遍历
- **内存管理**: 限制内存中轨迹点数量

---

*设计时间: 2026-03-15*