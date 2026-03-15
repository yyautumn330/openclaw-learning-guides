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
import { TrajectoryModel, TrajectoryPoint, RunRecord, KeyPoint } from '../models/TrajectoryModel';
import { LocationService } from './LocationService';
import { TrajectoryStore } from './TrajectoryStore';

const TAG = 'RunTrackerService';
const DOMAIN = 0x0000;

/**
 * 运动状态
 */
export type RunState = 'idle' | 'running' | 'paused';

/**
 * 状态变化回调
 */
export type StateCallback = (state: RunState) => void;

/**
 * 位置更新回调
 */
export type LocationUpdateCallback = (point: TrajectoryPoint) => void;

/**
 * 里程碑回调
 */
export type MilestoneCallback = (km: number, point: TrajectoryPoint) => void;

/**
 * 跑步轨迹记录主服务
 */
export class RunTrackerService {
  private static instance: RunTrackerService;
  
  // 状态
  private state: RunState = 'idle';
  private startTime: number = 0;
  private pauseStartTime: number = 0;
  private totalPauseDuration: number = 0;
  
  // 里程石记录
  private lastMilestone: number = 0;
  
  // 回调
  private stateCallbacks: StateCallback[] = [];
  private locationCallbacks: LocationUpdateCallback[] = [];
  private milestoneCallbacks: MilestoneCallback[] = [];
  
  // 服务依赖
  private trajectoryModel: TrajectoryModel;
  private locationService: LocationService;
  private trajectoryStore: TrajectoryStore;

  private constructor() {
    this.trajectoryModel = TrajectoryModel.getInstance();
    this.locationService = LocationService.getInstance();
    this.trajectoryStore = TrajectoryStore.getInstance();
  }

  static getInstance(): RunTrackerService {
    if (!RunTrackerService.instance) {
      RunTrackerService.instance = new RunTrackerService();
    }
    return RunTrackerService.instance;
  }

  /**
   * 设置 Context
   */
  setContext(context: common.UIAbilityContext): void {
    this.locationService.setContext(context);
    this.trajectoryStore.setContext(context);
    hilog.info(DOMAIN, TAG, 'Context set');
  }

  /**
   * 开始记录
   */
  async startTracking(): Promise<boolean> {
    if (this.state !== 'idle') {
      hilog.warn(DOMAIN, TAG, 'Already tracking');
      return false;
    }

    try {
      // 重置数据
      this.trajectoryModel.reset();
      this.startTime = Date.now();
      this.totalPauseDuration = 0;
      this.lastMilestone = 0;
      
      // 启动定位
      const started = await this.locationService.startLocationUpdates(
        this.onLocationUpdate.bind(this)
      );
      
      if (!started) {
        hilog.error(DOMAIN, TAG, 'Failed to start location updates');
        return false;
      }
      
      // 更新状态
      this.setState('running');
      
      hilog.info(DOMAIN, TAG, '🏃 Tracking started at %d', this.startTime);
      
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Start tracking failed: %{public}s', JSON.stringify(error));
      return false;
    }
  }

  /**
   * 暂停记录
   */
  async pauseTracking(): Promise<void> {
    if (this.state !== 'running') return;
    
    this.pauseStartTime = Date.now();
    
    // 添加暂停关键点
    const lastPoint = this.getLastPoint();
    if (lastPoint) {
      this.trajectoryModel.addKeyPoint('pause', lastPoint);
    }
    
    this.setState('paused');
    hilog.info(DOMAIN, TAG, '⏸️ Tracking paused');
  }

  /**
   * 继续记录
   */
  async resumeTracking(): Promise<void> {
    if (this.state !== 'paused') return;
    
    // 计算暂停时长
    const pauseDuration = Date.now() - this.pauseStartTime;
    this.totalPauseDuration += pauseDuration;
    
    // 添加继续关键点
    const lastPoint = this.getLastPoint();
    if (lastPoint) {
      this.trajectoryModel.addKeyPoint('resume', lastPoint, { pauseDuration });
    }
    
    this.setState('running');
    hilog.info(DOMAIN, TAG, '▶️ Tracking resumed');
  }

