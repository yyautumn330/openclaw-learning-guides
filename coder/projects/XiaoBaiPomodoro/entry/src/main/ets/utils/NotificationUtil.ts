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

import notificationManager from '@ohos.notificationManager';

/**
 * 通知工具类
 * 用于发送番茄钟完成提醒
 */
export class NotificationUtil {
  private static readonly NOTIFICATION_ID = 1001;
  private static readonly SLOT_TYPE = notificationManager.SlotType.OTHER_TYPES;
  
  /**
   * 发布通知
   */
  static async publishNotification(title: string, content: string): Promise<void> {
    try {
      // 创建通知渠道
      await this.createNotificationChannel();
      
      // 构建通知内容
      const notificationRequest: notificationManager.NotificationRequest = {
        id: this.NOTIFICATION_ID,
        notificationSlotType: this.SLOT_TYPE,
        content: {
          normal: {
            title: title,
            text: content,
          }
        },
      };
      
      // 发布通知
      await notificationManager.publish(notificationRequest);
      console.info('PomodoroNotification', '通知发布成功');
    } catch (error) {
      console.error('PomodoroNotification', `通知发布失败：${JSON.stringify(error)}`);
    }
  }
  
  /**
   * 创建通知渠道
   */
  private static async createNotificationChannel(): Promise<void> {
    try {
      // API 22 使用 addSlot，传入 SlotType 枚举
      await notificationManager.addSlot(this.SLOT_TYPE);
      console.info('PomodoroNotification', '通知渠道创建成功');
    } catch (error) {
      console.error('PomodoroNotification', `通知渠道创建失败：${JSON.stringify(error)}`);
    }
  }
  
  /**
   * 取消通知
   */
  static async cancelNotification(): Promise<void> {
    try {
      await notificationManager.cancel(this.NOTIFICATION_ID);
      console.info('PomodoroNotification', '通知取消成功');
    } catch (error) {
      console.error('PomodoroNotification', `通知取消失败：${JSON.stringify(error)}`);
    }
  }
  
  /**
   * 请求通知权限
   */
  static async requestNotificationPermission(): Promise<boolean> {
    try {
      // API 22 直接使用 isNotificationEnabled
      const isAllowed = await notificationManager.isNotificationEnabled();
      
      if (!isAllowed) {
        // 请求用户授权 - API 22 使用 requestEnableNotification
        await notificationManager.requestEnableNotification();
      }
      
      return isAllowed;
    } catch (error) {
      console.error('PomodoroNotification', `权限请求失败：${JSON.stringify(error)}`);
      return false;
    }
  }
}
