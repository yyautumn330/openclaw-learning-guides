/*
 * 小白快跑 - 首页
 * 使用 Navigation + Tabs 结构
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

const TAG = 'Index';
const DOMAIN = 0x0000;

@Entry
@Component
struct Index {
  @Provide('pageInfos') pageInfos: NavPathStack = new NavPathStack();
  @Provide('isPageHide') isPageHide: boolean = false;
  @State currentIndex: number = 0;
  @State isRunning: boolean = false;
  @State isPaused: boolean = false;
  @State duration: number = 0;
  @State distance: number = 0;
  @State pace: string = '0\'00"';
  @State isDarkMode: boolean = false;
  @State locationText: string = '准备开始';
  @State currentLat: number = 39.90923;
  @State currentLng: number = 116.397428;
  
  private timerId: number = -1;
  private lastLocation: LocationInfo | null = null;
  
  aboutToAppear() {
    hilog.info(DOMAIN, TAG, 'Index aboutToAppear');
    
    const context = getContext(this) as common.UIAbilityContext;
    runDataModel.initialize(context);
    locationService.setContext(context);
    backgroundService.setContext(context);
    voiceService.setContext(context);
    
    locationService.requestPermission();
  }
  
  aboutToDisappear() {
    hilog.info(DOMAIN, TAG, 'Index aboutToDisappear');
    this.stopTimer();
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
    Column() {
      // 地图占位区域
      Column() {
        Text('🗺️')
          .fontSize(60)
          .margin({ bottom: 16 })
        Text('地图功能开发中...')
          .fontSize(16)
          .fontColor('#666666')
        Text('请在 DevEco Studio 中运行项目')
          .fontSize(14)
          .fontColor('#999999')
          .margin({ top: 8 })
      }
      .width('100%')
      .height(280)
      .justifyContent(FlexAlign.Center)
      .backgroundColor('#F5F5F5')
      
      // 数据卡片
      Row() {
        Column() {
          Text('⏱️').fontSize(18).margin({ bottom: 4 })
          Text(this.formatTime(this.duration))
            .fontSize(22).fontWeight(FontWeight.Bold).fontColor('#333333')
          Text('时长').fontSize(11).fontColor('#999999')
        }.layoutWeight(1).padding(16)
        
        Column() {
          Text('📍').fontSize(18).margin({ bottom: 4 })
          Text(`${(this.distance / 1000).toFixed(2)}`)
            .fontSize(22).fontWeight(FontWeight.Bold).fontColor('#FF6B6B')
          Text('公里').fontSize(11).fontColor('#999999')
        }.layoutWeight(1).padding(16)
        
        Column() {
          Text('⚡').fontSize(18).margin({ bottom: 4 })
          Text(this.pace)
            .fontSize(22).fontWeight(FontWeight.Bold).fontColor('#333333')
          Text('配速').fontSize(11).fontColor('#999999')
        }.layoutWeight(1).padding(16)
      }
      .width('100%')
      .backgroundColor('#FFFFFF')
      .borderRadius(16)
      .margin({ top: -20, left: 16, right: 16 })
      .shadow({ radius: 8, color: 'rgba(0,0,0,0.1)', offsetX: 0, offsetY: 4 })
      
      Blank()
      
      // 控制按钮
      Row() {
        Button(this.getButtonText())
          .width('70%')
          .height(52)
          .fontSize(17)
          .linearGradient({
            angle: 90,
            colors: [['#FF6B6B', 0.0], ['#FF8E53', 1.0]]
          })
          .fontColor('#FFFFFF')
          .borderRadius(26)
          .onClick(() => {
            if (!this.isRunning) this.startRun();
            else if (this.isPaused) this.resumeRun();
            else this.pauseRun();
          })
        
        if (this.isRunning) {
          Button('⏹')
            .width(52).height(52).fontSize(20)
            .backgroundColor('#F5F5F5')
            .fontColor('#666666')
            .borderRadius(26)
            .margin({ left: 12 })
            .onClick(() => this.stopRun())
        }
      }
      .justifyContent(FlexAlign.Center)
      .width('100%')
      .padding({ left: 16, right: 16, bottom: 24 })
    }
    .width('100%')
    .height('100%')
    .backgroundColor('#F0F0F0')
  }
  
  @Builder
  buildTabBar(title: string, icon: string, index: number) {
    Column() {
      Text(icon).fontSize(20)
        .fontColor(this.currentIndex === index ? '#FF6B6B' : '#999999')
        .margin({ bottom: 2 })
      Text(title).fontSize(11)
        .fontColor(this.currentIndex === index ? '#FF6B6B' : '#999999')
    }
    .justifyContent(FlexAlign.Center)
  }
  
  build() {
    Navigation(this.pageInfos) {
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
    .width('100%')
    .height('100%')
  }
}