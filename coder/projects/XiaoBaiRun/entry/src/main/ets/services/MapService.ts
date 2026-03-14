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
import { locationService, LocationInfo } from './LocationService';

const TAG = 'MapService';
const DOMAIN = 0x0000;

export interface LocationPoint {
  latitude: number;
  longitude: number;
}

export class MapService {
  private static instance: MapService;
  private isInitialized: boolean = false;
  
  private constructor() {}
  
  static getInstance(): MapService {
    if (!MapService.instance) {
      MapService.instance = new MapService();
    }
    return MapService.instance;
  }
  
  async initialize(): Promise<boolean> {
    if (this.isInitialized) return true;
    this.isInitialized = true;
    hilog.info(DOMAIN, TAG, 'MapService initialized');
    return true;
  }
  
  /**
   * 获取当前位置（使用真实定位）
   */
  async getCurrentPosition(): Promise<LocationPoint | null> {
    try {
      // 使用 LocationService 的真实定位
      const location: LocationInfo | null = await locationService.getCurrentLocation();
      if (location) {
        hilog.info(DOMAIN, TAG, 'Got real location: %{public}s,%{public}s', 
                   location.latitude.toString(), location.longitude.toString());
        return { latitude: location.latitude, longitude: location.longitude };
      } else {
        // 如果真实定位失败，使用默认位置
        hilog.warn(DOMAIN, TAG, 'Real location unavailable, using default');
        return { latitude: 39.90923, longitude: 116.397428 };
      }
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Get position error: %{public}s', JSON.stringify(error) ?? '');
      return { latitude: 39.90923, longitude: 116.397428 };
    }
  }
}

export const mapService = MapService.getInstance();
