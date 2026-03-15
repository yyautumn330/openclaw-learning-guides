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
import preferences from '@ohos.data.preferences';

const TAG = 'SettingsService';
const DOMAIN = 0x0000;

const PREFS_NAME = 'xiaobai_run_settings';
const KEY_DARK_MODE = 'dark_mode';
const KEY_VOICE_ENABLED = 'voice_enabled';
const KEY_METRONOME_BPM = 'metronome_bpm';
const KEY_METRONOME_VOLUME = 'metronome_volume';

/**
 * 用户设置
 */
export interface UserSettings {
  darkMode: boolean;
  voiceEnabled: boolean;
  metronomeBpm: number;
  metronomeVolume: number;
}

/**
 * 设置服务
 * 管理用户偏好设置的持久化
 */
export class SettingsService {
  private static instance: SettingsService;
  private context: common.UIAbilityContext | null = null;
  private prefs: preferences.Preferences | null = null;
  
  // 默认设置
  private defaultSettings: UserSettings = {
    darkMode: false,
    voiceEnabled: true,
    metronomeBpm: 180,
    metronomeVolume: 0.7
  };
  
  // 内存缓存
  private settings: UserSettings = { ...this.defaultSettings };
  private isLoaded: boolean = false;

  private constructor() {}

  static getInstance(): SettingsService {
    if (!SettingsService.instance) {
      SettingsService.instance = new SettingsService();
    }
    return SettingsService.instance;
  }

  /**
   * 设置上下文
   */
  async setContext(context: common.UIAbilityContext): Promise<void> {
    this.context = context;
    await this.loadSettings();
  }

  /**
   * 加载设置
   */
  async loadSettings(): Promise<void> {
    if (!this.context || this.isLoaded) return;

    try {
      this.prefs = await preferences.getPreferences(this.context, PREFS_NAME);
      
      this.settings.darkMode = await this.prefs.get(KEY_DARK_MODE, this.defaultSettings.darkMode) as boolean;
      this.settings.voiceEnabled = await this.prefs.get(KEY_VOICE_ENABLED, this.defaultSettings.voiceEnabled) as boolean;
      this.settings.metronomeBpm = await this.prefs.get(KEY_METRONOME_BPM, this.defaultSettings.metronomeBpm) as number;
      this.settings.metronomeVolume = await this.prefs.get(KEY_METRONOME_VOLUME, this.defaultSettings.metronomeVolume) as number;
      
      this.isLoaded = true;
      hilog.info(DOMAIN, TAG, 'Settings loaded: darkMode=%{public}s', this.settings.darkMode);
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Load settings failed: %{public}s', JSON.stringify(error));
      this.settings = { ...this.defaultSettings };
    }
  }

  /**
   * 保存设置
   */
  private async saveSettings(): Promise<void> {
    if (!this.prefs) return;

    try {
      await this.prefs.put(KEY_DARK_MODE, this.settings.darkMode);
      await this.prefs.put(KEY_VOICE_ENABLED, this.settings.voiceEnabled);
      await this.prefs.put(KEY_METRONOME_BPM, this.settings.metronomeBpm);
      await this.prefs.put(KEY_METRONOME_VOLUME, this.settings.metronomeVolume);
      await this.prefs.flush();
      
      hilog.debug(DOMAIN, TAG, 'Settings saved');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Save settings failed: %{public}s', JSON.stringify(error));
    }
  }

  // ========== 深色模式 ==========

  getDarkMode(): boolean {
    return this.settings.darkMode;
  }

  async setDarkMode(enabled: boolean): Promise<void> {
    this.settings.darkMode = enabled;
    await this.saveSettings();
    hilog.info(DOMAIN, TAG, 'Dark mode set to: %{public}s', enabled);
  }

  // ========== 语音播报 ==========

  getVoiceEnabled(): boolean {
    return this.settings.voiceEnabled;
  }

  async setVoiceEnabled(enabled: boolean): Promise<void> {
    this.settings.voiceEnabled = enabled;
    await this.saveSettings();
    hilog.info(DOMAIN, TAG, 'Voice enabled set to: %{public}s', enabled);
  }

  // ========== 节拍器 ==========

  getMetronomeBpm(): number {
    return this.settings.metronomeBpm;
  }

  async setMetronomeBpm(bpm: number): Promise<void> {
    this.settings.metronomeBpm = bpm;
    await this.saveSettings();
    hilog.info(DOMAIN, TAG, 'Metronome BPM set to: %d', bpm);
  }

  getMetronomeVolume(): number {
    return this.settings.metronomeVolume;
  }

  async setMetronomeVolume(volume: number): Promise<void> {
    this.settings.metronomeVolume = volume;
    await this.saveSettings();
    hilog.info(DOMAIN, TAG, 'Metronome volume set to: %f', volume);
  }

  // ========== 全部设置 ==========

  getSettings(): UserSettings {
    return { ...this.settings };
  }

  async updateSettings(newSettings: Partial<UserSettings>): Promise<void> {
    this.settings = { ...this.settings, ...newSettings };
    await this.saveSettings();
    hilog.info(DOMAIN, TAG, 'Settings updated');
  }

  /**
   * 重置为默认设置
   */
  async resetToDefaults(): Promise<void> {
    this.settings = { ...this.defaultSettings };
    await this.saveSettings();
    hilog.info(DOMAIN, TAG, 'Settings reset to defaults');
  }
}

export const settingsService = SettingsService.getInstance();