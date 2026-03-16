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

import { runDataModel, RunRecord } from '../utils/RunDataModel';
import { DesignTokens, type ColorTheme } from '../constants/DesignTokens';
import { common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { ToastComponent } from '../components/Toast';
import { shareService, type RunRecordShareData } from '../services/ShareService';
import { settingsService } from '../services/SettingsService';
import { gpxService } from '../services/GPXService';

@Component
export struct History {
  @State records: RunRecord[] = [];
  @State isDarkMode: boolean = false;
  
  getColors(): ColorTheme {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    const context = getContext(this) as common.UIAbilityContext;
    try {
      await runDataModel.initialize(context);
      shareService.setContext(context);
      settingsService.setContext(context);
      gpxService.setContext(context);
      this.isDarkMode = settingsService.getDarkMode();
      this.loadRecords();
    } catch (error) {
      console.error('History init error:', error);
    }
  }
  
  getIsDarkMode(): boolean {
    return settingsService.getDarkMode();
  }
  
  loadRecords() {
    this.records = runDataModel.getRunRecords();
  }
  
  /**
   * 格式化时间
   */
  formatTime(timestamp: number): string {
    const date = new Date(timestamp);
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    const hour = date.getHours().toString().padStart(2, '0');
    const minute = date.getMinutes().toString().padStart(2, '0');
    return `${month}-${day} ${hour}:${minute}`;
  }
  
  /**
   * 格式化时长
   */
  formatDuration(seconds: number): string {
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = seconds % 60;
    
    if (h > 0) {
      return `${h}:${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
    }
    return `${m.toString().padStart(2, '0')}:${s.toString().padStart(2, '0')}`;
  }
  
  /**
   * 格式化距离
   */
  formatDistance(meters: number): string {
    return `${(meters / 1000).toFixed(2)}km`;
  }
  
  /**
   * 格式化配速
   */
  formatPace(pace: number): string {
    const minutes = Math.floor(pace / 60);
    const seconds = Math.floor(pace % 60);
    return `${minutes}'${seconds.toString().padStart(2, '0')}"`;
  }
  
  /**
   * 格式化轨迹点数量
   */
  formatTrackPoints(count: number): string {
    return `${count} 个点`;
  }
  
  /**
   * 删除记录
   */
  async deleteRecord(index: number) {
    const record = this.records[index];
    await runDataModel.deleteRecord(record.id);
    this.loadRecords();
    ToastComponent.success('已删除', 2000);
  }
  
  /**
   * 分享记录
   */
  async shareRecord(index: number) {
    const record = this.records[index];
    
    const shareData: RunRecordShareData = {
      distance: record.distance,
      duration: record.duration,
      avgPace: this.formatPace(record.pace),
      calories: record.calories,
      date: this.formatTime(record.startTime)
    };
    
    const success = await shareService.shareRunRecord(shareData);
    if (success) {
      ToastComponent.success('分享成功', 2000);
    } else {
      ToastComponent.info('已复制到剪贴板', 2000);
    }
  }
  
  /**
   * 导出 GPX
   */
  async exportGPX(index: number) {
    const record = this.records[index];
    try {
      // 使用记录中的轨迹点导出 GPX
      // 注意：GPXService 需要适配 RunDataModel 的 RunRecord 类型
      ToastComponent.info('GPX 导出功能开发中', 2000);
      hilog.info(0x0000, 'History', 'GPX export requested for record: %s', record.id);
    } catch (error) {
      console.error('Export GPX failed:', error);
      ToastComponent.error('GPX 导出失败', 2000);
    }
  }
  
  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('历史记录')
          .fontSize(DesignTokens.FONT_SIZE.xxl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ top: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.md })
      .justifyContent(FlexAlign.Center)
      
      // 记录列表
      if (this.records.length > 0) {
        List() {
          ForEach(this.records, (record: RunRecord, index: number) => {
            ListItem() {
              Column() {
                // 日期时间
                Row() {
                  Text(this.formatTime(record.startTime))
                    .fontSize(DesignTokens.FONT_SIZE.md)
                    .fontWeight(FontWeight.Medium)
                    .fontColor(this.getColors().textPrimary)
                  
                  Text(this.formatDistance(record.distance))
                    .fontSize(DesignTokens.FONT_SIZE.md)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.getColors().primaryColor)
                    .margin({ left: 'auto' })
                }
                .width('100%')
                
                // 数据行
                Row() {
                  Text(`时长：${this.formatDuration(record.duration)}`)
                    .fontSize(DesignTokens.FONT_SIZE.sm)
                    .fontColor(this.getColors().textSecondary)
                  
                  Text(`配速：${this.formatPace(record.pace)}`)
                    .fontSize(DesignTokens.FONT_SIZE.sm)
                    .fontColor(this.getColors().textSecondary)
                    .margin({ left: DesignTokens.SPACING.lg })
                  
                  Text(`轨迹：${this.formatTrackPoints(record.trackPoints.length)}`)
                    .fontSize(DesignTokens.FONT_SIZE.sm)
                    .fontColor(this.getColors().textSecondary)
                    .margin({ left: DesignTokens.SPACING.lg })
                  
                  Row() {
                    // 分享按钮
                    Button('📤')
                      .fontSize(DesignTokens.FONT_SIZE.sm)
                      .backgroundColor(this.getColors().primaryColor)
                      .fontColor('#FFFFFF')
                      .borderRadius(DesignTokens.RADIUS.sm)
                      .width(40)
                      .height(30)
                      .onClick(() => {
                        this.shareRecord(index);
                      })
                    
                    // 删除按钮
                    Button('删除')
                      .fontSize(DesignTokens.FONT_SIZE.sm)
                      .backgroundColor(this.getColors().errorColor)
                      .fontColor('#FFFFFF')
                      .borderRadius(DesignTokens.RADIUS.sm)
                      .width(60)
                      .height(30)
                      .margin({ left: 8 })
                      .onClick(() => {
                        this.deleteRecord(index);
                      })
                  }
                  .margin({ left: 'auto' })
                }
                .width('100%')
                .margin({ top: DesignTokens.SPACING.sm })
              }
              .width('100%')
              .padding(DesignTokens.SPACING.md)
              .backgroundColor(this.getColors().cardBackground)
              .borderRadius(DesignTokens.RADIUS.lg)
              .margin({ bottom: DesignTokens.SPACING.sm })
            }
          })
        }
        .width('100%')
        .layoutWeight(1)
      } else {
        Column() {
          Text('🏃')
            .fontSize(DesignTokens.FONT_SIZE.icon)
            .margin({ bottom: DesignTokens.SPACING.md })
          
          Text('暂无跑步记录')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontColor(this.getColors().textSecondary)
          
          Text('开始第一次跑步吧！')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textTertiary)
            .margin({ top: DesignTokens.SPACING.sm })
        }
        .width('100%')
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
      }
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
