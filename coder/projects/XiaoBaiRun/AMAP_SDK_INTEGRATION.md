# 高德地图 SDK 集成完整指南

**项目**: 小白快跑  
**日期**: 2026-03-13  
**当前状态**: ✅ 占位实现完成，待集成真实 SDK

---

## 📋 目录

1. [申请 API Key](#1-申请-api-key)
2. [下载 SDK](#2-下载-sdk)
3. [配置项目](#3-配置项目)
4. [代码集成](#4-代码集成)
5. [权限说明](#5-权限说明)
6. [真机测试](#6-真机测试)

---

## 1. 申请 API Key

### 步骤

1. **访问高德开放平台**
   - 网址：https://lbs.amap.com/
   - 注册/登录账号（需要手机号）

2. **创建应用**
   - 控制台 → 应用管理 → 我的应用 → 创建新应用
   - 应用名称：`小白快跑`
   - 应用类型：`移动应用`
   - 平台选择：`HarmonyOS`

3. **添加 Key**
   - 应用名称：`XiaoBaiRun`
   - 服务平台：`HarmonyOS`
   - 包名：`com.xiaobai.run`（与项目一致）
   - 安全签名 SHA256：需要生成（见下方）

4. **获取信息**
   - API Key（例：`a1b2c3d4e5f6g7h8i9j0`）
   - Security Code（安全码）

### 生成安全签名

```bash
# 在 DevEco Studio 中
# File → Project Structure → Signing Configs
# 查看 Debug 签名的 SHA256
```

或使用命令行：
```bash
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiRun
keytool -list -v -keystore ~/.android/debug.keystore -alias androiddebugkey -storepass android -keypass android
```

---

## 2. 下载 SDK

### 方式 1: DevEco Studio（推荐）

1. 打开 DevEco Studio
2. File → Project Structure → Dependencies
3. 点击 `+` → `Library Dependency`
4. 搜索 `@amap/map` 或 `Amap Map`
5. 选择最新版本 → Add

### 方式 2: 手动下载

1. 访问：https://lbs.amap.com/api/harmonyos-sdk/download
2. 下载 HarmonyOS 地图 SDK
3. 解压到项目目录

### 方式 3: 通过 ohpm 安装

```bash
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiRun
ohpm install @amap/map
```

---

## 3. 配置项目

### 3.1 build-profile.json5

```json5
{
  "app": {
    "signingConfigs": [],
    "products": [
      {
        "name": "default",
        "signingConfig": "default",
        "compatibleSdkVersion": "6.0.1(21)",
        "runtimeOS": "HarmonyOS"
      }
    ]
  },
  "modules": [
    {
      "name": "entry",
      "srcPath": "./entry",
      "dependencies": [
        {
          "name": "@amap/map",
          "version": "1.0.0"
        }
      ]
    }
  ]
}
```

### 3.2 module.json5

已配置权限（无需修改）：
```json5
"requestPermissions": [
  {
    "name": "ohos.permission.APPROXIMATELY_LOCATION",
    "reason": "$string:location_reason",
    "usedScene": {
      "abilities": ["EntryAbility"],
      "when": "inuse"
    }
  },
  {
    "name": "ohos.permission.LOCATION",
    "reason": "$string:location_reason",
    "usedScene": {
      "abilities": ["EntryAbility"],
      "when": "inuse"
    }
  }
]
```

### 3.3 oh-package.json5

```json5
{
  "name": "xiaobai-run",
  "version": "1.0.0",
  "dependencies": {
    "@amap/map": "^1.0.0"
  }
}
```

---

## 4. 代码集成

### 4.1 更新 MapService.ts

```typescript
import map from '@amap/map';

const TAG = 'MapService';

export class MapService {
  private static instance: MapService;
  private mapInstance: any = null;
  private isInitialized: boolean = false;
  
  private constructor() {}
  
  static getInstance(): MapService {
    if (!MapService.instance) {
      MapService.instance = new MapService();
    }
    return MapService.instance;
  }
  
  async initialize(): Promise<boolean> {
    if (this.isInitialized) {
      return true;
    }
    
    try {
      // 初始化高德地图 SDK
      await map.init({
        key: 'YOUR_API_KEY',
        securityCode: 'YOUR_SECURITY_CODE'
      });
      
      console.info(TAG, 'AMap SDK initialized');
      this.isInitialized = true;
      return true;
    } catch (error) {
      console.error(TAG, 'Initialize error:', error);
      return false;
    }
  }
  
  createMap(containerId: string, options: any): any {
    if (!this.isInitialized) {
      console.error(TAG, 'SDK not initialized');
      return null;
    }
    
    try {
      this.mapInstance = new map.Map(containerId, {
        zoom: options.zoom || 15,
        center: options.center || [116.4074, 39.9042],
        ...options
      });
      
      return this.mapInstance;
    } catch (error) {
      console.error(TAG, 'Create map error:', error);
      return null;
    }
  }
  
  setCenter(lat: number, lng: number): void {
    this.mapInstance?.setCenter([lng, lat]);
  }
  
  addMarker(lat: number, lng: number, title?: string): any {
    const marker = new map.Marker({
      position: [lng, lat],
      title: title || '',
      map: this.mapInstance
    });
    return marker;
  }
  
  addPolyline(points: Array<[number, number]>): any {
    const polyline = new map.Polyline({
      path: points,
      strokeColor: '#FF6B6B',
      strokeWeight: 5,
      map: this.mapInstance
    });
    return polyline;
  }
  
  getMapInstance(): any {
    return this.mapInstance;
  }
}

export const mapService = MapService.getInstance();
```

### 4.2 更新 MapContainer.ets

```typescript
import map from '@amap/map';

@Component
export struct MapContainer {
  @Prop isDarkMode: boolean = false;
  @State zoom: number = 15;
  @State currentLocation: LocationInfo | null = null;
  @State mapInitialized: boolean = false;
  
  private mapController: map.Map | null = null;
  
  async initMap() {
    try {
      await mapService.initialize();
      
      // 创建地图实例
      this.mapController = mapService.createMap('map_container', {
        zoom: this.zoom,
        center: [116.4074, 39.9042] // 北京
      });
      
      this.mapInitialized = true;
      ToastComponent.success('地图已加载', 1500);
    } catch (error) {
      console.error('Map init error:', error);
      ToastComponent.info('地图加载失败', 2000);
    }
  }
  
  locateToCurrent() {
    if (this.currentLocation) {
      this.mapController?.setCenter([
        this.currentLocation.longitude,
        this.currentLocation.latitude
      ]);
      ToastComponent.success('已定位到当前位置', 1500);
    }
  }
  
  // ... 其他方法
}
```

---

## 5. 权限说明

### 已配置权限

| 权限 | 用途 | 触发时机 |
|------|------|---------|
| `ohos.permission.APPROXIMATELY_LOCATION` | 获取大致位置 | 应用启动时 |
| `ohos.permission.LOCATION` | 获取精确位置 | 开始跑步时 |

### 权限请求流程

```
应用启动
    ↓
检查权限状态
    ↓
未授权 → 系统弹窗请求
    ↓
用户选择 允许/拒绝
    ↓
记录权限状态
```

### 在代码中检查权限

```typescript
import { atManager } from '@ohos.accessToken';

async checkPermission(): Promise<boolean> {
  const context = getContext(this) as common.UIAbilityContext;
  
  const tokenID = atManager.getAccessTokenInfo(
    context.bundleName,
    'ohos.permission.APPROXIMATELY_LOCATION'
  );
  
  return tokenID?.accessTokenExisted ?? false;
}
```

---

## 6. 真机测试

### 测试步骤

1. **连接真机**
   - USB 连接手机
   - 开启开发者模式
   - 开启 USB 调试

2. **运行应用**
   - DevEco Studio → 点击运行按钮
   - 选择真机设备
   - 等待安装完成

3. **测试功能**
   - [ ] 应用启动正常
   - [ ] 看到地图界面（不再是宫格）
   - [ ] 系统弹出定位权限请求
   - [ ] 允许权限后显示当前位置
   - [ ] 点击 📍 按钮定位到当前位置
   - [ ] 点击 +/- 缩放地图
   - [ ] 5 个 Tab 切换正常

### 预期效果

**地图显示**:
- 真实街道地图（不再是宫格）
- 当前位置标记（红色圆点）
- 道路、公园、建筑物等

**权限弹窗**:
```
┌─────────────────────────────┐
│   小白快跑想要访问您的位置    │
│                             │
│   用于记录跑步轨迹           │
│                             │
│   [ 拒绝 ]      [ 允许 ]    │
└─────────────────────────────┘
```

---

## 🔧 常见问题

### Q1: 地图不显示

**原因**: SDK 未正确集成或 API Key 无效

**解决**:
1. 检查 `build-profile.json5` 是否添加依赖
2. 检查 API Key 和 Security Code 是否正确
3. 查看日志：`console.info` 输出

### Q2: 权限弹窗不出现

**原因**: 权限已在之前授予或拒绝

**解决**:
1. 设置 → 应用管理 → 小白快跑 → 权限
2. 手动开启位置权限
3. 重新运行应用

### Q3: 定位不准确

**原因**: GPS 信号弱或仅使用网络定位

**解决**:
1. 到开阔地带测试
2. 等待 GPS 信号稳定
3. 检查手机定位服务是否开启

---

## 📞 参考文档

- [高德地图 HarmonyOS SDK](https://lbs.amap.com/api/harmonyos-sdk/summary)
- [HarmonyOS 定位服务](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-geoLocationManager-V5)
- [HarmonyOS 权限管理](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/access-token-V5)
- [DevEco Studio 使用指南](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/deveco-studio-overview-V5)

---

**当前状态**: ✅ 编译通过，待真机测试  
**下一步**: 
1. 申请高德地图 API Key
2. 安装 @amap/map SDK
3. 替换占位实现
4. 真机测试验证
