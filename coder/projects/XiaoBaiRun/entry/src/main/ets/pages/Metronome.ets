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
import { ToastComponent } from '../components/Toast';

@Component
export struct Metronome {
  @State isPlaying: boolean = false;
  @State bpm: number = 160;
  @State volume: number = 0.7;
  @State isDarkMode: boolean = false;
  @State beatCount: number = 0;
  
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
  
  private beatTimer: number = -1;
  
  aboutToAppear() {
    this.isDarkMode = this.getIsDarkMode();
    this.updateColors();
    this.bpm = metronomeService.getBpm();
    this.volume = metronomeService.getVolume();
    this.isPlaying = metronomeService.isCurrentlyPlaying();
  }
  
  aboutToDisappear() {
    this.stopBeatTimer();
  }
  
  getIsDarkMode(): boolean {
    return false;
  }
  
  updateColors() {
    this.colors = DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  togglePlay() {
    if (this.isPlaying) {
      metronomeService.stop();
      this.isPlaying = false;
      this.stopBeatTimer();
      ToastComponent.info('节拍器已停止', 1500);
    } else {
      metronomeService.start();
      this.isPlaying = true;
      this.beatCount = 0;
      this.startBeatTimer();
      ToastComponent.success(`节拍器已启动 ${this.bpm} BPM`, 1500);
    }
  }
  
  startBeatTimer() {
    this.stopBeatTimer();
    const intervalMs = 60000 / this.bpm;
    this.beatTimer = setInterval(() => {
      this.beatCount++;
    }, intervalMs);
  }
  
  /**
   * 停止节拍计时器
   */
  stopBeatTimer() {
    if (this.beatTimer !== -1) {
      clearInterval(this.beatTimer);
      this.beatTimer = -1;
    }
  }
  
  /**
   * 调节 BPM
   */
  onBpmChange(value: number) {
    this.bpm = Math.round(value);
    metronomeService.setBpm(this.bpm);
    if (this.isPlaying) {
      this.stopBeatTimer();
      this.startBeatTimer();
    }
  }
  
  /**
   * 调节音量
   */
  onVolumeChange(value: number) {
    this.volume = value;
    metronomeService.setVolume(value);
  }
  
  /**
   * 快速选择 BPM
   */
  setQuickBpm(bpm: number) {
    this.bpm = bpm;
    metronomeService.setBpm(bpm);
    ToastComponent.success(`${bpm} BPM`, 1000);
    if (this.isPlaying) {
      this.stopBeatTimer();
      this.startBeatTimer();
    }
  }
  
  /**
   * 格式化节拍显示
   */
  formatBeatCount(count: number): string {
    if (count < 60) {
      return count.toString();
    } else if (count < 3600) {
      const min = Math.floor(count / 60);
      const sec = count % 60;
      return `${min}:${sec.toString().padStart(2, '0')}`;
    } else {
      const hour = Math.floor(count / 3600);
      const min = Math.floor((count % 3600) / 60);
      const sec = count % 60;
      return `${hour}:${min.toString().padStart(2, '0')}:${sec.toString().padStart(2, '0')}`;
    }
  }
  
  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('🎵 跑步节拍器')
          .fontSize(DesignTokens.FONT_SIZE.xxl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.textPrimary)
      }
      .width('100%')
      .padding({ top: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.md })
      .justifyContent(FlexAlign.Center)
      
      Scroll() {
        Column() {
          // BPM 显示卡片
          Column() {
            Row() {
              Text('当前步频')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontColor(this.colors.textSecondary)
              
              Text(`${this.bpm} BPM`)
                .fontSize(DesignTokens.FONT_SIZE.xxl)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.colors.primaryColor)
                .margin({ left: 'auto' })
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.lg })
            
            // 节拍计数
            Row() {
              Text('节拍数')
                .fontSize(DesignTokens.FONT_SIZE.sm)
                .fontColor(this.colors.textTertiary)
              
              Text(this.formatBeatCount(this.beatCount))
                .fontSize(DesignTokens.FONT_SIZE.lg)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.colors.textPrimary)
                .margin({ left: 'auto' })
            }
            .width('100%')
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })
          
          // BPM 调节滑块
          Column() {
            Row() {
              Text('步频调节')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.textPrimary)
              
              Text(`${this.bpm}`)
                .fontSize(DesignTokens.FONT_SIZE.lg)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.colors.primaryColor)
                .margin({ left: 'auto' })
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })
            
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
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })
          
          // 快速选择按钮
          Column() {
            Row() {
              Text('快速选择')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.textPrimary)
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })
            
            Row() {
              ForEach([150, 160, 170, 180], (bpmValue: number) => {
                Button(`${bpmValue}`)
                  .fontSize(DesignTokens.FONT_SIZE.md)
                  .backgroundColor(bpmValue === this.bpm ? this.colors.primaryColor : this.colors.cardBackground)
                  .fontColor(bpmValue === this.bpm ? '#FFFFFF' : this.colors.textPrimary)
                  .borderWidth(2)
                  .borderColor(bpmValue === this.bpm ? this.colors.primaryColor : this.colors.borderColor)
                  .borderRadius(DesignTokens.RADIUS.md)
                  .width(60)
                  .height(40)
                  .margin({ right: DesignTokens.SPACING.md })
                  .onClick(() => {
                    this.setQuickBpm(bpmValue);
                  })
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })
          
          // 音量调节
          Column() {
            Row() {
              Text('🔊 音量')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.textPrimary)
              
              Text(`${Math.round(this.volume * 100)}%`)
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.colors.textPrimary)
                .margin({ left: 'auto' })
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })
            
            Slider({
              value: this.volume,
              min: 0,
              max: 1,
              step: 0.1
            })
              .onChange((value: number) => {
                this.onVolumeChange(value);
              })
              .blockColor(this.colors.secondaryColor)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.xl })
          
          // 播放/停止按钮
          Button(this.isPlaying ? '⏹ 停止节拍器' : '▶ 启动节拍器')
            .width('100%')
            .height(DesignTokens.BUTTON.height)
            .fontSize(DesignTokens.FONT_SIZE.xl)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(this.isPlaying ? this.colors.secondaryColor : this.colors.primaryColor)
            .fontColor('#FFFFFF')
            .borderRadius(DesignTokens.RADIUS.xl)
            .onClick(() => {
              this.togglePlay();
            })
          
          // 使用说明
          Column() {
            Text('💡 使用说明')
              .fontSize(DesignTokens.FONT_SIZE.md)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.colors.textPrimary)
              .margin({ bottom: DesignTokens.SPACING.sm })
            
            Text('• 推荐步频：慢跑 150-160 BPM，快跑 170-180 BPM')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.colors.textSecondary)
              .margin({ bottom: DesignTokens.SPACING.xs })
            
            Text('• 步频与步幅配合可达到最佳跑步效率')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.colors.textSecondary)
              .margin({ bottom: DesignTokens.SPACING.xs })
            
            Text('• 建议从 160 BPM 开始，逐渐适应后调整')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.colors.textSecondary)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ top: DesignTokens.SPACING.lg })
        }
        .width('100%')
        .padding({ left: DesignTokens.SPACING.lg, right: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.xl })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.backgroundColor)
  }
}
