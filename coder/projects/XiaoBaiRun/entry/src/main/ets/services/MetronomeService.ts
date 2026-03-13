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
 * 简化版本：仅记录节拍，不播放实际音频
 */
export class MetronomeService {
  private static instance: MetronomeService;
  private isPlaying: boolean = false;
  private bpm: number = 160;
  private beatInterval: number = -1;
  private beatCount: number = 0;
  
  private constructor() {}
  
  static getInstance(): MetronomeService {
    if (!MetronomeService.instance) {
      MetronomeService.instance = new MetronomeService();
    }
    return MetronomeService.instance;
  }
  
  async start(): Promise<void> {
    if (this.isPlaying) {
      hilog.warn(DOMAIN, TAG, 'Already playing');
      return;
    }
    
    try {
      this.isPlaying = true;
      this.beatCount = 0;
      const intervalMs = 60000 / this.bpm;
      
      hilog.info(DOMAIN, TAG, 'Metronome started at %d BPM', this.bpm);
      
      const playBeep = () => {
        if (!this.isPlaying) return;
        this.beatCount++;
        hilog.info(DOMAIN, TAG, 'Beat %d', this.beatCount);
      };
      
      playBeep();
      this.beatInterval = setInterval(() => {
        playBeep();
      }, intervalMs) as unknown as number;
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Start error: %s', JSON.stringify(error) ?? '');
      this.isPlaying = false;
    }
  }
  
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
      hilog.error(DOMAIN, TAG, 'Stop error: %s', JSON.stringify(error) ?? '');
    }
  }
  
  setBpm(bpm: number): void {
    if (bpm < 60 || bpm > 220) {
      hilog.warn(DOMAIN, TAG, 'Invalid BPM: %d', bpm);
      return;
    }
    this.bpm = bpm;
    hilog.info(DOMAIN, TAG, 'BPM set to %d', bpm);
    if (this.isPlaying) {
      this.stop();
      this.start();
    }
  }
  
  getBpm(): number {
    return this.bpm;
  }
  
  setVolume(volume: number): void {
    this.volume = volume;
    hilog.info(DOMAIN, TAG, 'Volume set to %f', volume);
  }
  
  getVolume(): number {
    return 0.7;
  }
  
  isCurrentlyPlaying(): boolean {
    return this.isPlaying;
  }
  
  getBeatCount(): number {
    return this.beatCount;
  }
  
  private volume: number = 0.7;
}

export const metronomeService = MetronomeService.getInstance();
