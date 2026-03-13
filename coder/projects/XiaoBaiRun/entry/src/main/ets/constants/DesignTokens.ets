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

/**
 * P1 改进：设计 Token 系统
 * 将所有 UI 常量集中管理，便于维护和深色模式切换
 */

// 颜色主题接口
export interface ColorTheme {
  backgroundColor: string;
  cardBackground: string;
  primaryColor: string;
  primaryColorPressed: string;
  secondaryColor: string;
  secondaryColorPressed: string;
  textPrimary: string;
  textSecondary: string;
  textTertiary: string;
  borderColor: string;
  dividerColor: string;
  successColor: string;
  warningColor: string;
  errorColor: string;
  infoColor: string;
  shadowColor: string;
}

// 字体大小接口
export interface FontSize {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
  xxxl: number;
  timer: number;
  icon: number;
  stat: number;
}

// 间距接口
export interface Spacing {
  xs: number;
  sm: number;
  md: number;
  lg: number;
  xl: number;
  xxl: number;
}

// 圆角接口
export interface Radius {
  sm: number;
  md: number;
  lg: number;
  xl: number;
  full: number;
}

// 按钮尺寸接口
export interface ButtonSize {
  width: number;
  height: number;
  smallWidth: number;
  smallHeight: number;
}

// 动画接口
export interface Animation {
  fast: number;
  normal: number;
  slow: number;
}

// 计时器配置接口
export interface TimerConfig {
  pomodoro: number;
  shortBreak: number;
  longBreak: number;
  pomodoroInterval: number;
}

// 成就等级接口
export interface AchievementLevel {
  beginner: number;
  intermediate: number;
  advanced: number;
  expert: number;
  master: number;
  legend: number;
}

// 浅色主题颜色
const LIGHT_THEME: ColorTheme = {
  backgroundColor: '#F7F7F7',
  cardBackground: '#FFFFFF',
  primaryColor: '#FF6B6B',
  primaryColorPressed: '#EE5A5A',
  secondaryColor: '#4ECDC4',
  secondaryColorPressed: '#3DBDB5',
  textPrimary: '#333333',
  textSecondary: '#666666',
  textTertiary: '#999999',
  borderColor: '#E0E0E0',
  dividerColor: '#E8E8E8',
  successColor: '#52C41A',
  warningColor: '#FAAD14',
  errorColor: '#FF4D4F',
  infoColor: '#1890FF',
  shadowColor: 'rgba(0, 0, 0, 0.1)',
};

// 深色主题颜色
const DARK_THEME: ColorTheme = {
  backgroundColor: '#1A1A1A',
  cardBackground: '#2D2D2D',
  primaryColor: '#FF7875',
  primaryColorPressed: '#FF6B6B',
  secondaryColor: '#5CDBD3',
  secondaryColorPressed: '#4ECDC4',
  textPrimary: '#E8E8E8',
  textSecondary: '#BFBFBF',
  textTertiary: '#8C8C8C',
  borderColor: '#434343',
  dividerColor: '#303030',
  successColor: '#73D13D',
  warningColor: '#D4B106',
  errorColor: '#FF7875',
  infoColor: '#40A9FF',
  shadowColor: 'rgba(0, 0, 0, 0.3)',
};

// 字体大小
const FONT_SIZE: FontSize = {
  xs: 12,
  sm: 14,
  md: 16,
  lg: 18,
  xl: 20,
  xxl: 24,
  xxxl: 32,
  timer: 72,
  icon: 80,
  stat: 36,
};

// 间距
const SPACING: Spacing = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
};

// 圆角
const RADIUS: Radius = {
  sm: 4,
  md: 8,
  lg: 16,
  xl: 25,
  full: 999,
};

// 按钮尺寸
const BUTTON: ButtonSize = {
  width: 140,
  height: 50,
  smallWidth: 100,
  smallHeight: 40,
};

// 动画时长
const ANIMATION: Animation = {
  fast: 150,
  normal: 300,
  slow: 500,
};

// 计时器配置
const TIMER: TimerConfig = {
  pomodoro: 25,
  shortBreak: 5,
  longBreak: 15,
  pomodoroInterval: 4,
};

// 成就等级
const ACHIEVEMENT: AchievementLevel = {
  beginner: 1,
  intermediate: 10,
  advanced: 50,
  expert: 100,
  master: 500,
  legend: 1000,
};

export class DesignTokens {
  // 浅色主题
  static readonly LIGHT: ColorTheme = LIGHT_THEME;
  
  // 深色主题
  static readonly DARK: ColorTheme = DARK_THEME;
  
  // 字体大小
  static readonly FONT_SIZE: FontSize = FONT_SIZE;
  
  // 间距
  static readonly SPACING: Spacing = SPACING;
  
  // 圆角
  static readonly RADIUS: Radius = RADIUS;
  
  // 按钮尺寸
  static readonly BUTTON: ButtonSize = BUTTON;
  
  // 动画时长
  static readonly ANIMATION: Animation = ANIMATION;
  
  // 计时器配置
  static readonly TIMER: TimerConfig = TIMER;
  
  // 成就等级
  static readonly ACHIEVEMENT: AchievementLevel = ACHIEVEMENT;
  
  /**
   * 获取当前主题颜色
   * @param isDarkMode 是否深色模式
   */
  static getThemeColors(isDarkMode: boolean): ColorTheme {
    return isDarkMode ? DesignTokens.DARK : DesignTokens.LIGHT;
  }
}
