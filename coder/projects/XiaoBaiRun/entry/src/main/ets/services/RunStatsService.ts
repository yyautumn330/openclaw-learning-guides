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

const TAG = 'RunStatsService';
const DOMAIN = 0x0000;

/**
 * 统计周期
 */
export type StatsPeriod = 'day' | 'week' | 'month' | 'year';

/**
 * 统计数据
 */
export interface RunStats {
  period: StatsPeriod;
  totalRuns: number;       // 总跑步次数
  totalDistance: number;   // 总距离（米）
  totalDuration: number;   // 总时长（秒）
  avgDistance: number;     // 平均距离
  avgDuration: number;     // 平均时长
  avgPace: string;         // 平均配速
  avgSpeed: number;        // 平均速度（km/h）
  maxDistance: number;     // 最长距离
  maxDuration: number;     // 最长时长
  totalCalories: number;   // 总卡路里
}

/**
 * 图表数据点
 */
export interface ChartDataPoint {
  label: string;           // 标签（日期/周次/月份）
  value: number;           // 数值
  date: string;            // 日期
}

/**
 * 图表数据
 */
export interface ChartData {
  title: string;           // 图表标题
  unit: string;            // 单位
  data: ChartDataPoint[];  // 数据点
  maxValue: number;        // 最大值
  avgValue: number;        // 平均值
  totalValue: number;      // 总值
}

/**
 * 运动统计服务
 */
export class RunStatsService {
  private static instance: RunStatsService;

  private constructor() {}

  static getInstance(): RunStatsService {
    if (!RunStatsService.instance) {
      RunStatsService.instance = new RunStatsService();
    }
    return RunStatsService.instance;
  }

  /**
   * 计算统计数据
   */
  calculateStats(
    runs: Array<{ distance: number; duration: number; date: string }>,
    period: StatsPeriod
  ): RunStats {
    if (runs.length === 0) {
      return this.getEmptyStats(period);
    }

    const totalRuns = runs.length;
    const totalDistance = runs.reduce((sum, r) => sum + r.distance, 0);
    const totalDuration = runs.reduce((sum, r) => sum + r.duration, 0);
    
    const avgDistance = totalDistance / totalRuns;
    const avgDuration = totalDuration / totalRuns;
    const avgPace = this.calculatePace(totalDistance, totalDuration);
    const avgSpeed = this.calculateSpeed(totalDistance, totalDuration);
    
    const maxDistance = Math.max(...runs.map(r => r.distance));
    const maxDuration = Math.max(...runs.map(r => r.duration));
    const totalCalories = this.calculateCalories(totalDistance, totalDuration);

    return {
      period,
      totalRuns,
      totalDistance,
      totalDuration,
      avgDistance,
      avgDuration,
      avgPace,
      avgSpeed,
      maxDistance,
      maxDuration,
      totalCalories
    };
  }

  /**
   * 生成周度图表数据
   */
  generateWeekChartData(
    runs: Array<{ distance: number; duration: number; date: string }>,
    metric: 'distance' | 'duration' | 'runs' = 'distance'
  ): ChartData {
    const weekDays = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
    const data: ChartDataPoint[] = [];
    
    // 获取本周日期范围
    const today = new Date();
    const dayOfWeek = today.getDay();
    const monday = new Date(today);
    monday.setDate(today.getDate() - (dayOfWeek === 0 ? 6 : dayOfWeek - 1));

    for (let i = 0; i < 7; i++) {
      const date = new Date(monday);
      date.setDate(monday.getDate() + i);
      const dateStr = this.formatDate(date);
      
      const dayRuns = runs.filter(r => r.date === dateStr);
      
      let value = 0;
      switch (metric) {
        case 'distance':
          value = dayRuns.reduce((sum, r) => sum + r.distance, 0);
          break;
        case 'duration':
          value = dayRuns.reduce((sum, r) => sum + r.duration, 0);
          break;
        case 'runs':
          value = dayRuns.length;
          break;
      }

      data.push({
        label: weekDays[i],
        value,
        date: dateStr
      });
    }

    const values = data.map(d => d.value);
    const maxValue = Math.max(...values);
    const totalValue = values.reduce((sum, v) => sum + v, 0);
    const avgValue = totalValue / 7;

    return {
      title: metric === 'distance' ? '本周距离' : metric === 'duration' ? '本周时长' : '本周跑步次数',
      unit: metric === 'distance' ? '公里' : metric === 'duration' ? '分钟' : '次',
      data,
      maxValue,
      avgValue,
      totalValue
    };
  }

