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
import { common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG = 'MapContainer';
const DOMAIN = 0x0000;

/**
 * 地图容器组件
 * 使用高德静态地图 API (免费，支持轨迹绘制)
 */
@Component
export struct MapContainer {
  @Prop isDarkMode: boolean = false;
  @State zoom: number = 15;
  @State longitude: number = 116.397428;
  @State latitude: number = 39.90923;
  @State mapImageUrl: string = '';
  @State isLoading: boolean = true;
  @State locationText: string = '定位中...';
  
  private context: common.UIAbilityContext | null = null;
  
  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'MapContainer aboutToAppear');
    this.context = getContext(this) as common.UIAbilityContext;
    this.initMap();
  }
  
  /**
   * 初始化地图
   */
  async initMap(): Promise<void> {
    try {
      hilog.info(DOMAIN, TAG, 'Initializing map service');
      
      // 初始化地图服务
      await mapService.initialize(this.context);
      
      // 获取当前位置
      const position = await mapService.getCurrentPosition();
      if (position) {
        this.longitude = position.longitude;
        this.latitude = position.latitude;
        this.locationText = '已定位';
      } else {
        this.locationText = '定位失败，使用默认位置';
      }
      
      // 更新地图图片 URL
      this.updateMapUrl();
      
      this.isLoading = false;
      hilog.info(DOMAIN, TAG, 'Map initialized at %{public}s,%{public}s', 
                 this.latitude.toString(), this.longitude.toString());
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Map init error: %{public}s', JSON.stringify(error) ?? '');
      this.isLoading = false;
      this.locationText = '地图加载失败';
    }
  }
  
  /**
   * 更新地图图片 URL (使用高德静态地图 API)
   */
  updateMapUrl(): void {
    // 添加当前位置标记
    interface MarkerPoint {
      lat: number;
      lng: number;
      label?: string;
    }
    
    const markers: Array<MarkerPoint> = [{
      lat: this.latitude,
      lng: this.longitude,
      label: 'A' // 起点标记
    }];
    
    this.mapImageUrl = mapService.getStaticMapUrl(
      this.latitude,
      this.longitude,
      this.zoom,
      640,
      400,
      markers
    );
    
    // 添加时间戳避免缓存
    this.mapImageUrl += `&t=${Date.now()}`;
    
    hilog.info(DOMAIN, TAG, 'Map URL updated, zoom: %{public}d', this.zoom);
  }
  
  /**
   * 缩放地图
   */
  zoomIn(): void {
    this.zoom = Math.min(this.zoom + 1, 18);
    this.updateMapUrl();
    hilog.info(DOMAIN, TAG, 'Zoom in: %{public}d', this.zoom);
  }
  
  zoomOut(): void {
    this.zoom = Math.max(this.zoom - 1, 3);
    this.updateMapUrl();
    hilog.info(DOMAIN, TAG, 'Zoom out: %{public}d', this.zoom);
  }
  
  /**
   * 定位到当前位置
   */
  async locateToCurrentPosition(): Promise<void> {
    try {
      hilog.info(DOMAIN, TAG, 'Locating to current position');
      this.locationText = '定位中...';
      
      const position = await mapService.getCurrentPosition();
      if (position) {
        this.longitude = position.longitude;
        this.latitude = position.latitude;
        this.updateMapUrl();
        this.locationText = '已定位到当前位置';
        hilog.info(DOMAIN, TAG, 'Located to: %{public}s,%{public}s', 
                   this.latitude.toString(), this.longitude.toString());
      } else {
        this.locationText = '定位失败';
      }
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Locate error: %{public}s', JSON.stringify(error) ?? '');
      this.locationText = '定位出错';
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
            hilog.info(DOMAIN, TAG, 'Map image loaded successfully');
            this.isLoading = false;
          })
          .onError((error) => {
            hilog.error(DOMAIN, TAG, 'Map image load error: %{public}s', 
                        JSON.stringify(error) ?? '');
            this.isLoading = false;
          })
        
        // 加载中提示
        if (this.isLoading) {
          Column() {
            Text('🌍')
              .fontSize(40)
              .margin({ bottom: 8 })
            Text('加载地图中...')
              .fontSize(14)
              .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
          }
          .justifyContent(FlexAlign.Center)
        }
        
        // 定位按钮（悬浮在地图右上角）
        Button('📍')
          .width(44)
          .height(44)
          .fontSize(20)
          .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
          .borderRadius(22)
          .borderWidth(1)
          .borderColor(DesignTokens.getThemeColors(this.isDarkMode).borderColor)
          .position({ x: '85%', y: 10 })
          .onClick(() => {
            this.locateToCurrentPosition();
          })
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
        Text(this.locationText)
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
          .layoutWeight(1)
        
        Button('➖')
          .fontSize(DesignTokens.FONT_SIZE.md)
          .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
          .borderWidth(1)
          .borderColor(DesignTokens.getThemeColors(this.isDarkMode).borderColor)
          .borderRadius(DesignTokens.RADIUS.md)
          .width(40)
          .height(36)
          .margin({ left: DesignTokens.SPACING.sm })
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
