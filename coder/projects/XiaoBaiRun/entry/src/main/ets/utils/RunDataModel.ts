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

import { preferences } from '@kit.ArkData';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';

const TAG = 'RunDataModel';
const DOMAIN = 0x0000;

/**
 * 轨迹点
 */
export interface TrackPoint {
  latitude: number;
  longitude: number;
  altitude?: number;
  timestamp: number;
}

/**
 * 跑步记录
 */
export interface RunRecord {
  id: string;
  startTime: number;
  endTime: number;
  duration: number;       // 时长 (秒)
  distance: number;       // 距离 (米)
  calories: number;       // 卡路里
  pace: number;           // 平均配速 (秒/公里)
  trackPoints: TrackPoint[];
}

/**
 * 跑步数据模型单例
 */
export class RunDataModel {
  private static instance: RunDataModel;
  private context: common.UIAbilityContext | null = null;
  private pref: preferences.Preferences | null = null;
  
  // 当前跑步数据
  private currentRun: RunRecord | null = null;
  private isRunning: boolean = false;
  private isPaused: boolean = false;
  
  // 历史跑步记录
  private runRecords: RunRecord[] = [];
  
  private constructor() {}
  
  /**
   * 获取单例实例
   */
  static getInstance(): RunDataModel {
    if (!RunDataModel.instance) {
      RunDataModel.instance = new RunDataModel();
    }
    return RunDataModel.instance;
  }
  
  /**
   * 初始化
   */
  async initialize(context: common.UIAbilityContext): Promise<void> {
    this.context = context;
    
    try {
      // 加载偏好设置
      this.pref = await preferences.getPreferences(context, 'xiaobai_run_data');
      
      // 加载历史记录
      await this.loadRecords();
      
      hilog.info(DOMAIN, TAG, 'RunDataModel initialized');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Initialize error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * 加载历史记录
   */
  private async loadRecords(): Promise<void> {
    if (!this.pref) return;
    
    try {
      const recordsJson = this.pref.get('runRecords', '[]') as unknown as string;
      this.runRecords = JSON.parse(recordsJson);
      
      hilog.info(DOMAIN, TAG, 'Loaded %{public}d run records', this.runRecords.length);
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Load records error: %{public}s', JSON.stringify(error) ?? '');
      this.runRecords = [];
    }
  }
  
  /**
   * 保存历史记录
   */
  private async saveRecords(): Promise<void> {
    if (!this.pref) return;
    
    try {
      const recordsJson = JSON.stringify(this.runRecords);
      this.pref.put('runRecords', recordsJson);
      await this.pref.flush();
      
      hilog.info(DOMAIN, TAG, 'Records saved, total: %{public}d', this.runRecords.length);
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Save records error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * 开始跑步
   */
  startRun(): void {
    if (this.isRunning) return;
    
    this.isRunning = true;
    this.isPaused = false;
    
    this.currentRun = {
      id: `run_${Date.now()}`,
      startTime: Date.now(),
      endTime: 0,
      duration: 0,
      distance: 0,
      calories: 0,
      pace: 0,
      trackPoints: []
    };
    
    hilog.info(DOMAIN, TAG, 'Run started: %{public}s', this.currentRun.id);
  }
  
  /**
   * 暂停跑步
   */
  pauseRun(): void {
    if (!this.isRunning) return;
    this.isPaused = true;
    hilog.info(DOMAIN, TAG, 'Run paused');
  }
  
  /**
   * 继续跑步
   */
  resumeRun(): void {
    if (!this.isPaused) return;
    this.isPaused = false;
    hilog.info(DOMAIN, TAG, 'Run resumed');
  }
  
  /**
   * 添加轨迹点
   */
  addTrackPoint(point: TrackPoint): void {
    if (!this.currentRun || !this.isRunning) return;
    this.currentRun.trackPoints.push(point);
  }
  
  /**
   * 更新跑步数据
   */
  updateRunData(distance: number, duration: number): void {
    if (!this.currentRun) return;
    
    this.currentRun.distance = distance;
    this.currentRun.duration = duration;
    
    // 计算配速 (秒/公里)
    if (distance > 0) {
      this.currentRun.pace = duration / (distance / 1000);
    }
    
    // 计算卡路里 (简化公式：距离 km * 体重 kg * 1.036)
    // 假设体重 65kg
    this.currentRun.calories = (distance / 1000) * 65 * 1.036;
  }
  
  /**
   * 结束跑步
   */
  async finishRun(): Promise<RunRecord | null> {
    if (!this.currentRun) return null;
    
    this.isRunning = false;
    this.isPaused = false;
    
    this.currentRun.endTime = Date.now();
    
    // 保存到历史记录
    this.runRecords.unshift(this.currentRun);
    await this.saveRecords();
    
    const finishedRun = this.currentRun;
    this.currentRun = null;
    
    hilog.info(DOMAIN, TAG, 'Run finished: %{public}s', finishedRun.id);
    
    return finishedRun;
  }
  
  /**
   * 获取当前跑步数据
   */
  getCurrentRun(): RunRecord | null {
    return this.currentRun;
  }
  
  /**
   * 检查是否正在跑步
   */
  isCurrentlyRunning(): boolean {
    return this.isRunning;
  }
  
  /**
   * 检查是否暂停
   */
  isCurrentlyPaused(): boolean {
    return this.isPaused;
  }
  
  /**
   * 获取历史记录
   */
  getRunRecords(): RunRecord[] {
    return [...this.runRecords];
  }
  
  /**
   * 删除记录
   */
  async deleteRecord(recordId: string): Promise<void> {
    this.runRecords = this.runRecords.filter(r => r.id !== recordId);
    await this.saveRecords();
    hilog.info(DOMAIN, TAG, 'Record deleted: %{public}s', recordId);
  }
  
  /**
   * 获取总跑步次数
   */
  getTotalRuns(): number {
    return this.runRecords.length;
  }
  
  /**
   * 获取总距离
   */
  getTotalDistance(): number {
    return this.runRecords.reduce((sum, record) => sum + record.distance, 0);
  }
  
  /**
   * 获取总时长
   */
  getTotalDuration(): number {
    return this.runRecords.reduce((sum, record) => sum + record.duration, 0);
  }
}

// 导出单例
export const runDataModel = RunDataModel.getInstance();
