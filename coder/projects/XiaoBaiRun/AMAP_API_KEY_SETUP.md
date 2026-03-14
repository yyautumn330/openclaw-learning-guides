# 高德地图 API Key 配置指南

## 📝 配置步骤

### 步骤 1: 找到你的 API Key

登录高德开放平台 → 控制台 → 应用管理 → 我的应用

你应该看到类似信息:
- **Key**: `xxxxxxxxxxxxxxxxxxxxxxxxxxxx` (32 位字符)
- **Security Code**: `xxxxxxxxxxxxxxxx`

---

### 步骤 2: 填写到项目

**文件**: `entry/src/main/resources/base/element/string.json`

找到这一行:
```json
{
  "name": "amap_key",
  "value": "请在此处粘贴你的高德地图 API Key"
}
```

替换为你的真实 Key:
```json
{
  "name": "amap_key",
  "value": "你的 32 位 API Key"
}
```

---

### 步骤 3: 验证配置

**文件**: `entry/src/main/ets/services/MapService.ts`

当前代码:
```typescript
getApiKey(): string {
  // TODO: 从资源文件读取
  return '你的 API Key';
}
```

后续会改为从资源文件读取。

---

## 🔍 验证是否成功

### 方法 1: 查看日志

运行应用后，查看日志输出:
```
MapService initialized
API Key loaded: xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 方法 2: 地图加载

打开应用的地图页面，应该能看到:
- ✅ 地图正常显示
- ✅ 可以缩放/拖动
- ✅ 当前位置标记

---

## ⚠️ 注意事项

1. **不要提交到 Git**: API Key 属于敏感信息
2. **权限设置**: 确保 Key 启用了以下服务:
   - Web 服务 API
   - JavaScript API
   - 移动应用 SDK (HarmonyOS)
3. **配额限制**: 免费版有每日调用次数限制

---

## 📱 使用示例

### WebView 方式 (推荐)

```typescript
// MapContainer.ets
private getMapUrl(): string {
  const apiKey = '你的 API Key';
  return `https://restapi.amap.com/v3/staticmap?location=116.397428,39.90923&zoom=15&size=750*400&key=${apiKey}`;
}
```

### SDK 方式 (待集成)

```typescript
import { AMap } from '@amap/map';

await AMap.initialize({
  key: '你的 API Key',
  securityCode: '你的 Security Code'
});
```

---

## 🔗 相关文档

- [高德地图 API 文档](https://lbs.amap.com/api/webservice/summary)
- [StaticMap API](https://lbs.amap.com/api/webservice/guide/api/staticmap)
- [JavaScript API](https://lbs.amap.com/api/javascript-api/summary)

---

*最后更新：2026-03-14*  
*状态：等待 API Key 填写*
