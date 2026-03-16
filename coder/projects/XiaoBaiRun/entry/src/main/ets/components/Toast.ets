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

import { promptAction } from '@kit.ArkUI';

/**
 * Toast 组件
 */
@Component
export struct ToastComponent {
  @State isVisible: boolean = false;
  @State message: string = '';
  @State toastType: string = 'info';
  
  private timerId: number = -1;
  
  aboutToDisappear() {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
    }
  }
  
  showToast(message: string, type: string = 'info', duration: number = 2000) {
    if (this.timerId !== -1) {
      clearTimeout(this.timerId);
    }
    
    this.message = message;
    this.toastType = type;
    this.isVisible = true;
    
    this.timerId = setTimeout(() => {
      this.isVisible = false;
    }, duration);
  }
  
  /**
   * 显示成功 Toast
   */
  static success(message: string, duration: number = 2000): void {
    promptAction.showToast({
      message: `✅ ${message}`,
      duration: duration / 1000
    });
  }
  
  /**
   * 显示信息 Toast
   */
  static info(message: string, duration: number = 2000): void {
    promptAction.showToast({
      message: `ℹ️ ${message}`,
      duration: duration / 1000
    });
  }
  
  /**
   * 显示错误 Toast
   */
  static error(message: string, duration: number = 2000): void {
    promptAction.showToast({
      message: `❌ ${message}`,
      duration: duration / 1000
    });
  }
  
  build() {
    if (this.isVisible) {
      Row() {
        Text(this.message)
          .fontSize(16)
          .fontColor('#FFFFFF')
      }
      .padding({ left: 20, right: 20, top: 12, bottom: 12 })
      .backgroundColor('#333333')
      .borderRadius(8)
      .position({ x: '50%', y: 100 })
      .translate({ x: '-50%' })
    }
  }
}
