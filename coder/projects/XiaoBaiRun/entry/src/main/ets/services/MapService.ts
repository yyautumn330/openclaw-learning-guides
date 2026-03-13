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

const TAG = 'MapService';
const DOMAIN = 0x0000;

/**
 * 地图配置
 */
export interface MapConfig {
  zoom: number;
  center: LocationPoint;
}

/**
 * 位置点
 */
export interface LocationPoint {
  latitude: number;
  longitude: number;
}

/**
 * 地图服务单例
 * 
 * 注意：HarmonyOS 地图组件需要高德地图 SDK
 * 当前使用占位实现，后续需要：
 * 1. 在 build-profile.json5 中添加高德地图依赖
 * 2. 在 module.json5 中配置地图权限
 * 3. 申请高德地图 API Key
 */
export class MapService {
  private static instance: MapService;
  private isInitialized: boolean = false;
  private currentLocation: LocationPoint | null = null;
  
  private constructor() {}
  
  /**
   * 获取单例实例
   */
  static getInstance(): MapService {
    if (!MapService.instance) {
      MapService.instance = new MapService();
    }
    return MapService.instance;
  }
  
  /**
   * 初始化地图服务
   */
  async initialize(): Promise<boolean> {
    if (this.isInitialized) {
      return true;
    }
    
    try {
      // TODO: 集成高德地图 SDK
      // 1. 引入 @amap/map
      // 2. 初始化地图 SDK
      // 3. 设置 API Key
      
      hilog.info(DOMAIN, TAG, 'MapService initialized (placeholder mode)');
      this.isInitialized = true;
      return true;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Initialize map service error: %{public}s', JSON.stringify(error) ?? '');
      return false;
    }
  }
  
  /**
   * 设置中心点
   */
  setCenter(latitude: number, longitude: number): void {
    this.currentLocation = { latitude, longitude };
    hilog.info(DOMAIN, TAG, 'Map center set to: %{public}f, %{public}f', latitude, longitude);
  }
  
  /**
   * 获取当前位置
   */
  getCurrentLocation(): LocationPoint | null {
    return this.currentLocation;
  }
  
  /**
   * 更新位置
   */
  updateLocation(latitude: number, longitude: number): void {
    this.currentLocation = { latitude, longitude };
    hilog.info(DOMAIN, TAG, 'Location updated: %{public}f, %{public}f', latitude, longitude);
  }
  
  /**
   * 检查是否已初始化
   */
  isReady(): boolean {
    return this.isInitialized;
  }
}

// 导出单例
export const mapService = MapService.getInstance();
