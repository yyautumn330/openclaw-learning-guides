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

const TAG = 'I18nService';
const DOMAIN = 0x0000;

/**
 * 支持的语言
 */
export type SupportedLanguage = 'zh' | 'en';

/**
 * 语言配置
 */
export interface LanguageConfig {
  code: SupportedLanguage;
  name: string;
  nativeName: string;
}

/**
 * 多语言服务
 */
export class I18nService {
  private static instance: I18nService;
  
  private currentLanguage: SupportedLanguage = 'zh';
  
  // 支持的语言列表
  private readonly supportedLanguages: LanguageConfig[] = [
    { code: 'zh', name: 'Chinese', nativeName: '中文' },
    { code: 'en', name: 'English', nativeName: 'English' }
  ];
  
  // 文本资源
  private readonly resources: Record<SupportedLanguage, Record<string, string>> = {
    zh: {
      // 通用
      'app_name': '小白快跑',
      'tab_home': '首页',
      'tab_stats': '统计',
      'tab_history': '历史',
      'tab_metronome': '节拍器',
      'tab_profile': '我的',
      
      // 首页
      'start_run': '开始跑步',
      'pause': '暂停',
      'resume': '继续',
      'stop': '停止',
      'duration': '时长',
      'distance': '距离',
      'pace': '配速',
      'simulation_mode': '模拟模式',
      
      // 节拍器
      'metronome_title': '跑步节拍器',
      'bpm': 'BPM',
      'volume': '音量',
      'quick_select': '快速选择',
      
      // 统计
      'today': '今天',
      'this_week': '本周',
      'this_month': '本月',
      'total_runs': '总跑步次数',
      'total_distance': '总距离',
      'total_duration': '总时长',
      'avg_pace': '平均配速',
      
      // 设置
      'settings': '设置',
      'dark_mode': '深色模式',
      'language': '语言',
      'about': '关于',
      'version': '版本',
      
      // 单位
      'km': '公里',
      'm': '米',
      'hour': '小时',
      'minute': '分钟',
      'second': '秒',
      'calorie': '卡路里',
      
      // 提示
      'run_started': '开始跑步',
      'run_paused': '已暂停',
      'run_stopped': '跑步完成',
      'dark_mode_enabled': '已开启深色模式',
      'dark_mode_disabled': '已关闭深色模式'
    },
    en: {
      // Common
      'app_name': 'XiaoBai Run',
      'tab_home': 'Home',
      'tab_stats': 'Stats',
      'tab_history': 'History',
      'tab_metronome': 'Metronome',
      'tab_profile': 'Profile',
      
      // Home
      'start_run': 'Start Run',
      'pause': 'Pause',
      'resume': 'Resume',
      'stop': 'Stop',
      'duration': 'Duration',
      'distance': 'Distance',
      'pace': 'Pace',
      'simulation_mode': 'Simulation Mode',
      
      // Metronome
      'metronome_title': 'Running Metronome',
      'bpm': 'BPM',
      'volume': 'Volume',
      'quick_select': 'Quick Select',
      
      // Stats
      'today': 'Today',
      'this_week': 'This Week',
      'this_month': 'This Month',
      'total_runs': 'Total Runs',
      'total_distance': 'Total Distance',
      'total_duration': 'Total Duration',
      'avg_pace': 'Avg Pace',
      
      // Settings
      'settings': 'Settings',
      'dark_mode': 'Dark Mode',
      'language': 'Language',
      'about': 'About',
      'version': 'Version',
      
      // Units
      'km': 'km',
      'm': 'm',
      'hour': 'h',
      'minute': 'min',
      'second': 's',
      'calorie': 'cal',
      
      // Messages
      'run_started': 'Run started',
      'run_paused': 'Paused',
      'run_stopped': 'Run completed',
      'dark_mode_enabled': 'Dark mode enabled',
      'dark_mode_disabled': 'Dark mode disabled'
    }
  };

  private constructor() {}

  static getInstance(): I18nService {
    if (!I18nService.instance) {
      I18nService.instance = new I18nService();
    }
    return I18nService.instance;
  }

  /**
   * 获取当前语言
   */
  getCurrentLanguage(): SupportedLanguage {
    return this.currentLanguage;
  }

  /**
   * 设置语言
   */
  setLanguage(lang: SupportedLanguage): void {
    this.currentLanguage = lang;
    hilog.info(DOMAIN, TAG, 'Language set to: %{public}s', lang);
  }

  /**
   * 获取支持的语列表
   */
  getSupportedLanguages(): LanguageConfig[] {
    return this.supportedLanguages;
  }

  /**
   * 获取文本
   */
  t(key: string): string {
    const resources = this.resources[this.currentLanguage];
    return resources[key] || key;
  }

  /**
   * 格式化文本
   */
  format(key: string, ...args: (string | number)[]): string {
    let text = this.t(key);
    args.forEach((arg, index) => {
      text = text.replace(`{${index}}`, String(arg));
    });
    return text;
  }

  /**
   * 获取语言名称
   */
  getLanguageName(code: SupportedLanguage): string {
    const lang = this.supportedLanguages.find(l => l.code === code);
    return lang ? lang.nativeName : code;
  }
}

export const i18nService = I18nService.getInstance();