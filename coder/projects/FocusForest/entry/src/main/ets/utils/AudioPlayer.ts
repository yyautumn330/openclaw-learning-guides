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

const TAG = 'AudioPlayer';
const DOMAIN = 0x0000;

export enum SoundType {
  RAIN = 1,
  CAFE = 2,
  WAVES = 3,
  FOREST = 4,
  CAMPFIRE = 5,
  NIGHT_RAIN = 6
}

export class AudioPlayer {
  private static instance: AudioPlayer;
  private currentSoundId: number = -1;
  private isPlaying: boolean = false;
  private volume: number = 0.6;
  
  private constructor() {}
  
  static getInstance(): AudioPlayer {
    if (!AudioPlayer.instance) {
      AudioPlayer.instance = new AudioPlayer();
    }
    return AudioPlayer.instance;
  }
  
  async play(soundId: SoundType, volume?: number): Promise<void> {
    try {
      if (this.currentSoundId === soundId && this.isPlaying) {
        hilog.info(DOMAIN, TAG, 'Sound already playing, skipping');
        return;
      }
      
      await this.stop();
      
      this.currentSoundId = soundId;
      this.volume = volume ?? this.volume;
      
      const soundPath = this.getSoundPath(soundId);
      hilog.info(DOMAIN, TAG, 'Playing sound: %{public}s', soundPath);
      
      // TODO: 使用 HarmonyOS audio 模块播放音频
      // 这里需要集成实际的音频播放功能
      this.isPlaying = true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Play sound error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  async stop(): Promise<void> {
    try {
      if (!this.isPlaying) {
        return;
      }
      
      hilog.info(DOMAIN, TAG, 'Stopping sound');
      
      // TODO: 停止音频播放
      this.isPlaying = false;
      this.currentSoundId = -1;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Stop sound error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  setVolume(volume: number): void {
    this.volume = Math.max(0, Math.min(1, volume));
    hilog.info(DOMAIN, TAG, 'Volume set to: %{public}f', this.volume);
  }
  
  getVolume(): number {
    return this.volume;
  }
  
  isPlayingSound(): boolean {
    return this.isPlaying;
  }
  
  getCurrentSoundId(): number {
    return this.currentSoundId;
  }
  
  private getSoundPath(soundId: SoundType): string {
    const paths: Record<number, string> = {
      [SoundType.RAIN]: 'rawfile/sounds/rain.mp3',
      [SoundType.CAFE]: 'rawfile/sounds/cafe.mp3',
      [SoundType.WAVES]: 'rawfile/sounds/waves.mp3',
      [SoundType.FOREST]: 'rawfile/sounds/forest.mp3',
      [SoundType.CAMPFIRE]: 'rawfile/sounds/campfire.mp3',
      [SoundType.NIGHT_RAIN]: 'rawfile/sounds/night_rain.mp3'
    };
    return paths[soundId] || '';
  }
}

export const audioPlayer = AudioPlayer.getInstance();
