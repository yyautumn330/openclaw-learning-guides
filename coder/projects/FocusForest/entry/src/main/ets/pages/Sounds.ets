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

interface SoundItem {
  id: number;
  name: string;
  emoji: string;
  isSelected: boolean;
}

@Entry
@Component
export struct Sounds {
  @State isDarkMode: boolean = false;
  @State selectedSoundId: number = 1;
  @State volume: number = 60;
  
  @State soundList: SoundItem[] = [
    { id: 1, name: '雨声', emoji: '🌧️', isSelected: true },
    { id: 2, name: '咖啡馆', emoji: '☕', isSelected: false },
    { id: 3, name: '海浪', emoji: '🌊', isSelected: false },
    { id: 4, name: '森林', emoji: '🌲', isSelected: false },
    { id: 5, name: '篝火', emoji: '🔥', isSelected: false },
    { id: 6, name: '夜雨', emoji: '🌙', isSelected: false }
  ];
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  selectSound(id: number) {
    this.soundList = this.soundList.map(sound => ({
      ...sound,
      isSelected: sound.id === id
    }));
    this.selectedSoundId = id;
  }
  
  build() {
    Column() {
      // 页面标题
      Row() {
        Text('白噪音')
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
      
      // 音效列表
      Scroll() {
        Column() {
          ForEach(this.soundList, (sound: SoundItem) => {
            Row() {
              Text(sound.emoji)
                .fontSize(DesignTokens.FONT_SIZE.xl)
                .margin({ right: DesignTokens.SPACING.md })
              
              Text(sound.name)
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontColor(this.getColors().textPrimary)
                .layoutWeight(1)
              
              Button(sound.isSelected ? '已选择' : '选择')
                .fontSize(DesignTokens.FONT_SIZE.sm)
                .backgroundColor(sound.isSelected ? this.getColors().primaryColor : 'transparent')
                .fontColor(sound.isSelected ? '#FFFFFF' : this.getColors().textPrimary)
                .borderRadius(DesignTokens.RADIUS.md)
                .width(80)
                .height(36)
                .onClick(() => {
                  this.selectSound(sound.id);
                })
            }
            .width('100%')
            .height(60)
            .padding(DesignTokens.SPACING.md)
            .backgroundColor(this.getColors().cardBackground)
            .borderRadius(DesignTokens.RADIUS.lg)
            .margin({ bottom: DesignTokens.SPACING.sm })
          })
        }
        .width('100%')
        .padding(DesignTokens.SPACING.md)
      }
      .layoutWeight(1)
      .edgeEffect(EdgeEffect.Spring)
      
      // 音量控制
      Column() {
        Row() {
          Text('🔊')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .margin({ right: DesignTokens.SPACING.xs })
          
          Text('音量')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontColor(this.getColors().textPrimary)
          
          Text(`${this.volume}%`)
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
            .margin({ left: DesignTokens.SPACING.sm })
        }
        .width('100%')
        .margin({ bottom: DesignTokens.SPACING.md })
        
        Slider({ value: this.volume, min: 0, max: 100, step: 1 })
          .width('100%')
          .activeColor(this.getColors().primaryColor)
          .onChange((value: number) => {
            this.volume = value;
          })
      }
      .width('100%')
      .padding({ 
        top: DesignTokens.SPACING.lg, 
        bottom: DesignTokens.SPACING.lg,
        left: DesignTokens.SPACING.lg,
        right: DesignTokens.SPACING.lg 
      })
      .backgroundColor(this.getColors().cardBackground)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
