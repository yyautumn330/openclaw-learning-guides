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
import { common } from '@kit.AbilityKit';
import { StatsChart } from '../components/StatsChart';

/**
 * 跑步记录简要信息
 */
interface RunSummary {
  startTime: number;
  distance: number;
  duration: number;
  calories: number;
}

@Component
export struct Statistics {
  @State totalRuns: number = 0;
  @State totalDistance: number = 0;
  @State totalDuration: number = 0;
  @State isDarkMode: boolean = false;
  
  getColors(): ColorTheme {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    const context = getContext(this) as common.UIAbilityContext;
    try {
      await runDataModel.initialize(context);
      this.isDarkMode = this.getIsDarkMode();
      this.loadStatistics();
    } catch (error) {
      console.error('Statistics init error:', error);
    }
  }
  
  getIsDarkMode(): boolean {
    return false;
  }
  
  loadStatistics() {
    this.totalRuns = runDataModel.getTotalRuns();
    this.totalDistance = runDataModel.getTotalDistance();
    this.totalDuration = runDataModel.getTotalDuration();
  }
  
  /**
   * 格式化时长
   */
  formatDuration(seconds: number): string {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    
    if (h > 0) {
      return `${h}小时${m}分钟`;
    }
    return `${m}分钟`;
  }
  
  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('数据统计')
          .fontSize(DesignTokens.FONT_SIZE.xxl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ top: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.md })
      .justifyContent(FlexAlign.Center)
      
      // 总数据卡片
      Row() {
        Column() {
          Text(this.totalRuns.toString())
            .fontSize(DesignTokens.FONT_SIZE.stat)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getColors().primaryColor)
          Text('总次数')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
        }
        .layoutWeight(1)
        
        Column() {
          Text(`${(this.totalDistance / 1000).toFixed(1)}`)
            .fontSize(DesignTokens.FONT_SIZE.stat)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getColors().primaryColor)
          Text('总公里')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
        }
        .layoutWeight(1)
        
        Column() {
          Text(this.formatDuration(this.totalDuration))
            .fontSize(DesignTokens.FONT_SIZE.stat)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getColors().primaryColor)
          Text('总时长')
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
      
      // 统计图表
      Scroll() {
        Column() {
          // 图表组件
          StatsChart({
            isDarkMode: this.isDarkMode
          })
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })
          
          // 详细数据列表
          if (this.totalRuns > 0) {
            Column() {
              Text('最近跑步记录')
                .fontSize(DesignTokens.FONT_SIZE.lg)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getColors().textPrimary)
                .width('100%')
                .textAlign(TextAlign.Start)
                .margin({ bottom: DesignTokens.SPACING.md })
              
              ForEach(this.getRecentRuns(), (run: RunSummary) => {
                this.RunListItem(run)
              })
            }
            .width('100%')
            .padding(DesignTokens.SPACING.lg)
            .backgroundColor(this.getColors().cardBackground)
            .borderRadius(DesignTokens.RADIUS.lg)
          }
        }
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
  
  /**
   * 获取最近跑步记录
   */
  getRecentRuns(): RunSummary[] {
    const records = runDataModel.getRunRecords();
    const result: RunSummary[] = [];
    for (let i = 0; i < Math.min(5, records.length); i++) {
      result.push({
        startTime: records[i].startTime,
        distance: records[i].distance,
        duration: records[i].duration,
        calories: records[i].calories
      });
    }
    return result;
  }
  
  @Builder
  RunListItem(run: RunSummary) {
    Row() {
      Column() {
        Text(this.formatDate(run.startTime))
          .fontSize(DesignTokens.FONT_SIZE.md)
          .fontColor(this.getColors().textPrimary)
          .fontWeight(FontWeight.Medium)
        
        Text(this.formatTime(run.startTime))
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().textSecondary)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Start)
      
      Column() {
        Text(`${(run.distance / 1000).toFixed(2)} km`)
          .fontSize(DesignTokens.FONT_SIZE.md)
          .fontColor(this.getColors().primaryColor)
          .fontWeight(FontWeight.Bold)
        
        Text(this.formatDuration(run.duration))
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().textSecondary)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.Center)
      
      Column() {
        Text(`${Math.round(run.calories)} cal`)
          .fontSize(DesignTokens.FONT_SIZE.md)
          .fontColor(this.getColors().secondaryColor)
          .fontWeight(FontWeight.Medium)
      }
      .layoutWeight(1)
      .alignItems(HorizontalAlign.End)
    }
    .width('100%')
    .padding({ top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.md })
    .border({ width: 1, color: this.getColors().borderColor })
  }
  
  /**
   * 格式化日期
   */
  formatDate(timestamp: number): string {
    const date = new Date(timestamp);
    const month = date.getMonth() + 1;
    const day = date.getDate();
    return `${month}/${day}`;
  }
  
  /**
   * 格式化时间
   */
  formatTime(timestamp: number): string {
    const date = new Date(timestamp);
    const hour = date.getHours().toString().padStart(2, '0');
    const minute = date.getMinutes().toString().padStart(2, '0');
    return `${hour}:${minute}`;
  }
}
