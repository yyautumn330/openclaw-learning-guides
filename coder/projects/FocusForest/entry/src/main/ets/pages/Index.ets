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

import { PomodoroModel } from '../utils/PomodoroModel';
import { TreeModel, TreeType } from '../utils/TreeModel';
import { BackgroundTaskService } from '../services/BackgroundTaskService';
import { eventBus, EventType } from '../utils/EventBus';
import { common } from '@kit.AbilityKit';
import { DesignTokens } from '../constants/DesignTokens';
import { ToastComponent, ToastType } from '../components/Toast';
import { TreeCard } from '../components/TreeCard';
import { Forest } from './Forest';
import { Sounds } from './Sounds';
import { Profile } from './Profile';

@Entry
@Component
struct Index {
  @State pomodoroModel: PomodoroModel = PomodoroModel.getInstance();
  @State treeModel: TreeModel = TreeModel.getInstance();
  @State remainingTime: string = '25:00';
  @State isRunning: boolean = false;
  @State isPaused: boolean = false;
  @State isDarkMode: boolean = false;
  @State currentTreeType: TreeType = TreeType.SEEDLING;
  @State selectedSound: string = '雨声';
  @State currentIndex: number = 0;
  
  private timerId: number = -1;
  private backgroundTaskService: BackgroundTaskService = BackgroundTaskService.getInstance();
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    await this.initModel();
  }
  
  aboutToDisappear() {
    this.stopUITimer();
    eventBus.offAll();
  }
  
  async initModel() {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      await this.pomodoroModel.initialize(context);
      await this.treeModel.initialize(context);
      
      this.isDarkMode = this.pomodoroModel.getIsDarkMode();
      const settings = this.pomodoroModel.getSettings();
      const duration = settings.pomodoroDuration * 60;
      this.pomodoroModel.setRemainingTime(duration);
      this.updateTimeDisplay();
      this.updateCurrentTree();
      
      // 设置后台服务回调
      this.setupBackgroundServiceCallbacks();
    } catch (error) {
      console.error('Index initModel error:', error);
    }
  }
  
  setupBackgroundServiceCallbacks() {
    this.backgroundTaskService.setCallbacks(
      // 计时器滴答回调
      (remainingTime: number) => {
        this.pomodoroModel.setRemainingTime(remainingTime);
        this.updateTimeDisplay();
      },
      // 计时器完成回调 - 种树逻辑
      async () => {
        await this.onTimerComplete();
      }
    );
  }
  
  updateTimeDisplay() {
    this.remainingTime = this.pomodoroModel.getFormattedTime();
  }
  
  startUITimer() {
    this.stopUITimer();
    this.timerId = setInterval(() => {
      this.updateTimeDisplay();
    }, 1000);
  }
  
  stopUITimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }
  }
  
  async startTimer() {
    if (this.isRunning && !this.isPaused) return;
    
    this.isRunning = true;
    this.isPaused = false;
    this.pomodoroModel.setIsRunning(true);
    this.pomodoroModel.setIsPaused(false);
    
    const settings = this.pomodoroModel.getSettings();
    const duration = settings.pomodoroDuration * 60;
    this.pomodoroModel.setRemainingTime(duration);
    
    // 集成后台服务
    await this.backgroundTaskService.startTimer();
    
    this.startUITimer();
    
    ToastComponent.success(`开始专注 ${settings.pomodoroDuration} 分钟`, 2000);
  }
  
  pauseTimer() {
    if (!this.isRunning) return;
    
    this.isPaused = true;
    this.pomodoroModel.setIsPaused(true);
    this.stopUITimer();
  }
  
  resumeTimer() {
    if (!this.isPaused) return;
    
    this.isPaused = false;
    this.pomodoroModel.setIsPaused(false);
    this.startUITimer();
  }
  
  resetTimer() {
    this.stopUITimer();
    const settings = this.pomodoroModel.getSettings();
    const duration = settings.pomodoroDuration * 60;
    this.pomodoroModel.setRemainingTime(duration);
    
    this.isRunning = false;
    this.isPaused = false;
    this.updateTimeDisplay();
    this.updateCurrentTree();
  }
  
  async onTimerComplete() {
    // 停止 UI 定时器
    this.stopUITimer();
    
    // 增加专注时长
    const settings = this.pomodoroModel.getSettings();
    await this.treeModel.addFocusMinutes(settings.pomodoroDuration);
    
    // 种树
    await this.treeModel.plantTree(this.currentTreeType, settings.pomodoroDuration);
    
    // 发送事件通知
    eventBus.emit(EventType.TREE_PLANTED, {
      treeType: this.currentTreeType,
      duration: settings.pomodoroDuration
    });
    
    ToastComponent.success(`🌱 专注完成！种下了一棵${this.getTreeName()}`, 3000);
    
    // 重置运行状态
    this.isRunning = false;
    this.isPaused = false;
    this.updateCurrentTree();
  }
  
  updateCurrentTree() {
    const totalMinutes = this.treeModel.getTotalFocusMinutes();
    const availableSeeds = this.treeModel.getAvailableSeeds();
    
    if (availableSeeds.length > 0) {
      const bestSeed = availableSeeds[availableSeeds.length - 1];
      this.currentTreeType = bestSeed.type;
    } else {
      this.currentTreeType = TreeType.SEEDLING;
    }
  }
  
  getButtonText(): string {
    if (!this.isRunning) return '开始专注';
    if (this.isPaused) return '继续';
    return '暂停';
  }
  
  getTreeName(): string {
    switch (this.currentTreeType) {
      case TreeType.SEEDLING: return '幼苗';
      case TreeType.PINE: return '松树';
      case TreeType.OAK: return '橡树';
      case TreeType.CHERRY: return '樱花树';
      case TreeType.MAPLE: return '枫树';
      case TreeType.BAMBOO: return '竹子';
      case TreeType.PALM: return '棕榈树';
      case TreeType.RARE_GOLDEN: return '金色传说树';
      default: return '树苗';
    }
  }
  
  getTreeEmoji(): string {
    switch (this.currentTreeType) {
      case TreeType.SEEDLING: return '🌱';
      case TreeType.PINE: return '🌲';
      case TreeType.OAK: return '🌳';
      case TreeType.CHERRY: return '🌸';
      case TreeType.MAPLE: return '🍁';
      case TreeType.BAMBOO: return '🎋';
      case TreeType.PALM: return '🌴';
      case TreeType.RARE_GOLDEN: return '🌟';
      default: return '🌱';
    }
  }
  
  @Builder
  buildTabBar(title: string, emoji: string, index: number) {
    Column() {
      Text(emoji)
        .fontSize(DesignTokens.FONT_SIZE.md)
        .fontColor(this.currentIndex === index ? this.getColors().primaryColor : this.getColors().textSecondary)
        .margin({ bottom: DesignTokens.SPACING.xs })
      
      Text(title)
        .fontSize(DesignTokens.FONT_SIZE.xs)
        .fontColor(this.currentIndex === index ? this.getColors().primaryColor : this.getColors().textSecondary)
    }
    .justifyContent(FlexAlign.Center)
  }
  
  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
      // Tab 1: 首页
      TabContent() {
        Column() {
          // 顶部标题栏
          Row() {
            Text('专注森林')
              .fontSize(DesignTokens.FONT_SIZE.xxl)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
          }
          .width('100%')
          .padding({ 
            top: DesignTokens.SPACING.lg, 
            bottom: DesignTokens.SPACING.md,
            left: DesignTokens.SPACING.lg 
          })
          
          // 树木展示区
          Column() {
            Text(this.getTreeName())
              .fontSize(DesignTokens.FONT_SIZE.md)
              .fontColor(this.getColors().textSecondary)
              .margin({ bottom: DesignTokens.SPACING.sm })
            
            Text(this.getTreeEmoji())
              .fontSize(DesignTokens.FONT_SIZE.icon)
              .animation({
                duration: DesignTokens.ANIMATION.normal,
                curve: Curve.EaseInOut
              })
          }
          .width('100%')
          .padding({ top: DesignTokens.SPACING.xl })
          
          // 计时器区域
          Column() {
            Text(this.remainingTime)
              .fontSize(DesignTokens.FONT_SIZE.timer)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().primaryColor)
              .fontFamily('monospace')
              .margin({ bottom: DesignTokens.SPACING.md })
            
            Row() {
              Text('🎵')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .margin({ right: DesignTokens.SPACING.xs })
              Text(this.selectedSound)
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontColor(this.getColors().textSecondary)
            }
            .padding({ 
              left: DesignTokens.SPACING.md, 
              right: DesignTokens.SPACING.md, 
              top: DesignTokens.SPACING.sm, 
              bottom: DesignTokens.SPACING.sm 
            })
            .backgroundColor(this.getColors().cardBackground)
            .borderRadius(DesignTokens.RADIUS.lg)
          }
          .width('100%')
          .padding({ top: DesignTokens.SPACING.xl })
          
          // 控制按钮区
          Row() {
            Button(this.getButtonText())
              .width(DesignTokens.BUTTON.width)
              .height(DesignTokens.BUTTON.height)
              .fontSize(DesignTokens.FONT_SIZE.lg)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(this.getColors().primaryColor)
              .fontColor('#FFFFFF')
              .borderRadius(DesignTokens.RADIUS.xl)
              .margin({ right: DesignTokens.SPACING.md })
              .onClick(() => {
                if (!this.isRunning) {
                  this.startTimer();
                } else if (this.isPaused) {
                  this.resumeTimer();
                } else {
                  this.pauseTimer();
                }
              })
            
            Button('重置')
              .width(DesignTokens.BUTTON.smallWidth)
              .height(DesignTokens.BUTTON.height)
              .fontSize(DesignTokens.FONT_SIZE.lg)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(this.getColors().secondaryColor)
              .fontColor('#FFFFFF')
              .borderRadius(DesignTokens.RADIUS.xl)
              .onClick(() => {
                this.resetTimer();
              })
          }
          .width('100%')
          .padding({ top: DesignTokens.SPACING.xl })
          .justifyContent(FlexAlign.Center)
        }
        .width('100%')
        .height('100%')
        .backgroundColor(this.getColors().backgroundColor)
      }
      .tabBar(this.buildTabBar('首页', '🏠', 0))
      
      // Tab 2: 森林
      TabContent() {
        Forest()
      }
      .tabBar(this.buildTabBar('森林', '🌲', 1))
      
      // Tab 3: 音效
      TabContent() {
        Sounds()
      }
      .tabBar(this.buildTabBar('音效', '🎵', 2))
      
      // Tab 4: 我的
      TabContent() {
        Profile()
      }
      .tabBar(this.buildTabBar('我的', '👤', 3))
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
    .onChange((index: number) => {
      this.currentIndex = index;
    })
  }
}
