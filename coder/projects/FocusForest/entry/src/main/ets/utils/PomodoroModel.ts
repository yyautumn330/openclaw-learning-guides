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

import preferences from '@ohos.data.preferences';
import { common } from '@kit.AbilityKit';

/**
 * 成就定义
 */
export interface Achievement {
  id: string;
  name: string;
  description: string;
  icon: string;
  isUnlocked: boolean;
  unlockDate?: string;
  condition: string;
}

/**
 * 每日统计数据
 */
export interface DailyStats {
  date: string;
  completedCount: number;
  focusDuration: number; // 秒
}

/**
 * 设置数据
 */
export interface PomodoroSettings {
  pomodoroDuration: number; // 番茄时长（分钟）
  shortBreakDuration: number; // 短休息时长（分钟）
  longBreakDuration: number; // 长休息时长（分钟）
  longBreakInterval: number; // 长休息间隔（几个番茄后）
}

/**
 * 番茄钟数据模型
 * 管理番茄计时器状态和统计数据
 * 使用单例模式确保全局数据一致性
 */
export class PomodoroModel {
  // 标准番茄钟时长（25 分钟 = 1500 秒）
  public static readonly STANDARD_POMODORO_DURATION: number = 25 * 60;
  
  // 单例实例
  private static instance: PomodoroModel | null = null;
  
  // 当前剩余时间（秒）
  private remainingTime: number = PomodoroModel.STANDARD_POMODORO_DURATION;
  
  // 是否正在运行
  private isRunning: boolean = false;
  
  // 是否暂停
  private isPaused: boolean = false;
  
  // 今日完成的番茄数
  private todayCompleted: number = 0;
  
  // 上次更新日期
  private lastUpdateDate: string = '';
  
  // 历史总完成数
  private totalCompleted: number = 0;
  
  // 历史总专注时长（秒）
  private totalFocusDuration: number = 0;
  
  // 连续使用天数
  private consecutiveDays: number = 0;
  
  // 上次使用日期
  private lastUseDate: string = '';
  
  // 最后一个番茄完成的小时数（用于成就判断）
  private lastTomatoHour: number = -1;
  
  // 成就列表
  private achievements: Achievement[] = [];
  
  // 每日统计记录
  private dailyStats: Map<string, DailyStats> = new Map();
  
  // 当前设置
  private settings: PomodoroSettings = {
    pomodoroDuration: 25,
    shortBreakDuration: 5,
    longBreakDuration: 15,
    longBreakInterval: 4
  };
  
  // Preferences 实例
  private preferencesInstance: preferences.Preferences | null = null;
  private context: common.UIAbilityContext | null = null;
  
  // 是否已初始化
  private isInitialized: boolean = false;
  
  /**
   * 私有构造函数，防止外部直接实例化
   */
  private constructor() {}
  
  /**
   * 获取单例实例
   */
  static getInstance(): PomodoroModel {
    if (!PomodoroModel.instance) {
      PomodoroModel.instance = new PomodoroModel();
    }
    return PomodoroModel.instance;
  }
  
  /**
   * 初始化模型（只初始化一次）
   */
  async initialize(context: common.UIAbilityContext): Promise<void> {
    // 防止重复初始化
    if (this.isInitialized) {
      console.info('PomodoroModel already initialized, skipping');
      return;
    }
    
    this.context = context;
    try {
      // 加载偏好设置
      this.preferencesInstance = await preferences.getPreferences(context, 'pomodoro_prefs');
      await this.loadFromPreferences();
      this.checkAndUpdateDate();
      this.checkAchievements();
      this.isInitialized = true;
      console.info('PomodoroModel initialized successfully');
    } catch (error) {
      console.error('PomodoroModel initialize error:', error);
    }
  }
  
  /**
   * 重置单例实例（用于测试）
   */
  static resetInstance(): void {
    PomodoroModel.instance = null;
  }
  
  /**
   * 获取剩余时间（秒）
   */
  getRemainingTime(): number {
    return this.remainingTime;
  }
  
  /**
   * 设置剩余时间
   */
  setRemainingTime(time: number): void {
    this.remainingTime = Math.max(0, time);
  }
  
