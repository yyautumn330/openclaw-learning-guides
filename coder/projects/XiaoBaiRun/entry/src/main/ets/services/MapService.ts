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
  private context: common.UIAbilityContext | null = null;
  
  // 高德静态地图 API Key（用户已申请并替换）
  private apiKey: string = '1b1487f32d95f0bd6a418f1337503eb3';
  
  private constructor() {}
  
  static getInstance(): MapService {
    if (!MapService.instance) {
      MapService.instance = new MapService();
    }
    return MapService.instance;
  }
  
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }
  
  async initialize(): Promise<boolean> {
    if (this.isInitialized) {
      return true;
    }
    
    this.isInitialized = true;
    const keyPreview: string = this.apiKey.substring(0, 8) + '***';
    hilog.info(DOMAIN, TAG, 'MapService initialized, API Key: %{public}s', keyPreview);
    return true;
  }
  
  async getCurrentPosition(): Promise<LocationPoint | null> {
    try {
      const location: LocationInfo | null = await locationService.getCurrentLocation();
      if (location) {
        return { latitude: location.latitude, longitude: location.longitude };
      }
      return { latitude: 39.90923, longitude: 116.397428 };
    } catch (error) {
      return { latitude: 39.90923, longitude: 116.397428 };
    }
  }
  
  /**
   * 生成高德静态地图 URL
   */
  getStaticMapUrl(
    latitude: number,
    longitude: number,
    zoom: number = 15,
    width: number = 640,
    height: number = 400
  ): string {
    // 高德静态地图 API v3
    // 文档：https://lbs.amap.com/api/webservice/guide/api/staticmap
    let url = 'https://restapi.amap.com/v3/staticmap?';
    url += `location=${longitude},${latitude}`;
    url += `&zoom=${zoom}`;
    url += `&size=${width}*${height}`;
    url += `&scale=2`;
    url += `&markers=mid,,A:${longitude},${latitude}`;
    url += `&key=${this.apiKey}`;
    
    hilog.info(DOMAIN, TAG, 'Static map URL generated');
    return url;
  }
}

export const mapService = MapService.getInstance();
