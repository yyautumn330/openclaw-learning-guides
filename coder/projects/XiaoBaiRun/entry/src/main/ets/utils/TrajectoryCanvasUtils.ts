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

const TAG = 'TrajectoryCanvas';
const DOMAIN = 0x0000;

/**
 * 轨迹画布工具类
 * 用于计算轨迹点的画布坐标
 */
export class TrajectoryCanvasUtils {
  /**
   * 计算轨迹的边界框
   */
  static calculateBounds(points: TrajectoryPoint[]): {
    minLat: number;
    maxLat: number;
    minLon: number;
    maxLon: number;
  } {
    if (points.length === 0) {
      return { minLat: 0, maxLat: 0, minLon: 0, maxLon: 0 };
    }

    let minLat = points[0].latitude;
    let maxLat = points[0].latitude;
    let minLon = points[0].longitude;
    let maxLon = points[0].longitude;

    for (const point of points) {
      minLat = Math.min(minLat, point.latitude);
      maxLat = Math.max(maxLat, point.latitude);
      minLon = Math.min(minLon, point.longitude);
      maxLon = Math.max(maxLon, point.longitude);
    }

    return { minLat, maxLat, minLon, maxLon };
  }

  /**
   * 将地理坐标转换为画布坐标
   */
  static geoToCanvas(
    lat: number,
    lon: number,
    bounds: { minLat: number; maxLat: number; minLon: number; maxLon: number },
    canvasWidth: number,
    canvasHeight: number,
    padding: number = 40
  ): { x: number; y: number } {
    const { minLat, maxLat, minLon, maxLon } = bounds;

    // 计算有效绘制区域
    const effectiveWidth = canvasWidth - 2 * padding;
    const effectiveHeight = canvasHeight - 2 * padding;

    // 计算缩放比例
    const latRange = maxLat - minLat || 0.001; // 避免除零
    const lonRange = maxLon - minLon || 0.001;

    const scaleX = effectiveWidth / lonRange;
    const scaleY = effectiveHeight / latRange;
    const scale = Math.min(scaleX, scaleY);

    // 计算偏移量（居中）
    const offsetX = padding + (effectiveWidth - lonRange * scale) / 2;
    const offsetY = padding + (effectiveHeight - latRange * scale) / 2;

    // 转换坐标
    const x = offsetX + (lon - minLon) * scale;
    const y = offsetY + (maxLat - lat) * scale; // Y轴翻转

    return { x, y };
  }

  /**
   * 生成轨迹路径命令
   * 返回 Canvas Path2D 的路径字符串
   */
  static generatePath(
    points: TrajectoryPoint[],
    canvasWidth: number,
    canvasHeight: number,
    padding: number = 40
  ): string {
    if (points.length === 0) return '';

    const bounds = this.calculateBounds(points);
    const commands: string[] = [];

    for (let i = 0; i < points.length; i++) {
      const { x, y } = this.geoToCanvas(
        points[i].latitude,
        points[i].longitude,
        bounds,
        canvasWidth,
        canvasHeight,
        padding
      );

      if (i === 0) {
        commands.push(`M ${x.toFixed(1)} ${y.toFixed(1)}`);
      } else {
        commands.push(`L ${x.toFixed(1)} ${y.toFixed(1)}`);
      }
    }

    return commands.join(' ');
  }

  /**
   * 获取轨迹中心点
   */
  static getCenter(points: TrajectoryPoint[]): { latitude: number; longitude: number } {
    if (points.length === 0) {
      return { latitude: 0, longitude: 0 };
    }

    const bounds = this.calculateBounds(points);
    return {
      latitude: (bounds.minLat + bounds.maxLat) / 2,
      longitude: (bounds.minLon + bounds.maxLon) / 2
    };
  }

  /**
   * 计算缩放级别（用于地图）
   */
  static calculateZoomLevel(points: TrajectoryPoint[]): number {
    if (points.length < 2) return 15;

    const bounds = this.calculateBounds(points);
    const latRange = bounds.maxLat - bounds.minLat;
    const lonRange = bounds.maxLon - bounds.minLon;
    const maxRange = Math.max(latRange, lonRange);

    // 根据范围估算缩放级别
    if (maxRange > 0.1) return 10;
    if (maxRange > 0.05) return 11;
    if (maxRange > 0.02) return 12;
    if (maxRange > 0.01) return 13;
    if (maxRange > 0.005) return 14;
    return 15;
  }
}