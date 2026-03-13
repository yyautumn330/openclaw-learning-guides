/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

import { webview } from '@kit.ArkWeb';
import { DesignTokens } from '../constants/DesignTokens';

/**
 * 地图组件 - 使用高德地图 Web
 */
@Component
export struct MapView {
  @State latitude: number = 39.9042;
  @State longitude: number = 116.4074;
  @State trackPoints: { lat: number; lng: number }[] = [];
  @State isDarkMode: boolean = false;
  
  private webController: webview.WebviewController = new webview.WebviewController();
  
  // 高德地图 Web URL
  private getMapUrl(): string {
    const center = `${this.longitude},${this.latitude}`;
    const style = this.isDarkMode ? 'dark' : 'light';
    return `https://uri.amap.com/marker?position=${center}&zoom=15&style=${style}`;
  }
  
  aboutToAppear() {
    // 初始化地图
  }
  
  aboutToDisappear() {
    // 清理资源
  }
  
  /**
   * 更新中心点
   */
  updateCenter(lat: number, lng: number) {
    this.latitude = lat;
    this.longitude = lng;
    
    // 更新 WebView 位置
    const jsCode = `
      if (window.map) {
        window.map.setCenter([${lng}, ${lat}]);
      }
    `;
    this.webController.runJavaScript(jsCode);
  }
  
  /**
   * 添加轨迹点
   */
  addTrackPoint(lat: number, lng: number) {
    this.trackPoints.push({ lat, lng });
    
    // 在地图上绘制轨迹
    const jsCode = `
      if (window.map && window.polyline) {
        window.polyline.setPath([
          ${this.trackPoints.map(p => `[${p.lng}, ${p.lat}]`).join(',')}
        ]);
      }
    `;
    this.webController.runJavaScript(jsCode);
  }
  
  /**
   * 清除轨迹
   */
  clearTrack() {
    this.trackPoints = [];
    
    const jsCode = `
      if (window.polyline) {
        window.polyline.setMap(null);
      }
    `;
    this.webController.runJavaScript(jsCode);
  }
  
  build() {
    Column() {
      Web({
        src: this.getMapUrl(),
        controller: this.webController
      })
        .width('100%')
        .height('100%')
        .javaScriptAccess(true)
        .domStorageAccess(true)
    }
    .width('100%')
    .height('100%')
  }
}
