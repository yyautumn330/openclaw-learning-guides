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
import { NotificationUtil } from '../utils/NotificationUtil';
import { BackgroundTaskService } from '../services/BackgroundTaskService';
import { eventBus, EventType } from '../utils/EventBus';
import { common } from '@kit.AbilityKit';
import { Statistics } from './Statistics';
import { Achievements } from './Achievements';
import { Settings } from './Settings';
import { DesignTokens } from '../constants/DesignTokens';
import { ToastComponent, ToastType } from '../components/Toast';

@Entry
@Component
struct Index {
  @State pomodoroModel: PomodoroModel = PomodoroModel.getInstance();
  @State remainingTime: string = '25:00';
  @State isRunning: boolean = false;
  @State isPaused: boolean = false;
  @State todayCompleted: number = 0;
  @State statusText: string = '专注 25 分钟，休息 5 分钟';
  @State isDarkMode: boolean = false; // P1 改进：深色模式支持
  private timerId: number = -1;
  
  // 后台任务服务
  private backgroundTaskService: BackgroundTaskService = BackgroundTaskService.getInstance();
  
  // P1 改进：使用 DesignTokens 替代硬编码颜色
  private getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    // 初始化模型（必须先于其他操作，确保设置已加载）
    await this.initModel();
    
    // 页面加载时初始化（在 initModel 完成后执行）
    this.updateTimeDisplay();
    this.todayCompleted = this.pomodoroModel.getTodayCompleted();
    
    // 设置后台任务服务的回调
    this.setupBackgroundServiceCallbacks();
    
    // 从后台服务恢复状态（如果是从后台切回）
    this.restoreTimerState();
    
    // 将 pomodoroModel 传递给后台服务，使其能获取最新设置
    this.backgroundTaskService.setPomodoroModel(this.pomodoroModel);
    
