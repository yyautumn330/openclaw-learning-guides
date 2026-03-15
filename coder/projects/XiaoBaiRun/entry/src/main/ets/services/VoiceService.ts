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

const TAG = 'VoiceService';
const DOMAIN = 0x0000;

/**
 * 语音播报服务
 * 用于跑步过程中的语音提示
 * 
 * 当前版本使用日志模拟语音播报
 * 真机测试时可使用 @ohos.ai.tts 或其他 TTS 服务
 */
export class VoiceService {
  private static instance: VoiceService;
  private isEnabled: boolean = true;
  private lastMilestone: number = 0;
  private context: common.UIAbilityContext | null = null;

  private constructor() {}

  static getInstance(): VoiceService {
    if (!VoiceService.instance) {
      VoiceService.instance = new VoiceService();
    }
    return VoiceService.instance;
  }

  /**
   * 设置上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
    hilog.info(DOMAIN, TAG, 'VoiceService context set');
  }

  /**
   * 启用/禁用语音
   */
  setEnabled(enabled: boolean): void {
    this.isEnabled = enabled;
    hilog.info(DOMAIN, TAG, 'Voice enabled: %{public}s', enabled ? 'true' : 'false');
  }

  /**
   * 是否启用
   */
  getEnabled(): boolean {
    return this.isEnabled;
  }

  /**
   * 播报距离里程碑
   */
  announceMilestone(distanceKm: number): void {
    if (!this.isEnabled) return;
    
    // 每公里播报一次
    const currentKm = Math.floor(distanceKm);
    if (currentKm > this.lastMilestone && currentKm > 0) {
      this.lastMilestone = currentKm;
      const text = `恭喜你，已完成${currentKm}公里`;
      this.speak(text);
    }
  }

  /**
   * 播报开始跑步
   */
  announceStart(): void {
    if (!this.isEnabled) return;
    this.speak('开始跑步');
  }

  /**
   * 播报暂停
   */
  announcePause(distance: number, duration: number): void {
    if (!this.isEnabled) return;
    
    const distanceText = this.formatDistance(distance);
    const durationText = this.formatDuration(duration);
    const text = `已暂停，当前${distanceText}，用时${durationText}`;
    this.speak(text);
  }

  /**
   * 播报继续
   */
  announceResume(): void {
    if (!this.isEnabled) return;
    this.speak('继续跑步');
  }

  /**
   * 播报结束
   */
  announceStop(distance: number, duration: number): void {
    if (!this.isEnabled) return;
    
    const distanceText = this.formatDistance(distance);
    const durationText = this.formatDuration(duration);
    const paceText = this.formatPace(distance, duration);
    const text = `跑步结束，总距离${distanceText}，总时长${durationText}，平均配速${paceText}`;
    this.speak(text);
    
    // 重置里程碑
    this.lastMilestone = 0;
  }

  /**
   * 语音播报（当前版本使用日志模拟）
   * 
   * TODO: 真机测试时集成实际 TTS API
   * 方案 1: @ohos.ai.tts (HarmonyOS TTS)
   * 方案 2: 第三方 TTS 服务（讯飞、百度等）
   */
  private speak(text: string): void {
    try {
      hilog.info(DOMAIN, TAG, '🔊 Voice: %{public}s', text);
      
      // 当前版本使用日志模拟语音播报
      // 真机测试时可在此处添加实际 TTS 调用
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Speak failed: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 格式化距离
   */
  private formatDistance(meters: number): string {
    if (meters < 1000) {
      return `${Math.round(meters)}米`;
    }
    return `${(meters / 1000).toFixed(1)}公里`;
  }

  /**
   * 格式化时长
   */
  private formatDuration(seconds: number): string {
    const hours = Math.floor(seconds / 3600);
    const minutes = Math.floor((seconds % 3600) / 60);
    const secs = Math.floor(seconds % 60);
    
    if (hours > 0) {
      return `${hours}小时${minutes}分${secs}秒`;
    } else if (minutes > 0) {
      return `${minutes}分${secs}秒`;
    }
    return `${secs}秒`;
  }

  /**
   * 格式化配速
   */
  private formatPace(distance: number, duration: number): string {
    if (distance === 0) return '0分每公里';
    
    const paceSeconds = duration / (distance / 1000);
    const minutes = Math.floor(paceSeconds / 60);
    const seconds = Math.floor(paceSeconds % 60);
    
    return `${minutes}分${seconds}秒每公里`;
  }
}

export const voiceService = VoiceService.getInstance();