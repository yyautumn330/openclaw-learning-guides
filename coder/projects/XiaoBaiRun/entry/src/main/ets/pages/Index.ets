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

import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';
import { DesignTokens } from '../constants/DesignTokens';
import { Statistics } from './Statistics';
import { History } from './History';
import { Metronome } from './Metronome';
import { Profile } from './Profile';
import { runDataModel } from '../utils/RunDataModel';
import { locationService, LocationInfo } from '../services/LocationService';
import { backgroundService } from '../services/BackgroundService';
import { voiceService } from '../services/VoiceService';
import { mapService } from '../services/MapService';

const TAG = 'Index';
const DOMAIN = 0x0000;

@Entry
@Component
struct Index {
  @State currentIndex: number = 0;
  @State isRunning: boolean = false;
  @State isPaused: boolean = false;
  @State duration: number = 0;
  @State distance: number = 0;
  @State pace: string = '0\'00"';
  @State isDarkMode: boolean = false;
  @State locationText: string = '准备开始';
  @State mapImageUrl: string = '';
  @State mapZoom: number = 15;
  @State currentLat: number = 39.90923;
  @State currentLng: number = 116.397428;
  @State isLoading: boolean = true;
  
  private timerId: number = -1;
  private lastLocation: LocationInfo | null = null;
  
  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'Index aboutToAppear');
    
    // 初始化服务
    const context = getContext(this) as common.UIAbilityContext;
    runDataModel.initialize(context);
    locationService.setContext(context);
    backgroundService.setContext(context);
    voiceService.setContext(context);
    mapService.setContext(context);
    
    // 初始化地图
    this.initMap();
    
    // 请求定位权限
    locationService.requestPermission();
  }
  
  aboutToDisappear() {
    hilog.info(DOMAIN, TAG, 'Index aboutToDisappear');
    this.stopTimer();
  }
  
  /**
   * 初始化地图
   */
  async initMap(): Promise<void> {
    try {
      await mapService.initialize();
      const position = await mapService.getCurrentPosition();
      if (position) {
        this.currentLat = position.latitude;
        this.currentLng = position.longitude;
      }
      this.updateMapUrl();
      this.isLoading = false;
      hilog.info(DOMAIN, TAG, 'Map initialized');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Map init error: %{public}s', JSON.stringify(error) ?? '');
      this.isLoading = false;
    }
  }
  
  /**
   * 更新地图 URL
   */
  updateMapUrl(): void {
    this.mapImageUrl = mapService.getStaticMapUrl(
      this.currentLat,
      this.currentLng,
      this.mapZoom
    );
  }
  
  /**
   * 定位到当前位置
   */
  async locateToCurrentPosition(): Promise<void> {
    try {
      this.locationText = '定位中...';
      const position = await mapService.getCurrentPosition();
      if (position) {
        this.currentLat = position.latitude;
        this.currentLng = position.longitude;
        this.updateMapUrl();
        this.locationText = '已定位';
      }
    } catch (error) {
      this.locationText = '定位失败';
    }
  }
  
  /**
   * 缩放地图
   */
  zoomIn(): void {
    this.mapZoom = Math.min(this.mapZoom + 1, 18);
    this.updateMapUrl();
  }
  
  zoomOut(): void {
    this.mapZoom = Math.max(this.mapZoom - 1, 3);
    this.updateMapUrl();
  }
  
  async startRun() {
    if (this.isRunning) return;
    
    this.isRunning = true;
    this.isPaused = false;
    this.duration = 0;
    this.distance = 0;
    
    runDataModel.startRun();
    await backgroundService.startBackgroundRunning();
    await voiceService.announceStart();
    
    this.startTimer();
    
    await locationService.startTracking((location) => {
      this.onLocationUpdate(location);
    });
    
    this.locationText = '跑步中...';
  }
  
  async pauseRun() {
    if (!this.isRunning) return;
    
    this.isPaused = true;
    this.stopTimer();
    await voiceService.announcePause(this.distance, this.duration);
    this.locationText = '已暂停';
  }
  
  async resumeRun() {
    if (!this.isPaused) return;
    
    this.isPaused = false;
    this.startTimer();
    await voiceService.announceResume();
    this.locationText = '跑步中...';
  }
  
  async stopRun() {
    if (!this.isRunning) return;
    
    this.isRunning = false;
    this.isPaused = false;
    this.stopTimer();
    
    await locationService.stopTracking();
    await backgroundService.stopBackgroundRunning();
    await voiceService.announceStop(this.distance, this.duration);
    await runDataModel.finishRun();
    
    this.locationText = '准备开始';
  }
  
  async onLocationUpdate(location: LocationInfo) {
    if (this.lastLocation) {
      const dist = this.calculateDistance(
        this.lastLocation.latitude,
        this.lastLocation.longitude,
        location.latitude,
        location.longitude
      );
      
      if (dist < 2) return;
      
      this.distance += dist;
      this.pace = this.calculatePace(this.duration, this.distance);
      voiceService.announceMilestone(this.distance / 1000);
    }
    
    this.lastLocation = location;
    this.currentLat = location.latitude;
    this.currentLng = location.longitude;
    
    // 更新地图中心
    this.updateMapUrl();
    
    runDataModel.addTrackPoint({
      latitude: location.latitude,
      longitude: location.longitude,
      altitude: location.altitude,
      timestamp: location.timestamp
    });
    
    runDataModel.updateRunData(this.distance, this.duration);
  }
  
  calculateDistance(lat1: number, lng1: number, lat2: number, lng2: number): number {
    const R = 6371000;
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLng = (lng2 - lng1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
              Math.sin(dLng / 2) * Math.sin(dLng / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }
  
  calculatePace(duration: number, distance: number): string {
    if (distance === 0) return '0\'00"';
    const paceSeconds = duration / (distance / 1000);
    const minutes = Math.floor(paceSeconds / 60);
    const seconds = Math.floor(paceSeconds % 60);
    return `${minutes}'${seconds.toString().padStart(2, '0')}"`;
  }
  
  startTimer() {
    this.stopTimer();
    this.timerId = setInterval(() => {
      this.duration++;
      this.pace = this.calculatePace(this.duration, this.distance);
    }, 1000);
  }
  
  stopTimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }
  
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
  
  @Builder
  buildHomeTab() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 底层：地图图片
      Image(this.mapImageUrl)
        .width('100%')
        .height('100%')
        .objectFit(ImageFit.Cover)
        .onComplete(() => {
          this.isLoading = false;
        })
        .onError(() => {
          this.isLoading = false;
        })
      
      // 加载状态
      if (this.isLoading) {
        Column() {
          Text('🗺️')
            .fontSize(40)
            .margin({ bottom: 8 })
          Text('加载地图中...')
            .fontSize(14)
            .fontColor('#FFFFFF')
        }
        .justifyContent(FlexAlign.Center)
        .width('100%')
        .height('100%')
        .backgroundColor('rgba(0,0,0,0.5)')
      }
      
      // 顶层：数据面板
      Column() {
        Blank()
        
        // 数据卡片
        Row() {
          Column() {
            Text('⏱️')
              .fontSize(18)
              .margin({ bottom: 4 })
            Text(this.formatTime(this.duration))
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
            Text('时长')
              .fontSize(11)
              .fontColor('#FFFFFFCC')
          }
          .layoutWeight(1)
          .padding(12)
          
          Column() {
            Text('📍')
              .fontSize(18)
              .margin({ bottom: 4 })
            Text(`${(this.distance / 1000).toFixed(2)}`)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
            Text('公里')
              .fontSize(11)
              .fontColor('#FFFFFFCC')
          }
          .layoutWeight(1)
          .padding(12)
          
          Column() {
            Text('⚡')
              .fontSize(18)
              .margin({ bottom: 4 })
            Text(this.pace)
              .fontSize(22)
              .fontWeight(FontWeight.Bold)
              .fontColor('#FFFFFF')
            Text('配速')
              .fontSize(11)
              .fontColor('#FFFFFFCC')
          }
          .layoutWeight(1)
          .padding(12)
        }
        .width('92%')
        .backgroundColor('rgba(0,0,0,0.6)')
        .borderRadius(16)
        .shadow({ radius: 12, color: 'rgba(0,0,0,0.3)', offsetX: 0, offsetY: 4 })
        .margin({ bottom: 16 })
        
        // 控制按钮
        Row() {
          Button(this.getButtonText())
            .width('70%')
            .height(52)
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .linearGradient({
              angle: 90,
              colors: [[DesignTokens.getThemeColors(this.isDarkMode).primaryColor, 0.0], 
                       [DesignTokens.getThemeColors(this.isDarkMode).secondaryColor, 1.0]]
            })
            .fontColor('#FFFFFF')
            .borderRadius(26)
            .shadow({ radius: 10, color: `${DesignTokens.getThemeColors(this.isDarkMode).primaryColor}66`, offsetX: 0, offsetY: 4 })
            .onClick(() => {
              if (!this.isRunning) {
                this.startRun();
              } else if (this.isPaused) {
                this.resumeRun();
              } else {
                this.pauseRun();
              }
            })
          
          if (this.isRunning) {
            Button('⏹')
              .width(52)
              .height(52)
              .fontSize(20)
              .backgroundColor('rgba(255,255,255,0.2)')
              .fontColor('#FFFFFF')
              .borderRadius(26)
              .borderWidth(1)
              .borderColor('#FFFFFF40')
              .margin({ left: 12 })
              .onClick(() => { this.stopRun(); })
          }
        }
        .justifyContent(FlexAlign.Center)
        .width('92%')
        .padding({ bottom: 24 })
        
        // 缩放控制
        Row() {
          Button('➖')
            .width(40)
            .height(36)
            .fontSize(18)
            .backgroundColor('rgba(255,255,255,0.9)')
            .borderRadius(18)
            .onClick(() => this.zoomOut())
          
          Text(`Z${this.mapZoom}`)
            .fontSize(14)
            .fontColor('#FFFFFF')
            .margin({ left: 8, right: 8 })
          
          Button('➕')
            .width(40)
            .height(36)
            .fontSize(18)
            .backgroundColor('rgba(255,255,255,0.9)')
            .borderRadius(18)
            .onClick(() => this.zoomIn())
        }
        .justifyContent(FlexAlign.Center)
        .width('92%')
        .padding({ bottom: 12 })
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 0,
        colors: [['transparent', 0.0], ['transparent', 0.3], 
                 ['rgba(0,0,0,0.3)', 0.6], ['rgba(0,0,0,0.7)', 1.0]]
      })
    }
    .width('100%')
    .height('100%')
  }
  
  @Builder
  buildTabBar(title: string, icon: string, index: number) {
    Column() {
      Text(icon)
        .fontSize(20)
        .fontColor(this.currentIndex === index ? DesignTokens.getThemeColors(this.isDarkMode).primaryColor : DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
        .margin({ bottom: 2 })
      Text(title)
        .fontSize(11)
        .fontColor(this.currentIndex === index ? DesignTokens.getThemeColors(this.isDarkMode).primaryColor : DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
    }
    .justifyContent(FlexAlign.Center)
  }
  
  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
      TabContent() {
        this.buildHomeTab()
      }
      .tabBar(this.buildTabBar('首页', '🏠', 0))
      
      TabContent() {
        Statistics()
      }
      .tabBar(this.buildTabBar('统计', '📊', 1))
      
      TabContent() {
        History()
      }
      .tabBar(this.buildTabBar('历史', '📝', 2))
      
      TabContent() {
        Metronome()
      }
      .tabBar(this.buildTabBar('节拍器', '🎵', 3))
      
      TabContent() {
        Profile()
      }
      .tabBar(this.buildTabBar('我的', '👤', 4))
    }
    .width('100%')
    .height('100%')
  }
}