    // P1 改进：订阅事件总线，实现跨组件状态同步
    this.setupEventBusSubscriptions();
  }
  
  aboutToDisappear() {
    // 页面销毁时停止 UI 定时器，但保留后台服务运行
    this.stopUITimer();
    
    // P1 改进：取消所有事件订阅，防止内存泄漏
    eventBus.offAll();
  }
  
  /**
   * 初始化模型
   */
  async initModel() {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      await this.pomodoroModel.initialize(context);
      this.todayCompleted = this.pomodoroModel.getTodayCompleted();
      
      // 加载深色模式设置
      this.isDarkMode = this.pomodoroModel.getIsDarkMode();
      
      // 根据设置更新显示时间和状态文字
      const settings = this.pomodoroModel.getSettings();
      const duration = settings.pomodoroDuration * 60;
      this.pomodoroModel.setRemainingTime(duration);
      this.updateTimeDisplay();
      
      // Bug 3 修复：初始化状态文字
      this.statusText = `专注 ${settings.pomodoroDuration}分钟，休息 ${settings.shortBreakDuration}分钟`;
    } catch (error) {
      console.error('Index initModel error:', error);
    }
  }
  
  async onPageShow() {
    // 每次页面显示时重新加载设置和深色模式，确保设置变更后生效
    await this.reloadSettings();
    this.isDarkMode = this.pomodoroModel.getIsDarkMode();
  }
  
  /**
   * 重新加载设置（用于 onPageShow）
   * 当用户从设置页返回首页时，确保使用最新的设置值
   */
  async reloadSettings() {
    try {
      // 关键修复：从 Preferences 重新加载设置，确保获取最新值
      // 因为 Settings.ets 和 Index.ets 使用不同的 PomodoroModel 实例
      await this.pomodoroModel.reloadSettings();
      
      const settings = this.pomodoroModel.getSettings();
      const duration = settings.pomodoroDuration * 60;
      
      // Bug 3 修复：动态更新状态文字描述
      this.statusText = `专注 ${settings.pomodoroDuration}分钟，休息 ${settings.shortBreakDuration}分钟`;
      
      // 无论计时器是否运行，都更新时间显示
      // 如果计时器正在运行，用户可能刚修改了设置，应该立即生效
      this.pomodoroModel.setRemainingTime(duration);
      this.backgroundTaskService.setRemainingTime(duration);
      this.updateTimeDisplay();
      
      this.todayCompleted = this.pomodoroModel.getTodayCompleted();
      
      console.info('Index reloadSettings: pomodoroDuration=', settings.pomodoroDuration, ', remainingTime=', this.remainingTime, ', statusText=', this.statusText);
    } catch (error) {
      console.error('Index reloadSettings error:', error);
    }
  }
  
  /**
   * 设置后台服务回调
   */
  setupBackgroundServiceCallbacks() {
    this.backgroundTaskService.setCallbacks(
      // 计时器滴答回调
      (remainingTime: number) => {
        // 更新模型和 UI
        this.pomodoroModel.setRemainingTime(remainingTime);
        this.updateTimeDisplay();
      },
      // 计时器完成回调
      () => {
        this.onTimerComplete();
      }
    );
  }
  
  /**
   * P1 改进：设置事件总线订阅
   */
  setupEventBusSubscriptions(): void {
    eventBus.on(EventType.SETTINGS_CHANGED, () => {
      console.info('Index received SETTINGS_CHANGED event');
      this.reloadSettings();
      ToastComponent.info('设置已同步', 1500);
    });
    
    eventBus.on(EventType.THEME_CHANGED, (isDark: boolean) => {
      console.info('Index received THEME_CHANGED event, isDark:', isDark, ', before:', this.isDarkMode);
      this.isDarkMode = !!isDark;
      console.info('Index THEME_CHANGED updated, isDarkMode:', this.isDarkMode);
    });
    
    eventBus.on(EventType.STATISTICS_UPDATED, (completed: number) => {
      this.todayCompleted = completed;
      console.info('Index received STATISTICS_UPDATED event, completed:', this.todayCompleted);
    });
    
    eventBus.on(EventType.ACHIEVEMENT_UNLOCKED, (name: string) => {
      ToastComponent.success(`🏆 解锁成就：${name}`, 3000);
      console.info('Index received ACHIEVEMENT_UNLOCKED event:', name);
    });
  }
  
  /**
   * 恢复计时器状态（从后台切回时）
   */
  restoreTimerState() {
    const serviceRunning = this.backgroundTaskService.getIsRunning();
    const serviceRemainingTime = this.backgroundTaskService.getRemainingTime();
    const settings = this.pomodoroModel.getSettings();
    const standardDuration = settings.pomodoroDuration * 60;
    
    if (serviceRunning && serviceRemainingTime < standardDuration) {
      // 后台服务正在运行，同步状态
      this.isRunning = true;
      this.isPaused = false;
      this.pomodoroModel.setIsRunning(true);
      this.pomodoroModel.setIsPaused(false);
      this.pomodoroModel.setRemainingTime(serviceRemainingTime);
      this.updateTimeDisplay();
      
      // 启动 UI 定时器用于页面显示更新
      this.startUITimer();
    }
  }
  
  /**
   * 更新显示时间
   */
  updateTimeDisplay() {
    this.remainingTime = this.pomodoroModel.getFormattedTime();
  }
  
  /**
   * 启动 UI 定时器（仅用于页面显示）
   * P0 修复：确保先清理旧定时器，防止内存泄漏
   */
  startUITimer() {
    // 关键修复：先停止旧定时器，确保不会创建多个定时器
    this.stopUITimer();
    
    this.timerId = setInterval(() => {
      // UI 定时器只负责触发页面刷新，实际计时由后台服务管理
      this.updateTimeDisplay();
    }, 1000);
    
    console.info('Index startUITimer: UI timer started');
  }
  
  /**
   * 停止 UI 定时器
   * P0 修复：确保定时器被正确清理
   */
  stopUITimer() {
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
      console.info('Index stopUITimer: UI timer stopped');
    }
  }
  
  /**
   * 开始计时器
   */
  startTimer() {
    if (this.isRunning && !this.isPaused) {
      return; // 已经在运行
    }
    
    this.isRunning = true;
    this.isPaused = false;
    this.pomodoroModel.setIsRunning(true);
    this.pomodoroModel.setIsPaused(false);
    
    // Bug 修复：从设置中读取最新的番茄时长，确保首次启动时从用户设置的时长开始
    const settings = this.pomodoroModel.getSettings();
    const duration = settings.pomodoroDuration * 60;
    this.pomodoroModel.setRemainingTime(duration);
    this.backgroundTaskService.setRemainingTime(duration);
    
    // 启动后台服务计时器（会在后台继续运行）
    this.backgroundTaskService.startTimer();
    
    // 启动 UI 定时器用于页面显示
    this.startUITimer();
    
    // P1 改进：发布事件并显示 Toast
    eventBus.emitTimerStarted(settings.pomodoroDuration);
    ToastComponent.success(`开始专注 ${settings.pomodoroDuration} 分钟`, 2000);
    
    console.info('Index startTimer: started with duration=', duration, 'seconds');
  }
  
  /**
   * 暂停计时器
   */
  pauseTimer() {
    if (!this.isRunning) {
      return;
    }
    
    this.isPaused = true;
    this.pomodoroModel.setIsPaused(true);
    
    // 暂停后台服务计时器
    this.backgroundTaskService.pauseTimer();
    
    // 停止 UI 定时器
    this.stopUITimer();
  }
  
  /**
   * 继续计时器
   */
  resumeTimer() {
    if (!this.isPaused) {
      return;
    }
    
    this.isPaused = false;
    this.pomodoroModel.setIsPaused(false);
    
    // 继续后台服务计时器
    this.backgroundTaskService.resumeTimer();
    
    // 启动 UI 定时器
    this.startUITimer();
  }
  
  /**
   * 停止计时器
   */
  stopTimer() {
    // 停止后台服务计时器
    this.backgroundTaskService.stopTimer();
    
    // 停止 UI 定时器
    this.stopUITimer();
    
    this.isRunning = false;
    this.isPaused = false;
    this.pomodoroModel.setIsRunning(false);
    this.pomodoroModel.setIsPaused(false);
  }
  
  /**
   * 重置计时器
   */
  async resetTimer() {
    // Bug 1 修复：先停止后台服务计时器，确保重置后不会继续运行
    this.backgroundTaskService.stopTimer();
    
    // Bug 2 修复：重新加载设置，确保使用最新的番茄时长
    await this.reloadSettings();
    
    // 重置模型状态（会使用最新的 settings.pomodoroDuration）
    this.pomodoroModel.reset();
    
    // 更新 UI 状态
    this.isRunning = false;
    this.isPaused = false;
    this.stopUITimer();
    this.updateTimeDisplay();
    this.todayCompleted = this.pomodoroModel.getTodayCompleted();
    
    console.info('Index resetTimer: timer reset to', this.remainingTime);
  }
  
  /**
   * 计时器完成
   */
  async onTimerComplete() {
    // 停止 UI 定时器
    this.stopUITimer();
    
    // 增加完成数
    await this.pomodoroModel.incrementCompleted();
    this.todayCompleted = this.pomodoroModel.getTodayCompleted();
    
    // 发送通知（后台服务也会发送，这里作为双重保险）
    await NotificationUtil.publishNotification(
      '🍅 番茄钟完成！',
      '恭喜完成一个番茄钟，休息一下吧！'
    );
    
    // P1 改进：发布事件和 Toast 反馈
    eventBus.emitStatisticsUpdated(this.todayCompleted);
    eventBus.emitTimerCompleted();
    ToastComponent.success('🍅 番茄钟完成！休息一下吧', 3000);
    
    // 关键修复：重新加载设置，确保使用最新的番茄时长
    await this.reloadSettings();
    
    // 重置计时器（会使用最新的 settings.pomodoroDuration）
    this.pomodoroModel.reset();
    this.updateTimeDisplay();
    
    // 重置运行状态
    this.isRunning = false;
    this.isPaused = false;
    
    console.info('Index onTimerComplete: timer completed and reset to', this.remainingTime);
  }
  
  /**
   * 处理开始/暂停按钮点击
   */
  handleStartPauseClick() {
    if (!this.isRunning) {
      // 开始
      this.startTimer();
    } else if (this.isPaused) {
      // 继续
      this.resumeTimer();
    } else {
      // 暂停
      this.pauseTimer();
    }
  }
  
  @State currentIndex: number = 0;
  
  build() {
    Tabs({ barPosition: BarPosition.End, index: this.currentIndex }) {
      // Tab 1: 首页
      TabContent() {
        Column() {
          // 顶部标题 - P1 改进：使用 DesignTokens
          Row() {
            Text('小白番茄专注钟')
              .fontSize(DesignTokens.FONT_SIZE.xxl)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
          }
          .width('100%')
          .padding({ top: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.md })
          .justifyContent(FlexAlign.Center)
          
          // 番茄图标
          Text('🍅')
            .fontSize(DesignTokens.FONT_SIZE.icon)
            .margin({ top: DesignTokens.SPACING.xl, bottom: DesignTokens.SPACING.lg })
          
          // 计时器显示
          Text(this.remainingTime)
            .fontSize(DesignTokens.FONT_SIZE.timer)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.getColors().primaryColor)
            .fontFamily('monospace')
            .margin({ bottom: DesignTokens.SPACING.xl })
          
          // 控制按钮
          Row() {
            // 开始/暂停按钮
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
                this.handleStartPauseClick();
              })
            
            // 重置按钮
            Button('重置')
              .width(DesignTokens.BUTTON.smallWidth)
              .height(DesignTokens.BUTTON.height)
              .fontSize(DesignTokens.FONT_SIZE.lg)
              .fontWeight(FontWeight.Medium)
              .backgroundColor(this.getColors().secondaryColor)
              .fontColor('#FFFFFF')
              .borderRadius(DesignTokens.RADIUS.xl)
              .onClick(async () => {
                await this.resetTimer();
              })
          }
          .margin({ bottom: DesignTokens.SPACING.xl })
          
          // 统计信息
          Column() {
            Divider()
              .width('80%')
              .color(this.getColors().dividerColor)
              .margin({ bottom: DesignTokens.SPACING.lg })
            
            Text('今日完成')
              .fontSize(DesignTokens.FONT_SIZE.md)
              .fontColor(this.getColors().textSecondary)
              .margin({ bottom: DesignTokens.SPACING.sm })
            
            Row() {
              ForEach(this.getTomatoes(this.todayCompleted), (item: string, index: number) => {
                Text(item)
                  .fontSize(DesignTokens.FONT_SIZE.xl)
                  .margin({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm })
              })
            }
            
            Text(`${this.todayCompleted} 个番茄钟`)
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.getColors().textSecondary)
              .margin({ top: DesignTokens.SPACING.sm })
          }
          .width('100%')
          .alignItems(HorizontalAlign.Center)
          
          // 底部提示 - Bug 3 修复：使用动态状态文字
          Text(this.statusText)
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
            .margin({ top: DesignTokens.SPACING.lg })
        }
        .width('100%')
        .height('100%')
        .backgroundColor(this.getColors().backgroundColor)
        .alignItems(HorizontalAlign.Center)
      }
      .tabBar(this.buildTabBar('首页', '🏠', 0))
      
      // Tab 2: 统计
      TabContent() {
        Statistics()
      }
      .tabBar(this.buildTabBar('统计', '📊', 1))
      
      // Tab 3: 成就
      TabContent() {
        Achievements()
      }
      .tabBar(this.buildTabBar('成就', '🏆', 2))
      
      // Tab 4: 设置
      TabContent() {
        Settings()
      }
      .tabBar(this.buildTabBar('设置', '⚙️', 3))
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
  
  /**
   * 构建底部导航栏
   */
  @Builder
  buildTabBar(title: string, icon: string, index: number): void {
    Column() {
      Text(icon)
        .fontSize(DesignTokens.FONT_SIZE.md)
        .fontColor(this.currentIndex === index ? this.getColors().primaryColor : this.getColors().textSecondary)
        .margin({ bottom: 4 })
      Text(title)
        .fontSize(DesignTokens.FONT_SIZE.sm)
        .fontColor(this.currentIndex === index ? this.getColors().primaryColor : this.getColors().textSecondary)
    }
    .justifyContent(FlexAlign.Center)
  }
  
  /**
   * 获取按钮文字
   */
  getButtonText(): string {
    if (!this.isRunning) {
      return '开始';
    } else if (this.isPaused) {
      return '继续';
    } else {
      return '暂停';
    }
  }
  
  /**
   * 生成番茄图标数组
   */
  getTomatoes(count: number): string[] {
    const tomatoes: string[] = [];
    const maxDisplay = 5; // 最多显示 5 个
    const displayCount = Math.min(count, maxDisplay);
    
    for (let i = 0; i < displayCount; i++) {
      tomatoes.push('🍅');
    }
    
    return tomatoes;
  }
}
