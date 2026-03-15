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

import { runDataModel, type RunRecord } from '../utils/RunDataModel';
import { DesignTokens, type ColorTheme } from '../constants/DesignTokens';

/**
 * 周统计数据
 */
export interface WeekStats {
  day: string;
  distance: number;
  duration: number;
  runs: number;
}

/**
 * 月统计数据
 */
export interface MonthStats {
  week: string;
  distance: number;
  duration: number;
  runs: number;
}

@Component
export struct StatsChart {
  @Prop isDarkMode: boolean = false;
  @State weekData: WeekStats[] = [];
  @State monthData: MonthStats[] = [];
  @State selectedTab: 'week' | 'month' = 'week';
  
  getColors(): ColorTheme {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  aboutToAppear() {
    this.loadWeekStats();
    this.loadMonthStats();
  }
  
  /**
   * 加载周统计数据
   */
  loadWeekStats() {
    const records = runDataModel.getRunRecords();
    const now = Date.now();
    const sevenDaysAgo = now - 7 * 24 * 60 * 60 * 1000;
    
    const days = ['周日', '周一', '周二', '周三', '周四', '周五', '周六'];
    const stats: WeekStats[] = [];
    
    // 初始化 7 天数据
    for (let i = 6; i >= 0; i--) {
      const dayStart = sevenDaysAgo + i * 24 * 60 * 60 * 1000;
      const dayEnd = dayStart + 24 * 60 * 60 * 1000;
      const date = new Date(dayStart);
      
      const dayRecords = records.filter(r => 
        r.startTime >= dayStart && r.startTime < dayEnd
      );
      
      stats.push({
        day: days[date.getDay()],
        distance: dayRecords.reduce((sum, r) => sum + r.distance, 0),
        duration: dayRecords.reduce((sum, r) => sum + r.duration, 0),
        runs: dayRecords.length
      });
    }
    
    this.weekData = stats;
  }
  
  /**
   * 加载月统计数据
   */
  loadMonthStats() {
    const records = runDataModel.getRunRecords();
    const now = Date.now();
    
    const stats: MonthStats[] = [];
    const weeks = ['第 1 周', '第 2 周', '第 3 周', '第 4 周'];
    
    // 按周统计（简化：每月 4 周）
    for (let i = 0; i < 4; i++) {
      const weekStart = now - (3 - i) * 7 * 24 * 60 * 60 * 1000;
      const weekEnd = weekStart + 7 * 24 * 60 * 60 * 1000;
      
      const weekRecords = records.filter(r => 
        r.startTime >= weekStart && r.startTime < weekEnd
      );
      
      stats.push({
        week: weeks[i],
        distance: weekRecords.reduce((sum, r) => sum + r.distance, 0),
        duration: weekRecords.reduce((sum, r) => sum + r.duration, 0),
        runs: weekRecords.length
      });
    }
    
    this.monthData = stats;
  }
  
  /**
   * 格式化距离
   */
  formatDistance(meters: number): string {
    if (meters >= 1000) {
      return `${(meters / 1000).toFixed(1)}km`;
    }
    return `${Math.round(meters)}m`;
  }
  
  /**
   * 格式化时长
   */
  formatDuration(seconds: number): string {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    
    if (h > 0) {
      return `${h}h${m}`;
    }
    return `${m}m`;
  }
  
  /**
   * 获取柱状图高度（百分比）
   */
  getBarHeight(value: number, maxValue: number): number {
    if (maxValue === 0) return 0;
    return Math.max(5, (value / maxValue) * 100);
  }
  
  build() {
    Column() {
      // 图表切换 Tab
      Row() {
        Text('周统计')
          .fontSize(DesignTokens.FONT_SIZE.md)
          .fontColor(this.selectedTab === 'week' ? this.getColors().primaryColor : this.getColors().textSecondary)
          .fontWeight(this.selectedTab === 'week' ? FontWeight.Bold : FontWeight.Normal)
          .onClick(() => {
            this.selectedTab = 'week';
          })
          .padding({ left: DesignTokens.SPACING.md, right: DesignTokens.SPACING.md })
          .padding({ top: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
          .backgroundColor(this.selectedTab === 'week' ? this.getColors().primaryColor + '15' : 'transparent')
          .borderRadius(DesignTokens.RADIUS.md)
        
        Text('月统计')
          .fontSize(DesignTokens.FONT_SIZE.md)
          .fontColor(this.selectedTab === 'month' ? this.getColors().primaryColor : this.getColors().textSecondary)
          .fontWeight(this.selectedTab === 'month' ? FontWeight.Bold : FontWeight.Normal)
          .onClick(() => {
            this.selectedTab = 'month';
          })
          .padding({ left: DesignTokens.SPACING.md, right: DesignTokens.SPACING.md })
          .padding({ top: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
          .backgroundColor(this.selectedTab === 'month' ? this.getColors().primaryColor + '15' : 'transparent')
          .borderRadius(DesignTokens.RADIUS.md)
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: DesignTokens.SPACING.lg })
      
      // 周统计图表
      if (this.selectedTab === 'week') {
        this.WeekChart()
      } else {
        this.MonthChart()
      }
    }
    .width('100%')
  }
  
  @Builder
  WeekChart() {
    Column() {
      // 距离柱状图
      Text('本周跑步距离')
        .fontSize(DesignTokens.FONT_SIZE.lg)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getColors().textPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)
      
      Row() {
        ForEach(this.weekData, (item: WeekStats) => {
          Column() {
            // 柱状图
            Column() {
              Text(this.formatDistance(item.distance))
                .fontSize(DesignTokens.FONT_SIZE.xs)
                .fontColor(this.getColors().textSecondary)
                .margin({ bottom: DesignTokens.SPACING.xs })
              
              Column()
                .width(30)
                .height(`${this.getBarHeight(item.distance, Math.max(...this.weekData.map(d => d.distance)))}%`)
                .backgroundColor(this.getColors().primaryColor)
                .borderRadius(DesignTokens.RADIUS.sm)
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.End)
            
            // 星期标签
            Text(item.day)
              .fontSize(DesignTokens.FONT_SIZE.xs)
              .fontColor(this.getColors().textTertiary)
              .margin({ top: DesignTokens.SPACING.sm })
          }
          .layoutWeight(1)
        })
      }
      .width('100%')
      .height(150)
      .padding({ top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.sm })
      
      Divider()
        .color(this.getColors().borderColor)
        .margin({ top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.md })
      
      // 次数柱状图
      Text('本周跑步次数')
        .fontSize(DesignTokens.FONT_SIZE.lg)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getColors().textPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)
      
      Row() {
        ForEach(this.weekData, (item: WeekStats) => {
          Column() {
            // 柱状图
            Column() {
              Text(item.runs.toString())
                .fontSize(DesignTokens.FONT_SIZE.xs)
                .fontColor(this.getColors().textSecondary)
                .margin({ bottom: DesignTokens.SPACING.xs })
              
              Column()
                .width(30)
                .height(`${this.getBarHeight(item.runs, Math.max(...this.weekData.map(d => d.runs)))}%`)
                .backgroundColor(this.getColors().secondaryColor)
                .borderRadius(DesignTokens.RADIUS.sm)
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.End)
            
            // 星期标签
            Text(item.day)
              .fontSize(DesignTokens.FONT_SIZE.xs)
              .fontColor(this.getColors().textTertiary)
              .margin({ top: DesignTokens.SPACING.sm })
          }
          .layoutWeight(1)
        })
      }
      .width('100%')
      .height(150)
      .padding({ top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.sm })
    }
    .width('100%')
  }
  
  @Builder
  MonthChart() {
    Column() {
      // 距离柱状图
      Text('本月跑步距离')
        .fontSize(DesignTokens.FONT_SIZE.lg)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getColors().textPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)
      
      Row() {
        ForEach(this.monthData, (item: MonthStats) => {
          Column() {
            // 柱状图
            Column() {
              Text(this.formatDistance(item.distance))
                .fontSize(DesignTokens.FONT_SIZE.xs)
                .fontColor(this.getColors().textSecondary)
                .margin({ bottom: DesignTokens.SPACING.xs })
              
              Column()
                .width(40)
                .height(`${this.getBarHeight(item.distance, Math.max(...this.monthData.map(d => d.distance)))}%`)
                .backgroundColor(this.getColors().primaryColor)
                .borderRadius(DesignTokens.RADIUS.sm)
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.End)
            
            // 周标签
            Text(item.week)
              .fontSize(DesignTokens.FONT_SIZE.xs)
              .fontColor(this.getColors().textTertiary)
              .margin({ top: DesignTokens.SPACING.sm })
          }
          .layoutWeight(1)
        })
      }
      .width('100%')
      .height(150)
      .padding({ top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.sm })
      
      Divider()
        .color(this.getColors().borderColor)
        .margin({ top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.md })
      
      // 次数柱状图
      Text('本月跑步次数')
        .fontSize(DesignTokens.FONT_SIZE.lg)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getColors().textPrimary)
        .width('100%')
        .textAlign(TextAlign.Start)
      
      Row() {
        ForEach(this.monthData, (item: MonthStats) => {
          Column() {
            // 柱状图
            Column() {
              Text(item.runs.toString())
                .fontSize(DesignTokens.FONT_SIZE.xs)
                .fontColor(this.getColors().textSecondary)
                .margin({ bottom: DesignTokens.SPACING.xs })
              
              Column()
                .width(40)
                .height(`${this.getBarHeight(item.runs, Math.max(...this.monthData.map(d => d.runs)))}%`)
                .backgroundColor(this.getColors().secondaryColor)
                .borderRadius(DesignTokens.RADIUS.sm)
            }
            .layoutWeight(1)
            .justifyContent(FlexAlign.End)
            
            // 周标签
            Text(item.week)
              .fontSize(DesignTokens.FONT_SIZE.xs)
              .fontColor(this.getColors().textTertiary)
              .margin({ top: DesignTokens.SPACING.sm })
          }
          .layoutWeight(1)
        })
      }
      .width('100%')
      .height(150)
      .padding({ top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.sm })
    }
    .width('100%')
  }
}
