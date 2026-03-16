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
import { hilog } from '@kit.PerformanceAnalysisKit';
import { mapService } from '../services/MapService';

const TAG = 'MapContainer';
const DOMAIN = 0x0000;

/**
 * 地图容器组件
 * 使用 OpenStreetMap 静态地图 (免费，无需 API Key)
 */
@Component
export struct MapContainer {
  @Prop isDarkMode: boolean = false;
  @State zoom: number = 15;
  @State longitude: number = 116.397428;
  @State latitude: number = 39.90923;
  @State mapImageUrl: string = '';
  @State isLoading: boolean = true;
  @State locationText: string = '加载地图中...';
  
  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'MapContainer aboutToAppear');
    this.initMap();
  }
  
  /**
   * 初始化地图
   */
  async initMap(): Promise<void> {
    try {
      hilog.info(DOMAIN, TAG, 'Initializing map');
      
      // 初始化地图服务
      await mapService.initialize();
      
      // 获取当前位置
      const position = await mapService.getCurrentPosition();
      if (position) {
        this.longitude = position.longitude;
        this.latitude = position.latitude;
      }
      
      // 更新地图 URL
      this.updateMapUrl();
      
      this.isLoading = false;
      this.locationText = '地图已加载';
      
      hilog.info(DOMAIN, TAG, 'Map initialized at %{public}f,%{public}f', 
                 this.latitude, this.longitude);
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Map init error: %{public}s', JSON.stringify(error) ?? '');
      this.isLoading = false;
      this.locationText = '地图加载失败';
    }
  }
  
  /**
   * 更新地图图片 URL
   */
  updateMapUrl(): void {
    this.mapImageUrl = mapService.getStaticMapUrl(
      this.latitude,
      this.longitude,
      this.zoom,
      640,
      400
    );
    
    hilog.info(DOMAIN, TAG, 'Map URL updated');
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
  async locateToCurrentPosition(): Promise<void> {
    try {
      this.locationText = '定位中...';
      const position = await mapService.getCurrentPosition();
      if (position) {
        this.longitude = position.longitude;
        this.latitude = position.latitude;
        this.updateMapUrl();
        this.locationText = '已定位';
      }
    } catch (error) {
      this.locationText = '定位失败';
    }
  }
  
  build() {
    Column() {
      Stack() {
        // 地图图片
        Image(this.mapImageUrl)
          .width('100%')
          .height('100%')
          .objectFit(ImageFit.Cover)
          .onComplete(() => {
            hilog.info(DOMAIN, TAG, 'Map image loaded');
            this.isLoading = false;
          })
          .onError((error) => {
            hilog.error(DOMAIN, TAG, 'Map image error: %{public}s', JSON.stringify(error) ?? '');
            this.isLoading = false;
          })
        
        // 加载中
        if (this.isLoading) {
          Column() {
            Text('🗺️')
              .fontSize(40)
              .margin({ bottom: 8 })
            Text(this.locationText)
              .fontSize(14)
              .fontColor('#FFFFFF')
          }
          .justifyContent(FlexAlign.Center)
          .width('100%')
          .height('100%')
          .backgroundColor('rgba(0,0,0,0.5)')
        }
        
        // 定位按钮
        Button('📍')
          .width(44)
          .height(44)
          .fontSize(20)
          .backgroundColor('rgba(255,255,255,0.9)')
          .borderRadius(22)
          .position({ x: '90%', y: 20 })
          .onClick(() => {
            this.locateToCurrentPosition();
          })
      }
      .width('100%')
      .height('100%')
      
      // 缩放控制
      Row() {
        Button('➖')
          .width(40)
          .height(36)
          .fontSize(18)
          .backgroundColor(this.isDarkMode ? '#333' : '#fff')
          .onClick(() => this.zoomOut())
        
        Text(`Z${this.zoom}`)
          .fontSize(14)
          .fontColor(this.isDarkMode ? '#fff' : '#333')
          .margin({ left: 8, right: 8 })
        
        Button('➕')
          .width(40)
          .height(36)
          .fontSize(18)
          .backgroundColor(this.isDarkMode ? '#333' : '#fff')
          .onClick(() => this.zoomIn())
      }
      .justifyContent(FlexAlign.Center)
      .padding({ top: 8 })
    }
    .width('100%')
    .height('100%')
  }
}
