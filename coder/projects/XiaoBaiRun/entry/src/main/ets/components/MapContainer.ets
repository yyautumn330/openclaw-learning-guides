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

import { DesignTokens, type ColorTheme } from '../constants/DesignTokens';
import { mapService } from '../services/MapService';
import { locationService, LocationInfo } from '../services/LocationService';
import { ToastComponent } from './Toast';

/**
 * 高德地图容器组件
 * 
 * 当前状态：改进的占位实现
 * 待集成：高德地图 HarmonyOS SDK
 */
@Component
export struct MapContainer {
  @Prop isDarkMode: boolean = false;
  @State zoom: number = 15;
  @State currentLocation: LocationInfo | null = null;
  @State mapInitialized: boolean = false;
  @State address: string = '定位中...';
  @State isLocating: boolean = false;
  
  private colors: ColorTheme = {
    backgroundColor: '#F7F7F7',
    cardBackground: '#FFFFFF',
    primaryColor: '#FF6B6B',
    primaryColorPressed: '#EE5A5A',
    secondaryColor: '#4ECDC4',
    secondaryColorPressed: '#3DBDB5',
    textPrimary: '#333333',
    textSecondary: '#666666',
    textTertiary: '#999999',
    borderColor: '#E0E0E0',
    dividerColor: '#E8E8E8',
    successColor: '#52C41A',
    warningColor: '#FAAD14',
    errorColor: '#FF4D4F',
    infoColor: '#1890FF',
    shadowColor: 'rgba(0, 0, 0, 0.1)',
  };
  
  aboutToAppear() {
    this.colors = DesignTokens.getThemeColors(this.isDarkMode);
    this.initMap();
    this.getCurrentPosition();
  }
  
  /**
   * 初始化地图
   */
  async initMap() {
    try {
      await mapService.initialize();
      this.mapInitialized = true;
      console.info('Map initialized');
    } catch (error) {
      console.error('Map init error:', error);
    }
  }
  
  /**
   * 获取当前位置
   */
  async getCurrentPosition() {
    this.isLocating = true;
    try {
      const location = await locationService.getCurrentLocation();
      if (location) {
        this.currentLocation = location;
        this.address = `纬度：${location.latitude.toFixed(4)}, 经度：${location.longitude.toFixed(4)}`;
        mapService.setCenter(location.latitude, location.longitude);
        ToastComponent.success('定位成功', 1500);
      } else {
        this.address = '定位失败，请检查权限设置';
        ToastComponent.info('定位失败', 2000);
      }
    } catch (error) {
      console.error('Get location error:', error);
      this.address = '定位不可用';
      ToastComponent.info('无法获取位置', 2000);
    } finally {
      this.isLocating = false;
    }
  }
  
  /**
   * 定位到当前位置
   */
  locateToCurrent() {
    if (this.currentLocation) {
      mapService.setCenter(this.currentLocation.latitude, this.currentLocation.longitude);
      ToastComponent.success('已定位到当前位置', 1500);
    } else {
      this.getCurrentPosition();
    }
  }
  
  /**
   * 放大
   */
  zoomIn() {
    if (this.zoom < 20) {
      this.zoom++;
      ToastComponent.info(`缩放级别：${this.zoom}`, 1000);
    }
  }
  
  /**
   * 缩小
   */
  zoomOut() {
    if (this.zoom > 3) {
      this.zoom--;
      ToastComponent.info(`缩放级别：${this.zoom}`, 1000);
    }
  }
  
