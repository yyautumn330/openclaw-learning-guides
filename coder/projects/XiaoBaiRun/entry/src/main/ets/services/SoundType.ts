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

/**
 * 声音类型枚举
 */
export enum SoundType {
  /** 电子音 - 标准beep */
  ELECTRONIC = 'electronic',

  /** 鼓点 - 类似击鼓声 */
  DRUM = 'drum',

  /** 人声提示 - 口令式声音 */
  VOICE = 'voice'
}

/**
 * 声音类型配置接口
 */
export interface SoundConfig {
  /** 声音类型 */
  type: SoundType;

  /** 是否启用人声提示（仅对VOICE类型有效） */
  enableVoicePrompt: boolean;

  /** 人声提示间隔（拍数）- 每隔多少拍播报一次 */
  voicePromptInterval: number;

  /** 音频文件路径 */
  audioPath: string;
}

/**
 * 默认电子音配置
 */
export const ELECTRONIC_CONFIG: SoundConfig = {
  type: SoundType.ELECTRONIC,
  enableVoicePrompt: false,
  voicePromptInterval: 10,
  audioPath: 'resource://rawfile/metronome_beep.mp3'
};

/**
 * 默认鼓点配置
 *
 * 注意：临时使用电子音（鼓点音频文件待生成）
 */
export const DRUM_CONFIG: SoundConfig = {
  type: SoundType.DRUM,
  enableVoicePrompt: false,
  voicePromptInterval: 10,
  audioPath: 'resource://rawfile/metronome_beep.mp3' // 临时使用电子音
};

/**
 * 默认人声配置
 */
export const VOICE_CONFIG: SoundConfig = {
  type: SoundType.VOICE,
  enableVoicePrompt: true,
  voicePromptInterval: 20,
  audioPath: 'resource://rawfile/voice_prompt.mp3'
};

/**
 * 获取声音类型显示名称
 */
export function getSoundTypeName(type: SoundType): string {
  switch (type) {
    case SoundType.ELECTRONIC:
      return '电子音';
    case SoundType.DRUM:
      return '鼓点';
    case SoundType.VOICE:
      return '人声提示';
    default:
      return '未知';
  }
}