  /**
   * 获取剩余时间（格式化：MM:SS）
   */
  getFormattedTime(): string {
    const minutes = Math.floor(this.remainingTime / 60);
    const seconds = this.remainingTime % 60;
    return `${minutes.toString().padStart(2, '0')}:${seconds.toString().padStart(2, '0')}`;
  }
  
  /**
   * 判断是否正在运行
   */
  getIsRunning(): boolean {
    return this.isRunning;
  }
  
  /**
   * 设置运行状态
   */
  setIsRunning(running: boolean): void {
    this.isRunning = running;
  }
  
  /**
   * 判断是否暂停
   */
  getIsPaused(): boolean {
    return this.isPaused;
  }
  
  /**
   * 设置暂停状态
   */
  setIsPaused(paused: boolean): void {
    this.isPaused = paused;
  }
  
  /**
   * 获取今日完成数
   */
  getTodayCompleted(): number {
    this.checkAndUpdateDate();
    return this.todayCompleted;
  }
  
  /**
   * 增加完成数
   * P0 修复：记录番茄完成时间，用于成就判断
   */
  async incrementCompleted(): Promise<void> {
    this.checkAndUpdateDate();
    this.todayCompleted++;
    this.totalCompleted++;
    
    // P0 修复：记录番茄完成的小时数，用于"早起鸟儿"和"夜猫子"成就判断
    const now = new Date();
    this.lastTomatoHour = now.getHours();
    
    // 添加专注时长
    const focusDuration = this.settings.pomodoroDuration * 60;
    this.totalFocusDuration += focusDuration;
    
    // 更新今日统计
    this.updateDailyStats();
    
    // 检查成就（使用记录的完成时间）
    await this.checkAchievements();
    
    // 保存到偏好设置
    await this.saveToPreferences();
    
    console.info('PomodoroModel incrementCompleted: todayCompleted=', this.todayCompleted, ', totalCompleted=', this.totalCompleted, ', lastUpdateDate=', this.lastUpdateDate, ', lastTomatoHour=', this.lastTomatoHour);
  }
  
  /**
   * 重置番茄钟
   */
  reset(): void {
    this.remainingTime = this.settings.pomodoroDuration * 60;
    this.isRunning = false;
    this.isPaused = false;
  }
  
  /**
   * 检查并更新日期
   * 如果是新的一天，重置完成数
   */
  private checkAndUpdateDate(): void {
    const currentDate = new Date().toLocaleDateString('zh-CN');
    console.info('PomodoroModel checkAndUpdateDate: lastUpdateDate=', this.lastUpdateDate, ', currentDate=', currentDate, ', todayCompleted(before)=', this.todayCompleted);
    
    if (this.lastUpdateDate !== currentDate) {
      // 日期已变化，重置今日完成数
      this.lastUpdateDate = currentDate;
      this.todayCompleted = 0;
      console.info('PomodoroModel checkAndUpdateDate: date changed, reset todayCompleted to 0');
    } else {
      console.info('PomodoroModel checkAndUpdateDate: same day, keep todayCompleted=', this.todayCompleted);
    }
  }
  
  /**
   * 更新每日统计
   * P0 修复：限制只保留最近 30 天数据，防止内存泄漏
   */
  private updateDailyStats(): void {
    const currentDate = new Date().toLocaleDateString('zh-CN');
    const focusDuration = this.settings.pomodoroDuration * 60;
    
    const existingStats = this.dailyStats.get(currentDate);
    if (existingStats) {
      existingStats.completedCount++;
      existingStats.focusDuration += focusDuration;
    } else {
      this.dailyStats.set(currentDate, {
        date: currentDate,
        completedCount: 1,
        focusDuration: focusDuration
      });
      
      // P0 修复：清理超过 30 天的数据，防止内存泄漏
      this.cleanupOldDailyStats(30);
    }
  }
  
  /**
   * 清理旧的每日统计数据
   * P0 修复：只保留最近 N 天的数据
   */
  private cleanupOldDailyStats(keepDays: number): void {
    const cutoffDate = new Date();
    cutoffDate.setDate(cutoffDate.getDate() - keepDays);
    const cutoffDateStr = cutoffDate.toLocaleDateString('zh-CN');
    
    const datesToRemove: string[] = [];
    this.dailyStats.forEach((stats, dateStr) => {
      if (dateStr < cutoffDateStr) {
        datesToRemove.push(dateStr);
      }
    });
    
    datesToRemove.forEach(dateStr => {
      this.dailyStats.delete(dateStr);
    });
    
    if (datesToRemove.length > 0) {
      console.info('PomodoroModel cleanupOldDailyStats: removed', datesToRemove.length, 'old daily stats');
    }
  }
  
