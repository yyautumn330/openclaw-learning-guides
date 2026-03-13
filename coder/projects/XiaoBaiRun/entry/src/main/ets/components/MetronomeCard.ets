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

import { metronomeService } from '../services/MetronomeService';
import { DesignTokens, type ColorTheme } from '../constants/DesignTokens';
import { ToastComponent } from './Toast';

/**
 * 节拍器卡片组件
 */
@Component
export struct MetronomeCard {
  @State isPlaying: boolean = false;
  @State bpm: number = 160;
  @State volume: number = 0.7;
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
  
  aboutToAppear() {
    this.colors = DesignTokens.getThemeColors(this.isDarkMode);
    this.bpm = metronomeService.getBpm();
    this.volume = metronomeService.getVolume();
    this.isPlaying = metronomeService.isCurrentlyPlaying();
  }
  
  /**
   * 切换播放状态
   */
  async togglePlay() {
    try {
      if (this.isPlaying) {
        await metronomeService.stop();
        this.isPlaying = false;
        ToastComponent.info('节拍器已停止', 1500);
      } else {
        await metronomeService.start();
        this.isPlaying = true;
        ToastComponent.success(`节拍器已启动 ${this.bpm} BPM`, 1500);
      }
    } catch (error) {
      ToastComponent.info('操作失败', 1500);
    }
  }
  
  /**
   * 调节 BPM
   */
  onBpmChange(value: number) {
    this.bpm = Math.round(value);
    metronomeService.setBpm(this.bpm);
  }
  
  /**
   * 调节音量
   */
  async onVolumeChange(value: number) {
    this.volume = value;
    await metronomeService.setVolume(value);
  }
  
  /**
   * 快速选择 BPM
   */
  setQuickBpm(bpm: number) {
    this.bpm = bpm;
    metronomeService.setBpm(bpm);
    ToastComponent.success(`${bpm} BPM`, 1000);
  }
  
  build() {
    Column() {
      // 标题栏
      Row() {
        Text('🎵 跑步节拍器')
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.textPrimary)
        
        Text(`${this.bpm} BPM`)
          .fontSize(DesignTokens.FONT_SIZE.xl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.primaryColor)
          .margin({ left: 'auto' })
      }
      .width('100%')
      .margin({ bottom: DesignTokens.SPACING.md })
      
      // BPM 调节滑块
      Column() {
        Row() {
          Text('步频')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.colors.textSecondary)
          
          Text(`${this.bpm}`)
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colors.primaryColor)
            .margin({ left: 'auto' })
        }
        .width('100%')
        .margin({ bottom: DesignTokens.SPACING.sm })
        
        Slider({
          value: this.bpm,
          min: 140,
          max: 200,
          step: 2
        })
          .onChange((value: number) => {
            this.onBpmChange(value);
          })
          .blockColor(this.colors.primaryColor)
      }
      .width('100%')
      .padding(DesignTokens.SPACING.md)
      .backgroundColor(this.colors.cardBackground)
      .borderRadius(DesignTokens.RADIUS.lg)
      .margin({ bottom: DesignTokens.SPACING.sm })
      
      // 快速选择按钮
      Row() {
        ForEach([150, 160, 170, 180], (bpmValue: number) => {
          Button(`${bpmValue}`)
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .backgroundColor(bpmValue === this.bpm ? this.colors.primaryColor : this.colors.cardBackground)
            .fontColor(bpmValue === this.bpm ? '#FFFFFF' : this.colors.textPrimary)
            .borderWidth(2)
            .borderColor(bpmValue === this.bpm ? this.colors.primaryColor : this.colors.borderColor)
            .borderRadius(DesignTokens.RADIUS.md)
            .width(50)
            .height(36)
            .margin({ right: DesignTokens.SPACING.sm })
            .onClick(() => {
              this.setQuickBpm(bpmValue);
            })
        })
      }
      .width('100%')
      .justifyContent(FlexAlign.Center)
      .margin({ bottom: DesignTokens.SPACING.sm })
      
      // 音量调节
      Column() {
        Row() {
          Text('🔊 音量')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.colors.textSecondary)
          
          Text(`${Math.round(this.volume * 100)}%`)
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontWeight(FontWeight.Bold)
            .fontColor(this.colors.textPrimary)
            .margin({ left: 'auto' })
        }
        .width('100%')
        .margin({ bottom: DesignTokens.SPACING.sm })
        
        Slider({
          value: this.volume,
          min: 0,
          max: 1,
          step: 0.1
        })
          .onChange(async (value: number) => {
            await this.onVolumeChange(value);
          })
          .blockColor(this.colors.secondaryColor)
      }
      .width('100%')
      .padding(DesignTokens.SPACING.md)
      .backgroundColor(this.colors.cardBackground)
      .borderRadius(DesignTokens.RADIUS.lg)
      .margin({ bottom: DesignTokens.SPACING.md })
      
      // 播放/停止按钮
      Row() {
        Button(this.isPlaying ? '⏹ 停止' : '▶ 启动')
          .width('100%')
          .height(DesignTokens.BUTTON.height)
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Medium)
          .backgroundColor(this.isPlaying ? this.colors.secondaryColor : this.colors.primaryColor)
          .fontColor('#FFFFFF')
          .borderRadius(DesignTokens.RADIUS.xl)
          .onClick(() => {
            this.togglePlay();
          })
      }
    }
    .width('100%')
    .padding(DesignTokens.SPACING.lg)
    .backgroundColor(this.colors.backgroundColor)
    .borderRadius(DesignTokens.RADIUS.lg)
  }
}
