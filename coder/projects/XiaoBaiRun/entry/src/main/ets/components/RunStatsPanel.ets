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

/**
 * 运动统计数据
 */
export interface RunStatsData {
  distance: number;       // 距离 (米)
  duration: number;       // 时长 (秒)
  avgSpeed: number;       // 平均速度 (m/s)
  maxSpeed: number;       // 最高速度 (m/s)
  avgPace: string;        // 平均配速
  calories: number;       // 卡路里
  signalQuality: string;  // 信号质量
}

/**
 * 运动统计面板
 * 实时显示跑步数据
 */
@Component
export struct RunStatsPanel {
  @Prop stats: RunStatsData = {
    distance: 0,
    duration: 0,
    avgSpeed: 0,
    maxSpeed: 0,
    avgPace: '0:00',
    calories: 0,
    signalQuality: 'good'
  };
  @Prop isDarkMode: boolean = false;
  @Prop isRunning: boolean = false;
  
  /**
   * 格式化时间
   */
  private formatDuration(seconds: number): string {
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    const secs = Math.floor(seconds % 60);
    
    if (hours > 0) {
      return `${hours}:${minutes.toString().padStart(2, '0')}:${secs.toString().padStart(2, '0')}`;
    }
    return `${minutes}:${secs.toString().padStart(2, '0')}`;
  }
  
  /**
   * 格式化距离
   */
  private formatDistance(meters: number): string {
    if (meters < 1000) {
      return `${Math.round(meters)}`;
    }
    return `${(meters / 1000).toFixed(2)}`;
  }
  
  /**
   * 获取距离单位
   */
  private getDistanceUnit(meters: number): string {
    return meters < 1000 ? '米' : '公里';
  }
  
  /**
   * 获取信号图标
   */
  private getSignalIcon(quality: string): string {
    switch (quality) {
      case 'excellent': return '📶';
      case 'good': return '📶';
      case 'weak': return '📶';
      case 'lost': return '❌';
      default: return '📶';
    }
  }
  
  /**
   * 获取信号颜色
   */
  private getSignalColor(quality: string): string {
    switch (quality) {
      case 'excellent': return '#4CAF50';
      case 'good': return '#8BC34A';
      case 'weak': return '#FF9800';
      case 'lost': return '#F44336';
      default: return '#9E9E9E';
    }
  }
  
  build() {
    Column() {
      // 主要数据行
      Row() {
        // 距离
        this.StatItem(
          this.formatDistance(this.stats.distance),
          this.getDistanceUnit(this.stats.distance),
          '距离'
        )
        
        Divider()
          .vertical(true)
          .height(60)
          .color(DesignTokens.getThemeColors(this.isDarkMode).borderColor)
        
        // 时长
        this.StatItem(
          this.formatDuration(this.stats.duration),
          '',
          '时长'
        )
        
        Divider()
          .vertical(true)
          .height(60)
          .color(DesignTokens.getThemeColors(this.isDarkMode).borderColor)
        
        // 配速
        this.StatItem(
          this.stats.avgPace,
          '/公里',
          '配速'
        )
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ top: 16, bottom: 16 })
      
      Divider()
        .color(DesignTokens.getThemeColors(this.isDarkMode).borderColor)
        .margin({ left: 16, right: 16 })
      
      // 次要数据行
      Row() {
        // 卡路里
        this.SmallStatItem('🔥', `${this.stats.calories}`, '卡路里')
        
        // 平均速度
        this.SmallStatItem('⚡', `${(this.stats.avgSpeed * 3.6).toFixed(1)}`, 'km/h')
        
        // 最高速度
        this.SmallStatItem('🚀', `${(this.stats.maxSpeed * 3.6).toFixed(1)}`, '最高 km/h')
        
        // 信号质量
        Column() {
          Text(this.getSignalIcon(this.stats.signalQuality))
            .fontSize(20)
          Text('GPS信号')
            .fontSize(DesignTokens.FONT_SIZE.xs)
            .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Center)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceEvenly)
      .padding({ top: 12, bottom: 16 })
    }
    .width('100%')
    .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
    .borderRadius(DesignTokens.RADIUS.lg)
    .margin({ left: 16, right: 16 })
    .shadow({ radius: 8, color: DesignTokens.getThemeColors(this.isDarkMode).shadowColor })
  }
  
  /**
   * 主要统计项
   */
  @Builder
  StatItem(value: string, unit: string, label: string) {
    Column() {
      Row() {
        Text(value)
          .fontSize(28)
          .fontWeight(FontWeight.Bold)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).primaryColor)
        
        if (unit) {
          Text(unit)
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
            .margin({ left: 2 })
        }
      }
      
      Text(label)
        .fontSize(DesignTokens.FONT_SIZE.sm)
        .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
        .margin({ top: 4 })
    }
    .alignItems(HorizontalAlign.Center)
  }
  
  /**
   * 次要统计项
   */
  @Builder
  SmallStatItem(icon: string, value: string, label: string) {
    Column() {
      Text(icon)
        .fontSize(20)
      Text(value)
        .fontSize(DesignTokens.FONT_SIZE.md)
        .fontWeight(FontWeight.Medium)
        .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textPrimary)
        .margin({ top: 4 })
      Text(label)
        .fontSize(DesignTokens.FONT_SIZE.xs)
        .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
        .margin({ top: 2 })
    }
    .alignItems(HorizontalAlign.Center)
  }
}