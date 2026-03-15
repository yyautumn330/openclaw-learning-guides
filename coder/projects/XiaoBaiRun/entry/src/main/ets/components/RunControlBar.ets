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
 * 跑步控制栏
 * 开始/暂停/继续/停止跑步
 */
@Component
export struct RunControlBar {
  @Prop isRunning: boolean = false;
  @Prop isPaused: boolean = false;
  @Prop isDarkMode: boolean = false;
  
  // 回调
  onStart?: () => void;
  onPause?: () => void;
  onResume?: () => void;
  onStop?: () => void;
  
  /**
   * 获取主按钮状态
   */
  private getMainButtonState(): { icon: string; text: string; color: string } {
    if (this.isRunning && !this.isPaused) {
      return { icon: '⏸', text: '暂停', color: '#FF9800' };
    } else if (this.isPaused) {
      return { icon: '▶', text: '继续', color: '#4CAF50' };
    } else {
      return { icon: '▶', text: '开始', color: DesignTokens.getThemeColors(this.isDarkMode).primaryColor };
    }
  }
  
  build() {
    Row() {
      // 停止按钮 (只在运行时显示)
      if (this.isRunning || this.isPaused) {
        Button('⏹ 停止')
          .fontSize(DesignTokens.FONT_SIZE.md)
          .fontWeight(FontWeight.Medium)
          .backgroundColor('#F44336')
          .fontColor('#FFFFFF')
          .borderRadius(DesignTokens.RADIUS.full)
          .width(100)
          .height(48)
          .onClick(() => {
            if (this.onStop) {
              this.onStop();
            }
          })
          .margin({ right: 16 })
      }
      
      // 主按钮 (开始/暂停/继续)
      Button(`${this.getMainButtonState().icon} ${this.getMainButtonState().text}`)
        .fontSize(DesignTokens.FONT_SIZE.lg)
        .fontWeight(FontWeight.Bold)
        .backgroundColor(this.getMainButtonState().color)
        .fontColor('#FFFFFF')
        .borderRadius(DesignTokens.RADIUS.full)
        .width(this.isRunning ? 140 : 200)
        .height(56)
        .shadow({
          radius: 12,
          color: this.getMainButtonState().color,
          offsetX: 0,
          offsetY: 4
        })
        .onClick(() => {
          if (this.isRunning && !this.isPaused) {
            // 暂停
            if (this.onPause) {
              this.onPause();
            }
          } else if (this.isPaused) {
            // 继续
            if (this.onResume) {
              this.onResume();
            }
          } else {
            // 开始
            if (this.onStart) {
              this.onStart();
            }
          }
        })
      
      // 占位 (保持对称)
      if (this.isRunning || this.isPaused) {
        Blank()
          .width(116)
      }
    }
    .width('100%')
    .justifyContent(FlexAlign.Center)
    .padding({ top: 16, bottom: 16 })
    .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
    .borderRadius(DesignTokens.RADIUS.lg)
    .margin({ left: 16, right: 16 })
  }
}

/**
 * 简化版控制按钮
 * 用于底部操作栏
 */
@Component
export struct RunControlButton {
  @Prop isRunning: boolean = false;
  @Prop isPaused: boolean = false;
  @Prop isDarkMode: boolean = false;
  
  onStart?: () => void;
  onPause?: () => void;
  onResume?: () => void;
  onStop?: () => void;
  
  build() {
    Row() {
      // 状态文字
      Column() {
        Text(this.getStatusText())
          .fontSize(DesignTokens.FONT_SIZE.sm)
          .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textSecondary)
        
        if (this.isRunning) {
          Text('点击停止结束跑步')
            .fontSize(DesignTokens.FONT_SIZE.xs)
            .fontColor(DesignTokens.getThemeColors(this.isDarkMode).textTertiary)
            .margin({ top: 2 })
        }
      }
      .alignItems(HorizontalAlign.Start)
      .layoutWeight(1)
      
      // 主按钮
      Button(this.getButtonText())
        .fontSize(DesignTokens.FONT_SIZE.md)
        .fontWeight(FontWeight.Medium)
        .backgroundColor(this.getButtonColor())
        .fontColor('#FFFFFF')
        .borderRadius(DesignTokens.RADIUS.full)
        .width(100)
        .height(44)
        .onClick(() => {
          this.handleButtonClick();
        })
    }
    .width('100%')
    .padding(16)
    .backgroundColor(DesignTokens.getThemeColors(this.isDarkMode).cardBackground)
    .borderRadius(DesignTokens.RADIUS.lg)
  }
  
  private getStatusText(): string {
    if (this.isRunning && !this.isPaused) {
      return '🏃 正在跑步...';
    } else if (this.isPaused) {
      return '⏸️ 已暂停';
    } else {
      return '准备开始跑步';
    }
  }
  
  private getButtonText(): string {
    if (this.isRunning && !this.isPaused) {
      return '⏸ 暂停';
    } else if (this.isPaused) {
      return '▶ 继续';
    } else {
      return '▶ 开始';
    }
  }
  
  private getButtonColor(): string {
    if (this.isRunning && !this.isPaused) {
      return '#FF9800';
    } else if (this.isPaused) {
      return '#4CAF50';
    } else {
      return DesignTokens.getThemeColors(this.isDarkMode).primaryColor;
    }
  }
  
  private handleButtonClick(): void {
    if (this.isRunning && !this.isPaused) {
      if (this.onPause) this.onPause();
    } else if (this.isPaused) {
      if (this.onResume) this.onResume();
    } else {
      if (this.onStart) this.onStart();
    }
  }
}