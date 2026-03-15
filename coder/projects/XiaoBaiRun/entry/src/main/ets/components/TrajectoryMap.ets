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

import { DesignTokens } from '../constants/DesignTokens';
import { TrajectoryPoint } from '../models/TrajectoryModel';

/**
 * 轨迹地图组件
 * 使用高德静态地图 API 显示轨迹
 */
@Component
export struct TrajectoryMap {
  @Prop trajectory: TrajectoryPoint[] = [];
  @Prop isDarkMode: boolean = false;
  @Prop isTracking: boolean = false;
  @Prop currentLocation: { latitude: number; longitude: number } | null = null;
  
  @State zoom: number = 15;
  @State mapWidth: number = 600;
  @State mapHeight: number = 350;
  
  // 高德地图 API Key
  private readonly AMAP_WEB_KEY: string = '5ad3390398c4a3a3e9a2e31f8a56a36a';
  
  /**
   * 获取地图 URL
   */
  getMapUrl(): string {
    if (this.trajectory.length === 0 && !this.currentLocation) {
      // 默认位置 (上海陆家嘴)
      return this.generateMapUrl(31.2304, 121.4737, []);
    }
    
    const center = this.trajectory.length > 0 
      ? this.trajectory[this.trajectory.length - 1]
      : this.currentLocation;
    
    if (!center) return '';
    
    return this.generateMapUrl(center.latitude, center.longitude, this.trajectory);
  }
  
  /**
   * 生成高德静态地图 URL
   */
  private generateMapUrl(
    centerLat: number,
    centerLon: number,
    points: TrajectoryPoint[]
  ): string {
    // 构建轨迹路径
    let paths = '';
    let markers = '';
    
    if (points.length > 1) {
      // 构建路径坐标串
      const pathCoords = points.map(p => `${p.longitude},${p.latitude}`).join(';');
      
      // 路径样式：蓝色实线
      paths = `&paths=10,0x4ED1C4,1,,${pathCoords}`;
      
      // 起点标记（绿色）
      const start = points[0];
      markers = `mid,0x4CAF50,起|${start.longitude},${start.latitude}`;
      
      // 终点标记（红色）
      const end = points[points.length - 1];
      markers += `&mid,0xF44336,终|${end.longitude},${end.latitude}`;
    } else if (points.length === 1) {
      // 只有一个点
      const p = points[0];
      markers = `mid,0x2196F3,●|${p.longitude},${p.latitude}`;
    } else if (this.currentLocation) {
      // 当前位置
      markers = `mid,0x2196F3,●|${this.currentLocation.longitude},${this.currentLocation.latitude}`;
    }
    
    // 高德静态地图 API (Web 服务)
    return `https://restapi.amap.com/v3/staticmap?` +
      `location=${centerLon},${centerLat}` +
      `&zoom=${this.zoom}` +
      `&size=${this.mapWidth}*${this.mapHeight}` +
      `${paths}${markers}` +
      `&key=${this.AMAP_WEB_KEY}`;
  }
  
  /**
   * 格式化距离
   */
  private formatDistance(meters: number): string {
    if (meters < 1000) {
      return `${Math.round(meters)}米`;
    }
    return `${(meters / 1000).toFixed(2)}公里`;
  }
  
  private getTotalDistance(): number {
    if (this.trajectory.length === 0) return 0;
    return this.trajectory[this.trajectory.length - 1].distance;
  }
  
  build() {
    Column() {
      // 地图标题
      Row() {
        Text('🗺️ 跑步轨迹')
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Medium)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
        
        Blank()
        
        if (this.trajectory.length > 0) {
          Text(this.formatDistance(this.getTotalDistance()))
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontColor(DesignTokens.getThemeColors(this.isDarkMode).primaryColor)
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 12, bottom: 8 })
      
      // 地图
      Stack({ alignContent: Alignment.Bottom }) {
        if (this.trajectory.length > 0 || this.currentLocation) {
          // 显示地图
          Image(this.getMapUrl())
            .width('100%')
            .height(250)
            .objectFit(ImageFit.Cover)
            .borderRadius(DesignTokens.RADIUS.lg)
        } else {
          // 空状态
          Column() {
            Text('📍')
              .fontSize(48)
              .opacity(0.5)
            Text('开始跑步后显示轨迹')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
              .margin({ top: 8 })
          }
          .width('100%')
          .height(250)
          .justifyContent(FlexAlign.Center)
          .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
        }
        
        // 底部控制栏
        if (this.trajectory.length > 0 || this.currentLocation) {
          Row() {
            // 缩放控制
            Button('-')
              .fontSize(16)
              .width(32)
              .height(32)
              .backgroundColor('rgba(0,0,0,0.5)')
              .fontColor('#FFFFFF')
              .borderRadius(16)
              .onClick(() => {
                this.zoom = Math.max(3, this.zoom - 1);
              })
            
            Text(`${this.zoom}`)
              .fontSize(14)
              .fontColor('#FFFFFF')
              .width(40)
              .textAlign(TextAlign.Center)
            
            Button('+')
              .fontSize(16)
              .width(32)
              .height(32)
              .backgroundColor('rgba(0,0,0,0.5)')
              .fontColor('#FFFFFF')
              .borderRadius(16)
              .onClick(() => {
                this.zoom = Math.min(18, this.zoom + 1);
              })
          }
          .padding({ left: 16, right: 16, bottom: 12 })
        }
      }
      .width('100%')
      .margin({ left: 16, right: 16 })
    }
    .width('100%')
  }
}