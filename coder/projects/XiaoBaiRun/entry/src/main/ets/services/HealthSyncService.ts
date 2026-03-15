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
import { common } from '@kit.AbilityKit';

const TAG = 'HealthSyncService';
const DOMAIN = 0x0000;

/**
 * 健康数据类型
 */
export type HealthDataType = 'distance' | 'duration' | 'calories' | 'steps' | 'heartRate';

/**
 * 健康数据记录
 */
export interface HealthRecord {
  type: HealthDataType;
  value: number;
  unit: string;
  timestamp: number;
  source: 'xiaobai_run';
  metadata?: Record<string, string>;
}

/**
 * 健康同步状态
 */
export interface SyncStatus {
  lastSyncTime: number;
  syncedRecords: number;
  failedRecords: number;
  isSyncing: boolean;
}

/**
 * 健康数据同步服务
 * 支持同步到华为健康和 Apple Health
 */
export class HealthSyncService {
  private static instance: HealthSyncService;
  private context: common.UIAbilityContext | null = null;
  
  // 同步状态
  private syncStatus: SyncStatus = {
    lastSyncTime: 0,
    syncedRecords: 0,
    failedRecords: 0,
    isSyncing: false
  };
  
  // 同步开关
  private huaweiHealthEnabled: boolean = false;
  private appleHealthEnabled: boolean = false;

  private constructor() {}

  static getInstance(): HealthSyncService {
    if (!HealthSyncService.instance) {
      HealthSyncService.instance = new HealthSyncService();
    }
    return HealthSyncService.instance;
  }

  /**
   * 设置上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
    hilog.info(DOMAIN, TAG, 'Context set');
  }

  /**
   * 同步跑步记录到健康应用
   */
  async syncRunRecord(record: {
    distance: number;
    duration: number;
    calories: number;
    startTime: number;
    endTime: number;
  }): Promise<boolean> {
    if (!this.huaweiHealthEnabled && !this.appleHealthEnabled) {
      hilog.info(DOMAIN, TAG, 'Health sync disabled');
      return false;
    }

    this.syncStatus.isSyncing = true;
    let success = false;

    try {
      // 构建健康数据记录
      const healthRecords: HealthRecord[] = [
        {
          type: 'distance',
          value: record.distance / 1000, // 转换为公里
          unit: 'km',
          timestamp: record.startTime,
          source: 'xiaobai_run',
          metadata: { activity: 'running' }
        },
        {
          type: 'duration',
          value: record.duration / 60, // 转换为分钟
          unit: 'min',
          timestamp: record.startTime,
          source: 'xiaobai_run',
          metadata: { activity: 'running' }
        },
        {
          type: 'calories',
          value: record.calories,
          unit: 'kcal',
          timestamp: record.startTime,
          source: 'xiaobai_run',
          metadata: { activity: 'running' }
        }
      ];

      // 同步到华为健康
      if (this.huaweiHealthEnabled) {
        const huaweiSuccess = await this.syncToHuaweiHealth(healthRecords);
        hilog.info(DOMAIN, TAG, 'Huawei Health sync: %{public}s', huaweiSuccess ? 'success' : 'failed');
      }

      // 同步到 Apple Health
      if (this.appleHealthEnabled) {
        const appleSuccess = await this.syncToAppleHealth(healthRecords);
        hilog.info(DOMAIN, TAG, 'Apple Health sync: %{public}s', appleSuccess ? 'success' : 'failed');
      }

      this.syncStatus.syncedRecords++;
      this.syncStatus.lastSyncTime = Date.now();
      success = true;
      
      hilog.info(DOMAIN, TAG, '✅ Health sync completed');
    } catch (error) {
      this.syncStatus.failedRecords++;
      hilog.error(DOMAIN, TAG, 'Health sync failed: %{public}s', JSON.stringify(error));
    } finally {
      this.syncStatus.isSyncing = false;
    }

    return success;
  }

  /**
   * 同步到华为健康
   * 
   * 注意：需要配置华为健康 API 权限
   * 参考：https://developer.huawei.com/consumer/cn/doc/harmonyos-guides-V5/health-service-V5
   */
  private async syncToHuaweiHealth(records: HealthRecord[]): Promise<boolean> {
    if (!this.context) return false;

    try {
      // TODO: 集成华为健康 Kit
      // 当前版本记录日志模拟
      for (const record of records) {
        hilog.info(DOMAIN, TAG, 
          'Huawei Health: type=%{public}s, value=%{public}f, unit=%{public}s',
          record.type, record.value, record.unit);
      }
      
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Huawei Health sync error: %{public}s', JSON.stringify(error));
      return false;
    }
  }

  /**
   * 同步到 Apple Health
   * 
   * 注意：HarmonyOS 应用可以通过 Health Kit 接入健康数据
   * iOS 应用需要使用 HealthKit 框架
   */
  private async syncToAppleHealth(records: HealthRecord[]): Promise<boolean> {
    if (!this.context) return false;

    try {
      // TODO: 集成 Health Kit
      // 当前版本记录日志模拟
      for (const record of records) {
        hilog.info(DOMAIN, TAG, 
          'Apple Health: type=%{public}s, value=%{public}f, unit=%{public}s',
          record.type, record.value, record.unit);
      }
      
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Apple Health sync error: %{public}s', JSON.stringify(error));
      return false;
    }
  }

  // ========== 同步开关 ==========

  setHuaweiHealthEnabled(enabled: boolean): void {
    this.huaweiHealthEnabled = enabled;
    hilog.info(DOMAIN, TAG, 'Huawei Health sync: %{public}s', enabled ? 'enabled' : 'disabled');
  }

  getHuaweiHealthEnabled(): boolean {
    return this.huaweiHealthEnabled;
  }

  setAppleHealthEnabled(enabled: boolean): void {
    this.appleHealthEnabled = enabled;
    hilog.info(DOMAIN, TAG, 'Apple Health sync: %{public}s', enabled ? 'enabled' : 'disabled');
  }

  getAppleHealthEnabled(): boolean {
    return this.appleHealthEnabled;
  }

  // ========== 同步状态 ==========

  getSyncStatus(): SyncStatus {
    return { ...this.syncStatus };
  }

  getLastSyncTime(): number {
    return this.syncStatus.lastSyncTime;
  }

  isSyncing(): boolean {
    return this.syncStatus.isSyncing;
  }
}

export const healthSyncService = HealthSyncService.getInstance();