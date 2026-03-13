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
 * P1 改进：Toast 组件
 * 统一的用户反馈提示组件
 */

export enum ToastType {
  SUCCESS = 'success',
  ERROR = 'error',
  WARNING = 'warning',
  INFO = 'info',
}

export interface ToastOptions {
  message: string;
  type?: ToastType;
  duration?: number; // 毫秒，默认 2000ms
}

@Observer
class ToastState {
  isVisible: boolean = false;
  message: string = '';
  type: ToastType = ToastType.INFO;
  timerId: number = -1;
}

@Component
export struct ToastComponent {
  @Observed @State private toastState: ToastState = new ToastState();
  @State private isDarkMode: boolean = false;
  
  // 单例模式，提供全局访问
  private static instance: ToastComponent | null = null;
  private static showCallback?: (message: string, type: ToastType, duration: number) => void;
  
  aboutToAppear() {
    ToastComponent.instance = this;
    // 注册全局回调
    ToastComponent.showCallback = (message: string, type: ToastType, duration: number) => {
      this.showToast(message, type, duration);
    };
  }
  
  aboutToDisappear() {
    ToastComponent.instance = null;
    ToastComponent.showCallback = undefined;
  }
  
  /**
   * 显示 Toast
   */
  showToast(message: string, type: ToastType = ToastType.INFO, duration: number = 2000) {
    // 清除之前的定时器
    if (this.toastState.timerId !== -1) {
      clearTimeout(this.toastState.timerId);
    }
    
    // 更新状态
    this.toastState.message = message;
    this.toastState.type = type;
    this.toastState.isVisible = true;
    
    // 设置自动隐藏定时器
    this.toastState.timerId = setTimeout(() => {
      this.hideToast();
    }, duration) as any;
  }
  
  /**
   * 隐藏 Toast
   */
  hideToast() {
    this.toastState.isVisible = false;
  }
  
  /**
   * 静态方法：显示成功 Toast
   */
  static success(message: string, duration?: number) {
    if (ToastComponent.showCallback) {
      ToastComponent.showCallback(message, ToastType.SUCCESS, duration || 2000);
    }
  }
  
  /**
   * 静态方法：显示错误 Toast
   */
  static error(message: string, duration?: number) {
    if (ToastComponent.showCallback) {
      ToastComponent.showCallback(message, ToastType.ERROR, duration || 3000);
    }
  }
  
  /**
   * 静态方法：显示警告 Toast
   */
  static warning(message: string, duration?: number) {
    if (ToastComponent.showCallback) {
      ToastComponent.showCallback(message, ToastType.WARNING, duration || 2500);
    }
  }
  
  /**
   * 静态方法：显示信息 Toast
   */
  static info(message: string, duration?: number) {
    if (ToastComponent.showCallback) {
      ToastComponent.showCallback(message, ToastType.INFO, duration || 2000);
    }
  }
  
  /**
   * 获取 Toast 图标
   */
  @Builder
  getToastIcon(type: ToastType): string {
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
  
  /**
   * 获取 Toast 背景色
   */
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
    if (this.toastState.isVisible) {
      Column() {
        Row() {
          Text(this.getToastIcon(this.toastState.type))
            .fontSize(20)
            .margin({ right: 8 })
          
          Text(this.toastState.message)
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontColor('#FFFFFF')
            .maxLines(2)
            .textOverflow({ overflow: TextOverflow.Ellipsis })
        }
        .padding({ left: 16, right: 16, top: 12, bottom: 12 })
        .backgroundColor(this.getToastBackgroundColor(this.toastState.type))
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
