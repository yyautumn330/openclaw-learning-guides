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

export enum ToastType {
  SUCCESS = 'success',
  ERROR = 'error',
  WARNING = 'warning',
  INFO = 'info',
}

@Component
export struct ToastComponent {
  @State isVisible: boolean = false;
  @State message: string = '';
  @State toastType: ToastType = ToastType.INFO;
  isDarkMode: boolean = false;
  
  private static showCallback?: (message: string, type: ToastType, duration: number) => void;
  private timerId: number = -1;
  
  aboutToAppear(): void {
    ToastComponent.showCallback = (msg: string, type: ToastType, duration: number) => {
      this.showToast(msg, type, duration);
    };
  }
  
  aboutToDisappear(): void {
    ToastComponent.showCallback = undefined;
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
    }
  }
  
  showToast(message: string, type: ToastType = ToastType.INFO, duration: number = 2000): void {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
    }
    
    this.message = message;
    this.toastType = type;
    this.isVisible = true;
    
    this.timerId = setTimeout(() => {
      this.hideToast();
    }, duration) as number;
  }
  
  hideToast(): void {
    this.isVisible = false;
  }
  
  static success(message: string, duration?: number): void {
    if (ToastComponent.showCallback) {
      ToastComponent.showCallback(message, ToastType.SUCCESS, duration || 2000);
    }
  }
  
  static error(message: string, duration?: number): void {
    if (ToastComponent.showCallback) {
      ToastComponent.showCallback(message, ToastType.ERROR, duration || 3000);
    }
  }
  
  static warning(message: string, duration?: number): void {
    if (ToastComponent.showCallback) {
      ToastComponent.showCallback(message, ToastType.WARNING, duration || 2500);
    }
  }
  
  static info(message: string, duration?: number): void {
    if (ToastComponent.showCallback) {
      ToastComponent.showCallback(message, ToastType.INFO, duration || 2000);
    }
  }
  
  @Builder
  getToastIcon(type: ToastType): void {
    Text(this.getIconForType(type))
      .fontSize(DesignTokens.FONT_SIZE.md)
      .margin({ right: 8 })
  }
  
  getIconForType(type: ToastType): string {
    switch (type) {
      case ToastType.SUCCESS:
        return '✅';
      case ToastType.ERROR:
        return '❌';
      case ToastType.WARNING:
        return '⚠️';
      case ToastType.INFO:
      default:
        return 'ℹ️';
    }
  }
  
  getToastBackgroundColor(type: ToastType): string {
    const colors = DesignTokens.getThemeColors(this.isDarkMode);
    switch (type) {
      case ToastType.SUCCESS:
        return colors.successColor;
      case ToastType.ERROR:
        return colors.errorColor;
      case ToastType.WARNING:
        return colors.warningColor;
      case ToastType.INFO:
      default:
        return colors.infoColor;
    }
  }
  
  build() {
    if (this.isVisible) {
      Column() {
        Row() {
          this.getToastIcon(this.toastType)
          
          Text(this.message)
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontColor('#FFFFFF')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .backgroundColor(this.getToastBackgroundColor(this.toastType))
        .borderRadius(DesignTokens.RADIUS.md)
        .shadow({
          radius: 8,
          color: 'rgba(0, 0, 0, 0.15)',
          offsetX: 0,
          offsetY: 4,
        })
      }
      .width('auto')
      .position({ x: '50%', y: 100 })
      .translate({ x: '-50%' })
      .animation({
        duration: DesignTokens.ANIMATION.normal,
        curve: Curve.EaseInOut,
      })
      .zIndex(9999)
    }
  }
}
