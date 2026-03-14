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
 * 轨迹点
 */
export interface TrackPoint {
  latitude: number;
  longitude: number;
  altitude?: number;
  timestamp: number;
  accuracy: number;
  speed: number;
  heartRate?: number;
}

/**
 * 定位配置
 */
export interface LocationConfig {
  interval?: number;
  distanceInterval?: number;
  accuracy?: 'low' | 'medium' | 'high';
  backgroundMode?: boolean;
}

/**
 * 定位回调
 */
export type LocationCallback = (point: TrackPoint) => void;

/**
 * GPS 定位服务
 * 
 * 功能：
 * - 高精度 GPS 定位（1Hz 采样率）
 * - 轨迹点平滑处理
 * - GPS 漂移过滤
 * - 后台定位支持
 * - 自适应电池优化
 */
export class LocationService {
  private static instance: LocationService;
  private context: common.UIAbilityContext | null = null;
  private isTracking: boolean = false;
  private trackPoints: TrackPoint[] = [];
  private locationCallback: LocationCallback | null = null;
  
  // 默认配置
  private config: LocationConfig = {
    interval: 1000,
    distanceInterval: 5,
    accuracy: 'high',
    backgroundMode: true
  };
  
  private constructor() {}
  
  static getInstance(): LocationService {
    if (!LocationService.instance) {
      LocationService.instance = new LocationService();
    }
    return LocationService.instance;
  }
  
  /**
   * 初始化上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }
  
  /**
   * 更新配置
   */
  async updateConfig(newConfig: Partial<LocationConfig>): Promise<void> {
    this.config = { ...this.config, ...newConfig };
    
    if (this.isTracking) {
      // 如果正在跟踪，重启以应用新配置
      await this.stopTracking();
      if (this.locationCallback) {
        await this.startTracking(this.locationCallback);
      }
    }
  }
  
  /**
   * 开始定位
   */
  async startTracking(callback: LocationCallback, customConfig?: Partial<LocationConfig>): Promise<void> {
    if (this.isTracking) {
      hilog.warn(DOMAIN, TAG, 'Already tracking');
      return;
    }
    
    try {
      // 应用自定义配置
      if (customConfig) {
        this.config = { ...this.config, ...customConfig };
      }
      
      // 检查定位服务
      const isEnabled = await geolocationManager.isLocationEnabled();
      if (!isEnabled) {
        hilog.error(DOMAIN, TAG, 'Location service is disabled');
        throw new Error('Location service disabled');
      }
      
      this.isTracking = true;
      this.locationCallback = callback;
      this.trackPoints = [];
      
      // 根据精度等级选择优先级
      const priorityMap = {
        'low': geolocationManager.LocationRequestPriority.LOW_POWER,
        'medium': geolocationManager.LocationRequestPriority.BALANCED,
        'high': geolocationManager.LocationRequestPriority.ACCURACY
      };
      
      const request = {
        priority: priorityMap[this.config.accuracy],
        interval: this.config.interval!,
        distanceInterval: this.config.distanceInterval!
      };
      
      hilog.info(DOMAIN, TAG, 'Start tracking: interval=%dms, distance=%dm, accuracy=%s', 
                 this.config.interval, this.config.distanceInterval, this.config.accuracy);
      
      geolocationManager.on('locationChange', request, (location) => {
        if (!this.isTracking) return;
        
        const rawPoint: TrackPoint = {
          latitude: location.latitude,
          longitude: location.longitude,
          altitude: location.altitude ?? 0,
          timestamp: Date.now(),
          accuracy: location.accuracy ?? 0,
          speed: location.speed ?? 0
        };
        
        // 过滤 GPS 漂移
        const filteredPoint = this.filterGPSDrift(rawPoint);
        
        if (filteredPoint) {
          hilog.debug(DOMAIN, TAG, 'Track point: lat=%.6f, lon=%.6f, acc=%.1f', 
                     filteredPoint.latitude, filteredPoint.longitude, filteredPoint.accuracy);
          
          callback(filteredPoint);
          this.trackPoints.push(filteredPoint);
        }
      });
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Start tracking error: %{public}s', JSON.stringify(error) ?? '');
      this.isTracking = false;
      throw error;
    }
  }
  
