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
import { abilityAccessCtrl, bundleManager, Permissions } from '@kit.AbilityKit';
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
      // 需要请求的权限列表
      const permissions: Array<Permissions> = [
        'ohos.permission.APPROXIMATELY_LOCATION',
        'ohos.permission.LOCATION'
      ];
      
      // 创建权限管理器
      const atManager = abilityAccessCtrl.createAtManager();
      
      // 请求用户授权
      const grantStatus = await atManager.requestPermissionsFromUser(this.context, permissions);
      
      // 检查授权结果
      const allGranted = grantStatus.authResults.every((result) => result === abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED);
      
      if (allGranted) {
        hilog.info(DOMAIN, TAG, 'Location permission granted');
        return true;
      } else {
        hilog.error(DOMAIN, TAG, 'Location permission denied');
        return false;
      }
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Permission request error: %{public}s', JSON.stringify(error) ?? '');
      return false;
    }
  }
  
  /**
   * 检查定位权限
   */
  async checkPermission(): Promise<boolean> {
    if (!this.context) {
      hilog.error(DOMAIN, TAG, 'Context not initialized');
      return false;
    }
    
    try {
      const atManager = abilityAccessCtrl.createAtManager();
      const permissions: Array<Permissions> = [
        'ohos.permission.APPROXIMATELY_LOCATION',
        'ohos.permission.LOCATION'
      ];
      
      // 检查每个权限的授权状态
      for (const permission of permissions) {
        const status = await atManager.checkAccessToken(
          this.context.applicationInfo.accessTokenId,
          permission
        );
        if (status !== abilityAccessCtrl.GrantStatus.PERMISSION_GRANTED) {
          hilog.warn(DOMAIN, TAG, 'Permission not granted: %{public}s', permission);
          return false;
        }
      }
      
      hilog.info(DOMAIN, TAG, 'All location permissions granted');
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Check permission error: %{public}s', JSON.stringify(error) ?? '');
      return false;
    }
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
      // 先检查并启用定位服务
      const isEnabled = await geolocationManager.isLocationEnabled();
      if (!isEnabled) {
        hilog.error(DOMAIN, TAG, 'Location service is disabled');
        throw new Error('Location service disabled');
      }
      
      this.locationCallback = callback;
      this.isTracking = true;
      hilog.info(DOMAIN, TAG, 'Location tracking started');
      
      // 真实定位请求
      const request = {
        priority: geolocationManager.LocationRequestPriority.FIRST_FIX,
        interval: 1000
      };
      
      geolocationManager.on('locationChange', request, (location) => {
        if (this.isTracking && this.locationCallback) {
          const locationInfo: LocationInfo = {
            latitude: location.latitude,
            longitude: location.longitude,
            altitude: location.altitude ?? 0,
            speed: location.speed ?? 0,
            accuracy: location.accuracy ?? 0,
            timestamp: Date.now()
          };
          
          hilog.info(DOMAIN, TAG, 'Location received: lat=%{public}.6f, lon=%{public}.6f, acc=%{public}.1f', 
                     locationInfo.latitude, locationInfo.longitude, locationInfo.accuracy);
          
          this.locationCallback(locationInfo);
        }
      });
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Start tracking error: %{public}s', JSON.stringify(error) ?? '');
      this.isTracking = false;
      
      // 如果真实定位失败，使用模拟数据作为后备
      hilog.warn(DOMAIN, TAG, 'Using mock location as fallback');
      this.startMockTracking(callback);
    }
  }
  
  /**
   * 启动模拟定位（真实定位失败时的后备方案）
   */
  private startMockTracking(callback: LocationCallback): void {
    const mockLocation: LocationInfo = {
      latitude: 39.9042,
      longitude: 116.4074,
      altitude: 50,
      speed: 0,
      accuracy: 10,
      timestamp: Date.now()
    };
    
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
      // 检查定位服务是否启用
      const isEnabled = await geolocationManager.isLocationEnabled();
      if (!isEnabled) {
        hilog.error(DOMAIN, TAG, 'Location service is disabled');
        return null;
      }
      
      const request = {
        priority: geolocationManager.LocationRequestPriority.FIRST_FIX,
      };
      
      const location = await geolocationManager.getCurrentLocation(request);
      
      hilog.info(DOMAIN, TAG, 'Got location: %{public}s,%{public}s', 
                 location.latitude.toString(), location.longitude.toString());
      
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
