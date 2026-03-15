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
import { TrajectoryPoint } from '../models/TrajectoryModel';

const TAG = 'TrajectoryPlayback';
const DOMAIN = 0x0000;

/**
 * 轨迹回放状态
 */
export type PlaybackState = 'idle' | 'playing' | 'paused';

/**
 * 轨迹回放进度回调
 */
export type PlaybackProgressCallback = (point: TrajectoryPoint, index: number, total: number) => void;

/**
 * 轨迹回放服务
 * 用于回放历史跑步轨迹
 */
export class TrajectoryPlaybackService {
  private static instance: TrajectoryPlaybackService;
  
  private state: PlaybackState = 'idle';
  private trajectory: TrajectoryPoint[] = [];
  private currentIndex: number = 0;
  private playbackTimer: number = -1;
  private playbackSpeed: number = 1; // 1x, 2x, 4x
  private callback: PlaybackProgressCallback | null = null;

  private constructor() {}

  static getInstance(): TrajectoryPlaybackService {
    if (!TrajectoryPlaybackService.instance) {
      TrajectoryPlaybackService.instance = new TrajectoryPlaybackService();
    }
    return TrajectoryPlaybackService.instance;
  }

  /**
   * 加载轨迹
   */
  loadTrajectory(trajectory: TrajectoryPoint[]): void {
    this.stop();
    this.trajectory = trajectory;
    this.currentIndex = 0;
    hilog.info(DOMAIN, TAG, 'Loaded trajectory with %d points', trajectory.length);
  }

  /**
   * 开始播放
   */
  play(callback: PlaybackProgressCallback): void {
    if (this.trajectory.length === 0) {
      hilog.warn(DOMAIN, TAG, 'No trajectory loaded');
      return;
    }

    if (this.state === 'playing') {
      hilog.warn(DOMAIN, TAG, 'Already playing');
      return;
    }

    this.callback = callback;
    this.state = 'playing';
    
    hilog.info(DOMAIN, TAG, '▶️ Playback started, speed: %dx', this.playbackSpeed);
    
    // 计算播放间隔（基于实际轨迹时间）
    this.scheduleNextPoint();
  }

  /**
   * 暂停播放
   */
  pause(): void {
    if (this.state !== 'playing') return;
    
    this.state = 'paused';
    
    if (this.playbackTimer !== -1) {
      clearTimeout(this.playbackTimer);
      this.playbackTimer = -1;
    }
    
    hilog.info(DOMAIN, TAG, '⏸️ Playback paused at index %d', this.currentIndex);
  }

  /**
   * 继续播放
   */
  resume(): void {
    if (this.state !== 'paused') return;
    
    this.state = 'playing';
    this.scheduleNextPoint();
    
    hilog.info(DOMAIN, TAG, '▶️ Playback resumed from index %d', this.currentIndex);
  }

  /**
   * 停止播放
   */
  stop(): void {
    this.state = 'idle';
    this.currentIndex = 0;
    
    if (this.playbackTimer !== -1) {
      clearTimeout(this.playbackTimer);
      this.playbackTimer = -1;
    }
    
    hilog.info(DOMAIN, TAG, '⏹️ Playback stopped');
  }

  /**
   * 跳转到指定位置
   */
  seekTo(index: number): void {
    if (index < 0 || index >= this.trajectory.length) return;
    
    this.currentIndex = index;
    
    if (this.callback) {
      this.callback(this.trajectory[index], index, this.trajectory.length);
    }
    
    hilog.info(DOMAIN, TAG, 'Seeked to index %d', index);
  }

  /**
   * 设置播放速度
   */
  setSpeed(speed: number): void {
    this.playbackSpeed = Math.max(0.5, Math.min(10, speed));
    hilog.info(DOMAIN, TAG, 'Speed set to %dx', this.playbackSpeed);
  }

  /**
   * 获取播放状态
   */
  getState(): PlaybackState {
    return this.state;
  }

  /**
   * 获取当前索引
   */
  getCurrentIndex(): number {
    return this.currentIndex;
  }

  /**
   * 获取总点数
   */
  getTotalPoints(): number {
    return this.trajectory.length;
  }

  /**
   * 获取播放进度（0-100）
   */
  getProgress(): number {
    if (this.trajectory.length === 0) return 0;
    return Math.floor((this.currentIndex / this.trajectory.length) * 100);
  }

  /**
   * 调度下一个点
   */
  private scheduleNextPoint(): void {
    if (this.state !== 'playing') return;
    
    if (this.currentIndex >= this.trajectory.length) {
      // 播放完成
      this.state = 'idle';
      hilog.info(DOMAIN, TAG, '✅ Playback completed');
      return;
    }

    const currentPoint = this.trajectory[this.currentIndex];
    
    // 回调当前点
    if (this.callback) {
      this.callback(currentPoint, this.currentIndex, this.trajectory.length);
    }

    // 计算下一个点的延迟
    let delay = 100; // 默认 100ms
    
    if (this.currentIndex < this.trajectory.length - 1) {
      const nextPoint = this.trajectory[this.currentIndex + 1];
      const timeDiff = nextPoint.timestamp - currentPoint.timestamp;
      delay = Math.floor(timeDiff / this.playbackSpeed);
      delay = Math.max(50, Math.min(2000, delay)); // 限制在 50-2000ms
    }

    this.currentIndex++;

    // 调度下一个点
    this.playbackTimer = setTimeout(() => {
      this.scheduleNextPoint();
    }, delay) as unknown as number;
  }
}

export const trajectoryPlaybackService = TrajectoryPlaybackService.getInstance();