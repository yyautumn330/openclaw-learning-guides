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

const TAG = 'RunCalendarService';
const DOMAIN = 0x0000;

/**
 * 日历数据项
 */
export interface CalendarDay {
  date: string;           // 日期 (YYYY-MM-DD)
  hasRun: boolean;        // 是否有跑步记录
  distance: number;       // 距离（米）
  duration: number;       // 时长（秒）
  count: number;          // 跑步次数
}

/**
 * 月度统计
 */
export interface MonthStats {
  year: number;
  month: number;
  totalDays: number;      // 总天数
  runDays: number;        // 跑步天数
  totalDistance: number;  // 总距离
  totalDuration: number;  // 总时长
  totalRuns: number;      // 总跑步次数
  avgDistance: number;    // 平均距离
  avgPace: string;        // 平均配速
}

/**
 * 运动日历服务
 */
export class RunCalendarService {
  private static instance: RunCalendarService;
  private context: common.UIAbilityContext | null = null;
  private calendarData: Map<string, CalendarDay> = new Map();

  private constructor() {}

  static getInstance(): RunCalendarService {
    if (!RunCalendarService.instance) {
      RunCalendarService.instance = new RunCalendarService();
    }
    return RunCalendarService.instance;
  }

  /**
   * 设置上下文
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }

  /**
   * 添加跑步记录
   */
  addRun(date: string, distance: number, duration: number): void {
    const existing = this.calendarData.get(date);
    
    if (existing) {
      existing.distance += distance;
      existing.duration += duration;
      existing.count++;
    } else {
      this.calendarData.set(date, {
        date,
        hasRun: true,
        distance,
        duration,
        count: 1
      });
    }
    
    hilog.info(DOMAIN, TAG, 'Added run for %s: %dm, %ds', date, distance, duration);
  }

  /**
   * 获取某天的数据
   */
  getDay(date: string): CalendarDay | null {
    return this.calendarData.get(date) || null;
  }

  /**
   * 获取某月的数据
   */
  getMonth(year: number, month: number): CalendarDay[] {
    const days: CalendarDay[] = [];
    const daysInMonth = new Date(year, month, 0).getDate();
    
    for (let day = 1; day <= daysInMonth; day++) {
      const date = `${year}-${month.toString().padStart(2, '0')}-${day.toString().padStart(2, '0')}`;
      const data = this.calendarData.get(date);
      
      if (data) {
        days.push(data);
      } else {
        days.push({
          date,
          hasRun: false,
          distance: 0,
          duration: 0,
          count: 0
        });
      }
    }
    
    return days;
  }

  /**
   * 获取月度统计
   */
  getMonthStats(year: number, month: number): MonthStats {
    const days = this.getMonth(year, month);
    
    let runDays = 0;
    let totalDistance = 0;
    let totalDuration = 0;
    let totalRuns = 0;
    
    for (const day of days) {
      if (day.hasRun) {
        runDays++;
        totalDistance += day.distance;
        totalDuration += day.duration;
        totalRuns += day.count;
      }
    }
    
    const avgDistance = runDays > 0 ? totalDistance / runDays : 0;
    const avgPace = this.calculatePace(totalDistance, totalDuration);
    
    return {
      year,
      month,
      totalDays: days.length,
      runDays,
      totalDistance,
      totalDuration,
      totalRuns,
      avgDistance,
      avgPace
    };
  }

  /**
   * 获取连续跑步天数
   */
  getStreak(): number {
    const today = new Date();
    let streak = 0;
    let checkDate = new Date(today);
    
    while (true) {
      const dateStr = this.formatDate(checkDate);
      const day = this.calendarData.get(dateStr);
      
      if (day && day.hasRun) {
        streak++;
        checkDate.setDate(checkDate.getDate() - 1);
      } else {
        break;
      }
    }
    
    return streak;
  }

  /**
   * 获取本周跑步数据
   */
  getWeekData(): CalendarDay[] {
    const today = new Date();
    const dayOfWeek = today.getDay();
    const monday = new Date(today);
    monday.setDate(today.getDate() - (dayOfWeek === 0 ? 6 : dayOfWeek - 1));
    
    const days: CalendarDay[] = [];
    
    for (let i = 0; i < 7; i++) {
      const date = new Date(monday);
      date.setDate(monday.getDate() + i);
      const dateStr = this.formatDate(date);
      const data = this.calendarData.get(dateStr);
      
      if (data) {
        days.push(data);
      } else {
        days.push({
          date: dateStr,
          hasRun: false,
          distance: 0,
          duration: 0,
          count: 0
        });
      }
    }
    
    return days;
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
   * 保存数据
   */
  async save(): Promise<void> {
    if (!this.context) return;
    
    try {
      // TODO: 实现持久化存储
      hilog.info(DOMAIN, TAG, 'Calendar data saved');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Save failed: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 加载数据
   */
  async load(): Promise<void> {
    if (!this.context) return;
    
    try {
      // TODO: 实现从存储加载数据
      hilog.info(DOMAIN, TAG, 'Calendar data loaded');
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Load failed: %{public}s', JSON.stringify(error));
    }
  }
}

export const runCalendarService = RunCalendarService.getInstance();