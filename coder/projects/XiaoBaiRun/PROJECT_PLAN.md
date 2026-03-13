# 小白快跑 - 项目计划书

**项目名称**: 小白快跑 (XiaoBai Run)  
**版本**: V1.0  
**创建日期**: 2026-03-12  
**目标平台**: HarmonyOS (后续 iOS 移植)

---

## 📋 产品概述

### 产品定位
专业的跑步数据记录应用，提供 GPS 轨迹追踪、跑步数据分析和历史记录管理。

### 目标用户
- 跑步爱好者
- 健身人群
- 马拉松训练者

### 核心价值
- 🏃 **精准轨迹**: GPS 实时追踪，精准记录跑步路线
- 📊 **数据分析**: 配速/距离/时间/卡路里全面统计
- 📝 **历史记录**: 完整的跑步历史管理
- 🎨 **美观界面**: 简洁现代的 UI 设计

---

## 🎯 功能规划

### V1.0 MVP 版本

#### 1. 跑步首页 (Index)
- [ ] 地图显示 (高德地图 Web)
- [ ] 开始/暂停/停止按钮
- [ ] 实时数据显示 (时间/距离/配速)
- [ ] GPS 轨迹绘制 (Canvas)
- [ ] 定位权限申请

#### 2. 历史记录 (History)
- [ ] 跑步列表 (时间/距离/配速)
- [ ] 详情查看 (轨迹/数据)
- [ ] 删除记录
- [ ] 搜索/筛选

#### 3. 数据统计 (Statistics)
- [ ] 周/月/年统计
- [ ] 配速图表
- [ ] 距离趋势
- [ ] 总数据汇总

#### 4. 个人中心 (Profile)
- [ ] 个人信息
- [ ] 跑步目标设定
- [ ] 深色模式开关
- [ ] 设置选项

---

## 🏗️ 技术架构

### 技术栈
- **UI 框架**: ArkUI (声明式 UI)
- **定位服务**: @ohos.geoLocationManager
- **地图显示**: WebView + 高德地图 Web
- **轨迹绘制**: Canvas
- **数据存储**: Preferences + 本地文件

### 项目结构
```
XiaoBaiRun/
├── entry/
│   └── src/main/ets/
│       ├── entryability/
│       │   └── EntryAbility.ets
│       ├── pages/
│       │   ├── Index.ets          # 跑步首页
│       │   ├── History.ets        # 历史记录
│       │   ├── Statistics.ets     # 数据统计
│       │   └── Profile.ets        # 个人中心
│       ├── components/
│       │   ├── MapView.ets        # 地图组件
│       │   ├── RunCard.ets        # 跑步卡片
│       │   └── TrackCanvas.ets    # 轨迹绘制
│       ├── utils/
│       │   ├── LocationTracker.ts # GPS 追踪
│       │   ├── RunDataModel.ts    # 跑步数据模型
│       │   └── DistanceCalculator.ts
│       └── services/
│           └── LocationService.ts # 定位服务
├── hvigor/
│   └── hvigor-config.json5
├── build-profile.json5
└── oh-package.json5
```

---

## 📅 开发计划

### Day 1: 项目初始化 + 跑步首页
- [x] 项目目录创建
- [ ] 项目配置文件
- [ ] 跑步首页 UI
- [ ] 定位服务集成

### Day 2: 轨迹记录 + 地图
- [ ] 地图组件 (WebView)
- [ ] GPS 轨迹追踪
- [ ] Canvas 轨迹绘制
- [ ] 实时数据更新

### Day 3: 历史记录
- [ ] 历史记录页面
- [ ] 数据持久化
- [ ] 详情查看
- [ ] 删除功能

### Day 4: 数据统计
- [ ] 统计页面
- [ ] 图表组件
- [ ] 数据聚合
- [ ] 趋势分析

### Day 5: 个人中心 + 完善
- [ ] 个人中心页面
- [ ] 设置选项
- [ ] 深色模式
- [ ] 整体优化

---

## 🎨 UX 设计规范

### 色彩系统
- **主色**: #FF6B6B (番茄红 - 与番茄钟保持一致)
- **辅色**: #4ECDC4 (薄荷绿)
- **背景**: #F7F7F7 (浅色) / #1A1A1A (深色)

### 字体规范
- **标题**: 24px Bold
- **正文**: 16px Regular
- **辅助**: 14px Regular

### 组件规范
- **按钮**: 圆角 25px
- **卡片**: 圆角 12px
- **间距**: 8/16/24px

---

## 📊 数据模型

### 跑步记录 (RunRecord)
```typescript
interface RunRecord {
  id: string;           // 唯一标识
  startTime: number;    // 开始时间戳
  endTime: number;      // 结束时间戳
  duration: number;     // 时长 (秒)
  distance: number;     // 距离 (米)
  calories: number;     // 卡路里
  pace: number;         // 平均配速 (秒/公里)
  trackPoints: TrackPoint[]; // 轨迹点
}

interface TrackPoint {
  latitude: number;
  longitude: number;
  altitude?: number;
  timestamp: number;
}
```

---

## 🔧 技术方案

### 定位服务
```typescript
import geoLocationManager from '@ohos.geoLocationManager';

// 请求权限
// 订阅位置更新
// 计算距离 (Haversine 公式)
```

### 轨迹绘制
```typescript
// 使用 Canvas 绘制轨迹
// 缩放和平移支持
// 起点/终点标记
```

### 数据存储
```typescript
// Preferences: 用户设置
// 本地文件：跑步记录 (JSON)
```

---

*创建时间*: 2026-03-12  
*状态*: 项目初始化中