  /**
   * 获取设置
   */
  getSettings(): PomodoroSettings {
    return { ...this.settings };
  }
  
  /**
   * 获取深色模式状态
   */
  getIsDarkMode(): boolean {
    return this.settings.isDarkMode;
  }
  
  /**
   * 设置深色模式
   */
  async setIsDarkMode(isDark: boolean): Promise<void> {
    this.settings.isDarkMode = isDark;
    if (this.preferencesInstance) {
      await this.preferencesInstance.put('isDarkMode', isDark);
      await this.preferencesInstance.flush();
    }
  }
  
  /**
   * 重新加载设置（从 Preferences 读取最新值）
   * 用于确保多个页面实例之间的设置同步
   */
  async reloadSettings(): Promise<void> {
    if (!this.preferencesInstance) {
      console.warn('PomodoroModel reloadSettings: preferencesInstance is null, skipping');
      return;
    }
    
    try {
      const pomodoroDuration = await this.preferencesInstance.get('pomodoroDuration', 25) as number || 25;
      const shortBreakDuration = await this.preferencesInstance.get('shortBreakDuration', 5) as number || 5;
      const longBreakDuration = await this.preferencesInstance.get('longBreakDuration', 15) as number || 15;
      const longBreakInterval = await this.preferencesInstance.get('longBreakInterval', 4) as number || 4;
      
      this.settings.pomodoroDuration = pomodoroDuration;
      this.settings.shortBreakDuration = shortBreakDuration;
      this.settings.longBreakDuration = longBreakDuration;
      this.settings.longBreakInterval = longBreakInterval;
      
      console.info('PomodoroModel reloadSettings: settings reloaded from preferences', JSON.stringify(this.settings));
    } catch (error) {
      console.error('PomodoroModel reloadSettings error:', error);
    }
  }
  
  /**
   * 更新设置
   */
  async updateSettings(newSettings: Partial<PomodoroSettings>): Promise<void> {
    this.settings = { ...this.settings, ...newSettings };
    console.info('PomodoroModel updateSettings: settings updated', JSON.stringify(this.settings));
    this.reset(); // 重置计时器以应用新设置
    await this.saveToPreferences();
    console.info('PomodoroModel updateSettings: settings saved to preferences');
  }
  
  /**
   * 重置为默认设置
   */
  async resetSettings(): Promise<void> {
    this.settings = {
      pomodoroDuration: 25,
      shortBreakDuration: 5,
      longBreakDuration: 15,
      longBreakInterval: 4
    };
    this.reset();
    await this.saveToPreferences();
  }
  
  /**
   * 获取成就列表
   */
  getAchievements(): Achievement[] {
    return [...this.achievements];
  }
  
  /**
   * 初始化成就列表
   */
  private initAchievements(): Achievement[] {
    return [
      {
        id: 'first_tomato',
        name: '新手入门',
        description: '完成第 1 个番茄',
        icon: '🌱',
        isUnlocked: false,
        condition: '完成 1 个番茄'
      },
      {
        id: 'persistent_10',
        name: '持之以恒',
        description: '完成 10 个番茄',
        icon: '💪',
        isUnlocked: false,
        condition: '完成 10 个番茄'
      },
      {
        id: 'focus_master_50',
        name: '专注达人',
        description: '完成 50 个番茄',
        icon: '🎯',
        isUnlocked: false,
        condition: '完成 50 个番茄'
      },
      {
        id: 'tomato_master_100',
        name: '番茄大师',
        description: '完成 100 个番茄',
        icon: '👑',
        isUnlocked: false,
        condition: '完成 100 个番茄'
      },
      {
        id: 'early_bird',
        name: '早起鸟儿',
        description: '早上 8 点前完成 1 个番茄',
        icon: '🌅',
        isUnlocked: false,
        condition: '8:00 前完成番茄'
      },
      {
        id: 'night_owl',
        name: '夜猫子',
        description: '晚上 10 点后完成 1 个番茄',
        icon: '🦉',
        isUnlocked: false,
        condition: '22:00 后完成番茄'
      },
      {
        id: 'streak_7',
        name: '连续打卡',
        description: '连续 7 天使用',
        icon: '🔥',
        isUnlocked: false,
        condition: '连续使用 7 天'
      },
      {
        id: 'perfect_day',
        name: '完美一天',
        description: '一天完成 10 个番茄',
        icon: '⭐',
        isUnlocked: false,
        condition: '单日完成 10 个番茄'
      },
      {
        id: 'streak_30',
        name: '坚持不懈',
        description: '连续使用 30 天',
        icon: '🏆',
        isUnlocked: false,
        condition: '连续使用 30 天'
      },
      {
        id: 'legend_1000',
        name: '传奇',
        description: '完成 1000 个番茄',
        icon: '🌟',
        isUnlocked: false,
        condition: '完成 1000 个番茄'
      }
    ];
  }
  
