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
import { TrajectoryPoint, RunRecord } from '../models/TrajectoryModel';

const TAG = 'GPXService';
const DOMAIN = 0x0000;

/**
 * GPX 导出服务
 */
export class GPXService {
  private static instance: GPXService;
  private context: common.UIAbilityContext | null = null;

  private constructor() {}

  static getInstance(): GPXService {
    if (!GPXService.instance) {
      GPXService.instance = new GPXService();
    }
    return GPXService.instance;
  }

  /**
   * 设置 Context
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }

  /**
   * 导出为 GPX 格式
   */
  async exportGPX(record: RunRecord, trajectory: TrajectoryPoint[]): Promise<string> {
    const gpx = this.generateGPX(record, trajectory);
    
    if (!this.context) {
      hilog.warn(DOMAIN, TAG, 'No context, returning GPX string only');
      return gpx;
    }

    try {
      // 确保目录存在
      const fs = await import('@ohos.file.fs');
      const exportDir = `${this.context.filesDir}/running/exports`;
      
      try {
        fs.accessSync(exportDir);
      } catch (e) {
        fs.mkdirSync(exportDir, true);
      }
      
      // 生成文件名
      const timestamp = new Date(record.startTime).toISOString().replace(/[:.]/g, '-');
      const fileName = `run_${timestamp}.gpx`;
      const filePath = `${exportDir}/${fileName}`;
      
      // 写入文件
      const file = fs.openSync(filePath, fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY);
      const encoder = new TextEncoder();
      const buffer = encoder.encode(gpx).buffer;
      fs.writeSync(file.fd, buffer);
      fs.closeSync(file);
      
      hilog.info(DOMAIN, TAG, 'GPX exported: %s', filePath);
      
      return filePath;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Export GPX failed: %{public}s', JSON.stringify(error));
      throw error;
    }
  }

  /**
   * 生成 GPX XML
   */
  private generateGPX(record: RunRecord, trajectory: TrajectoryPoint[]): string {
    const startTime = new Date(record.startTime).toISOString();
    const durationMin = Math.floor(record.duration / 60);
    const durationSec = record.duration % 60;
    
    let gpx = `<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="小白快跑" 
     xmlns="http://www.topografix.com/GPX/1/1"
     xmlns:gpxtpx="http://www.garmin.com/xmlschemas/TrackPointExtension/v1">
  
  <metadata>
    <name>${this.formatDate(record.startTime)} 跑步记录</name>
    <time>${startTime}</time>
    <desc>总距离: ${(record.totalDistance / 1000).toFixed(2)}km, 总时长: ${durationMin}:${durationSec.toString().padStart(2, '0')}, 平均配速: ${record.avgPace}/km</desc>
  </metadata>
  
  <trk>
    <name>跑步轨迹</name>
    <type>running</type>
    
    <trkseg>
`;

    // 添加轨迹点
    for (const point of trajectory) {
      const time = new Date(point.timestamp).toISOString();
      gpx += `      <trkpt lat="${point.latitude.toFixed(7)}" lon="${point.longitude.toFixed(7)}">
        <ele>${point.altitude.toFixed(1)}</ele>
        <time>${time}</time>
        <speed>${point.speed.toFixed(2)}</speed>
        <course>${point.bearing.toFixed(1)}</course>
        <hdop>${(point.accuracy / 3).toFixed(1)}</hdop>
      </trkpt>
`;
    }

    gpx += `    </trkseg>
  </trk>
</gpx>`;

    return gpx;
  }

  /**
   * 格式化日期
   */
  private formatDate(timestamp: number): string {
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  /**
   * 导入 GPX 文件
   */
  async importGPX(filePath: string): Promise<{ record: RunRecord; trajectory: TrajectoryPoint[] }> {
    try {
      const fs = await import('@ohos.file.fs');
      const file = fs.openSync(filePath, fs.OpenMode.READ_ONLY);
      const stat = fs.statSync(filePath);
      const buffer = new ArrayBuffer(stat.size);
      fs.readSync(file.fd, buffer);
      fs.closeSync(file);
      
      const gpxContent = String.fromCharCode(...new Uint8Array(buffer));
      return this.parseGPX(gpxContent);
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Import GPX failed: %{public}s', JSON.stringify(error));
      throw error;
    }
  }

  /**
   * 解析 GPX XML
   */
  private parseGPX(gpxContent: string): { record: RunRecord; trajectory: TrajectoryPoint[] } {
    // 简化的 GPX 解析（实际应使用 XML 解析器）
    const trkptRegex = /<trkpt lat="([^"]+)" lon="([^"]+)">[\s\S]*?<ele>([^<]+)<\/ele>[\s\S]*?<time>([^<]+)<\/time>[\s\S]*?<speed>([^<]+)<\/speed>/g;
    
    const trajectory: TrajectoryPoint[] = [];
    let match;
    let totalDistance = 0;
    let maxSpeed = 0;
    
    while ((match = trkptRegex.exec(gpxContent)) !== null) {
      const latitude = parseFloat(match[1]);
      const longitude = parseFloat(match[2]);
      const altitude = parseFloat(match[3]);
      const timestamp = new Date(match[4]).getTime();
      const speed = parseFloat(match[5]);
      
      // 计算距离
      if (trajectory.length > 0) {
        const prev = trajectory[trajectory.length - 1];
        totalDistance += this.calculateDistance(
          prev.latitude, prev.longitude,
          latitude, longitude
        );
      }
      
      if (speed > maxSpeed) {
        maxSpeed = speed;
      }
      
      trajectory.push({
        id: `pt_${timestamp}`,
        timestamp,
        latitude,
        longitude,
        altitude,
        accuracy: 10, // 默认精度
        speed,
        bearing: 0,
        distance: totalDistance,
        locationType: 'gps',
        isKeyPoint: false
      });
    }
    
    const startTime = trajectory.length > 0 ? trajectory[0].timestamp : Date.now();
    const endTime = trajectory.length > 0 ? trajectory[trajectory.length - 1].timestamp : Date.now();
    const duration = (endTime - startTime) / 1000;
    
    const record: RunRecord = {
      id: `run_${startTime}`,
      startTime,
      endTime,
      duration,
      totalDistance,
      directDistance: 0,
      avgSpeed: duration > 0 ? totalDistance / duration : 0,
      maxSpeed,
      avgPace: this.calculatePace(totalDistance, duration),
      calories: this.calculateCalories(totalDistance, duration),
      pointCount: trajectory.length,
      keyPoints: []
    };
    
    return { record, trajectory };
  }

  private calculateDistance(lat1: number, lon1: number, lat2: number, lon2: number): number {
    const R = 6371000;
    const dLat = (lat2 - lat1) * Math.PI / 180;
    const dLon = (lon2 - lon1) * Math.PI / 180;
    const a = Math.sin(dLat / 2) * Math.sin(dLat / 2) +
              Math.cos(lat1 * Math.PI / 180) * Math.cos(lat2 * Math.PI / 180) *
              Math.sin(dLon / 2) * Math.sin(dLon / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }

  private calculatePace(distance: number, duration: number): string {
    if (distance === 0) return '0:00';
    const paceSeconds = duration / (distance / 1000);
    const minutes = Math.floor(paceSeconds / 60);
    const seconds = Math.floor(paceSeconds % 60);
    return `${minutes}:${seconds.toString().padStart(2, '0')}`;
  }

  private calculateCalories(distance: number, duration: number, weight: number = 70): number {
    const MET = 9.1;
    const hours = duration / 3600;
    return Math.round(MET * weight * hours);
  }
}

export const gpxService = GPXService.getInstance();