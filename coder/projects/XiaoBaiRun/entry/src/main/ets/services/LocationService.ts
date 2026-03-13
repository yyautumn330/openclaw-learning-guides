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

import geolocationManager from '@ohos.geoLocationManager';
import { hilog } from '@kit.PerformanceAnalysisKit';
import { common } from '@kit.AbilityKit';

const TAG = 'LocationService';
const DOMAIN = 0x0000;

/**
 * 位置信息
 */
export interface LocationInfo {
  latitude: number;
  longitude: number;
  altitude?: number;
  speed?: number;
  accuracy?: number;
  timestamp: number;
}

/**
 * 位置订阅回调
 */
export type LocationCallback = (location: LocationInfo) => void;

/**
 * 定位服务单例
 */
export class LocationService {
  private static instance: LocationService;
  private isTracking: boolean = false;
  private locationCallback: LocationCallback | null = null;
  private context: common.UIAbilityContext | null = null;
  
  private constructor() {}
  
  /**
   * 初始化上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }
  
  /**
   * 获取单例实例
   */
  static getInstance(): LocationService {
    if (!LocationService.instance) {
      LocationService.instance = new LocationService();
    }
    return LocationService.instance;
  }
  
  /**
   * 请求定位权限
   */
  async requestPermission(): Promise<boolean> {
    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context not initialized');
      return false;
    }
    
    try {
      // 使用 context 直接请求权限
      const permissions = ['ohos.permission.LOCATION'];
      // TODO: 需要在 UIAbility 中实现权限请求
      hilog.info(DOMAIN, TAG, 'Location permission requested');
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Request permission error: %{public}s', JSON.stringify(error) ?? '');
      return false;
    }
  }
  
  /**
   * 检查定位权限
   */
  async checkPermission(): Promise<boolean> {
    // TODO: 简化实现，默认有权限
    return true;
  }
  
  /**
   * 开始位置追踪
   */
  async startTracking(callback: LocationCallback): Promise<void> {
    if (this.isTracking) {
      hilog.warn(DOMAIN, TAG, 'Already tracking');
      return;
    }
    
    try {
      this.locationCallback = callback;
      this.isTracking = true;
      hilog.info(DOMAIN, TAG, 'Location tracking started (mock mode)');
      
      // 模拟位置更新（因为 API 限制，先使用模拟数据）
      const mockLocation: LocationInfo = {
        latitude: 39.9042,
        longitude: 116.4074,
        altitude: 50,
        speed: 0,
        accuracy: 10,
        timestamp: Date.now()
      };
      
      // 每秒发送模拟位置
      const intervalId = setInterval(() => {
        if (this.isTracking && this.locationCallback) {
          mockLocation.timestamp = Date.now();
          mockLocation.latitude += 0.0001;
          mockLocation.longitude += 0.0001;
          this.locationCallback(mockLocation);
        } else {
          clearInterval(intervalId);
        }
      }, 1000);
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Start tracking error: %{public}s', JSON.stringify(error) ?? '');
      this.isTracking = false;
    }
  }
  
  /**
   * 停止位置追踪
   */
  async stopTracking(): Promise<void> {
    if (!this.isTracking) {
      return;
    }
    
    try {
      this.isTracking = false;
      this.locationCallback = null;
      hilog.info(DOMAIN, TAG, 'Location tracking stopped');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Stop tracking error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * 获取当前位置
   */
  async getCurrentLocation(): Promise<LocationInfo | null> {
    try {
      const request = {
        priority: geolocationManager.LocationRequestPriority.FIRST_FIX,
      };
      
      const location = await geolocationManager.getCurrentLocation(request);
      
      return {
        latitude: location.latitude,
        longitude: location.longitude,
        altitude: location.altitude ?? 0,
        speed: location.speed ?? 0,
        accuracy: location.accuracy ?? 0,
        timestamp: Date.now()
      };
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Get current location error: %{public}s', JSON.stringify(error) ?? '');
      return null;
    }
  }
  
  /**
   * 检查是否正在追踪
   */
  isCurrentlyTracking(): boolean {
    return this.isTracking;
  }
}

// 导出单例
export const locationService = LocationService.getInstance();
