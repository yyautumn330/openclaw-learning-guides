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

export class DesignTokens {
  // ==================== 颜色系统 ====================
  
  // 浅色主题颜色
  static readonly LIGHT = {
    // 背景色
    backgroundColor: '#F7F7F7',
    cardBackground: '#FFFFFF',
    
    // 主色调 - 番茄红
    primaryColor: '#FF6B6B',
    primaryColorPressed: '#EE5A5A',
    
    // 辅助色 - 薄荷绿
    secondaryColor: '#4ECDC4',
    secondaryColorPressed: '#3DBDB5',
    
    // 文字颜色
    textPrimary: '#333333',
    textSecondary: '#666666',
    textTertiary: '#999999',
    
    // 边框和分割线
    borderColor: '#E0E0E0',
    dividerColor: '#E8E8E8',
    
    // 状态色
    successColor: '#52C41A',
    warningColor: '#FAAD14',
    errorColor: '#FF4D4F',
    infoColor: '#1890FF',
    
    // 阴影
    shadowColor: 'rgba(0, 0, 0, 0.1)',
  };
  
  // 深色主题颜色
  static readonly DARK = {
    // 背景色
    backgroundColor: '#1A1A1A',
    cardBackground: '#2D2D2D',
    
    // 主色调 - 番茄红（降低饱和度）
    primaryColor: '#FF7875',
    primaryColorPressed: '#FF6B6B',
    
    // 辅助色 - 薄荷绿
    secondaryColor: '#5CDBD3',
    secondaryColorPressed: '#4ECDC4',
    
    // 文字颜色
    textPrimary: '#E8E8E8',
    textSecondary: '#BFBFBF',
    textTertiary: '#8C8C8C',
    
    // 边框和分割线
    borderColor: '#434343',
    dividerColor: '#303030',
    
    // 状态色
    successColor: '#73D13D',
    warningColor: '#D4B106',
    errorColor: '#FF7875',
    infoColor: '#40A9FF',
    
    // 阴影
    shadowColor: 'rgba(0, 0, 0, 0.3)',
  };
  
  // ==================== 尺寸系统 ====================
  
  // 字体大小
  static readonly FONT_SIZE = {
    xs: 12,
    sm: 14,
    md: 16,
    lg: 18,
    xl: 20,
    xxl: 24,
    xxxl: 32,
    timer: 72, // 计时器特大字体
    icon: 80,  // 图标特大字体
  };
  
  // 间距
  static readonly SPACING = {
    xs: 4,
    sm: 8,
    md: 16,
    lg: 24,
    xl: 32,
    xxl: 48,
  };
  
  // 圆角
  static readonly RADIUS = {
    sm: 4,
    md: 8,
    lg: 16,
    xl: 25, // 按钮大圆角
    full: 999,
  };
  
  // 按钮尺寸
  static readonly BUTTON = {
    width: 140,
    height: 50,
    smallWidth: 100,
    smallHeight: 40,
  };
  
  // ==================== 动画 ====================
  
  // 动画时长
  static readonly ANIMATION = {
    fast: 150,
    normal: 300,
    slow: 500,
  };
  
  // ==================== 计时器配置 ====================
  
  // 默认时间（分钟）
  static readonly TIMER = {
    pomodoro: 25,
    shortBreak: 5,
    longBreak: 15,
    pomodoroInterval: 4, // 几个番茄后长休息
  };
  
  // ==================== 成就系统 ====================
  
  // 成就等级
  static readonly ACHIEVEMENT = {
    beginner: 1,    // 新手入门
    intermediate: 10, // 渐入佳境
    advanced: 50,     // 得心应手
    expert: 100,      // 专家级别
    master: 500,      // 大师级别
    legend: 1000,     // 传奇级别
  };
  
  /**
   * 获取当前主题颜色
   * @param isDarkMode 是否深色模式
   */
  static getThemeColors(isDarkMode: boolean): typeof DesignTokens.LIGHT {
    return isDarkMode ? DesignTokens.DARK : DesignTokens.LIGHT;
  }
}
