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
 * 设计 Token 系统
 */

// 浅色主题
const LIGHT_THEME = {
  primaryColor: '#FF6B6B',
  secondaryColor: '#4ECDC4',
  backgroundColor: '#F7F7F7',
  cardBackground: '#FFFFFF',
  textPrimary: '#333333',
  textSecondary: '#666666',
  textTertiary: '#999999',
  errorColor: '#FF4D4F',
  successColor: '#52C41A',
  warningColor: '#FAAD14',
  infoColor: '#1890FF',
};

// 深色主题
const DARK_THEME = {
  primaryColor: '#FF7875',
  secondaryColor: '#5CDBD3',
  backgroundColor: '#1A1A1A',
  cardBackground: '#2D2D2D',
  textPrimary: '#E8E8E8',
  textSecondary: '#BFBFBF',
  textTertiary: '#8C8C8C',
  errorColor: '#FF7875',
  successColor: '#73D13D',
  warningColor: '#D4B106',
  infoColor: '#40A9FF',
};

// 字体大小
export const FONT_SIZE = {
  xs: 12,
  sm: 14,
  md: 16,
  lg: 18,
  xl: 20,
  xxl: 24,
  stat: 32,
  icon: 80,
};

// 间距
export const SPACING = {
  xs: 4,
  sm: 8,
  md: 16,
  lg: 24,
  xl: 32,
  xxl: 48,
};

// 圆角
export const RADIUS = {
  sm: 4,
  md: 8,
  lg: 12,
  xl: 25,
};

// 按钮尺寸
export const BUTTON = {
  width: 140,
  height: 50,
  smallWidth: 100,
  smallHeight: 40,
};

/**
 * 获取主题颜色
 */
export function getThemeColors(isDark: boolean) {
  return isDark ? DARK_THEME : LIGHT_THEME;
}