  /**
   * 停止记录
   */
  async stopTracking(): Promise<RunRecord | null> {
    if (this.state === 'idle') return null;
    
    try {
      // 停止定位
      await this.locationService.stopLocationUpdates();
      
      // 刷新缓存
      await this.trajectoryStore.flushCache();
      
      const endTime = Date.now();
      
      // 添加终点关键点
      const lastPoint = this.getLastPoint();
      if (lastPoint) {
        this.trajectoryModel.addKeyPoint('end', lastPoint);
      }
      
      // 创建记录
      const record = this.trajectoryModel.createRecord(this.startTime, endTime);
      
      // 保存轨迹
      const trajectory = this.trajectoryModel.getTrajectory();
      await this.trajectoryStore.saveRecord(record, trajectory);
      
      // 更新状态
      this.setState('idle');
      
      hilog.info(DOMAIN, TAG, '⏹️ Tracking stopped. Distance: %dm, Duration: %ds',
        record.totalDistance, record.duration);
      
      return record;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Stop tracking failed: %{public}s', JSON.stringify(error));
      return null;
    }
  }

  /**
   * 定位更新回调
   */
  private onLocationUpdate(location: {
    latitude: number;
    longitude: number;
    altitude: number;
    accuracy: number;
    speed: number;
    bearing: number;
    locationType: string;
  }): void {
    if (this.state !== 'running') return;
    
    // 添加轨迹点
    const point = this.trajectoryModel.addPoint(location, location.locationType as any);
    
    // 第一个点作为起点
    if (this.trajectoryModel.getStats().pointCount === 1) {
      this.trajectoryModel.addKeyPoint('start', point);
    }
    
    // 检查里程碑
    this.checkMilestone(point);
    
    // 缓存轨迹点
    this.trajectoryStore.addPoint(point);
    
    // 通知回调
    this.notifyLocationUpdate(point);
  }

  /**
   * 检查里程碑 (每公里)
   */
  private checkMilestone(point: TrajectoryPoint): void {
    const distanceKm = Math.floor(point.distance / 1000);
    
    if (distanceKm > this.lastMilestone) {
      this.lastMilestone = distanceKm;
      
      // 添加里程碑关键点
      this.trajectoryModel.addKeyPoint('milestone', point, { milestone: distanceKm });
      
      // 通知回调
      this.notifyMilestone(distanceKm, point);
      
      hilog.info(DOMAIN, TAG, '🏁 Milestone: %d km', distanceKm);
    }
  }

  /**
   * 设置状态
   */
  private setState(state: RunState): void {
    this.state = state;
    this.notifyStateChange(state);
  }

  /**
   * 获取状态
   */
  getState(): RunState {
    return this.state;
  }

  /**
   * 获取最后轨迹点
   */
  private getLastPoint(): TrajectoryPoint | null {
    const trajectory = this.trajectoryModel.getTrajectory();
    return trajectory.length > 0 ? trajectory[trajectory.length - 1] : null;
  }

  /**
   * 获取实时统计
   */
  getStats(): {
    distance: number;
    duration: number;
    avgSpeed: number;
    maxSpeed: number;
    avgPace: string;
    calories: number;
    pointCount: number;
    signalQuality: string;
  } {
    const stats = this.trajectoryModel.getStats();
    const duration = this.state !== 'idle' 
      ? (Date.now() - this.startTime - this.totalPauseDuration) / 1000
      : 0;
    
    return {
      ...stats,
      duration,
      avgPace: this.trajectoryModel.calculatePace(stats.distance, duration),
      calories: this.trajectoryModel.calculateCalories(stats.distance, duration),
      signalQuality: 'good'
    };
  }

  // ========== 事件订阅 ==========

  onStateChange(callback: StateCallback): void {
    this.stateCallbacks.push(callback);
  }

  onLocationUpdate(callback: LocationUpdateCallback): void {
    this.locationCallbacks.push(callback);
  }

  onMilestone(callback: MilestoneCallback): void {
    this.milestoneCallbacks.push(callback);
  }

  private notifyStateChange(state: RunState): void {
    this.stateCallbacks.forEach(cb => cb(state));
  }

  private notifyLocationUpdate(point: TrajectoryPoint): void {
    this.locationCallbacks.forEach(cb => cb(point));
  }

  private notifyMilestone(km: number, point: TrajectoryPoint): void {
    this.milestoneCallbacks.forEach(cb => cb(km, point));
  }
}

export const runTrackerService = RunTrackerService.getInstance();