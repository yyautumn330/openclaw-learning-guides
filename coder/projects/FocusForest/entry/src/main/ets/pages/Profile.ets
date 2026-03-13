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

import { PomodoroModel } from '../utils/PomodoroModel';
import { DesignTokens } from '../constants/DesignTokens';
import { common } from '@kit.AbilityKit';

interface MenuItem {
  id: number;
  name: string;
  emoji: string;
  value?: string;
}

@Entry
@Component
export struct Profile {
  @State pomodoroModel: PomodoroModel = PomodoroModel.getInstance();
  @State isDarkMode: boolean = false;
  @State level: number = 5;
  @State title: string = '专注达人';
  
  @State menuList: MenuItem[] = [
    { id: 1, name: '统计', emoji: '📊' },
    { id: 2, name: '成就', emoji: '🏆', value: '8/10' },
    { id: 3, name: '设置', emoji: '⚙️' },
    { id: 4, name: '关于', emoji: 'ℹ️' }
  ];
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  async aboutToAppear() {
    try {
      const context = getContext(this) as common.UIAbilityContext;
      await this.pomodoroModel.initialize(context);
      this.isDarkMode = this.pomodoroModel.getIsDarkMode();
    } catch (error) {
      console.error('Profile aboutToAppear error:', error);
    }
  }
  
  toggleDarkMode() {
    this.isDarkMode = !this.isDarkMode;
    this.pomodoroModel.setIsDarkMode(this.isDarkMode);
  }
  
  build() {
    Column() {
      // 页面标题
      Row() {
        Text('个人中心')
          .fontSize(DesignTokens.FONT_SIZE.xl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ 
        top: DesignTokens.SPACING.lg, 
        bottom: DesignTokens.SPACING.md,
        left: DesignTokens.SPACING.lg 
      })
      
      Scroll() {
        Column() {
          // 用户信息卡片
          Column() {
            Text('👤')
              .fontSize(DesignTokens.FONT_SIZE.icon)
              .margin({ bottom: DesignTokens.SPACING.md })
            
            Text(this.title)
              .fontSize(DesignTokens.FONT_SIZE.lg)
              .fontWeight(FontWeight.Medium)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: DesignTokens.SPACING.xs })
            
            Text(`LV.${this.level}`)
              .fontSize(DesignTokens.FONT_SIZE.md)
              .fontColor(this.getColors().textSecondary)
          }
          .width('100%')
          .padding({ top: DesignTokens.SPACING.xl, bottom: DesignTokens.SPACING.xl })
          .justifyContent(FlexAlign.Center)
          
          // 功能列表
          Column() {
            ForEach(this.menuList, (item: MenuItem) => {
              Row() {
                Text(item.emoji)
                  .fontSize(DesignTokens.FONT_SIZE.lg)
                  .margin({ right: DesignTokens.SPACING.md })
                
                Text(item.name)
                  .fontSize(DesignTokens.FONT_SIZE.md)
                  .fontColor(this.getColors().textPrimary)
                  .layoutWeight(1)
                
                if (item.value) {
                  Text(item.value)
                    .fontSize(DesignTokens.FONT_SIZE.sm)
                    .fontColor(this.getColors().textSecondary)
                    .margin({ right: DesignTokens.SPACING.sm })
                }
                
                Text('›')
                  .fontSize(DesignTokens.FONT_SIZE.lg)
                  .fontColor(this.getColors().textTertiary)
              }
              .width('100%')
              .height(60)
              .padding({ 
                left: DesignTokens.SPACING.md, 
                right: DesignTokens.SPACING.md 
              })
              .backgroundColor(this.getColors().cardBackground)
              .borderRadius(DesignTokens.RADIUS.md)
              .margin({ bottom: DesignTokens.SPACING.sm })
            }
            
            // 深色模式开关
            Row() {
              Text('🌗 深色模式')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontColor(this.getColors().textPrimary)
                .layoutWeight(1)
              
              Toggle({ type: ToggleType.Switch, isOn: this.isDarkMode })
                .selectedColor(this.getColors().primaryColor)
                .onChange((isOn: boolean) => {
                  this.isDarkMode = isOn;
                  this.pomodoroModel.setIsDarkMode(isOn);
                })
            }
            .width('100%')
            .height(60)
            .padding({ 
              left: DesignTokens.SPACING.md, 
              right: DesignTokens.SPACING.md 
            })
            .backgroundColor(this.getColors().cardBackground)
            .borderRadius(DesignTokens.RADIUS.md)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.md)
        }
        .width('100%')
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
