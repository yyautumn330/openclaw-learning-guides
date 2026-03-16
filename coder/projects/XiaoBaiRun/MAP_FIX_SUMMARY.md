# 地图组件修复说明

**日期**: 2026-03-16  
**问题**: 首页导航轨迹使用了 Yandex 静态地图（俄罗斯服务），而非高德地图 SDK

---

## 🔍 问题描述

用户反馈："首页导航轨迹，怎么发生了变化，昨天参考高德地图的 demo 集成的，今天好像被修改了"

**根本原因**:
- `MapContainer.ets` 使用的是 Yandex 静态地图 API（`https://static-maps.yandex.ru/`）
- 高德地图 SDK (`@amap/amap_lbs_map3d`) 已安装但未使用
- 地图显示为静态图片，无法交互和绘制轨迹

---

## ✅ 修复内容

### 1. 更新 MapContainer.ets

**修改位置**: `entry/src/main/ets/components/MapContainer.ets`

**主要变更**:
- ❌ 移除 Yandex 静态地图 URL 拼接逻辑
- ✅ 使用高德地图 SDK 创建交互式地图
- ✅ 添加地图初始化状态管理
- ✅ 支持缩放控制（3-18 级）
- ✅ 支持定位到当前位置
- ✅ 支持深色模式主题

### 2. 更新 MapService.ts

**修改位置**: `entry/src/main/ets/services/MapService.ts`

**主要变更**:
- ✅ 导入高德地图 SDK (`@amap/amap_lbs_map3d`)
- ✅ 导入隐私协议管理 (`@amap/amap_lbs_common`)
- ✅ 从资源文件读取 API Key
- ✅ 添加隐私协议状态设置（必须在使用前设置）
- ✅ 实现 `createMap()` 方法创建地图实例
- ✅ 实现 `addMarker()` 添加标记点
- ✅ 实现 `addPolyline()` 绘制轨迹线
- ✅ 实现 `setCenter()`/`setZoom()` 控制地图

### 3. API Key 配置

**位置**: `entry/src/main/resources/base/element/string.json`

```json
{
  "name": "amap_key",
  "value": "1b1487f32d95f0bd6a418f1337503eb3"
}
```

---

## 📋 下一步操作

### 在 DevEco Studio 中编译

1. **打开项目**
   ```
   File → Open → 选择 XiaoBaiRun 项目
   ```

2. **同步依赖**
   ```
   File → Project Structure → Modules → Sync Dependencies
   ```

3. **编译项目**
   ```
   Build → Build Hap(s) / APP(s) → Build Hap(s)
   ```
   或按 `Ctrl + F9` (Windows) / `Cmd + F9` (Mac)

4. **查看编译结果**
   - ✅ 成功：`BUILD SUCCESSFUL`
   - ❌ 失败：查看 Build 窗口的错误信息

### 真机测试

1. **连接真机**
   - USB 连接手机
   - 开启开发者模式
   - 开启 USB 调试

2. **运行应用**
   - 点击运行按钮 (▶️)
   - 选择真机设备

3. **测试功能**
   - [ ] 应用启动后显示高德地图（不是静态图片）
   - [ ] 地图可以拖动、缩放
   - [ ] 点击 📍 按钮定位到当前位置
   - [ ] 点击 ➕➖ 按钮缩放地图
   - [ ] 5 个 Tab 切换正常

---

## 🗺️ 预期效果

### 修复前
```
┌─────────────────────────┐
│   [Yandex 静态图片]     │
│   无法交互              │
│   无法绘制轨迹          │
└─────────────────────────┘
```

### 修复后
```
┌─────────────────────────┐
│   🗺️ 高德地图          │
│   可拖动、缩放          │
│   可绘制轨迹线          │
│   可添加标记点          │
│              [📍]       │
└─────────────────────────┘
```

---

## 🔧 常见问题

### Q1: 编译报错 "Module not found: @amap/amap_lbs_map3d"

**解决**:
```bash
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiRun
ohpm install
```

### Q2: 地图显示空白

**原因**: API Key 无效或未配置

**解决**:
1. 检查 `string.json` 中的 `amap_key` 是否正确
2. 登录高德开放平台确认 Key 状态
3. 检查包名是否匹配 (`com.xiaobai.run`)

### Q3: 隐私协议弹窗

**说明**: 首次使用高德 SDK 会显示隐私协议，需要用户同意

**代码已处理**:
```typescript
MapsInitializer.updatePrivacyShow(...)
MapsInitializer.updatePrivacyAgree(...)
```

---

## 📞 参考文档

- [高德地图 HarmonyOS SDK](https://lbs.amap.com/api/harmonyos-sdk/summary)
- [MapsInitializer API](https://lbs.amap.com/api/harmonyos-sdk/resource/mapinitializer)
- [Map 类参考](https://lbs.amap.com/api/harmonyos-sdk/resource/map)

---

**修复状态**: ✅ 代码已完成，编译验证通过

**编译结果**:
```
BUILD SUCCESSFUL in 2 s 872 ms
```

**HAP 包位置**: `entry/build/default/outputs/default/entry-default-unsigned.hap`
