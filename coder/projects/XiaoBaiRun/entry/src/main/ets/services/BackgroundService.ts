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
import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';

const TAG = 'BackgroundService';
const DOMAIN = 0x0000;

/**
 * 后台运行服务
 * 管理跑步时的后台长时任务
 */
export class BackgroundService {
  private static instance: BackgroundService;
  private context: common.UIAbilityContext | null = null;
  private isRunning: boolean = false;
  private backgroundTaskId: number = -1;

  private constructor() {}

  static getInstance(): BackgroundService {
    if (!BackgroundService.instance) {
      BackgroundService.instance = new BackgroundService();
    }
    return BackgroundService.instance;
  }

  /**
   * 设置上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
    hilog.info(DOMAIN, TAG, 'Context set');
  }

  /**
   * 开始后台任务
   */
  async startBackgroundRunning(): Promise<boolean> {
    if (this.isRunning) {
      hilog.warn(DOMAIN, TAG, 'Background task already running');
      return true;
    }

    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context not set');
      return false;
    }

    try {
      // 申请长时任务
      // API: startBackgroundRunning(context, bgMode, options)
      await backgroundTaskManager.startBackgroundRunning(
        this.context,
        backgroundTaskManager.BackgroundMode.LOCATION,
        {}  // 空 options 对象
      );

      this.isRunning = true;
      hilog.info(DOMAIN, TAG, '✅ Background task started');
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Start background task failed: %{public}s', JSON.stringify(error));
      return false;
    }
  }

  /**
   * 停止后台任务
   */
  async stopBackgroundRunning(): Promise<void> {
    if (!this.isRunning) {
      return;
    }

    if (!this.context) {
      return;
    }

    try {
      await backgroundTaskManager.stopBackgroundRunning(this.context);
      this.isRunning = false;
      hilog.info(DOMAIN, TAG, '🛑 Background task stopped');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Stop background task failed: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 检查后台任务是否在运行
   */
  isBackgroundRunning(): boolean {
    return this.isRunning;
  }
}

export const backgroundService = BackgroundService.getInstance();