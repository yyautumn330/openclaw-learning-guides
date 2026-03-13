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
import { ToastComponent } from '../components/Toast';

@Entry
@Component
export struct Profile {
  @State isDarkMode: boolean = false;
  @State darkModeEnabled: boolean = false;
  
  getColors(): ColorTheme {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  aboutToAppear() {
    // 加载深色模式设置
    this.isDarkMode = this.getIsDarkMode();
    this.darkModeEnabled = this.isDarkMode;
  }
  
  getIsDarkMode(): boolean {
    // TODO: 从设置读取
    return false;
  }
  
  toggleDarkMode() {
    this.darkModeEnabled = !this.darkModeEnabled;
    this.isDarkMode = this.darkModeEnabled;
    
    ToastComponent.info(
      this.darkModeEnabled ? '已开启深色模式' : '已关闭深色模式',
      2000
    );
  }
  
  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('个人中心')
          .fontSize(DesignTokens.FONT_SIZE.xxl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ top: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.md })
      .justifyContent(FlexAlign.Center)
      
      // 用户信息卡片
      Column() {
        Text('🏃')
          .fontSize(DesignTokens.FONT_SIZE.icon)
          .margin({ bottom: DesignTokens.SPACING.md })
        
        Text('跑者')
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
        
        Text('开始跑步吧！')
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(this.getColors().textSecondary)
          .margin({ top: DesignTokens.SPACING.sm })
      }
      .width('100%')
      .padding(DesignTokens.SPACING.xl)
      .backgroundColor(this.getColors().cardBackground)
      .borderRadius(DesignTokens.RADIUS.lg)
      .margin({ bottom: DesignTokens.SPACING.lg })
      .justifyContent(FlexAlign.Center)
      
      // 设置选项
      Column() {
        Text('设置')
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
          .margin({ bottom: DesignTokens.SPACING.md })
          .alignSelf(ItemAlign.Start)
        
        // 深色模式开关
        Row() {
          Text('深色模式')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontColor(this.getColors().textPrimary)
            .layoutWeight(1)
          
          Toggle({ type: ToggleType.Switch, isOn: this.darkModeEnabled })
            .selectedColor(this.getColors().primaryColor)
            .onChange(() => {
              this.toggleDarkMode();
            })
        }
        .width('100%')
        .padding(DesignTokens.SPACING.md)
        .backgroundColor(this.getColors().cardBackground)
        .borderRadius(DesignTokens.RADIUS.md)
        .margin({ bottom: DesignTokens.SPACING.sm })
        
        // 关于
        Row() {
          Text('关于小白快跑')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontColor(this.getColors().textPrimary)
            .layoutWeight(1)
          
          Text('v1.0.0')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
        }
        .width('100%')
        .padding(DesignTokens.SPACING.md)
        .backgroundColor(this.getColors().cardBackground)
        .borderRadius(DesignTokens.RADIUS.md)
      }
      .width('100%')
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