  /**
   * 构建地图内容
   */
  @Builder
  buildMapContent() {
    Column() {
      // 模拟道路
      Row() {
        Column()
          .width('100%')
          .height(8)
          .backgroundColor('#CCCCCC')
      }
      .width('100%')
      .position({ x: '50%', y: '30%' })
      
      Row() {
        Column()
          .width('100%')
          .height(8)
          .backgroundColor('#CCCCCC')
      }
      .width('100%')
      .position({ x: '50%', y: '70%' })
      
      Column() {
        Column()
          .width(8)
          .height('100%')
          .backgroundColor('#CCCCCC')
      }
      .width('100%')
      .position({ x: '30%', y: '50%' })
      
      Column() {
        Column()
          .width(8)
          .height('100%')
          .backgroundColor('#CCCCCC')
      }
      .width('100%')
      .position({ x: '70%', y: '50%' })
      
      // 公园/绿地
      Column()
        .width(80)
        .height(60)
        .backgroundColor('#A5D6A7')
        .borderRadius(8)
        .position({ x: '20%', y: '20%' })
      
      Column()
        .width(60)
        .height(80)
        .backgroundColor('#A5D6A7')
        .borderRadius(8)
        .position({ x: '75%', y: '65%' })
      
      // 建筑物
      Column()
        .width(50)
        .height(50)
        .backgroundColor('#E0E0E0')
        .borderRadius(4)
        .position({ x: '60%', y: '25%' })
      
      Column()
        .width(70)
        .height(40)
        .backgroundColor('#E0E0E0')
        .borderRadius(4)
        .position({ x: '15%', y: '70%' })
      
      // 当前位置标记
      Column() {
        Column()
          .width(20)
          .height(20)
          .backgroundColor('#FF6B6B')
          .borderRadius(10)
          .border({ width: 3, color: '#FFFFFF' })
        
        Column()
          .width(40)
          .height(40)
          .backgroundColor('rgba(255, 107, 107, 0.3)')
          .borderRadius(20)
          .margin({ top: -10 })
      }
      .position({ x: '50%', y: '50%' })
      .translate({ x: '-50%', y: '-50%' })
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.isDarkMode ? '#1A1A2E' : '#E8F5E9')
  }
  
  build() {
    Stack() {
      // 地图内容
      if (this.mapInitialized) {
        this.buildMapContent()
      } else {
        Column() {
          LoadingProgress()
            .width(40)
            .height(40)
            .color(this.colors.primaryColor)
          
          Text('地图加载中...')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontColor(this.colors.textSecondary)
            .margin({ top: 12 })
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
        .backgroundColor(this.colors.cardBackground)
      }
      
      // 位置信息卡片
      Column() {
        Row() {
          Text(this.isLocating ? '📍 定位中...' : '📍 ' + this.address)
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.colors.textPrimary)
            .maxLines(1)
        }
        .width('100%')
        .padding(DesignTokens.SPACING.md)
        .backgroundColor(this.colors.cardBackground)
        .borderRadius(DesignTokens.RADIUS.md)
        .shadow({
          radius: 6,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 0,
          offsetY: 2
        })
      }
      .width('90%')
      .position({ x: '50%', y: 20 })
      .translate({ x: '-50%' })
      
      // 控制按钮
      Column() {
        // 定位按钮
        Button() {
          Text('📍')
            .fontSize(DesignTokens.FONT_SIZE.md)
        }
        .width(44)
        .height(44)
        .backgroundColor(this.colors.cardBackground)
        .borderRadius(DesignTokens.RADIUS.md)
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.2)',
          offsetX: 0,
          offsetY: 2
        })
        .margin({ bottom: 8 })
        .onClick(() => {
          this.locateToCurrent();
        })
        
        // 放大按钮
        Button() {
          Text('+')
            .fontSize(DesignTokens.FONT_SIZE.lg)
            .fontColor(this.colors.textPrimary)
        }
        .width(44)
        .height(44)
        .backgroundColor(this.colors.cardBackground)
        .borderRadius(DesignTokens.RADIUS.md)
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.2)',
          offsetX: 0,
          offsetY: 2
        })
        .onClick(() => {
          this.zoomIn();
        })
        
        // 缩小按钮
        Button() {
          Text('−')
            .fontSize(DesignTokens.FONT_SIZE.xl)
            .fontColor(this.colors.textPrimary)
        }
        .width(44)
        .height(44)
        .backgroundColor(this.colors.cardBackground)
        .borderRadius(DesignTokens.RADIUS.md)
        .shadow({
          radius: 4,
          color: 'rgba(0, 0, 0, 0.2)',
          offsetX: 0,
          offsetY: 2
        })
        .margin({ top: 8 })
        .onClick(() => {
          this.zoomOut();
        })
      }
      .position({ x: '95%', y: '50%' })
      .translate({ y: '-50%' })
      .alignItems(HorizontalAlign.End)
      
      // 高德地图 Logo（占位）
      Row() {
        Text('🗺️ 高德地图')
          .fontSize(10)
          .fontColor(this.isDarkMode ? '#888888' : '#666666')
      }
      .position({ x: 10, y: '95%' })
      .padding(4)
      .backgroundColor(this.isDarkMode ? 'rgba(0,0,0,0.5)' : 'rgba(255,255,255,0.8)')
      .borderRadius(4)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.cardBackground)
    .borderRadius(DesignTokens.RADIUS.lg)
  }
}
