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

import { UIAbility, AbilityConstant, Want } from '@kit.AbilityKit';
import { window } from '@kit.ArkUI';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { NotificationUtil } from '../utils/NotificationUtil';
import { BackgroundTaskService } from '../services/BackgroundTaskService';
import { PomodoroModel } from '../utils/PomodoroModel';

const TAG = 'EntryAbility';
const DOMAIN = 0x0000;

export default class EntryAbility extends UIAbility {
  private backgroundTaskService: BackgroundTaskService = BackgroundTaskService.getInstance();

  /**
   * Ability 创建时的回调
   */
  async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onCreate');
    
    // 初始化后台任务服务
    if (this.context) {
      this.backgroundTaskService.init(this.context);
      
      // 初始化全局 PomodoroModel 单例，确保统计数据加载
      const pomodoroModel = PomodoroModel.getInstance();
      await pomodoroModel.initialize(this.context);
      hilog.info(DOMAIN, TAG, 'PomodoroModel initialized in EntryAbility');
    }
  }

  /**
   * Ability 销毁时的回调
   */
  async onDestroy(): Promise<void> {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onDestroy');
    
    // 清理后台任务服务
    await this.backgroundTaskService.cleanup();
  }

  /**
   * 窗口创建完成后的回调
   */
  async onWindowStageCreate(windowStage: window.WindowStage): Promise<void> {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onWindowStageCreate');

    // 加载主页面
    windowStage.loadContent('pages/Index', (err: Error) => {
      if (err) {
        hilog.error(DOMAIN, TAG, 'Failed to load content. Cause: %{public}s', JSON.stringify(err) ?? '');
        return;
      }
      hilog.info(DOMAIN, TAG, 'Succeeded in loading content.');
    });

    // 请求通知权限
    await this.requestNotificationPermission();
  }

  /**
   * 窗口销毁时的回调
   */
  onWindowStageDestroy(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onWindowStageDestroy');
  }

  /**
   * Ability 进入前台时的回调
   */
  onForeground(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onForeground');
    
    // 应用回到前台，恢复计时器 UI 同步
    if (this.backgroundTaskService.getIsRunning()) {
      hilog.info(DOMAIN, TAG, 'App returned to foreground, timer is running');
    }
  }

  /**
   * Ability 进入后台时的回调
   */
  async onBackground(): Promise<void> {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onBackground');
    
    // 应用在后台运行时，确保后台任务继续运行
    if (this.backgroundTaskService.getIsRunning()) {
      hilog.info(DOMAIN, TAG, 'App went to background, ensuring background task continues');
      // 后台任务服务已经管理了自己的后台任务生命周期
      // 这里只需要记录日志，不需要额外操作
    }
  }

  /**
   * 请求通知权限
   */
  private async requestNotificationPermission(): Promise<void> {
    try {
      const isAllowed = await NotificationUtil.requestNotificationPermission();
      if (isAllowed) {
        hilog.info(DOMAIN, TAG, 'Notification permission granted');
      } else {
        hilog.warn(DOMAIN, TAG, 'Notification permission denied');
      }
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Failed to request notification permission: %{public}s', JSON.stringify(error) ?? '');
    }
  }

  /**
   * 获取后台任务服务实例（供页面使用）
   */
  getBackgroundTaskService(): BackgroundTaskService {
    return this.backgroundTaskService;
  }
}
