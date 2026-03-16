# 地图集成问题说明

**日期**: 2026-03-16 23:30  
**状态**: 需要用户协助

---

## 🔍 问题分析

### 1. 高德静态地图 API
- **问题**: API Key 平台不匹配 (`USERKEY_PLAT_NOMATCH`)
- **原因**: 当前 API Key 绑定的平台与 Web 服务不匹配
- **解决**: 需要在高德开放平台重新申请 Key，选择正确的服务平台

### 2. 高德地图 SDK (MapViewComponent)
- **问题**: 无法在普通组件中使用
- **原因**: MapViewComponent 需要在 Navigation 结构的页面中使用
- **限制**: 需要特定的页面容器和路由配置

### 3. OpenStreetMap 静态地图
- **问题**: 无法访问 (网络超时)
- **原因**: 服务器在中国大陆访问不稳定

---

## ✅ 建议解决方案

### 方案 A: 申请正确的高德静态地图 API Key（推荐）

1. **访问高德开放平台**: https://lbs.amap.com/
2. **创建新应用**:
   - 应用名称：小白快跑
   - 平台选择：**Web 服务 (IP 白名单)**
3. **添加 Key**:
   - 服务平台：Web 服务
   - IP 白名单：0.0.0.0/0 (测试用)
4. **替换 API Key**:
   - 文件：`entry/src/main/ets/services/MapService.ts`
   - 变量：`apiKey`

### 方案 B: 使用高德地图 SDK（需要重构页面）

1. **修改页面结构**: 使用 Navigation + NavDestination
2. **配置路由**: 添加 route_map.json
3. **集成 MapViewComponent**: 在 NavDestination 中使用

参考：`AMapHarmonyDemo/harmony_map_demo` 项目

### 方案 C: 真机测试（最简单）

在 DevEco Studio 中直接运行项目到真机：
1. 连接真机（USB 调试）
2. DevEco Studio → 运行
3. 使用真机 GPS 和网络

---

## 📝 当前代码状态

### MapContainer.ets
- 使用 Image 组件加载静态地图
- 支持缩放和定位
- 等待有效的地图源

### MapService.ts
- 支持多种地图源（高德/Mapbox/OSM）
- 当前默认使用高德静态地图 API
- 需要有效的 API Key

### Index.ets
- 沉浸式布局（全屏地图 + 悬浮数据）
- 集成定位和轨迹记录
- 5 个 Tab 导航

---

## 🎯 下一步行动

**推荐**: 申请高德静态地图 API Key

1. 登录高德开放平台
2. 创建 Web 服务类型的 Key
3. 替换 `MapService.ts` 中的 API Key
4. 重新编译运行

**或者**: 在 DevEco Studio 中直接运行项目进行真机测试

---

## 📞 参考文档

- [高德地图 Web 服务 API](https://lbs.amap.com/api/webservice/summary)
- [静态地图 API](https://lbs.amap.com/api/webservice/guide/api/staticmap)
- [高德地图 HarmonyOS SDK](https://lbs.amap.com/api/harmonyos-sdk/summary)

---

*请用户选择方案并协助完成配置*
