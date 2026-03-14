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
import media from '@ohos.multimedia.media';
import { BusinessError } from '@kit.BasicServicesKit';

const TAG = 'MetronomeService';
const DOMAIN = 0x0000;

/**
 * 节拍器服务单例
 */
export class MetronomeService {
  private static instance: MetronomeService;
  private isPlaying: boolean = false;
  private bpm: number = 160;
  private beatInterval: number = -1;
  private beatCount: number = 0;
  private context: common.UIAbilityContext | null = null;
  private volume: number = 0.7;
  private avPlayer: media.AVPlayer | null = null;
  
  private constructor() {}
  
  static getInstance(): MetronomeService {
    if (!MetronomeService.instance) {
      MetronomeService.instance = new MetronomeService();
    }
    return MetronomeService.instance;
  }
  
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }
  
  /**
   * 播放 beep 音
   */
  private async playBeep(): Promise<void> {
    if (!this.isPlaying) return;
    
    try {
      // 如果没有 AVPlayer，创建一个
      if (!this.avPlayer) {
        this.avPlayer = await media.createAVPlayer();
      }
      
      // 设置音量
      this.avPlayer.setVolume(this.volume);
      
      // 播放音频
      this.avPlayer.url = `resource://rawfile/metronome_beep.mp3`;
      await this.avPlayer.play();
      
      hilog.info(DOMAIN, TAG, '🔊 Beep played (vol: %.1f)', this.volume);
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(DOMAIN, TAG, 'Play beep error: %{public}s', err.message ?? '');
      
      // 如果播放失败，回退到日志
      hilog.info(DOMAIN, TAG, '🔊 Beep at %d BPM (vol: %.1f)', this.bpm, this.volume);
    }
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
      
      hilog.info(DOMAIN, TAG, '🎵 Metronome started at %d BPM', this.bpm);
      
      const playBeat = async () => {
        if (!this.isPlaying) return;
        this.beatCount++;
        await this.playBeep();
        hilog.info(DOMAIN, TAG, 'Beat %d', this.beatCount);
      };
      
      playBeat();
      
      this.beatInterval = setInterval(() => {
        playBeat();
      }, intervalMs) as unknown as number;
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Start error: %{public}s', JSON.stringify(error) ?? '');
      this.isPlaying = false;
    }
  }
  
  async stop(): Promise<void> {
    if (!this.isPlaying) return;
    
    try {
      this.isPlaying = false;
      if (this.beatInterval !== -1) {
        clearInterval(this.beatInterval);
        this.beatInterval = -1;
      }
      
      // 释放 AVPlayer
      if (this.avPlayer) {
        try {
          await this.avPlayer.release();
          this.avPlayer = null;
        } catch (error) {
          hilog.warn(DOMAIN, TAG, 'AVPlayer release error');
        }
      }
      
      hilog.info(DOMAIN, TAG, '🎵 Metronome stopped');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Stop error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  async setBpm(bpm: number): Promise<void> {
    if (bpm < 60 || bpm > 220) {
      hilog.warn(DOMAIN, TAG, 'Invalid BPM: %d', bpm);
      return;
    }
    this.bpm = bpm;
    hilog.info(DOMAIN, TAG, 'BPM set to %d', bpm);
    if (this.isPlaying) {
      await this.stop();
      await this.start();
    }
  }
  
  getBpm(): number {
    return this.bpm;
  }
  
  setVolume(volume: number): void {
    this.volume = volume;
    // 如果 AVPlayer 存在且正在播放，实时调整音量
    if (this.avPlayer && this.isPlaying) {
      this.avPlayer.setVolume(volume);
    }
    hilog.info(DOMAIN, TAG, 'Volume set to %f', volume);
  }
  
  getVolume(): number {
    return this.volume;
  }
  
  isCurrentlyPlaying(): boolean {
    return this.isPlaying;
  }
  
  getBeatCount(): number {
    return this.beatCount;
  }
}

export const metronomeService = MetronomeService.getInstance();
