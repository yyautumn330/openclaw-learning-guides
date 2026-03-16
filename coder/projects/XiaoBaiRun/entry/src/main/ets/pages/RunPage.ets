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

import { common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { DesignTokens } from '../constants/DesignTokens';
import { TrajectoryMap } from '../components/TrajectoryMap';
import { RunStatsPanel, RunStatsData } from '../components/RunStatsPanel';
import { RunControlBar } from '../components/RunControlBar';
import { ToastComponent } from '../components/Toast';
import { runTrackerService } from '../services/RunTrackerService';
import { TrajectoryPoint } from '../models/TrajectoryModel';

const TAG = 'RunPage';
const DOMAIN = 0x0000;

/**
 * 跑步页面
 * 整合轨迹地图、统计面板、控制栏
 */
@Component
export struct RunPage {
  @State isDarkMode: boolean = false;
  @State isRunning: boolean = false;
  @State isPaused: boolean = false;
  @State trajectory: TrajectoryPoint[] = [];
  @State stats: RunStatsData = {
    distance: 0,
    duration: 0,
    avgSpeed: 0,
    maxSpeed: 0,
    avgPace: '0:00',
    calories: 0,
    signalQuality: 'good'
  };
  
  private context: common.UIAbilityContext | null = null;
  private updateTimer: number = -1;
  
  async aboutToAppear() {
    this.context = getContext(this) as common.UIAbilityContext;
    
    // 设置服务 Context
    runTrackerService.setContext(this.context);
    
    // 订阅状态变化
    runTrackerService.onStateChange((state) => {
      hilog.info(DOMAIN, TAG, 'State changed: %s', state);
      this.isRunning = state === 'running';
      this.isPaused = state === 'paused';
    });
    
    // 启动定时更新
    this.startStatsUpdate();
    
    hilog.info(DOMAIN, TAG, 'RunPage initialized');
  }
  
  aboutToDisappear() {
    if (this.updateTimer !== -1) {
      clearInterval(this.updateTimer);
    }
  }
  
  /**
   * 启动统计更新
   */
  private startStatsUpdate(): void {
    this.updateTimer = setInterval(() => {
      this.updateStats();
    }, 1000) as unknown as number;
  }
  
  /**
   * 更新统计数据
   */
  private updateStats(): void {
    const stats = runTrackerService.getStats();
    this.stats = {
      distance: stats.distance,
      duration: stats.duration,
      avgSpeed: stats.avgSpeed,
      maxSpeed: stats.maxSpeed,
      avgPace: stats.avgPace,
      calories: stats.calories,
      signalQuality: stats.signalQuality
    };
    
    // 更新轨迹
    this.trajectory = runTrackerService.getStats().pointCount > 0 
      ? [] // 简化：不实时更新整个轨迹
      : [];
  }
  
  /**
   * 开始跑步
   */
  private async handleStart(): Promise<void> {
    hilog.info(DOMAIN, TAG, 'Start running');
    await runTrackerService.startTracking();
  }
  
  /**
   * 暂停跑步
   */
  private async handlePause(): Promise<void> {
    hilog.info(DOMAIN, TAG, 'Pause running');
    await runTrackerService.pauseTracking();
  }
  
  /**
   * 继续跑步
   */
  private async handleResume(): Promise<void> {
    hilog.info(DOMAIN, TAG, 'Resume running');
    await runTrackerService.resumeTracking();
  }
  
  /**
   * 停止跑步
   */
  private async handleStop(): Promise<void> {
    hilog.info(DOMAIN, TAG, 'Stop running');
    const record = await runTrackerService.stopTracking();
    
    if (record) {
      hilog.info(DOMAIN, TAG, 'Run saved: %d meters, %d seconds', 
        record.totalDistance, record.duration);
      
      // 显示跑步结果弹窗
      this.showRunResultDialog(record);
    }
  }
  
  /**
   * 显示跑步结果弹窗
   */
  private showRunResultDialog(record: any): void {
    const distanceKm = (record.totalDistance / 1000).toFixed(2);
    const durationMin = Math.floor(record.duration / 60);
    const durationSec = record.duration % 60;
    
    hilog.info(DOMAIN, TAG, '🏃 跑步完成！距离：%s km, 时长：%d:%02d, 配速：%s',
      distanceKm, durationMin, durationSec, record.avgPace);
    
    // 使用 Toast 显示结果（弹窗功能待系统 Dialog API 支持）
    ToastComponent.success(`🏃 跑步完成！${distanceKm}km / ${durationMin}:${durationSec.toString().padStart(2, '0')} / 配速 ${record.avgPace}`, 5000);
  }
  
  build() {
    Column() {
      // 标题栏
      Row() {
        Text('🏃 跑步')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
        
        Blank()
        
        // GPS 信号指示
        Row() {
          Text(this.getSignalIcon())
            .fontSize(16)
          Text(this.stats.signalQuality)
            .fontSize(DesignTokens.FONT_SIZE.xs)
            .fontColor(this.getSignalColor())
            .margin({ left: 4 })
        }
      }
      .width('100%')
      .padding({ left: 16, right: 16, top: 16, bottom: 8 })
      
      Scroll() {
        Column() {
          // 轨迹地图
          TrajectoryMap({
            trajectory: this.trajectory,
            isDarkMode: this.isDarkMode,
            isTracking: this.isRunning
          })
          
          // 统计面板
          RunStatsPanel({
            stats: this.stats,
            isDarkMode: this.isDarkMode,
            isRunning: this.isRunning
          })
          .margin({ top: 16 })
          
          // 控制栏
          RunControlBar({
            isRunning: this.isRunning,
            isPaused: this.isPaused,
            isDarkMode: this.isDarkMode,
            onStart: () => this.handleStart(),
            onPause: () => this.handlePause(),
            onResume: () => this.handleResume(),
            onStop: () => this.handleStop()
          })
          .margin({ top: 16 })
          
          // 提示信息
          if (!this.isRunning && !this.isPaused) {
            Column() {
              Text('💡 提示')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
                .margin({ bottom: 8 })
              
              Text('• 点击"开始"按钮开始记录跑步轨迹')
                .fontSize(DesignTokens.FONT_SIZE.sm)
                .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
                .margin({ bottom: 4 })
              
              Text('• 需要开启定位权限')
                .fontSize(DesignTokens.FONT_SIZE.sm)
                .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
                .margin({ bottom: 4 })
              
              Text('• 建议在户外空旷地点开始跑步')
                .fontSize(DesignTokens.FONT_SIZE.sm)
                .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
            }
            .width('100%')
            .padding(16)
            .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
            .borderRadius(DesignTokens.RADIUS.lg)
            .margin({ top: 16, bottom: 24 })
            .alignItems(HorizontalAlign.Start)
          }
        }
        .padding({ left: 0, right: 0 })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).backgroundColor)
  }
  
  private getSignalIcon(): string {
    switch (this.stats.signalQuality) {
      case 'excellent': return '📶';
      case 'good': return '📶';
      case 'weak': return '📶';
      case 'lost': return '❌';
      default: return '📶';
    }
  }
  
  private getSignalColor(): string {
    switch (this.stats.signalQuality) {
      case 'excellent': return '#4CAF50';
      case 'good': return '#8BC34A';
      case 'weak': return '#FF9800';
      case 'lost': return '#F44336';
      default: return '#9E9E9E';
    }
  }
}