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

const TAG = 'MetronomeService';
const DOMAIN = 0x0000;

/**
 * 节拍器服务单例
 * 简化版本：使用系统音效模拟节拍
 */
export class MetronomeService {
  private static instance: MetronomeService;
  private isPlaying: boolean = false;
  private bpm: number = 160; // 默认步频 160 步/分钟
  private volume: number = 0.5; // 音量 0-1
  private beatInterval: number = -1;
  private beatCount: number = 0;
  
  private constructor() {}
  
  /**
   * 获取单例实例
   */
  static getInstance(): MetronomeService {
    if (!MetronomeService.instance) {
      MetronomeService.instance = new MetronomeService();
    }
    return MetronomeService.instance;
  }
  
  /**
   * 开始播放节拍
   * 使用系统 beep 音模拟
   */
  async start(): Promise<void> {
    if (this.isPlaying) {
      hilog.warn(DOMAIN, TAG, 'Already playing');
      return;
    }
    
    try {
      this.isPlaying = true;
      this.beatCount = 0;
      
      // 计算节拍间隔 (毫秒)
      const intervalMs = 60000 / this.bpm;
      
      hilog.info(DOMAIN, TAG, 'Metronome started at %{public}d BPM', this.bpm);
      
      // 使用系统音效模拟节拍 (简化实现)
      // 实际项目中可以使用 system.sound.playEffect() 或自定义音频
      const playBeep = () => {
        if (!this.isPlaying) return;
        
        this.beatCount++;
        hilog.info(DOMAIN, TAG, 'Beat %{public}d', this.beatCount);
        
        // 这里可以集成实际音频播放
        // 当前使用日志模拟节拍
      };
      
      // 立即播放第一拍
      playBeep();
      
      // 设置节拍定时器
      this.beatInterval = setInterval(() => {
        playBeep();
      }, intervalMs) as unknown as number;
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Start error: %{public}s', JSON.stringify(error) ?? '');
      this.isPlaying = false;
    }
  }
  
  /**
   * 停止播放节拍
   */
  async stop(): Promise<void> {
    if (!this.isPlaying) {
      return;
    }
    
    try {
      this.isPlaying = false;
      
      if (this.beatInterval !== -1) {
        clearInterval(this.beatInterval);
        this.beatInterval = -1;
      }
      
      hilog.info(DOMAIN, TAG, 'Metronome stopped');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Stop error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * 设置步频 (BPM)
   */
  setBpm(bpm: number): void {
    if (bpm < 60 || bpm > 220) {
      hilog.warn(DOMAIN, TAG, 'Invalid BPM: %{public}d', bpm);
      return;
    }
    
    this.bpm = bpm;
    hilog.info(DOMAIN, TAG, 'BPM set to %{public}d', bpm);
    
    // 如果正在播放，重启节拍器
    if (this.isPlaying) {
      this.stop();
      this.start();
    }
  }
  
  /**
   * 获取当前步频
   */
  getBpm(): number {
    return this.bpm;
  }
  
  /**
   * 设置音量
   */
  setVolume(volume: number): void {
    if (volume < 0 || volume > 1) {
      hilog.warn(DOMAIN, TAG, 'Invalid volume: %{public}f', volume);
      return;
    }
    
    this.volume = volume;
    hilog.info(DOMAIN, TAG, 'Volume set to %{public}f', volume);
  }
  
  /**
   * 获取音量
   */
  getVolume(): number {
    return this.volume;
  }
  
  /**
   * 是否正在播放
   */
  isCurrentlyPlaying(): boolean {
    return this.isPlaying;
  }
  
  /**
   * 获取节拍计数
   */
  getBeatCount(): number {
    return this.beatCount;
  }
}

// 导出单例
export const metronomeService = MetronomeService.getInstance();
