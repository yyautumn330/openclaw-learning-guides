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

import { PomodoroModel, Achievement } from '../utils/PomodoroModel';
import { DesignTokens } from '../constants/DesignTokens';
import { eventBus, EventType } from '../utils/EventBus';
import { common } from '@kit.AbilityKit';

@Component
export struct Achievements {
  @State achievements: Achievement[] = [];
  @State unlockedCount: number = 0;
  @State totalCount: number = 0;
  @State isDarkMode: boolean = false;
  
  private pomodoroModel: PomodoroModel = PomodoroModel.getInstance();
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    this.isDarkMode = this.pomodoroModel.getIsDarkMode();
    this.loadAchievements();
    this.setupEventBusSubscriptions();
  }
  
  aboutToDisappear() {
    eventBus.offAll();
  }
  
  async onPageShow() {
    // 重新加载深色模式，确保从设置页返回时同步
    this.isDarkMode = this.pomodoroModel.getIsDarkMode();
    await this.loadAchievementsAsync();
  }
  
  setupEventBusSubscriptions(): void {
    eventBus.on(EventType.ACHIEVEMENT_UNLOCKED, (name: string) => {
      console.info('Achievements received ACHIEVEMENT_UNLOCKED event:', name);
      this.loadAchievements();
    });
    
    eventBus.on(EventType.STATISTICS_UPDATED, () => {
      console.info('Achievements received STATISTICS_UPDATED event');
      this.loadAchievements();
    });
    
    // 监听主题变更事件
    eventBus.on(EventType.THEME_CHANGED, (isDark: boolean) => {
      console.info('Achievements received THEME_CHANGED event, isDark:', isDark);
      this.isDarkMode = !!isDark;
    });
  }
  
  /**
   * 加载成就数据
   */
  loadAchievements() {
    try {
      this.achievements = this.pomodoroModel.getAchievements();
      this.totalCount = this.achievements.length;
      this.unlockedCount = this.achievements.filter(a => a.isUnlocked).length;
      console.info('Achievements loadAchievements: unlockedCount=', this.unlockedCount, ', totalCount=', this.totalCount);
    } catch (error) {
      console.error('Achievements loadAchievements error:', error);
    }
  }
  
  /**
   * 异步加载成就数据（用于 onPageShow）
   */
  async loadAchievementsAsync() {
    try {
      // 确保模型已初始化
      if (!this.pomodoroModel) {
        this.pomodoroModel = PomodoroModel.getInstance();
      }
      
      this.achievements = this.pomodoroModel.getAchievements();
      this.totalCount = this.achievements.length;
      this.unlockedCount = this.achievements.filter(a => a.isUnlocked).length;
      console.info('Achievements loadAchievementsAsync: unlockedCount=', this.unlockedCount, ', totalCount=', this.totalCount);
    } catch (error) {
      console.error('Achievements loadAchievementsAsync error:', error);
    }
  }
  
  /**
   * 获取成就进度百分比
   */
  getProgressPercentage(): number {
    if (this.totalCount === 0) return 0;
    return Math.round((this.unlockedCount / this.totalCount) * 100);
  }
  
  @Builder
  buildAchievementCard(achievement: Achievement, index: number) {
    Row() {
      // 成就图标
      Column() {
        Text(achievement.isUnlocked ? achievement.icon : '🔒')
          .fontSize(36)
      }
      .width(60)
      .height(60)
      .backgroundColor(achievement.isUnlocked ? '#FFF3E0' : '#F5F5F5')
      .borderRadius(30)
      .justifyContent(FlexAlign.Center)
      
      // 成就信息
      Column() {
        Row() {
          Text(achievement.name)
            .fontSize(16)
            .fontWeight(FontWeight.Medium)
            .fontColor(achievement.isUnlocked ? this.getColors().textPrimary : this.getColors().textTertiary)
          
          if (achievement.isUnlocked) {
            Text('✅')
              .fontSize(14)
              .margin({ left: 8 })
          }
        }
        .width('100%')
        
        Text(achievement.description)
          .fontSize(13)
          .fontColor(achievement.isUnlocked ? this.getColors().textSecondary : this.getColors().textTertiary)
          .margin({ top: 4 })
        
        if (achievement.isUnlocked && achievement.unlockDate) {
          Text(`解锁于：${achievement.unlockDate}`)
            .fontSize(11)
            .fontColor(this.getColors().primaryColor)
            .margin({ top: 4 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      .margin({ left: 15 })
    }
    .width('100%')
    .padding(15)
    .backgroundColor(this.getColors().cardBackground)
    .borderRadius(12)
    .shadow({
      radius: 4,
      color: 'rgba(0, 0, 0, 0.05)',
      offsetX: 0,
      offsetY: 2
    })
    .opacity(achievement.isUnlocked ? 1 : 0.7)
  }
  
  @Builder
  buildStatCard(title: string, value: string, icon: string) {
    Column() {
      Text(icon)
        .fontSize(28)
        .margin({ bottom: 8 })
      
      Text(value)
        .fontSize(24)
        .fontWeight(FontWeight.Bold)
        .fontColor(this.getColors().primaryColor)
      
      Text(title)
        .fontSize(13)
        .fontColor(this.getColors().textSecondary)
        .margin({ top: 4 })
    }
    .width('30%')
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
  
  build() {
    Column() {
      // 顶部标题栏
      Row() {
        Text('成就')
          .fontSize(24)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ top: 20, bottom: 20, left: 20 })
      
      Scroll() {
        Column() {
          // 进度概览
          Column() {
            Row() {
              Text('成就进度')
                .fontSize(18)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.getColors().textPrimary)
              
              Text(`${this.unlockedCount}/${this.totalCount}`)
                .fontSize(16)
                .fontColor(this.getColors().textSecondary)
                .margin({ left: 10 })
            }
            .width('100%')
            .margin({ bottom: 15 })
            
            // 进度条
            Row() {
              Row() {
                // 填充部分
                Row()
                  .width(`${this.getProgressPercentage()}%`)
                  .height('100%')
                  .backgroundColor(this.getColors().primaryColor)
                  .borderRadius(5)
              }
              .width('100%')
              .height('100%')
              .backgroundColor('#E0E0E0')
              .borderRadius(5)
            }
            .width('100%')
            .height(10)
            
            Row() {
              Text(`${this.getProgressPercentage()}% 已完成`)
                .fontSize(13)
                .fontColor(this.getColors().textSecondary)
            }
            .width('100%')
            .alignItems(VerticalAlign.Top)
            .margin({ top: 8 })
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(12)
          .margin({ bottom: 20 })
          
          // 统计卡片
          Row() {
            this.buildStatCard('已解锁', `${this.unlockedCount}`, '🏆')
            this.buildStatCard('未解锁', `${this.totalCount - this.unlockedCount}`, '🔒')
            this.buildStatCard('完成率', `${this.getProgressPercentage()}%`, '📈')
          }
          .width('100%')
          .justifyContent(FlexAlign.SpaceBetween)
          .margin({ bottom: 20 })
          
          // 成就列表
          Column() {
            Text('成就列表')
              .fontSize(18)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: 15 })
            
            // 已解锁成就
            if (this.unlockedCount > 0) {
              Text(`🎉 已解锁 (${this.unlockedCount})`)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.getColors().primaryColor)
                .margin({ bottom: 10 })
              
              ForEach(
                this.achievements.filter(a => a.isUnlocked),
                (achievement: Achievement, index: number) => {
                  this.buildAchievementCard(achievement, index)
                },
                (achievement: Achievement) => achievement.id
              )
            }
            
            // 未解锁成就
            if (this.unlockedCount < this.totalCount) {
              Text(`🔒 未解锁 (${this.totalCount - this.unlockedCount})`)
                .fontSize(15)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.getColors().textSecondary)
                .margin({ top: 20, bottom: 10 })
              
              ForEach(
                this.achievements.filter(a => !a.isUnlocked),
                (achievement: Achievement, index: number) => {
                  this.buildAchievementCard(achievement, index)
                },
                (achievement: Achievement) => achievement.id
              )
            }
          }
          .width('100%')
          .padding(20)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(12)
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
