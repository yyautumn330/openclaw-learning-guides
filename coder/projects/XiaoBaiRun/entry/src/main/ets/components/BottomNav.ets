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

import { DesignTokens } from '../constants/DesignTokens';

/**
 * 底部导航组件
 */
@Component
export struct BottomNav {
  @State currentIndex: number = 0;
  @State isDarkMode: boolean = false;
  onChange?: (index: number) => void;
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  build() {
    Row() {
      // 跑步
      Column() {
        Text('🏃')
          .fontSize(24)
          .margin({ bottom: 4 })
        Text('跑步')
          .fontSize(12)
          .fontColor(this.currentIndex === 0 ? this.getColors().primaryColor : this.getColors().textSecondary)
      }
      .layoutWeight(1)
      .onClick(() => {
        this.currentIndex = 0;
        if (this.onChange) this.onChange(0);
      })
      
      // 历史
      Column() {
        Text('📝')
          .fontSize(24)
          .margin({ bottom: 4 })
        Text('历史')
          .fontSize(12)
          .fontColor(this.currentIndex === 1 ? this.getColors().primaryColor : this.getColors().textSecondary)
      }
      .layoutWeight(1)
      .onClick(() => {
        this.currentIndex = 1;
        if (this.onChange) this.onChange(1);
      })
      
      // 统计
      Column() {
        Text('📊')
          .fontSize(24)
          .margin({ bottom: 4 })
        Text('统计')
          .fontSize(12)
          .fontColor(this.currentIndex === 2 ? this.getColors().primaryColor : this.getColors().textSecondary)
      }
      .layoutWeight(1)
      .onClick(() => {
        this.currentIndex = 2;
        if (this.onChange) this.onChange(2);
      })
      
      // 我的
      Column() {
        Text('👤')
          .fontSize(24)
          .margin({ bottom: 4 })
        Text('我的')
          .fontSize(12)
          .fontColor(this.currentIndex === 3 ? this.getColors().primaryColor : this.getColors().textSecondary)
      }
      .layoutWeight(1)
      .onClick(() => {
        this.currentIndex = 3;
        if (this.onChange) this.onChange(3);
      })
    }
    .width('100%')
    .height(60)
    .backgroundColor(this.getColors().cardBackground)
    .borderRadius(DesignTokens.RADIUS.lg)
    .padding({ left: 8, right: 8 })
  }
}
