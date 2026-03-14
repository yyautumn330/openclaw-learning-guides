/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not obtain a copy of the License at
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

const TAG = 'VoicePromptService';
const DOMAIN = 0x0000;

/**
 * 语音提示类型
 */
export enum VoicePromptType {
  /** 节拍数提示（每20拍） */
  BEAT_COUNT = 'beat_count',

  /** BPM变化提示 */
  BPM_CHANGE = 'bpm_change',

  /** 节奏阶段提示（冲刺/恢复） */
  PHASE_CHANGE = 'phase_change',

  /** 配速提醒 */
  PACE_REMINDER = 'pace_reminder',

  /** 自定义文本 */
  CUSTOM = 'custom'
}

/**
 * 语音提示配置接口
 */
export interface VoicePromptConfig {
  /** 是否启用 */
  enabled: boolean;

  /** 提示音量（0-1） */
  volume: number;

  /** 提示间隔（拍数） */
  interval: number;

  /** 启用的提示类型 */
  promptTypes: VoicePromptType[];
}

/**
 * 默认语音提示配置
 */
export const DEFAULT_VOICE_CONFIG: VoicePromptConfig = {
  enabled: false,
  volume: 0.8,
  interval: 20,
  promptTypes: [
    VoicePromptType.BEAT_COUNT,
    VoicePromptType.BPM_CHANGE,
    VoicePromptType.PHASE_CHANGE
  ]
};

/**
 * 语音提示服务
 * 使用系统TTS引擎播放语音提示
 */
export class VoicePromptService {
  private static instance: VoicePromptService;
  private config: VoicePromptConfig;
  private context: common.UIAbilityContext | null = null;
  private avPlayer: media.AVPlayer | null = null;
  private isPlaying: boolean = false;

  private constructor() {
    this.config = { ...DEFAULT_VOICE_CONFIG };
  }

  static getInstance(): VoicePromptService {
    if (!VoicePromptService.instance) {
      VoicePromptService.instance = new VoicePromptService();
    }
    return VoicePromptService.instance;
  }

  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }

  /**
   * 设置配置
   */
  setConfig(config: Partial<VoicePromptConfig>): void {
    this.config = { ...this.config, ...config };
    hilog.info(DOMAIN, TAG, 'Config updated: enabled=%s', this.config.enabled);
  }

  /**
   * 获取配置
   */
  getConfig(): VoicePromptConfig {
    return { ...this.config };
  }

  /**
   * 播放语音提示
   *
   * 注意：HarmonyOS TTS API 较复杂，这里使用音频文件模拟
   * 真实环境可以使用 `@ohos.ai.tts.textToSpeechEngine`
   */
  async speak(text: string, type: VoicePromptType = VoicePromptType.CUSTOM): Promise<void> {
    if (!this.config.enabled) {
      hilog.debug(DOMAIN, TAG, 'Voice prompt disabled');
      return;
    }

    // 检查是否启用了该类型
    if (type !== VoicePromptType.CUSTOM && !this.config.promptTypes.includes(type)) {
      hilog.debug(DOMAIN, TAG, 'Voice prompt type not enabled: %{public}s', type);
      return;
    }

    try {
      // 生成TTS音频文件路径（简化版，使用预录制的音频文件）
      // 实际环境应使用TTS API生成
      const audioPath = this.getAudioPath(text, type);

      if (!audioPath) {
        hilog.warn(DOMAIN, TAG, 'No audio path for text: %{public}s', text);
        return;
      }

      // 如果没有AVPlayer，创建一个
      if (!this.avPlayer) {
        this.avPlayer = await media.createAVPlayer();
      }

      // 设置音量
      this.avPlayer.setVolume(this.config.volume);

      // 播放音频
      this.avPlayer.url = audioPath;
      await this.avPlayer.play();

      hilog.info(DOMAIN, TAG, '🗣️ Spoke: %{public}s', text);
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(DOMAIN, TAG, 'Speak error: %{public}s', err.message ?? '');
    }
  }

  /**
   * 播放节拍数提示
   */
  async speakBeatCount(beatCount: number, bpm: number): Promise<void> {
    const text = `保持节奏，当前${bpm}步每分钟`;
    await this.speak(text, VoicePromptType.BEAT_COUNT);
  }

  /**
   * 播放BPM变化提示
   */
  async speakBpmChange(oldBpm: number, newBpm: number): Promise<void> {
    const text = newBpm > oldBpm
      ? `加速到${newBpm}步每分钟`
      : `减速到${newBpm}步每分钟`;
    await this.speak(text, VoicePromptType.BPM_CHANGE);
  }

  /**
   * 播放节奏阶段提示
   */
  async speakPhaseChange(phase: string): Promise<void> {
    const text = phase.includes('冲刺')
      ? `开始冲刺${phase}`
      : `进入恢复${phase}`;
    await this.speak(text, VoicePromptType.PHASE_CHANGE);
  }

  /**
   * 播放配速提醒
   */
  async speakPaceReminder(pace: number): Promise<void> {
    const minutes = Math.floor(pace);
    const seconds = Math.round((pace - minutes) * 60);
    const text = `当前配速${minutes}分${seconds}秒每公里`;
    await this.speak(text, VoicePromptType.PACE_REMINDER);
  }

  /**
   * 检查是否需要播报（根据节拍数）
   */
  shouldPrompt(beatCount: number): boolean {
    return this.config.enabled && (beatCount % this.config.interval === 0);
  }

  /**
   * 获取音频文件路径（简化版）
   * 实际环境应使用TTS API生成音频
   *
   * 注意：临时统一使用电子音，避免音频文件缺失导致构建失败
   */
  private getAudioPath(text: string, type: VoicePromptType): string | null {
    // 临时统一使用电子音（避免音频文件缺失）
    // TODO: 后续生成真实的语音提示音频文件
    return 'resource://rawfile/metronome_beep.mp3';

    // 原始代码（待音频文件就绪后启用）
    // switch (type) {
    //   case VoicePromptType.BEAT_COUNT:
    //     return 'resource://rawfile/voice_beat_count.mp3';
    //   case VoicePromptType.BPM_CHANGE:
    //     return 'resource://rawfile/voice_bpm_change.mp3';
    //   case VoicePromptType.PHASE_CHANGE:
    //     return 'resource://rawfile/voice_phase_change.mp3';
    //   case VoicePromptType.PACE_REMINDER:
    //     return 'resource://rawfile/voice_pace_reminder.mp3';
    //   default:
    //     return null;
    // }
  }

  /**
   * 停止播放
   */
  async stop(): Promise<void> {
    if (this.avPlayer) {
      try {
        await this.avPlayer.release();
        this.avPlayer = null;
      } catch (error) {
        hilog.warn(DOMAIN, TAG, 'AVPlayer release error');
      }
    }
    hilog.info(DOMAIN, TAG, 'Voice prompt stopped');
  }
}

export const voicePromptService = VoicePromptService.getInstance();