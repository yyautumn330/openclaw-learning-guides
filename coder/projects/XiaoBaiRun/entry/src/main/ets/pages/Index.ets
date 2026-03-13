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

import { runDataModel, TrackPoint } from '../utils/RunDataModel';
import { locationService, LocationInfo } from '../services/LocationService';
import { DesignTokens } from '../constants/DesignTokens';
import { common } from '@kit.AbilityKit';
import { ToastComponent } from '../components/Toast';
import { MapContainer } from '../components/MapContainer';
import { Statistics } from './Statistics';
import { History } from './History';
import { Metronome } from './Metronome';
import { Profile } from './Profile';

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State isRunning: boolean = false;
  @State isPaused: boolean = false;
  @State duration: number = 0; // 秒
  @State distance: number = 0; // 米
  @State pace: string = '0\'00"';
  @State isDarkMode: boolean = false;
  @State locationText: string = '准备开始';
  
  private timerId: number = -1;
  private lastLocation: LocationInfo | null = null;
  private context: common.UIAbilityContext | null = null;
  
  getColors(): import('../constants/DesignTokens').ColorTheme {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    this.context = getContext(this) as common.UIAbilityContext;
    try {
      if (this.context) {
        await runDataModel.initialize(this.context);
        locationService.setContext(this.context);
        this.isDarkMode = this.getIsDarkMode();
        
        // 请求定位权限（系统会自动弹窗）
        await locationService.requestPermission();
        ToastComponent.info('首次使用需要定位权限', 2000);
      }
    } catch (error) {
      console.error('Index init error:', error);
    }
  }
  
  aboutToDisappear() {
    this.stopTimer();
  }
  
  getIsDarkMode(): boolean {
    // TODO: 从设置读取
    return false;
  }
  
  /**
   * 开始跑步
   */
  async startRun() {
    if (this.isRunning) return;
    
    this.isRunning = true;
    this.isPaused = false;
    this.duration = 0;
    this.distance = 0;
    
    runDataModel.startRun();
    
    // 开始计时
    this.startTimer();
    
    // 开始位置追踪
    await locationService.startTracking((location) => {
      this.onLocationUpdate(location);
    });
    
    this.locationText = '跑步中...';
    ToastComponent.success('开始跑步', 2000);
  }
  
  /**
   * 暂停跑步
   */
  pauseRun() {
    if (!this.isRunning) return;
    
    this.isPaused = true;
    this.stopTimer();
    this.locationText = '已暂停';
    
    ToastComponent.info('已暂停', 2000);
  }
  
  /**
   * 继续跑步
   */
  async resumeRun() {
    if (!this.isPaused) return;
    
    this.isPaused = false;
    this.startTimer();
    this.locationText = '跑步中...';
    
    ToastComponent.success('继续跑步', 2000);
  }
  
  /**
   * 停止跑步
   */
  async stopRun() {
    if (!this.isRunning) return;
    
    this.isRunning = false;
    this.isPaused = false;
    this.stopTimer();
    
    await locationService.stopTracking();
    await runDataModel.finishRun();
    
    this.locationText = '准备开始';
    ToastComponent.success('跑步完成', 3000);
  }
  
  /**
   * 位置更新回调
   */
  onLocationUpdate(location: LocationInfo) {
    if (this.lastLocation) {
      // 计算距离 (Haversine 公式)
      const dist = this.calculateDistance(
        this.lastLocation.latitude,
        this.lastLocation.longitude,
        location.latitude,
        location.longitude
      );
      
      this.distance += dist;
      this.pace = this.calculatePace(this.duration, this.distance);
    }
    
    this.lastLocation = location;
    runDataModel.updateRunData(this.distance, this.duration);
  }
  
  /**
   * 计算距离 (Haversine 公式)
   */
  calculateDistance(lat1: number, lng1: number, lat2: number, lng2: number): number {
    const R = 6371000; // 地球半径 (米)
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLng = (lng2 - lng1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
              Math.sin(dLng / 2) * Math.sin(dLng / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }
  
  /**
   * 计算配速
   */
  calculatePace(duration: number, distance: number): string {
    if (distance === 0) return '0\'00"';
    
    const paceSeconds = duration / (distance / 1000);
    const minutes = Math.floor(paceSeconds / 60);
    const seconds = Math.floor(paceSeconds % 60);
    
    return `${minutes}'${seconds.toString().padStart(2, '0')}"`;
  }
  
  /**
   * 启动计时器
   */
  startTimer() {
    this.stopTimer();
    this.timerId = setInterval(() => {
      this.duration++;
      this.pace = this.calculatePace(this.duration, this.distance);
    }, 1000);
  }
  
  /**
   * 停止计时器
   */
  stopTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }
  
  /**
   * 格式化时间
   */
  formatTime(seconds: number): string {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = seconds % 60;
    
    if (h > 0) {
      return `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
    }
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  }
  
  getButtonText(): string {
    if (!this.isRunning) return '开始跑步';
    if (this.isPaused) return '继续';
    return '暂停';
  }
  
  /**
   * 构建首页内容（Tab 1）
   */
  @Builder
  buildHomeTab() {
    Column() {
      // 顶部标题
      Row() {
        Text('小白快跑')
          .fontSize(DesignTokens.FONT_SIZE.xxl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ top: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.md })
      .justifyContent(FlexAlign.Center)
      
      // 地图区域
      MapContainer({ isDarkMode: this.isDarkMode })
        .width('100%')
        .height('40%')
        .margin({ bottom: DesignTokens.SPACING.lg })
      
      // 状态显示
      Row() {
        Column() {
          Text(this.formatTime(this.duration))
            .fontSize(DesignTokens.FONT_SIZE.stat)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getColors().primaryColor)
          Text('时间')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
        }
        .layoutWeight(1)
        
        Column() {
          Text(`${(this.distance / 1000).toFixed(2)}`)
            .fontSize(DesignTokens.FONT_SIZE.stat)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getColors().primaryColor)
          Text('公里')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
        }
        .layoutWeight(1)
        
        Column() {
          Text(this.pace)
            .fontSize(DesignTokens.FONT_SIZE.stat)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getColors().primaryColor)
          Text('配速')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
        }
        .layoutWeight(1)
      }
      .width('100%')
      .padding(DesignTokens.SPACING.lg)
      .backgroundColor(this.getColors().cardBackground)
      .borderRadius(DesignTokens.RADIUS.lg)
      .margin({ bottom: DesignTokens.SPACING.lg })
      
      // 位置状态
      Text(this.locationText)
        .fontSize(DesignTokens.FONT_SIZE.md)
        .fontColor(this.getColors().textSecondary)
        .margin({ bottom: DesignTokens.SPACING.lg })
      
      // 控制按钮
      Row() {
        Button(this.getButtonText())
          .width(DesignTokens.BUTTON.width)
          .height(DesignTokens.BUTTON.height)
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.getColors().primaryColor)
          .fontColor('#FFFFFF')
          .borderRadius(DesignTokens.RADIUS.xl)
          .margin({ right: DesignTokens.SPACING.md })
          .onClick(() => {
            if (!this.isRunning) {
              this.startRun();
            } else if (this.isPaused) {
              this.resumeRun();
            } else {
              this.pauseRun();
            }
          })
        
        Button('停止')
          .width(DesignTokens.BUTTON.smallWidth)
          .height(DesignTokens.BUTTON.height)
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.getColors().secondaryColor)
          .fontColor('#FFFFFF')
          .borderRadius(DesignTokens.RADIUS.xl)
          .enabled(this.isRunning)
          .onClick(() => {
            this.stopRun();
          })
      }
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
  
  /**
   * 构建底部导航栏
   */
  @Builder
  buildTabBar(title: string, icon: string, index: number): void {
    Column() {
      Text(icon)
        .fontSize(20)
        .fontColor(this.currentIndex === index ? this.getColors().primaryColor : this.getColors().textSecondary)
        .margin({ bottom: 2 })
      Text(title)
        .fontSize(11)
        .fontColor(this.currentIndex === index ? this.getColors().primaryColor : this.getColors().textSecondary)
    }
    .justifyContent(FlexAlign.Center)
  }
  
  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
      // Tab 1: 首页
      TabContent() {
        this.buildHomeTab()
      }
      .tabBar(this.buildTabBar('首页', '🏠', 0))
      
      // Tab 2: 统计
      TabContent() {
        Statistics()
      }
      .tabBar(this.buildTabBar('统计', '📊', 1))
      
      // Tab 3: 历史
      TabContent() {
        History()
      }
      .tabBar(this.buildTabBar('历史', '📝', 2))
      
      // Tab 4: 节拍器
      TabContent() {
        Metronome()
      }
      .tabBar(this.buildTabBar('节拍器', '🎵', 3))
      
      // Tab 5: 我的
      TabContent() {
        Profile()
      }
      .tabBar(this.buildTabBar('我的', '👤', 4))
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