  /**
   * 检查成就解锁状态
   * P0 修复：使用番茄完成时的小时数判断时间相关成就
   */
  async checkAchievements(): Promise<void> {
    if (this.achievements.length === 0) {
      this.achievements = this.initAchievements();
    }
    
    // P0 修复：使用记录的番茄完成时间，而不是当前时间
    // 如果 lastTomatoHour 为 -1（未设置），使用当前时间作为后备
    const tomatoHour = this.lastTomatoHour >= 0 ? this.lastTomatoHour : new Date().getHours();
    let hasNewUnlock = false;
    
    // 检查每个成就
    this.achievements.forEach(achievement => {
      if (achievement.isUnlocked) return;
      
      let shouldUnlock = false;
      
      switch (achievement.id) {
        case 'first_tomato':
          shouldUnlock = this.totalCompleted >= 1;
          break;
        case 'persistent_10':
          shouldUnlock = this.totalCompleted >= 10;
          break;
        case 'focus_master_50':
          shouldUnlock = this.totalCompleted >= 50;
          break;
        case 'tomato_master_100':
          shouldUnlock = this.totalCompleted >= 100;
          break;
        case 'early_bird':
          // P0 修复：使用番茄完成时的小时数判断
          shouldUnlock = this.totalCompleted >= 1 && tomatoHour < 8;
          break;
        case 'night_owl':
          // P0 修复：使用番茄完成时的小时数判断
          shouldUnlock = this.totalCompleted >= 1 && tomatoHour >= 22;
          break;
        case 'streak_7':
          shouldUnlock = this.consecutiveDays >= 7;
          break;
        case 'perfect_day':
          shouldUnlock = this.todayCompleted >= 10;
          break;
        case 'streak_30':
          shouldUnlock = this.consecutiveDays >= 30;
          break;
        case 'legend_1000':
          shouldUnlock = this.totalCompleted >= 1000;
          break;
      }
      
      if (shouldUnlock) {
        achievement.isUnlocked = true;
        achievement.unlockDate = new Date().toLocaleDateString('zh-CN');
        hasNewUnlock = true;
        console.info('PomodoroModel checkAchievements: unlocked', achievement.name);
      }
    });
    
    if (hasNewUnlock) {
      await this.saveToPreferences();
    }
  }
  
  /**
   * 获取统计数据
   */
  getStats(): {
    today: { count: number; duration: number };
    week: DailyStats[];
    month: DailyStats[];
    total: { count: number; duration: number };
    bestDay: DailyStats | null;
  } {
    const today = new Date().toLocaleDateString('zh-CN');
    const todayStats = this.dailyStats.get(today) || { date: today, completedCount: 0, focusDuration: 0 };
    
    // 获取本周统计（最近 7 天）
    const weekStats: DailyStats[] = [];
    for (let i = 6; i >= 0; i--) {
      const date = new Date();
      date.setDate(date.getDate() - i);
      const dateStr = date.toLocaleDateString('zh-CN');
      weekStats.push(this.dailyStats.get(dateStr) || { date: dateStr, completedCount: 0, focusDuration: 0 });
    }
    
    // 获取本月统计（最近 30 天）
    const monthStats: DailyStats[] = [];
    for (let i = 29; i >= 0; i--) {
      const date = new Date();
      date.setDate(date.getDate() - i);
      const dateStr = date.toLocaleDateString('zh-CN');
      monthStats.push(this.dailyStats.get(dateStr) || { date: dateStr, completedCount: 0, focusDuration: 0 });
    }
    
    // 找出最佳记录
    let bestDay: DailyStats | null = null;
    this.dailyStats.forEach(stats => {
      if (!bestDay || stats.completedCount > bestDay.completedCount) {
        bestDay = stats;
      }
    });
    
    return {
      today: {
        count: todayStats.completedCount,
        duration: todayStats.focusDuration
      },
      week: weekStats,
      month: monthStats,
      total: {
        count: this.totalCompleted,
        duration: this.totalFocusDuration
      },
      bestDay: bestDay
    };
  }
  
