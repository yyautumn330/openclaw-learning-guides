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

import { runDataModel } from '../utils/RunDataModel';
import { DesignTokens, type ColorTheme } from '../constants/DesignTokens';
import { common } from '@kit.AbilityKit';

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
      
      // 提示信息
      Column() {
        Text('📊')
          .fontSize(DesignTokens.FONT_SIZE.icon)
          .margin({ bottom: DesignTokens.SPACING.md })
        
        Text('开始跑步后')
          .fontSize(DesignTokens.FONT_SIZE.md)
          .fontColor(this.getColors().textSecondary)
        
        Text('这里会显示详细统计')
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().textTertiary)
          .margin({ top: DesignTokens.SPACING.sm })
      }
      .width('100%')
      .layoutWeight(1)
      .justifyContent(FlexAlign.Center)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
