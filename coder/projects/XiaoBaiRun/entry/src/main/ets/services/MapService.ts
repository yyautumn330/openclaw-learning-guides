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
  
  // 高德静态地图 API Key（从资源文件读取）
  private apiKey: string = '';
  
  private constructor() {}
  
  static getInstance(): MapService {
    if (!MapService.instance) {
      MapService.instance = new MapService();
    }
    return MapService.instance;
  }
  
  /**
   * 设置上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }
  
  /**
   * 初始化地图服务
   */
  async initialize(context?: common.UIAbilityContext): Promise<boolean> {
    if (this.isInitialized) {
      hilog.info(DOMAIN, TAG, 'Already initialized');
      return true;
    }
    
    try {
      if (context) {
        this.context = context;
      }
      
      if (!this.context) {
        hilog.error(DOMAIN, TAG, 'Context is null');
        return false;
      }
      
      // 使用配置的高德地图 API Key
      // 从资源文件读取：entry/src/main/resources/base/element/string.json
      this.apiKey = '1b1487f32d95f0bd6a418f1337503eb3';
      hilog.info(DOMAIN, TAG, 'API Key configured: %{public}s', 
                 this.apiKey.substring(0, 8) + '***');
      
      this.isInitialized = true;
      hilog.info(DOMAIN, TAG, 'MapService initialized');
      return true;
      
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Initialize error: %{public}s', JSON.stringify(error) ?? '');
      return false;
    }
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
        // 如果真实定位失败，使用默认位置（北京）
        hilog.warn(DOMAIN, TAG, 'Real location unavailable, using default');
        return { latitude: 39.90923, longitude: 116.397428 };
      }
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Get position error: %{public}s', JSON.stringify(error) ?? '');
      return { latitude: 39.90923, longitude: 116.397428 };
    }
  }
  
  /**
   * 生成 OpenStreetMap 静态地图 URL (免费，无需 API Key)
   * 使用 StaticMap 服务：https://staticmap.openstreetmap.de/
   */
  getStaticMapUrl(
    latitude: number,
    longitude: number,
    zoom: number = 15,
    width: number = 640,
    height: number = 400
  ): string {
    // OpenStreetMap StaticMap (免费，无需 API Key)
    let url = `https://staticmap.openstreetmap.de/staticmap.php?`;
    url += `center=${latitude},${longitude}`;
    url += `&zoom=${zoom}`;
    url += `&size=${width}x${height}`;
    url += `&maptype=mapnik`;
    
    // 添加时间戳避免缓存
    url += `&t=${Date.now()}`;
    
    hilog.info(DOMAIN, TAG, 'OSM Static map URL: %{public}s', url);
    return url;
  }
  
  /**
   * 生成带轨迹的静态地图 URL
   */
  getTrajectoryMapUrl(
    latitude: number,
    longitude: number,
    zoom: number,
    width: number,
    height: number,
    trajectoryPoints?: Array<{ lat: number; lng: number }>
  ): string {
    let url = this.getStaticMapUrl(latitude, longitude, zoom, width, height);
    
    // 添加轨迹线（高德静态地图支持 path 参数）
    if (trajectoryPoints && trajectoryPoints.length > 0) {
      const pathParam = trajectoryPoints.map(p => `${p.lng},${p.lat}`).join('|');
      url += `&path=2,5,FF0000FF,${pathParam}`; // 宽度 5，红色
    }
    
    return url;
  }
}

export const mapService = MapService.getInstance();