  /**
   * 获取总完成数
   */
  getTotalCompleted(): number {
    return this.totalCompleted;
  }
  
  /**
   * 获取总专注时长（秒）
   */
  getTotalFocusDuration(): number {
    return this.totalFocusDuration;
  }
  
  /**
   * 获取连续天数
   */
  getConsecutiveDays(): number {
    return this.consecutiveDays;
  }
  
  /**
   * 更新连续天数
   */
  private updateConsecutiveDays(): void {
    const currentDate = new Date().toLocaleDateString('zh-CN');
    
    if (this.lastUseDate === currentDate) {
      // 今天已经更新过
      return;
    }
    
    const yesterday = new Date();
    yesterday.setDate(yesterday.getDate() - 1);
    const yesterdayStr = yesterday.toLocaleDateString('zh-CN');
    
    if (this.lastUseDate === yesterdayStr) {
      // 连续使用
      this.consecutiveDays++;
    } else if (this.lastUseDate !== currentDate) {
      // 中断后重新开始
      this.consecutiveDays = 1;
    }
    
    this.lastUseDate = currentDate;
  }
  
  /**
   * 保存到偏好设置
   */
  async saveToPreferences(): Promise<void> {
    if (!this.preferencesInstance) {
      console.error('PomodoroModel saveToPreferences: preferencesInstance is null');
      return;
    }
    
    try {
      this.updateConsecutiveDays();
      
      // 保存统计数据
      await this.preferencesInstance.put('totalCompleted', this.totalCompleted);
      await this.preferencesInstance.put('totalFocusDuration', this.totalFocusDuration);
      await this.preferencesInstance.put('consecutiveDays', this.consecutiveDays);
      await this.preferencesInstance.put('lastUseDate', this.lastUseDate);
      await this.preferencesInstance.put('todayCompleted', this.todayCompleted);
      await this.preferencesInstance.put('lastUpdateDate', this.lastUpdateDate);
      // P0 修复：保存最后一个番茄完成的小时数
      await this.preferencesInstance.put('lastTomatoHour', this.lastTomatoHour);
      
      // 保存设置
      await this.preferencesInstance.put('pomodoroDuration', this.settings.pomodoroDuration);
      await this.preferencesInstance.put('shortBreakDuration', this.settings.shortBreakDuration);
      await this.preferencesInstance.put('longBreakDuration', this.settings.longBreakDuration);
      await this.preferencesInstance.put('longBreakInterval', this.settings.longBreakInterval);
      
      console.info('PomodoroModel saveToPreferences: settings saved', JSON.stringify(this.settings));
      
      // 保存成就状态
      const achievementsData = this.achievements.map(a => ({
        id: a.id,
        isUnlocked: a.isUnlocked,
        unlockDate: a.unlockDate
      }));
      await this.preferencesInstance.put('achievements', JSON.stringify(achievementsData));
      
      // 保存每日统计（最近 30 天）
      const statsData: Array<{date: string, count: number, duration: number}> = [];
      const now = new Date();
      for (let i = 0; i < 30; i++) {
        const date = new Date();
        date.setDate(date.getDate() - i);
        const dateStr = date.toLocaleDateString('zh-CN');
        const stats = this.dailyStats.get(dateStr);
        if (stats) {
          statsData.push({
            date: dateStr,
            count: stats.completedCount,
            duration: stats.focusDuration
          });
        }
      }
      await this.preferencesInstance.put('dailyStats', JSON.stringify(statsData));
      
      // 确保数据持久化
      await this.preferencesInstance.flush();
      console.info('PomodoroModel saveToPreferences: flush completed, totalCompleted=', this.totalCompleted, ', todayCompleted=', this.todayCompleted, ', lastUpdateDate=', this.lastUpdateDate);
    } catch (error) {
      console.error('PomodoroModel saveToPreferences error:', error);
    }
  }
  
