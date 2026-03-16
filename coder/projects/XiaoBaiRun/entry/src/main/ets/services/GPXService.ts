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
 * 生成 GPX 1.1 格式的轨迹文件
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
   * 导出为 GPX 格式字符串
   * 返回 GPX XML 内容，可用于分享或保存
   */
  async exportGPX(record: RunRecord, trajectory: TrajectoryPoint[]): Promise<string> {
    const gpx = this.generateGPX(record, trajectory);
    hilog.info(DOMAIN, TAG, 'GPX generated, length: %{public}d', gpx.length);
    return gpx;
  }

  /**
   * 生成 GPX XML
   */
  private generateGPX(record: RunRecord, trajectory: TrajectoryPoint[]): string {
    const startTime = new Date(record.startTime).toISOString();
    const endTime = new Date(record.endTime || Date.now()).toISOString();
    
    let gpx = `<?xml version="1.0" encoding="UTF-8"?>
<gpx version="1.1" creator="小白快跑" xmlns="http://www.topografix.com/GPX/1/1">
  <metadata>
    <name>跑步轨迹</name>
    <desc>小白快跑记录的跑步轨迹</desc>
    <time>${startTime}</time>
  </metadata>
  <trk>
    <name>跑步 ${startTime}</name>
    <trkseg>
`;

    // 添加轨迹点
    for (const point of trajectory) {
      const time = new Date(point.timestamp).toISOString();
      gpx += `      <trkpt lat="${point.latitude}" lon="${point.longitude}">
        <ele>${point.altitude || 0}</ele>
        <time>${time}</time>
      </trkpt>
`;
    }

    gpx += `    </trkseg>
  </trk>
</gpx>`;

    return gpx;
  }

  /**
   * 获取 GPX 文件名
   */
  getGPXFileName(record: RunRecord): string {
    const timestamp = new Date(record.startTime).toISOString().replace(/[:.]/g, '-');
    return `run_${timestamp}.gpx`;
  }

  /**
   * 解析 GPX 内容（用于导入功能）
   */
  parseGPX(gpxContent: string): { record: RunRecord; trajectory: TrajectoryPoint[] } {
    // 简化的 GPX 解析
    const trajectory: TrajectoryPoint[] = [];
    
    // 正则匹配轨迹点
    const trkptRegex = /<trkpt lat="([^"]+)" lon="([^"]+)">[\s\S]*?<ele>([^<]*)<\/ele>[\s\S]*?<time>([^<]*)<\/time>/g;
    let match;
    let index = 0;
    
    while ((match = trkptRegex.exec(gpxContent)) !== null) {
      trajectory.push({
        id: `point_${index}`,
        timestamp: new Date(match[4]).getTime(),
        latitude: parseFloat(match[1]),
        longitude: parseFloat(match[2]),
        altitude: parseFloat(match[3]) || 0,
        accuracy: 0,
        speed: 0,
        bearing: 0,
        distance: 0,
        locationType: 'gps',
        isKeyPoint: false
      });
      index++;
    }

    // 创建记录
    const record: RunRecord = {
      id: Date.now().toString(),
      startTime: trajectory.length > 0 ? trajectory[0].timestamp : Date.now(),
      endTime: trajectory.length > 0 ? trajectory[trajectory.length - 1].timestamp : Date.now(),
      duration: 0,
      totalDistance: 0,
      directDistance: 0,
      avgSpeed: 0,
      maxSpeed: 0,
      avgPace: '0\'00"',
      calories: 0,
      pointCount: trajectory.length,
      keyPoints: []
    };

    return { record, trajectory };
  }
}

export const gpxService = GPXService.getInstance();