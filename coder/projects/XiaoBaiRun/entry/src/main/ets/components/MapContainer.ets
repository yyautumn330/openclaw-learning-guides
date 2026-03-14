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
import { mapService } from '../services/MapService';

/**
 * 地图容器组件
 * 使用 OpenStreetMap 静态地图 API (免费，无需 API Key)
 */
@Component
export struct MapContainer {
  @State isDarkMode: boolean = false;
  @State zoom: number = 15;
  @State longitude: number = 116.397428;
  @State latitude: number = 39.90923;
  @State mapImageUrl: string = '';
  @State isLoading: boolean = true;
  
  aboutToAppear() {
    console.info('MapContainer aboutToAppear');
    mapService.initialize();
    this.updateMapUrl();
  }
  
  /**
   * 更新地图图片 URL (使用 OpenStreetMap 静态地图 API)
   */
  updateMapUrl(): void {
    // OpenStreetMap 静态地图 (通过 osm-static-maps 服务，免费且无需 API Key)
    // Yandex 限制：width <= 650, height <= 450
    this.mapImageUrl = `https://static-maps.yandex.ru/1.x/?ll=${this.longitude},${this.latitude}&z=${this.zoom}&l=map&size=600,350&pt=${this.longitude},${this.latitude},vkbkm`;
    console.info('Map URL updated:', this.mapImageUrl);
  }
  
  /**
   * 缩放地图
   */
  zoomIn(): void {
    this.zoom = Math.min(this.zoom + 1, 18);
    this.updateMapUrl();
  }
  
  zoomOut(): void {
    this.zoom = Math.max(this.zoom - 1, 3);
    this.updateMapUrl();
  }
  
  /**
   * 定位到当前位置
   */
  async locateToCurrentPosition() {
    try {
      const position = await mapService.getCurrentPosition();
      if (position) {
        this.longitude = position.longitude;
        this.latitude = position.latitude;
        this.updateMapUrl();
        console.info('Located to:', position);
      }
    } catch (error) {
      console.error('Locate error:', error);
    }
  }
  
  build() {
    Column() {
      // 地图图片
      Stack({ alignContent: Alignment.Center }) {
        // 地图图片
        Image(this.mapImageUrl)
          .width('100%')
          .height(250)
          .objectFit(ImageFit.Cover)
          .borderRadius(DesignTokens.RADIUS.lg)
          .onComplete(() => {
            console.info('Map image loaded successfully');
            this.isLoading = false;
          })
          .onError((error) => {
            console.error('Map image load error:', error);
            this.isLoading = false;
          })
        
        // 加载中提示
        if (this.isLoading) {
          Text('加载地图中...')
            .fontSize(14)
            .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
        }
      }
      .width('100%')
      .height(250)
      .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
      .borderRadius(DesignTokens.RADIUS.lg)
      .border({
        width: 1,
        color: DesignTokens.getThemeColors(this.isDarkMode).borderColor
      })
      
      // 控制按钮
      Row() {
        Button('📍 定位')
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).primaryColor)
          .fontColor('#FFFFFF')
          .borderRadius(DesignTokens.RADIUS.md)
          .width(80)
          .height(36)
          .onClick(() => {
            this.locateToCurrentPosition();
          })
        
        Blank()
        
        Button('➖')
          .fontSize(DesignTokens.FONT_SIZE.md)
          .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
          .borderWidth(1)
          .borderColor(DesignTokens.getThemeColors(this.isDarkMode).borderColor)
          .borderRadius(DesignTokens.RADIUS.md)
          .width(40)
          .height(36)
          .onClick(() => {
            this.zoomOut();
          })
        
        Text(`Z${this.zoom}`)
          .fontSize(DesignTokens.FONT_SIZE.md)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
          .margin({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm })
        
        Button('➕')
          .fontSize(DesignTokens.FONT_SIZE.md)
          .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
          .borderWidth(1)
          .borderColor(DesignTokens.getThemeColors(this.isDarkMode).borderColor)
          .borderRadius(DesignTokens.RADIUS.md)
          .width(40)
          .height(36)
          .onClick(() => {
            this.zoomIn();
          })
      }
      .width('100%')
      .padding({ top: DesignTokens.SPACING.md })
    }
    .width('100%')
  }
}
