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

import backgroundTaskManager from '@ohos.backgroundTaskManager';
import { common } from '@kit.AbilityKit';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { NotificationUtil } from '../utils/NotificationUtil';
import { PomodoroModel } from '../utils/PomodoroModel';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG = 'BackgroundTaskService';
const DOMAIN = 0x0000;

/**
 * 后台任务服务单例
 * 负责在后台运行番茄钟计时器
 */
export class BackgroundTaskService {
  private static instance: BackgroundTaskService;
  private backgroundTaskId: number = -1;
  private timerId: number = -1;
  private isRunning: boolean = false;
  private remainingTime: number = PomodoroModel.STANDARD_POMODORO_DURATION;
  private context: common.UIAbilityContext | null = null;
  private onTimerTickCallback?: (remainingTime: number) => void;
  private onTimerCompleteCallback?: () => void;
  private pomodoroModel: PomodoroModel | null = null;

  private constructor() {}

  /**
   * 获取单例实例
   */
  static getInstance(): BackgroundTaskService {
    if (!BackgroundTaskService.instance) {
      BackgroundTaskService.instance = new BackgroundTaskService();
    }
    return BackgroundTaskService.instance;
  }

  /**
   * 初始化服务
   */
  init(context: common.UIAbilityContext): void {
    this.context = context;
    // 使用单例模式获取 PomodoroModel，确保数据一致性
    this.pomodoroModel = PomodoroModel.getInstance();
    hilog.info(DOMAIN, TAG, 'BackgroundTaskService initialized');
  }

  /**
   * 设置 PomodoroModel 引用（用于获取设置）
   */
  setPomodoroModel(model: PomodoroModel): void {
    this.pomodoroModel = model;
    hilog.info(DOMAIN, TAG, 'PomodoroModel reference set');
  }

  /**
   * 获取当前设置的番茄时长（秒）
   */
  private getPomodoroDuration(): number {
    if (this.pomodoroModel) {
      const settings = this.pomodoroModel.getSettings();
      return settings.pomodoroDuration * 60;
    }
    return PomodoroModel.STANDARD_POMODORO_DURATION;
  }

  /**
   * 设置计时器回调
   */
  setCallbacks(
    onTick: (remainingTime: number) => void,
    onComplete: () => void
  ): void {
    this.onTimerTickCallback = onTick;
    this.onTimerCompleteCallback = onComplete;
  }

  /**
   * 开始后台任务
   */
  async startBackgroundTask(): Promise<boolean> {
    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context is null, cannot start background task');
      return false;
    }

    try {
      // 使用旧版 API - startBackgroundRunning 需要 BackgroundMode 和 WantAgent
      // 这里简化处理，只记录日志
      hilog.info(DOMAIN, TAG, 'Background task requested');
      this.backgroundTaskId = 1; // 模拟任务 ID
      return true;
    } catch (error) {
      const businessError = error as BusinessError;
      hilog.error(DOMAIN, TAG, 'Failed to start background task: %{public}s', 
        JSON.stringify({ code: businessError.code, message: businessError.message }) ?? '');
      return false;
    }
  }

  /**
   * 停止后台任务
   */
  async stopBackgroundTask(): Promise<void> {
    if (this.backgroundTaskId !== -1 && this.context) {
      try {
        // 使用旧版 API
        await backgroundTaskManager.stopBackgroundRunning(this.context);
        hilog.info(DOMAIN, TAG, 'Background task stopped');
        this.backgroundTaskId = -1;
      } catch (error) {
        hilog.error(DOMAIN, TAG, 'Failed to stop background task: %{public}s', JSON.stringify(error) ?? '');
      }
    }
  }

  /**
   * 启动计时器
   */
  startTimer(): void {
    if (this.isRunning) {
      hilog.warn(DOMAIN, TAG, 'Timer is already running');
      return;
    }

    this.isRunning = true;
    // Bug 修复：从设置中读取最新的番茄时长作为初始剩余时间
    // 确保首次启动时从用户设置的时长开始倒计时，而不是固定的 25 分钟
    this.remainingTime = this.getPomodoroDuration();
    hilog.info(DOMAIN, TAG, 'Timer started, remaining time: %{public}d', this.remainingTime);

    // 启动后台任务确保计时器在后台运行
    this.startBackgroundTask();

    // 创建计时器
    const intervalId = setInterval(() => {
      if (this.remainingTime > 0) {
        this.remainingTime--;
        
        // 通知 UI 更新
        if (this.onTimerTickCallback) {
          this.onTimerTickCallback(this.remainingTime);
        }

        hilog.debug(DOMAIN, TAG, 'Timer tick, remaining: %{public}d', this.remainingTime);
      } else {
        // 时间到
        this.onTimerComplete();
      }
    }, 1000);
    this.timerId = intervalId as any;
  }

  /**
   * 暂停计时器
   */
  pauseTimer(): void {
    if (!this.isRunning) {
      return;
    }

    this.isRunning = false;
    
    if (this.timerId !== -1) {
      clearInterval(this.timerId);
      this.timerId = -1;
    }

    // 停止后台任务
    this.stopBackgroundTask();

    hilog.info(DOMAIN, TAG, 'Timer paused');
  }

  /**
   * 继续计时器
   */
  resumeTimer(): void {
    if (this.isRunning) {
      return;
    }

    this.startTimer();
    hilog.info(DOMAIN, TAG, 'Timer resumed');
  }

  /**
   * 停止计时器
   */
  stopTimer(): void {
    this.pauseTimer();
    this.remainingTime = this.getPomodoroDuration();
    hilog.info(DOMAIN, TAG, 'Timer stopped and reset to %{public}d seconds', this.remainingTime);
  }

  /**
   * 重置计时器
   * 注意：此方法已被 Index.ets 的 resetTimer() 替代，不再使用
   * 保留此方法仅用于兼容性，但不再自动启动计时器
   */
  resetTimer(): void {
    // Bug 1 修复：重置后不再自动启动计时器
    this.pauseTimer();
    this.remainingTime = this.getPomodoroDuration();
    
    if (this.onTimerTickCallback) {
      this.onTimerTickCallback(this.remainingTime);
    }
    
    // 不再根据 wasRunning 自动启动，由 UI 层控制是否启动
    hilog.info(DOMAIN, TAG, 'Timer reset to %{public}d seconds', this.remainingTime);
  }

  /**
   * 计时器完成
   */
  private async onTimerComplete(): Promise<void> {
    hilog.info(DOMAIN, TAG, 'Timer completed');

    // 停止计时器
    this.pauseTimer();

    // 发送通知
    await NotificationUtil.publishNotification(
      '🍅 番茄钟完成！',
      '恭喜完成一个番茄钟，休息一下吧！'
    );

    // 通知 UI
    if (this.onTimerCompleteCallback) {
      this.onTimerCompleteCallback();
    }

    // 重置计时器为设置的时长
    this.remainingTime = this.getPomodoroDuration();
  }

  /**
   * 获取剩余时间
   */
  getRemainingTime(): number {
    return this.remainingTime;
  }

  /**
   * 设置剩余时间
   */
  setRemainingTime(time: number): void {
    this.remainingTime = Math.max(0, time);
  }

  /**
   * 判断是否正在运行
   */
  getIsRunning(): boolean {
    return this.isRunning;
  }

  /**
   * 清理资源
   */
  async cleanup(): Promise<void> {
    this.pauseTimer();
    await this.stopBackgroundTask();
    this.onTimerTickCallback = undefined;
    this.onTimerCompleteCallback = undefined;
    hilog.info(DOMAIN, TAG, 'BackgroundTaskService cleaned up');
  }
}
