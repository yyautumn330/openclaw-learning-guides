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

import { PomodoroModel, DailyStats } from '../utils/PomodoroModel';
import { DesignTokens } from '../constants/DesignTokens';
import { eventBus, EventType } from '../utils/EventBus';
import { common } from '@kit.AbilityKit';

@Component
export struct Statistics {
  @State todayCount: number = 0;
  @State todayDuration: number = 0;
  @State totalCount: number = 0;
  @State totalDuration: number = 0;
  @State bestDayCount: number = 0;
  @State bestDayDate: string = '';
  @State weekStats: DailyStats[] = [];
  @State monthStats: DailyStats[] = [];
  @State selectedTab: number = 0; // 0: 周，1: 月
  @State isLoading: boolean = true;
  @State isDarkMode: boolean = false;
  
  private pomodoroModel: PomodoroModel = PomodoroModel.getInstance();
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    this.isDarkMode = this.pomodoroModel.getIsDarkMode();
    this.loadStatistics();
    this.setupEventBusSubscriptions();
  }
  
  aboutToDisappear() {
    eventBus.offAll();
  }
  
  async onPageShow() {
    // 重新加载深色模式，确保从设置页返回时同步
    this.isDarkMode = this.pomodoroModel.getIsDarkMode();
    await this.loadStatisticsAsync();
  }
  
  setupEventBusSubscriptions(): void {
    eventBus.on(EventType.STATISTICS_UPDATED, (completed: number) => {
      console.info('Statistics received STATISTICS_UPDATED event, completed:', completed);
      this.todayCount = completed;
      this.loadStatistics();
    });
    
    // 监听主题变更事件
    eventBus.on(EventType.THEME_CHANGED, (isDark: boolean) => {
      console.info('Statistics received THEME_CHANGED event, isDark:', isDark);
      this.isDarkMode = !!isDark;
    });
  }
  
  /**
   * 加载统计数据
   */
  loadStatistics() {
    try {
      const stats = this.pomodoroModel.getStats();
      
      this.todayCount = stats.today.count;
      this.todayDuration = stats.today.duration;
      this.totalCount = stats.total.count;
      this.totalDuration = stats.total.duration;
      
      if (stats.bestDay) {
        this.bestDayCount = stats.bestDay.completedCount;
        this.bestDayDate = stats.bestDay.date;
      }
      
      this.weekStats = stats.week;
      this.monthStats = stats.month;
      this.isLoading = false;
      
      console.info('Statistics loadStatistics: todayCount=', this.todayCount, ', totalCount=', this.totalCount);
    } catch (error) {
      console.error('Statistics loadStatistics error:', error);
      this.isLoading = false;
    }
  }
  
  /**
   * 异步加载统计数据（用于 onPageShow）
   */
  async loadStatisticsAsync() {
    try {
      // 确保模型已初始化
      if (!this.pomodoroModel) {
        this.pomodoroModel = PomodoroModel.getInstance();
      }
      
      const stats = this.pomodoroModel.getStats();
      
      this.todayCount = stats.today.count;
      this.todayDuration = stats.today.duration;
      this.totalCount = stats.total.count;
      this.totalDuration = stats.total.duration;
      
      if (stats.bestDay) {
        this.bestDayCount = stats.bestDay.completedCount;
        this.bestDayDate = stats.bestDay.date;
      }
      
      this.weekStats = stats.week;
      this.monthStats = stats.month;
      this.isLoading = false;
      
      console.info('Statistics loadStatisticsAsync: todayCount=', this.todayCount, ', totalCount=', this.totalCount);
    } catch (error) {
      console.error('Statistics loadStatisticsAsync error:', error);
      this.isLoading = false;
    }
  }
  
  /**
   * 格式化时长（秒 -> 小时：分钟）
   */
  formatDuration(seconds: number): string {
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    
    if (hours > 0) {
      return `${hours}小时${minutes}分钟`;
    } else {
      return `${minutes}分钟`;
    }
  }
  
  /**
   * 获取当前选中的统计数据
   */
  getCurrentStats(): DailyStats[] {
    return this.selectedTab === 0 ? this.weekStats : this.monthStats;
  }
  
  /**
   * 获取最大值（用于图表缩放）
   */
  getMaxCount(): number {
    const stats = this.getCurrentStats();
    if (stats.length === 0) return 5;
    const max = Math.max(...stats.map(s => s.completedCount), 1);
    const result = Math.ceil(max / 5) * 5; // 向上取整到 5 的倍数
    return result;
  }
  
  /**
   * 获取柱状图高度
   */
  getBarHeight(count: number, maxHeight: number): number {
    const maxCount = this.getMaxCount();
    if (maxCount === 0) return 0;
    return (count / maxCount) * maxHeight;
  }
  
  /**
   * 获取柱状图颜色
   */
  getBarColor(count: number, index: number): string {
    if (count === 0) return '#E0E0E0';
    
    // 今天的数据用主色
    const today = new Date().toLocaleDateString('zh-CN');
    const stat = this.getCurrentStats()[index];
    if (stat.date === today) {
      return this.getColors().primaryColor;
    }
    
    return this.getColors().secondaryColor;
  }
  
  @Builder
  buildStatCard(title: string, value: string, subtitle: string, icon: string) {
    Column() {
      Row() {
        Text(icon)
          .fontSize(24)
        
        Column() {
          Text(value)
            .fontSize(28)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getColors().primaryColor)
          
          Text(title)
            .fontSize(14)
            .fontColor(this.getColors().textSecondary)
            .margin({ top: 4 })
        }
        .alignItems(HorizontalAlign.Start)
        .margin({ left: 12 })
        .layoutWeight(1)
      }
      .width('100%')
      
      if (subtitle) {
        Text(subtitle)
          .fontSize(12)
          .fontColor(this.getColors().textSecondary)
          .margin({ top: 8 })
      }
    }
    .width('48%')
    .padding(15)
    .backgroundColor(this.getColors().cardBackground)
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 2
    })
  }
  
  @Builder
  buildBarChart() {
    Column() {
      // 图表区域
      Row() {
        // Y 轴标签
        Column() {
          Text(`${this.getMaxCount()}`)
            .fontSize(10)
            .fontColor(this.getColors().textSecondary)
          
          Text(`${Math.floor(this.getMaxCount() / 2)}`)
            .fontSize(10)
            .fontColor(this.getColors().textSecondary)
            .margin({ top: 60 })
          
          Text('0')
            .fontSize(10)
            .fontColor(this.getColors().textSecondary)
            .margin({ top: 60 })
        }
        .width(30)
        .justifyContent(FlexAlign.SpaceBetween)
        .height(150)
        .margin({ right: 10 })
        
        // 柱状图
        Row() {
          ForEach(
            this.getCurrentStats(),
            (stat: DailyStats, index: number) => {
              Column() {
                // 柱子
                Row() {
                  Column()
                    .width('100%')
                    .height(this.getBarHeight(stat.completedCount, 150))
                    .backgroundColor(this.getBarColor(stat.completedCount, index))
                    .borderRadius(4)
                    .position({ y: 150 - this.getBarHeight(stat.completedCount, 150) })
                }
                .width(30)
                .height(150)
                .alignItems(VerticalAlign.Bottom)
                
                // X 轴标签
                Text(this.getShortDate(stat.date))
                  .fontSize(10)
                  .fontColor(this.getColors().textSecondary)
                  .margin({ top: 8 })
              }
              .width(40)
            },
            (stat: DailyStats, index: number) => index.toString()
          )
        }
        .height(180)
        .alignItems(VerticalAlign.Bottom)
      }
      .width('100%')
      .height(180)
    }
    .width('100%')
    .padding(15)
  }
  
  /**
   * 获取简短日期显示
   */
  getShortDate(dateStr: string): string {
    const parts = dateStr.split('/');
    if (parts.length >= 2) {
      return `${parts[1]}/${parts[2]}`;
    }
    return dateStr;
  }
  
  /**
   * 获取星期几
   */
  getWeekDay(dateStr: string): string {
    const today = new Date().toLocaleDateString('zh-CN');
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    const yesterdayStr = yesterday.toLocaleDateString('zh-CN');
    
    if (dateStr === today) return '今天';
    if (dateStr === yesterdayStr) return '昨天';
    
    const date = new Date(dateStr);
    const weekdays = ['日', '一', '二', '三', '四', '五', '六'];
    return `周${weekdays[date.getDay()]}`;
  }
  
  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('统计')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ top: 20, bottom: 20, left: 20 })
      
      Scroll() {
        Column() {
          // 今日统计
          Column() {
            Text('今日统计')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: 15 })
            
            Row() {
              this.buildStatCard(
                '完成番茄',
                `${this.todayCount}`,
                '个',
                '🍅'
              )
              this.buildStatCard(
                '专注时长',
                this.formatDuration(this.todayDuration),
                '',
                '⏱️'
              )
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(12)
          .margin({ bottom: 20 })
          
          // 总计统计
          Column() {
            Text('总计统计')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: 15 })
            
            Row() {
              this.buildStatCard(
                '完成番茄',
                `${this.todayCount}`,
                '个',
                '🍅'
              )
              this.buildStatCard(
                '专注时长',
                this.formatDuration(this.todayDuration),
                '',
                '⏱️'
              )
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(12)
          .margin({ bottom: 20 })
          
          // 总计统计
          Column() {
            Text('总计统计')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: 15 })
            
            Row() {
              this.buildStatCard(
                '总番茄数',
                `${this.totalCount}`,
                '个',
                '🎯'
              )
              this.buildStatCard(
                '总专注时长',
                this.formatDuration(this.totalDuration),
                '',
                '📊'
              )
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(12)
          .margin({ bottom: 20 })
          
          // 最佳记录
          if (this.bestDayCount > 0) {
            Column() {
              Text('🏆 最佳记录')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getColors().textPrimary)
                .margin({ bottom: 15 })
              
              Row() {
                Column() {
                  Text(`${this.bestDayCount}`)
                    .fontSize(36)
                    .fontWeight(FontWeight.Bold)
                    .fontColor(this.getColors().primaryColor)
                  
                  Text('个番茄')
                    .fontSize(14)
                    .fontColor(this.getColors().textSecondary)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Center)
                
                Column() {
                  Text(this.bestDayDate)
                    .fontSize(16)
                    .fontColor(this.getColors().textPrimary)
                    .margin({ top: 8 })
                  
                  Text('单日最高记录')
                    .fontSize(13)
                    .fontColor(this.getColors().textSecondary)
                    .margin({ top: 4 })
                }
                .alignItems(HorizontalAlign.Start)
                .margin({ left: 20 })
                .layoutWeight(1)
              }
              .width('100%')
              .padding(15)
              .backgroundColor('#FFF3E0')
              .borderRadius(12)
            }
            .width('100%')
            .padding(20)
            .backgroundColor(this.getColors().cardBackground)
            .borderRadius(12)
            .margin({ bottom: 20 })
          }
          
          // 趋势图表
          Column() {
            Row() {
              Text('📈 趋势图')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getColors().textPrimary)
              
              // 切换器
              Row() {
                Text('周')
                  .fontSize(14)
                  .fontColor(this.selectedTab === 0 ? '#FFFFFF' : this.getColors().textSecondary)
                  .padding({ left: 15, right: 15, top: 6, bottom: 6 })
                  .backgroundColor(this.selectedTab === 0 ? this.getColors().primaryColor : 'transparent')
                  .borderRadius(15)
                  .onClick(() => {
                    this.selectedTab = 0;
                  })
                
                Text('月')
                  .fontSize(14)
                  .fontColor(this.selectedTab === 1 ? '#FFFFFF' : this.getColors().textSecondary)
                  .padding({ left: 15, right: 15, top: 6, bottom: 6 })
                  .backgroundColor(this.selectedTab === 1 ? this.getColors().primaryColor : 'transparent')
                  .borderRadius(15)
                  .margin({ left: 5 })
                  .onClick(() => {
                    this.selectedTab = 1;
                  })
              }
              .backgroundColor('#F0F0F0')
              .borderRadius(18)
              .padding(3)
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: 15 })
            
            // 柱状图
            this.buildBarChart()
            
            // 图例
            Row() {
              Row() {
                Row()
                  .width(12)
                  .height(12)
                  .backgroundColor(this.getColors().primaryColor)
                  .borderRadius(3)
                  .margin({ right: 6 })
                
                Text('今天')
                  .fontSize(12)
                  .fontColor(this.getColors().textSecondary)
              }
              
              Row() {
                Row()
                  .width(12)
                  .height(12)
                  .backgroundColor(this.getColors().secondaryColor)
                  .borderRadius(3)
                  .margin({ right: 6 })
                  .margin({ left: 15 })
                
                Text('其他')
                  .fontSize(12)
                  .fontColor(this.getColors().textSecondary)
              }
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
            .margin({ top: 10 })
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(12)
          
          // 每日详情
          Column() {
            Text('每日详情')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: 15 })
            
            ForEach(
              this.getCurrentStats().filter(s => s.completedCount > 0),
              (stat: DailyStats, index: number) => {
                Row() {
                  Column() {
                    Text(this.getWeekDay(stat.date))
                      .fontSize(15)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.getColors().textPrimary)
                    
                    Text(stat.date)
                      .fontSize(12)
                      .fontColor(this.getColors().textSecondary)
                      .margin({ top: 4 })
                  }
                  .alignItems(HorizontalAlign.Start)
                  .layoutWeight(1)
                  
                  Row() {
                    Text('🍅')
                      .fontSize(16)
                      .margin({ right: 6 })
                    
                    Text(`${stat.completedCount}`)
                      .fontSize(16)
                      .fontWeight(FontWeight.Medium)
                      .fontColor(this.getColors().primaryColor)
                  }
                  
                  Row() {
                    Text('⏱️')
                      .fontSize(16)
                      .margin({ left: 15, right: 6 })
                    
                    Text(this.formatDuration(stat.focusDuration))
                      .fontSize(14)
                      .fontColor(this.getColors().textSecondary)
                  }
                  .margin({ left: 20 })
                }
                .width('100%')
                .padding({ top: 12, bottom: 12 })
              },
              (stat: DailyStats, index: number) => stat.date
            )
            
            if (this.getCurrentStats().filter(s => s.completedCount > 0).length === 0) {
              Text('暂无数据，开始专注吧！')
                .fontSize(14)
                .fontColor(this.getColors().textSecondary)
                .width('100%')
                .textAlign(TextAlign.Center)
                .padding(20)
            }
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(12)
          .margin({ top: 20 })
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