  /**
   * 从偏好设置加载
   */
  async loadFromPreferences(): Promise<void> {
    if (!this.preferencesInstance) {
      console.error('PomodoroModel loadFromPreferences: preferencesInstance is null');
      return;
    }
    
    try {
      // 加载统计数据
      this.totalCompleted = await this.preferencesInstance.get('totalCompleted', 0) as number || 0;
      this.totalFocusDuration = await this.preferencesInstance.get('totalFocusDuration', 0) as number || 0;
      this.consecutiveDays = await this.preferencesInstance.get('consecutiveDays', 0) as number || 0;
      this.lastUseDate = await this.preferencesInstance.get('lastUseDate', '') as string || '';
      this.todayCompleted = await this.preferencesInstance.get('todayCompleted', 0) as number || 0;
      this.lastUpdateDate = await this.preferencesInstance.get('lastUpdateDate', '') as string || '';
      // P0 修复：加载最后一个番茄完成的小时数
      this.lastTomatoHour = await this.preferencesInstance.get('lastTomatoHour', -1) as number || -1;
      
      // 加载设置
      this.settings.pomodoroDuration = await this.preferencesInstance.get('pomodoroDuration', 25) as number || 25;
      this.settings.shortBreakDuration = await this.preferencesInstance.get('shortBreakDuration', 5) as number || 5;
      this.settings.longBreakDuration = await this.preferencesInstance.get('longBreakDuration', 15) as number || 15;
      this.settings.longBreakInterval = await this.preferencesInstance.get('longBreakInterval', 4) as number || 4;
      
      console.info('PomodoroModel loadFromPreferences: settings loaded', JSON.stringify(this.settings), ', totalCompleted=', this.totalCompleted, ', todayCompleted=', this.todayCompleted, ', lastUpdateDate=', this.lastUpdateDate);
      
      // 加载成就
      const achievementsData = await this.preferencesInstance.get('achievements', '[]') as string || '[]';
      const loadedAchievements = JSON.parse(achievementsData);
      this.achievements = this.initAchievements();
      loadedAchievements.forEach((loaded: any) => {
        const achievement = this.achievements.find(a => a.id === loaded.id);
        if (achievement) {
          achievement.isUnlocked = loaded.isUnlocked;
          achievement.unlockDate = loaded.unlockDate;
        }
      });
      
      // 加载每日统计
      const statsData = await this.preferencesInstance.get('dailyStats', '[]') as string || '[]';
      const loadedStats = JSON.parse(statsData);
      loadedStats.forEach((stat: any) => {
        this.dailyStats.set(stat.date, {
          date: stat.date,
          completedCount: stat.count,
          focusDuration: stat.duration
        });
      });
      
      // Bug 2 修复：检查并更新日期（只在日期真正变化时重置 todayCompleted）
      // 注意：此时 lastUpdateDate 已从 Preferences 加载，如果是同一天则不会重置
      const dateChanged = (this.lastUpdateDate !== new Date().toLocaleDateString('zh-CN'));
      this.checkAndUpdateDate();
      
      // 如果日期变化导致 todayCompleted 重置，立即保存以确保持久化
      if (dateChanged) {
        await this.saveToPreferences();
        console.info('PomodoroModel loadFromPreferences: date changed, saved reset todayCompleted');
      }
      
      console.info('PomodoroModel loadFromPreferences: data loaded successfully, totalCompleted=', this.totalCompleted, ', todayCompleted=', this.todayCompleted, ', lastUpdateDate=', this.lastUpdateDate);
    } catch (error) {
      console.error('PomodoroModel loadFromPreferences error:', error);
    }
  }
  
  /**
   * 获取标准时长
   */
  static getStandardDuration(): number {
    return PomodoroModel.STANDARD_POMODORO_DURATION;
  }
}
