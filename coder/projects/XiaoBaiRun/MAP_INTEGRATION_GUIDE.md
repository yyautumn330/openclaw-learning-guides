# 高德地图集成指南

**项目**: 小白快跑  
**日期**: 2026-03-13  
**状态**: 🟡 占位实现，待集成真实 SDK

---

## ✅ 已完成

### 1. 权限配置

**module.json5** 已添加位置权限：
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

### 2. 服务层

**已创建文件**:
- `MapService.ts` - 地图服务单例（占位实现）
- `LocationService.ts` - 定位服务（含模拟位置更新）
- `MapContainer.ets` - 地图 UI 组件（含控制按钮）

### 3. UI 组件

**MapContainer 功能**:
- ✅ 地图占位显示（网格背景）
- ✅ 定位按钮（📍）
- ✅ 缩放按钮（+ / -）
- ✅ 深色模式支持
- ✅ Toast 反馈

---

## 📋 待集成步骤

### 步骤 1: 申请高德地图 API Key

1. 访问 [高德开放平台](https://lbs.amap.com/)
2. 注册/登录账号
3. 创建应用 → 选择 "HarmonyOS"
4. 获取 API Key (Security Code)

### 步骤 2: 下载 HarmonyOS 地图 SDK

```bash
# 方式 1: 通过 DevEco Studio 添加
# File → Project Structure → Dependencies → Add → AMap Map

# 方式 2: 手动下载
# 访问：https://lbs.amap.com/api/harmonyos-sdk/download
```

### 步骤 3: 配置 build-profile.json5

```json5
{
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

### 步骤 4: 更新 MapService.ts

```typescript
import map from '@amap/map';

export class MapService {
  private mapInstance: any = null;
  
  async initialize(): Promise<boolean> {
    // 初始化高德地图 SDK
    await map.init({
      key: 'YOUR_API_KEY',
      securityCode: 'YOUR_SECURITY_CODE'
    });
    
    this.mapInstance = new map.Map('map_container', {
      zoom: 15,
      center: [116.4074, 39.9042] // 北京
    });
    
    return true;
  }
  
  setCenter(lat: number, lng: number) {
    this.mapInstance?.setCenter([lng, lat]);
  }
  
  addMarker(lat: number, lng: number) {
    const marker = new map.Marker({
      position: [lng, lat],
      map: this.mapInstance
    });
    return marker;
  }
  
  // ... 其他方法
}
```

### 步骤 5: 更新 MapContainer.ets

```typescript
// 使用真实的地图组件
build() {
  Stack() {
    // 高德地图容器
    Column() {
      Map({
        controller: this.mapController,
        zoom: this.zoom,
        center: this.currentLocation
      })
      .width('100%')
      .height('100%')
    }
    
    // 控制按钮保持不变
    Column() {
      // ... 定位/缩放按钮
    }
  }
}
```

---

## 🔧 当前实现（占位）

### MapContainer 显示效果

```
┌─────────────────────────────┐
│  [网格背景 - 模拟地图]       │
│                             │
│         📍 (中心标记)        │
│                             │
│                    [📍]     │
│                    [+]     │
│                    [−]     │
└─────────────────────────────┘
```

### 功能演示

1. **定位按钮** - 点击获取当前位置（模拟）
2. **缩放按钮** - +/- 调整缩放级别（3-20）
3. **Toast 反馈** - 操作提示

---

## 📱 权限使用说明

### 系统自动请求

权限已在 `module.json5` 中声明，当应用首次使用定位功能时：

1. 系统自动弹出权限对话框
2. 用户选择"允许"或"拒绝"
3. 权限状态持久化保存

### 手动检查权限（可选）

```typescript
import { atManager } from '@ohos.accessToken';

// 检查权限状态
const accessToken = atManager.getAccessToken(
  context.bundleName,
  'ohos.permission.APPROXIMATELY_LOCATION'
);

if (accessToken === 0) {
  // 已授权
} else {
  // 未授权，需要请求
}
```

---

## 🎯 下一步

### 近期（本周）
- [ ] 申请高德地图 API Key
- [ ] 下载并集成 SDK
- [ ] 替换占位实现为真实地图

### 中期（下周）
- [ ] 实现跑步轨迹绘制
- [ ] 添加路线回放功能
- [ ] 地图标记（起点/终点）

### 长期（未来）
- [ ] 离线地图支持
- [ ] 实时位置共享
- [ ] 跑步路线推荐

---

## 📞 参考文档

- [高德地图 HarmonyOS SDK 文档](https://lbs.amap.com/api/harmonyos-sdk/summary)
- [HarmonyOS 定位服务](https://developer.huawei.com/consumer/cn/doc/harmonyos-references-V5/js-apis-geoLocationManager-V5)
- [HarmonyOS 权限管理](https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/access-token-V5)

---

**当前状态**: ✅ 编译通过，待真机测试  
**下一步**: 在 DevEco Studio 中运行测试地图组件