  /**
   * 生成月度图表数据
   */
  generateMonthChartData(
    runs: Array<{ distance: number; duration: number; date: string }>,
    year: number,
    month: number,
    metric: 'distance' | 'duration' | 'runs' = 'distance'
  ): ChartData {
    const data: ChartDataPoint[] = [];
    const daysInMonth = new Date(year, month, 0).getDate();

    for (let day = 1; day <= daysInMonth; day++) {
      const dateStr = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
      
      const dayRuns = runs.filter(r => r.date === dateStr);
      
      let value = 0;
      switch (metric) {
        case 'distance':
          value = dayRuns.reduce((sum, r) => sum + r.distance, 0);
          break;
        case 'duration':
          value = dayRuns.reduce((sum, r) => sum + r.duration, 0);
          break;
        case 'runs':
          value = dayRuns.length;
          break;
      }

      data.push({
        label: `${day}日`,
        value,
        date: dateStr
      });
    }

    const values = data.map(d => d.value);
    const maxValue = Math.max(...values);
    const totalValue = values.reduce((sum, v) => sum + v, 0);
    const runDays = values.filter(v => v > 0).length;
    const avgValue = runDays > 0 ? totalValue / runDays : 0;

    return {
      title: metric === 'distance' ? `${month}月距离` : metric === 'duration' ? `${month}月时长` : `${month}月跑步次数`,
      unit: metric === 'distance' ? '公里' : metric === 'duration' ? '分钟' : '次',
      data,
      maxValue,
      avgValue,
      totalValue
    };
  }

  /**
   * 格式化日期
   */
  private formatDate(date: Date): string {
    const year = date.getFullYear();
    const month = (date.getMonth() + 1).toString().padStart(2, '0');
    const day = date.getDate().toString().padStart(2, '0');
    return `${year}-${month}-${day}`;
  }

  /**
   * 计算配速
   */
  private calculatePace(distance: number, duration: number): string {
    if (distance === 0) return '0:00';
    
    const paceSeconds = duration / (distance / 1000);
    const minutes = Math.floor(paceSeconds / 60);
    const seconds = Math.floor(paceSeconds % 60);
    
    return `${minutes}:${seconds.toString().padStart(2, '0')}`;
  }

  /**
   * 计算速度（km/h）
   */
  private calculateSpeed(distance: number, duration: number): number {
    if (duration === 0) return 0;
    
    const hours = duration / 3600;
    const km = distance / 1000;
    
    return hours > 0 ? km / hours : 0;
  }

  /**
   * 计算卡路里
   */
  private calculateCalories(distance: number, duration: number): number {
    const MET = 9.1; // 跑步 MET 值
    const weight = 70; // 默认体重（kg）
    const hours = duration / 3600;
    
    return Math.round(MET * weight * hours);
  }

  /**
   * 获取空统计数据
   */
  private getEmptyStats(period: StatsPeriod): RunStats {
    return {
      period,
      totalRuns: 0,
      totalDistance: 0,
      totalDuration: 0,
      avgDistance: 0,
      avgDuration: 0,
      avgPace: '0:00',
      avgSpeed: 0,
      maxDistance: 0,
      maxDuration: 0,
      totalCalories: 0
    };
  }
}

export const runStatsService = RunStatsService.getInstance();