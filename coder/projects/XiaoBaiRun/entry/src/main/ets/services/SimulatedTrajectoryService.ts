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
import { TrajectoryPoint } from '../models/TrajectoryModel';

const TAG = 'SimulatedTrajectory';
const DOMAIN = 0x0000;

/**
 * 模拟轨迹服务
 * 用于测试轨迹功能，无需实际跑步
 */
export class SimulatedTrajectoryService {
  private static instance: SimulatedTrajectoryService;
  
  private isSimulating: boolean = false;
  private simulationTimer: number = -1;
  private callback: ((point: TrajectoryPoint) => void) | null = null;
  
  // 模拟参数
  private startLocation = { latitude: 31.2304, longitude: 121.4737 }; // 上海陆家嘴
  private currentLocation = { ...this.startLocation };
  private speed: number = 3.0; // m/s (约 10km/h)
  private direction: number = 0; // 度
  private distance: number = 0;
  private pointCount: number = 0;

  private constructor() {}

  static getInstance(): SimulatedTrajectoryService {
    if (!SimulatedTrajectoryService.instance) {
      SimulatedTrajectoryService.instance = new SimulatedTrajectoryService();
    }
    return SimulatedTrajectoryService.instance;
  }

  /**
   * 开始模拟
   */
  startSimulation(callback: (point: TrajectoryPoint) => void): void {
    if (this.isSimulating) {
      hilog.warn(DOMAIN, TAG, 'Already simulating');
      return;
    }

    this.callback = callback;
    this.isSimulating = true;
    this.currentLocation = { ...this.startLocation };
    this.distance = 0;
    this.pointCount = 0;
    this.direction = Math.random() * 360;

    hilog.info(DOMAIN, TAG, '🎮 Simulation started');

    // 立即发送第一个点
    this.sendPoint();

    // 每秒发送一个点
    this.simulationTimer = setInterval(() => {
      this.sendPoint();
    }, 1000) as unknown as number;
  }

  /**
   * 停止模拟
   */
  stopSimulation(): void {
    if (!this.isSimulating) return;

    if (this.simulationTimer !== -1) {
      clearInterval(this.simulationTimer);
      this.simulationTimer = -1;
    }

    this.isSimulating = false;
    this.callback = null;
    
    hilog.info(DOMAIN, TAG, '🎮 Simulation stopped. Total distance: %dm', this.distance);
  }

  /**
   * 发送模拟轨迹点
   */
  private sendPoint(): void {
    if (!this.callback) return;

    // 随机改变方向（模拟真实跑步）
    this.direction += (Math.random() - 0.5) * 30;
    this.direction = this.direction % 360;

    // 计算新位置
    const distancePerSecond = this.speed;
    const deltaLat = distancePerSecond * Math.cos(this.direction * Math.PI / 180) / 111320;
    const deltaLon = distancePerSecond * Math.sin(this.direction * Math.PI / 180) / (111320 * Math.cos(this.currentLocation.latitude * Math.PI / 180));

    this.currentLocation.latitude += deltaLat;
    this.currentLocation.longitude += deltaLon;
    this.distance += distancePerSecond;
    this.pointCount++;

    // 创建轨迹点
    const point: TrajectoryPoint = {
      id: `sim_${Date.now()}`,
      timestamp: Date.now(),
      latitude: this.currentLocation.latitude,
      longitude: this.currentLocation.longitude,
      altitude: 5 + Math.random() * 10,
      accuracy: 5 + Math.random() * 10,
      speed: this.speed + (Math.random() - 0.5) * 0.5,
      bearing: this.direction,
      distance: this.distance,
      locationType: 'gps',
      isKeyPoint: false
    };

    this.callback(point);

    // 每公里打印日志
    if (this.pointCount % 333 === 0) {
      hilog.info(DOMAIN, TAG, '🎮 Simulated %d points, %.2f km', 
        this.pointCount, this.distance / 1000);
    }
  }

  /**
   * 是否正在模拟
   */
  isRunning(): boolean {
    return this.isSimulating;
  }

  /**
   * 获取模拟距离
   */
  getDistance(): number {
    return this.distance;
  }

  /**
   * 设置速度 (m/s)
   */
  setSpeed(speed: number): void {
    this.speed = speed;
    hilog.info(DOMAIN, TAG, 'Speed set to %.1f m/s', speed);
  }

  /**
   * 设置起始位置
   */
  setStartLocation(latitude: number, longitude: number): void {
    this.startLocation = { latitude, longitude };
    this.currentLocation = { ...this.startLocation };
    hilog.info(DOMAIN, TAG, 'Start location set to: lat=%f, lon=%f', latitude, longitude);
  }
}

export const simulatedTrajectoryService = SimulatedTrajectoryService.getInstance();