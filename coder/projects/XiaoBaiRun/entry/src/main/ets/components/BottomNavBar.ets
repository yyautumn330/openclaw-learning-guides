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

import { DesignTokens, type ColorTheme } from '../constants/DesignTokens';

/**
 * 底部导航项
 */
export interface NavItem {
  icon: string;
  label: string;
  route: string;
}

/**
 * 底部导航组件
 */
@Component
export struct BottomNavBar {
  @Prop currentIndex: number = 0;
  @State isDarkMode: boolean = false;
  
  private colors: ColorTheme = {
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
  
  private navItems: NavItem[] = [
    { icon: '🏠', label: '首页', route: 'index' },
    { icon: '📊', label: '统计', route: 'statistics' },
    { icon: '📝', label: '历史', route: 'history' },
    { icon: '🎵', label: '节拍器', route: 'metronome' },
    { icon: '👤', label: '我的', route: 'profile' },
  ];
  
  aboutToAppear() {
    this.colors = DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  build() {
    Row() {
      ForEach(this.navItems, (item: NavItem, index: number) => {
        Column() {
          Text(item.icon)
            .fontSize(24)
            .margin({ bottom: 4 })
          
          Text(item.label)
            .fontSize(12)
            .fontColor(index === this.currentIndex ? this.colors.primaryColor : this.colors.textSecondary)
        }
        .layoutWeight(1)
        .justifyContent(FlexAlign.Center)
        .onClick(() => {
          // 触发页面切换
        })
      })
    }
    .width('100%')
    .height(60)
    .backgroundColor(this.colors.cardBackground)
    .borderRadius({ topLeft: DesignTokens.RADIUS.lg, topRight: DesignTokens.RADIUS.lg })
    .shadowColor(this.colors.shadowColor)
    .shadowRadius(8)
    .shadowOffset({ width: 0, height: -2 })
  }
}
