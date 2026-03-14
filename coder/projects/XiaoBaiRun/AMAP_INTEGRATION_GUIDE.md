# 地图集成指南 (HarmonyOS)

> **当前方案**: ✅ Yandex 静态地图 API (免费，无需 API Key)
>
> **地图服务**: Yandex Static Maps
>
> **当前状态**: ✅ 已集成，地图可正常显示

---

## ✅ 当前实现 (Yandex 静态地图)

### 为什么选择 Yandex?

| 对比项 | Yandex Static Maps | 高德静态地图 | OpenStreetMap |
|--------|-------------------|-------------|---------------|
| **API Key** | ❌ 不需要 | ✅ 需要 | ❌ 不需要 |
| **免费额度** | ✅ 无限制 | ⚠️ 有限制 | ✅ 无限制 |
| **地图质量** | ✅ 高 | ✅ 高 | ✅ 中等 |
| **响应速度** | ✅ 快 | ✅ 快 | ✅ 中等 |
| **经纬度格式** | 经度,纬度 | 经度,纬度 | 经度,纬度 |

### 已完成功能

| 功能 | 状态 | 说明 |
|------|------|------|
| 地图图片加载 | ✅ | 600x350 PNG |
| 缩放控制 (+/-) | ✅ | zoom 3-18 |
| 定位标记 | ✅ | 红色大头针 |
| 深色模式适配 | ✅ | 自动适配 |
| 加载状态提示 | ✅ | "加载地图中..." |
| 错误处理 | ✅ | onError 回调 |

---

## 📋 API 配置

### URL 格式

```
https://static-maps.yandex.ru/1.x/?ll=经度,纬度&z=缩放级别&l=map&size=宽度,高度&pt=经度,纬度,标记样式
```

### 参数说明

| 参数 | 值 | 说明 |
|------|-----|------|
| `ll` | `经度,纬度` | 地图中心点 |
| `z` | `3-18` | 缩放级别 (15 为城市街道) |
| `l` | `map` | 地图类型 (map=标准, sat=卫星) |
| `size` | `600,350` | 图片尺寸 (宽 <= 650, 高 <= 450) |
| `pt` | `经度,纬度,vkbkm` | 标记位置 (vkbkm=红色大头针) |

### 示例 URL

```
https://static-maps.yandex.ru/1.x/?ll=116.397428,39.90923&z=15&l=map&size=600,350&pt=116.397428,39.90923,vkbkm
```

---

## 🔧 代码实现

### MapContainer.ets

```typescript
import { DesignTokens } from '../constants/DesignTokens';
import { mapService } from '../services/MapService';

@Component
export struct MapContainer {
  @State isDarkMode: boolean = false;
  @State zoom: number = 15;
  @State longitude: number = 116.397428;
  @State latitude: number = 39.90923;
  @State mapImageUrl: string = '';
  @State isLoading: boolean = true;
  
  aboutToAppear() {
    mapService.initialize();
    this.updateMapUrl();
  }
  
  updateMapUrl(): void {
    this.mapImageUrl = `https://static-maps.yandex.ru/1.x/?ll=${this.longitude},${this.latitude}&z=${this.zoom}&l=map&size=600,350&pt=${this.longitude},${this.latitude},vkbkm`;
    console.info('Map URL updated:', this.mapImageUrl);
  }
  
  build() {
    Column() {
      // 地图图片
      Stack({ alignContent: Alignment.Center }) {
        Image(this.mapImageUrl)
          .width('100%')
          .height(250)
          .objectFit(ImageFit.Cover)
          .onComplete(() => {
            console.info('Map image loaded successfully');
            this.isLoading = false;
          })
          .onError((error) => {
            console.error('Map image load error:', error);
            this.isLoading = false;
          })
        
        if (this.isLoading) {
          Text('加载地图中...')
            .fontSize(14)
        }
      }
      // ... 控制按钮
    }
  }
}
```

---

## 🚫 高德地图问题 (已废弃)

### 问题记录

**错误**: `{"info":"USERKEY_PLAT_NOMATCH","infocode":"10009","status":"0"}`

**原因**: API Key 平台不匹配，当前 Key 不支持静态地图 API

**解决方案**: 切换到 Yandex 静态地图 (免费且无需 API Key)

---

## 📦 后续扩展方案

### 方案一：交互式地图 (Web 组件)

需要动态交互（拖拽、点击、路线规划）时使用：

```typescript
import { webview } from '@kit.ArkWeb';

@Component
export struct MapContainer {
  private webviewController: webview.WebviewController = new webview.WebviewController();
  
  build() {
    Column() {
      webview.Web({
        controller: this.webviewController
      })
        .loadUrl('https://yandex.ru/map-widget/v1/?z=15&ol=biz&ll=116.397428,39.90923')
        .javaScriptAccess(true)
        .zoomAccess(true)
    }
  }
}
```

### 方案二：HarmonyOS 原生地图

如果需要系统级地图集成：

```typescript
import { map } from '@kit.MapKit';

@Component
export struct MapContainer {
  private mapController: map.MapComponentController;
  
  build() {
    Map({
      controller: this.mapController
    })
  }
}
```

---

## 🔗 参考文档

- [Yandex Static Maps API](https://yandex.ru/dev/static-maps/doc/ru/)
- [HarmonyOS WebView](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V3/js-apis-webview-0000001541903643-V3)

---

*最后更新：2026-03-14 20:39*  
*状态：✅ 已使用 Yandex 静态地图*
