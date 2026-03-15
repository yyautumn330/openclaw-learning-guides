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

const TAG = 'TrajectoryModel';
const DOMAIN = 0x0000;

/**
 * 关键点类型
 */
export type KeyPointType = 'start' | 'end' | 'pause' | 'resume' | 'milestone' | 'turn';

/**
 * 定位类型
 */
export type LocationType = 'gps' | 'network' | 'cached';

/**
 * 轨迹点
 */
export interface TrajectoryPoint {
  id: string;
  timestamp: number;
  latitude: number;
  longitude: number;
  altitude: number;
  accuracy: number;
  speed: number;
  bearing: number;
  distance: number;
  locationType: LocationType;
  isKeyPoint: boolean;
  keyPointType?: KeyPointType;
}

/**
 * 关键点
 */
export interface KeyPoint {
  id: string;
  type: KeyPointType;
  timestamp: number;
  latitude: number;
  longitude: number;
  milestone?: number;
  pauseDuration?: number;
  turnAngle?: number;
}

/**
 * 运动记录
 */
export interface RunRecord {
  id: string;
  startTime: number;
  endTime: number;
  duration: number;
  totalDistance: number;
  directDistance: number;
  avgSpeed: number;
  maxSpeed: number;
  avgPace: string;
  calories: number;
  pointCount: number;
  keyPoints: KeyPoint[];
  gpxPath?: string;
  jsonPath?: string;
}

/**
 * 轨迹模型 - 数据管理和计算
 */
export class TrajectoryModel {
  private static instance: TrajectoryModel;
  
  private trajectory: TrajectoryPoint[] = [];
  private keyPoints: KeyPoint[] = [];
  private currentRecord: RunRecord | null = null;
  
  // 统计数据
  private totalDistance: number = 0;
  private maxSpeed: number = 0;
  private lastPoint: TrajectoryPoint | null = null;

  private constructor() {}

  static getInstance(): TrajectoryModel {
    if (!TrajectoryModel.instance) {
      TrajectoryModel.instance = new TrajectoryModel();
    }
    return TrajectoryModel.instance;
  }

  /**
   * 重置轨迹
   */
  reset(): void {
    this.trajectory = [];
    this.keyPoints = [];
    this.currentRecord = null;
    this.totalDistance = 0;
    this.maxSpeed = 0;
    this.lastPoint = null;
    hilog.info(DOMAIN, TAG, 'Trajectory reset');
  }

  /**
   * 添加轨迹点
   */
  addPoint(location: {
    latitude: number;
    longitude: number;
    altitude: number;
    accuracy: number;
    speed: number;
    bearing: number;
  }, locationType: LocationType = 'gps'): TrajectoryPoint {
    const timestamp = Date.now();
    const id = `pt_${timestamp}`;
    
    // 计算累计距离
    let distance = 0;
    if (this.lastPoint) {
      distance = this.totalDistance + this.calculateDistance(
        this.lastPoint.latitude, this.lastPoint.longitude,
        location.latitude, location.longitude
      );
    }
    
    const point: TrajectoryPoint = {
      id,
      timestamp,
      latitude: location.latitude,
      longitude: location.longitude,
      altitude: location.altitude,
      accuracy: location.accuracy,
      speed: location.speed,
      bearing: location.bearing,
      distance,
      locationType,
      isKeyPoint: false
    };
    
    this.trajectory.push(point);
    this.totalDistance = distance;
    this.lastPoint = point;
    
    // 更新最高速度
    if (location.speed > this.maxSpeed) {
      this.maxSpeed = location.speed;
    }
    
    hilog.debug(DOMAIN, TAG, 'Point added: lat=%f, lon=%f, dist=%d', 
      location.latitude, location.longitude, distance);
    
    return point;
  }