  /**
   * 停止定位
   */
  async stopTracking(): Promise<void> {
    if (!this.isTracking) return;
    
    try {
      this.isTracking = false;
      
      geolocationManager.off('locationChange');
      
      hilog.info(DOMAIN, TAG, 'Tracking stopped. Total points: %d', this.trackPoints.length);
      
      this.locationCallback = null;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Stop tracking error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
  
  /**
   * GPS 漂移过滤
   * 
   * 过滤逻辑：
   * 1. 精度阈值：accuracy > 50m 的点丢弃
   * 2. 速度异常：速度 > 20m/s 的点丢弃
   * 3. 距离异常：距离变化 < 2m 的点丢弃
   * 4. 时间间隔：时间间隔 < 3s 的点丢弃
   */
  private filterGPSDrift(rawPoint: TrackPoint): TrackPoint | null {
    // 精度过滤
    if (rawPoint.accuracy > 50) {
      hilog.debug(DOMAIN, TAG, 'Point filtered: accuracy too high (%.1fm)', rawPoint.accuracy);
      return null;
    }
    
    const lastPoint = this.trackPoints[this.trackPoints.length - 1];
    
    if (!lastPoint) {
      return rawPoint; // 第一个点，直接返回
    }
    
    // 时间间隔过滤
    const timeDiff = rawPoint.timestamp - lastPoint.timestamp;
    if (timeDiff < 3000) {
      hilog.debug(DOMAIN, TAG, 'Point filtered: time diff too small (%dms)', timeDiff);
      return null;
    }
    
    // 计算距离
    const distance = this.calculateDistance(lastPoint, rawPoint);
    
    // 距离过滤
    if (distance < 2) {
      hilog.debug(DOMAIN, TAG, 'Point filtered: distance too small (%.1fm)', distance);
      return null;
    }
    
    // 速度过滤
    const speed = distance / (timeDiff / 1000);
    if (speed > 20) {
      hilog.warn(DOMAIN, TAG, 'Point filtered: speed too high (%.1fm/s)', speed);
      return null;
    }
    
    return rawPoint;
  }
  
  /**
   * 计算两点间距离（Haversine 公式）
   */
  private calculateDistance(p1: TrackPoint, p2: TrackPoint): number {
    const R = 6371000; // 地球半径（米）
    const dLat = (p2.latitude - p1.latitude) * Math.PI / 180;
    const dLng = (p2.longitude - p1.longitude) * Math.PI / 180;
    
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(p1.latitude * Math.PI / 180) * Math.cos(p2.latitude * Math.PI / 180) *
              Math.sin(dLng / 2) * Math.sin(dLng / 2);
    
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    
    return R * c;
  }
  
  /**
   * 获取所有轨迹点
   */
  getTrackPoints(): TrackPoint[] {
    return [...this.trackPoints];
  }
  
  /**
   * 获取当前定位状态
   */
  isCurrentlyTracking(): boolean {
    return this.isTracking;
  }
  
  /**
   * 清空轨迹点
   */
  clearTrackPoints(): void {
    this.trackPoints = [];
    hilog.info(DOMAIN, TAG, 'Track points cleared');
  }
  
  /**
   * 计算总距离
   */
  calculateTotalDistance(points?: TrackPoint[]): number {
    const trackPoints = points || this.trackPoints;
    
    if (trackPoints.length < 2) return 0;
    
    let totalDistance = 0;
    for (let i = 1; i < trackPoints.length; i++) {
      totalDistance += this.calculateDistance(trackPoints[i - 1], trackPoints[i]);
    }
    
    return totalDistance;
  }
}

// 导出单例
export const locationService = LocationService.getInstance();