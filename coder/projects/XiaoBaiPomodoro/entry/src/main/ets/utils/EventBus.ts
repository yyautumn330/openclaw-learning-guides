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

import { hilog } from '@kit.PerformanceAnalysisKit';

const TAG = 'EventBus';
const DOMAIN = 0x0000;

/**
 * P1 改进：事件总线
 * 用于跨组件状态同步，解决 Index 和 Settings 之间的竞态条件
 */

// 事件类型定义
export enum EventType {
  // 设置相关
  SETTINGS_CHANGED = 'settings_changed',
  THEME_CHANGED = 'theme_changed',
  
  // 计时器相关
  TIMER_STARTED = 'timer_started',
  TIMER_PAUSED = 'timer_paused',
  TIMER_RESUMED = 'timer_resumed',
  TIMER_STOPPED = 'timer_stopped',
  TIMER_COMPLETED = 'timer_completed',
  
  // 统计相关
  STATISTICS_UPDATED = 'statistics_updated',
  
  // 成就相关
  ACHIEVEMENT_UNLOCKED = 'achievement_unlocked',
}

// 事件回调类型
export type EventCallback = (data?: any) => void;

// 事件订阅项
interface Subscription {
  eventType: EventType;
  callback: EventCallback;
}

/**
 * 事件总线单例
 */
export class EventBus {
  private static instance: EventBus;
  private subscriptions: Map<string, EventCallback[]> = new Map();
  
  private constructor() {}
  
  /**
   * 获取单例实例
   */
  static getInstance(): EventBus {
    if (!EventBus.instance) {
      EventBus.instance = new EventBus();
    }
    return EventBus.instance;
  }
  
  /**
   * 订阅事件
   * @param eventType 事件类型
   * @param callback 回调函数
   */
  on(eventType: EventType, callback: EventCallback): void {
    const key = eventType.toString();
    if (!this.subscriptions.has(key)) {
      this.subscriptions.set(key, []);
    }
    this.subscriptions.get(key)!.push(callback);
    hilog.debug(DOMAIN, TAG, 'Event subscribed: %{public}s', eventType);
  }
  
  /**
   * 取消订阅
   * @param eventType 事件类型
   * @param callback 回调函数
   */
  off(eventType: EventType, callback: EventCallback): void {
    const key = eventType.toString();
    const callbacks = this.subscriptions.get(key);
    if (callbacks) {
      const index = callbacks.indexOf(callback);
      if (index > -1) {
        callbacks.splice(index, 1);
        hilog.debug(DOMAIN, TAG, 'Event unsubscribed: %{public}s', eventType);
      }
    }
  }
  
  /**
   * 取消所有订阅（页面销毁时调用）
   * @param eventType 可选，只取消特定事件的订阅
   */
  offAll(eventType?: EventType): void {
    if (eventType) {
      this.subscriptions.delete(eventType.toString());
    } else {
      this.subscriptions.clear();
    }
    hilog.debug(DOMAIN, TAG, 'All events unsubscribed');
  }
  
  /**
   * 发布事件
   * @param eventType 事件类型
   * @param data 事件数据
   */
  emit(eventType: EventType, data?: any): void {
    const key = eventType.toString();
    const callbacks = this.subscriptions.get(key);
    if (callbacks) {
      hilog.debug(DOMAIN, TAG, 'Event emitted: %{public}s, data: %{public}s', 
        eventType, JSON.stringify(data) ?? '');
      
      // 异步执行所有回调，防止阻塞
      callbacks.forEach(callback => {
        try {
          callback(data);
        } catch (error) {
          hilog.error(DOMAIN, TAG, 'Event callback error: %{public}s', 
            JSON.stringify(error) ?? '');
        }
      });
    }
  }
  
  /**
   * 发布设置变更事件
   */
  emitSettingsChanged(settings: any): void {
    this.emit(EventType.SETTINGS_CHANGED, settings);
  }
  
  /**
   * 发布主题变更事件
   */
  emitThemeChanged(isDarkMode: boolean): void {
    this.emit(EventType.THEME_CHANGED, isDarkMode);
  }
  
  /**
   * 发布计时器开始事件
   */
  emitTimerStarted(duration: number): void {
    this.emit(EventType.TIMER_STARTED, { duration });
  }
  
  /**
   * 发布计时器完成事件
   */
  emitTimerCompleted(): void {
    this.emit(EventType.TIMER_COMPLETED);
  }
  
  /**
   * 发布统计更新事件
   */
  emitStatisticsUpdated(completed: number): void {
    this.emit(EventType.STATISTICS_UPDATED, { completed });
  }
  
  /**
   * 发布成就解锁事件
   */
  emitAchievementUnlocked(achievementName: string): void {
    this.emit(EventType.ACHIEVEMENT_UNLOCKED, { achievementName });
  }
}

// 导出单例实例
export const eventBus = EventBus.getInstance();