  /**
   * 添加关键点
   */
  addKeyPoint(type: KeyPointType, point: TrajectoryPoint, extra?: {
    milestone?: number;
    pauseDuration?: number;
    turnAngle?: number;
  }): KeyPoint {
    const keyPoint: KeyPoint = {
      id: `kp_${Date.now()}`,
      type,
      timestamp: point.timestamp,
      latitude: point.latitude,
      longitude: point.longitude,
      ...extra
    };
    
    this.keyPoints.push(keyPoint);
    point.isKeyPoint = true;
    point.keyPointType = type;
    
    hilog.info(DOMAIN, TAG, 'Key point added: type=%s', type);
    
    return keyPoint;
  }

  /**
   * 计算两点间距离 (Haversine 公式)
   */
  calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
    const R = 6371000; // 地球半径 (米)
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
              Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }

  /**
   * 计算配速
   */
  calculatePace(distance: number, duration: number): string {
    if (distance === 0) return '0:00';
    const paceSeconds = duration / (distance / 1000);
    const minutes = Math.floor(paceSeconds / 60);
    const seconds = Math.floor(paceSeconds % 60);
    return `${minutes}:${seconds.toString().padStart(2, '0')}`;
  }

  /**
   * 计算卡路里
   */
  calculateCalories(distance: number, duration: number, weight: number = 70): number {
    const MET = 9.1; // 跑步 MET 值
    const hours = duration / 3600;
    return Math.round(MET * weight * hours);
  }

  /**
   * 创建运动记录
   */
  createRecord(startTime: number, endTime: number): RunRecord {
    const duration = (endTime - startTime) / 1000;
    const avgSpeed = duration > 0 ? this.totalDistance / duration : 0;
    
    // 计算直线距离
    let directDistance = 0;
    if (this.trajectory.length >= 2) {
      const first = this.trajectory[0];
      const last = this.trajectory[this.trajectory.length - 1];
      directDistance = this.calculateDistance(
        first.latitude, first.longitude,
        last.latitude, last.longitude
      );
    }
    
    const record: RunRecord = {
      id: `run_${startTime}`,
      startTime,
      endTime,
      duration,
      totalDistance: this.totalDistance,
      directDistance,
      avgSpeed,
      maxSpeed: this.maxSpeed,
      avgPace: this.calculatePace(this.totalDistance, duration),
      calories: this.calculateCalories(this.totalDistance, duration),
      pointCount: this.trajectory.length,
      keyPoints: [...this.keyPoints]
    };
    
    this.currentRecord = record;
    return record;
  }

  /**
   * 获取轨迹
   */
  getTrajectory(): TrajectoryPoint[] {
    return [...this.trajectory];
  }

  /**
   * 获取关键点
   */
  getKeyPoints(): KeyPoint[] {
    return [...this.keyPoints];
  }

  /**
   * 获取当前记录
   */
  getCurrentRecord(): RunRecord | null {
    return this.currentRecord;
  }

  /**
   * 获取统计信息
   */
  getStats(): {
    distance: number;
    duration: number;
    avgSpeed: number;
    maxSpeed: number;
    pointCount: number;
  } {
    const duration = this.trajectory.length > 0 
      ? (this.trajectory[this.trajectory.length - 1].timestamp - this.trajectory[0].timestamp) / 1000
      : 0;
    
    return {
      distance: this.totalDistance,
      duration,
      avgSpeed: duration > 0 ? this.totalDistance / duration : 0,
      maxSpeed: this.maxSpeed,
      pointCount: this.trajectory.length
    };
  }

  /**
   * 过滤轨迹点 (去除异常点)
   */
  filterTrajectory(minAccuracy: number = 30, maxSpeed: number = 20): TrajectoryPoint[] {
    return this.trajectory.filter((point, index, arr) => {
      if (point.accuracy > minAccuracy) return false;
      
      if (index > 0) {
        const prev = arr[index - 1];
        const dist = this.calculateDistance(
          prev.latitude, prev.longitude,
          point.latitude, point.longitude
        );
        const timeDiff = (point.timestamp - prev.timestamp) / 1000;
        if (timeDiff > 0 && dist / timeDiff > maxSpeed) return false;
      }
      
      return true;
    });
  }
}

export const trajectoryModel = TrajectoryModel.getInstance();