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
import { metronomeService } from '../services/MetronomeService';
import { backgroundService } from '../services/BackgroundService';
import { voiceService } from '../services/VoiceService';
import { settingsService } from '../services/SettingsService';
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
        metronomeService.setContext(this.context);
        backgroundService.setContext(this.context);
        voiceService.setContext(this.context);
        await settingsService.setContext(this.context);
        this.isDarkMode = settingsService.getDarkMode();
        
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
    return settingsService.getDarkMode();
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
    
    // 启动后台任务
    await backgroundService.startBackgroundRunning();
    
    // 语音播报开始
    await voiceService.announceStart();
    
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
  async pauseRun() {
    if (!this.isRunning) return;
    
    this.isPaused = true;
    this.stopTimer();
    
    // 语音播报暂停
    await voiceService.announcePause(this.distance, this.duration);
    
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
    
    // 语音播报继续
    await voiceService.announceResume();
    
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
    await backgroundService.stopBackgroundRunning();
    
    // 语音播报结束
    await voiceService.announceStop(this.distance, this.duration);
    
    await runDataModel.finishRun();
    
    this.locationText = '准备开始';
    ToastComponent.success('跑步完成', 3000);
  }
  
  /**
   * 位置更新回调
   */
  async onLocationUpdate(location: LocationInfo) {
    console.info('Location update:', JSON.stringify(location));
    
    if (this.lastLocation) {
      // 计算距离 (Haversine 公式)
      const dist = this.calculateDistance(
        this.lastLocation.latitude,
        this.lastLocation.longitude,
        location.latitude,
        location.longitude
      );
      
      // 过滤无效位置变化（GPS 漂移）
      if (dist < 2) {
        console.info('Distance too small, ignoring');
        return;
      }
      
      this.distance += dist;
      this.pace = this.calculatePace(this.duration, this.distance);
      
      // 语音播报里程碑（每公里）
      voiceService.announceMilestone(this.distance / 1000);
    }
    
    this.lastLocation = location;
    
    // 保存轨迹点
    runDataModel.addTrackPoint({
      latitude: location.latitude,
      longitude: location.longitude,
      altitude: location.altitude,
      timestamp: location.timestamp
    });
    
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
   * 构建首页内容（Tab 1）- 沉浸式地图布局
   */
  @Builder
  buildHomeTab() {
    Stack({ alignContent: Alignment.Bottom }) {
      // 底层：全屏地图（沉浸式）
      Column() {
        MapContainer({ isDarkMode: this.isDarkMode })
          .width('100%')
          .height('100%')
      }
      .width('100%')
      .height('100%')
      
      // 顶层：半透明数据面板（从底部浮起）
      Column() {
        Blank() // 占位，让内容靠下
        
        // 数据卡片区域（悬浮在地图上）
        Row() {
          // 时间
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
          
          // 距离
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
          
          // 配速
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
        .shadow({
          radius: 12,
          color: 'rgba(0,0,0,0.3)',
          offsetX: 0,
          offsetY: 4
        })
        .margin({ bottom: 16 })
        
        // 控制按钮区域
        Row() {
          // 开始/暂停/继续按钮
          Button(this.getButtonText())
            .width('70%')
            .height(52)
            .fontSize(17)
            .fontWeight(FontWeight.Medium)
            .linearGradient({
              angle: 90,
              colors: [
                [this.getColors().primaryColor, 0.0],
                [this.getColors().secondaryColor, 1.0]
              ]
            })
            .fontColor('#FFFFFF')
            .borderRadius(26)
            .shadow({
              radius: 10,
              color: `${this.getColors().primaryColor}66`,
              offsetX: 0,
              offsetY: 4
            })
            .onClick(() => {
              if (!this.isRunning) {
                this.startRun();
              } else if (this.isPaused) {
                this.resumeRun();
              } else {
                this.pauseRun();
              }
            })
          
          // 停止按钮（跑步时显示）
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
              .onClick(() => {
                this.stopRun();
              })
          }
        }
        .justifyContent(FlexAlign.Center)
        .width('92%')
        .padding({ bottom: 24 })
        
        // 位置状态（最底部）
        if (this.locationText !== '准备开始' && this.locationText !== '') {
          Row() {
            Text('📡')
              .fontSize(14)
              .margin({ right: 4 })
            Text(this.locationText)
              .fontSize(12)
              .fontColor('#FFFFFF99')
          }
          .padding({ left: 12, right: 12, top: 6, bottom: 6 })
          .backgroundColor('rgba(0,0,0,0.4)')
          .borderRadius(12)
          .margin({ bottom: 12 })
        }
      }
      .width('100%')
      .height('100%')
      .linearGradient({
        angle: 0,
        colors: [
          ['transparent', 0.0],
          ['transparent', 0.3],
          ['rgba(0,0,0,0.3)', 0.6],
          ['rgba(0,0,0,0.7)', 1.0]
        ]
      })
    }
    .width('100%')
    .height('100%')
  }
  
  /**
   * 构建底部导航栏
   */
  @Builder
  buildTabBar(title: string, icon: string, index: number) {
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
