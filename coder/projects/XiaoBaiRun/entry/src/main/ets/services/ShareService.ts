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

import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';

const TAG = 'ShareService';
const DOMAIN = 0x0000;

/**
 * 分享内容类型
 */
export type ShareContentType = 'text' | 'image' | 'file';

/**
 * 分享选项
 */
export interface ShareOptions {
  title?: string;           // 分享标题
  text?: string;            // 分享文本
  imageUri?: string;        // 图片 URI
  fileUri?: string;         // 文件 URI
  contentType: ShareContentType;
}

/**
 * 跑步记录分享数据
 */
export interface RunRecordShareData {
  distance: number;
  duration: number;
  avgPace: string;
  calories: number;
  date: string;
}

/**
 * 分享服务
 * 当前版本使用日志模拟，真机测试时替换为真实分享 API
 */
export class ShareService {
  private static instance: ShareService;
  private context: common.UIAbilityContext | null = null;

  private constructor() {}

  static getInstance(): ShareService {
    if (!ShareService.instance) {
      ShareService.instance = new ShareService();
    }
    return ShareService.instance;
  }

  /**
   * 设置上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
    hilog.info(DOMAIN, TAG, 'Context set');
  }

  /**
   * 分享文本
   */
  async shareText(text: string, title?: string): Promise<boolean> {
    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context not set');
      return false;
    }

    try {
      const shareText = this.generateShareText(text, title);
      hilog.info(DOMAIN, TAG, '📤 Sharing: %{public}s', shareText);
      
      // 真机测试时替换为系统分享 API
      // 当前版本记录日志
      hilog.info(DOMAIN, TAG, '✅ Text share completed (logged)');
      
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Share text failed: %{public}s', JSON.stringify(error));
      return false;
    }
  }

  /**
   * 分享跑步记录
   */
  async shareRunRecord(record: RunRecordShareData): Promise<boolean> {
    const text = this.formatRunRecordText(record);
    return await this.shareText(text, '跑步记录分享');
  }

  /**
   * 分享图片
   */
  async shareImage(imageUri: string, title?: string): Promise<boolean> {
    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context not set');
      return false;
    }

    try {
      hilog.info(DOMAIN, TAG, '📤 Sharing image: %{public}s', imageUri);
      hilog.info(DOMAIN, TAG, '✅ Image share completed (logged)');
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Share image failed: %{public}s', JSON.stringify(error));
      return false;
    }
  }

  /**
   * 分享 GPX 文件
   */
  async shareGPXFile(fileUri: string, recordName: string): Promise<boolean> {
    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context not set');
      return false;
    }

    try {
      hilog.info(DOMAIN, TAG, '📤 Sharing GPX: %{public}s', fileUri);
      hilog.info(DOMAIN, TAG, '✅ GPX share completed (logged)');
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Share GPX failed: %{public}s', JSON.stringify(error));
      return false;
    }
  }

  /**
   * 生成分享文本
   */
  private generateShareText(text: string, title?: string): string {
    if (title) {
      return `【${title}】\n${text}\n\n来自「小白快跑」`;
    }
    return `${text}\n\n来自「小白快跑」`;
  }

  /**
   * 格式化跑步记录文本
   */
  private formatRunRecordText(record: {
    distance: number;
    duration: number;
    avgPace: string;
    calories: number;
    date: string;
  }): string {
    const distanceKm = (record.distance / 1000).toFixed(2);
    const durationMin = Math.floor(record.duration / 60);
    const durationSec = record.duration % 60;
    
    return `🏃 跑步记录\n` +
      `📅 ${record.date}\n` +
      `📏 距离：${distanceKm} 公里\n` +
      `⏱️ 时长：${durationMin}分${durationSec}秒\n` +
      `⚡ 配速：${record.avgPace}/公里\n` +
      `🔥 卡路里：${record.calories} 千卡`;
  }

  /**
   * 保存到相册
   */
  async saveToGallery(imageUri: string): Promise<boolean> {
    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context not set');
      return false;
    }

    try {
      hilog.info(DOMAIN, TAG, '💾 Saving to gallery: %{public}s', imageUri);
      hilog.info(DOMAIN, TAG, '✅ Image saved to gallery (logged)');
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Save to gallery failed: %{public}s', JSON.stringify(error));
      return false;
    }
  }

  /**
   * 复制到剪贴板
   */
  async copyToClipboard(text: string): Promise<boolean> {
    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context not set');
      return false;
    }

    try {
      hilog.info(DOMAIN, TAG, '📋 Copy to clipboard: %{public}s', text);
      hilog.info(DOMAIN, TAG, '✅ Text copied to clipboard (logged)');
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Copy to clipboard failed: %{public}s', JSON.stringify(error));
      return false;
    }
  }
}

export const shareService = ShareService.getInstance();
