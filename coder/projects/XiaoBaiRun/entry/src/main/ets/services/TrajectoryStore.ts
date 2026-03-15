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
import { TrajectoryPoint, RunRecord, KeyPoint } from '../models/TrajectoryModel';

const TAG = 'TrajectoryStore';
const DOMAIN = 0x0000;

/**
 * 轨迹存储服务
 */
export class TrajectoryStore {
  private static instance: TrajectoryStore;
  
  private context: common.UIAbilityContext | null = null;
  private cacheBuffer: TrajectoryPoint[] = [];
  private readonly CACHE_SIZE = 100;  // 缓存大小
  private readonly FLUSH_INTERVAL = 10; // 刷新间隔 (点数)

  private constructor() {}

  static getInstance(): TrajectoryStore {
    if (!TrajectoryStore.instance) {
      TrajectoryStore.instance = new TrajectoryStore();
    }
    return TrajectoryStore.instance;
  }

  /**
   * 设置 Context
   */
  setContext(context: common.UIAbilityContext): void {
    this.context = context;
    hilog.info(DOMAIN, TAG, 'Context set');
  }

  /**
   * 添加轨迹点到缓存
   */
  async addPoint(point: TrajectoryPoint): Promise<void> {
    this.cacheBuffer.push(point);
    
    // 达到刷新间隔时保存
    if (this.cacheBuffer.length >= this.FLUSH_INTERVAL) {
      await this.flushCache();
    }
  }

  /**
   * 刷新缓存到文件
   */
  async flushCache(): Promise<void> {
    if (this.cacheBuffer.length === 0) return;
    
    try {
      // 获取缓存文件路径
      const cachePath = this.getCachePath();
      
      // 读取现有缓存
      let existing: TrajectoryPoint[] = [];
      try {
        const content = await this.readFile(cachePath);
        existing = JSON.parse(content);
      } catch (e) {
        // 文件不存在，使用空数组
      }
      
      // 合并并保存
      const merged = [...existing, ...this.cacheBuffer];
      await this.writeFile(cachePath, JSON.stringify(merged));
      
      hilog.debug(DOMAIN, TAG, 'Cache flushed: %d points', this.cacheBuffer.length);
      
      // 清空缓存
      this.cacheBuffer = [];
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Flush cache failed: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 保存运动记录
   */
  async saveRecord(record: RunRecord, trajectory: TrajectoryPoint[]): Promise<string> {
    if (!this.context) {
      throw new Error('Context not set');
    }

    try {
      // 创建记录目录
      const recordDir = `${this.context.filesDir}/running/records`;
      await this.ensureDir(recordDir);
      
      // 生成文件名
      const timestamp = new Date(record.startTime).toISOString().replace(/[:.]/g, '-');
      const baseName = `run_${timestamp}`;
      
      // 保存 JSON
      const jsonPath = `${recordDir}/${baseName}.json`;
      const jsonData = {
        record,
        trajectory
      };
      await this.writeFile(jsonPath, JSON.stringify(jsonData, null, 2));
      
      hilog.info(DOMAIN, TAG, 'Record saved: %s', jsonPath);
      
      return jsonPath;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Save record failed: %{public}s', JSON.stringify(error));
      throw error;
    }
  }

  /**
   * 加载运动记录
   */
  async loadRecord(jsonPath: string): Promise<{ record: RunRecord; trajectory: TrajectoryPoint[] }> {
    try {
      const content = await this.readFile(jsonPath);
      const data = JSON.parse(content);
      
      hilog.info(DOMAIN, TAG, 'Record loaded: %s', jsonPath);
      
      return data;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Load record failed: %{public}s', JSON.stringify(error));
      throw error;
    }
  }

  /**
   * 列出所有记录
   */
  async listRecords(): Promise<RunRecord[]> {
    if (!this.context) {
      return [];
    }

    try {
      const recordDir = `${this.context.filesDir}/running/records`;
      const files = await this.listFiles(recordDir, '.json');
      
      const records: RunRecord[] = [];
      
      for (const file of files) {
        try {
          const content = await this.readFile(file);
          const data = JSON.parse(content);
          if (data.record) {
            records.push(data.record);
          }
        } catch (e) {
          // 跳过无效文件
        }
      }
      
      // 按时间倒序排列
      records.sort((a, b) => b.startTime - a.startTime);
      
      hilog.info(DOMAIN, TAG, 'Listed %d records', records.length);
      
      return records;
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'List records failed: %{public}s', JSON.stringify(error));
      return [];
    }
  }

  /**
   * 删除记录
   */
  async deleteRecord(recordId: string): Promise<void> {
    if (!this.context) return;
    
    try {
      const recordDir = `${this.context.filesDir}/running/records`;
      const files = await this.listFiles(recordDir, '.json');
      
      for (const file of files) {
        if (file.includes(recordId)) {
          await this.deleteFile(file);
          hilog.info(DOMAIN, TAG, 'Record deleted: %s', file);
        }
      }
    } catch (error) {
      hilog.error(DOMAIN, TAG, 'Delete record failed: %{public}s', JSON.stringify(error));
    }
  }

  /**
   * 恢复缓存的轨迹
   */
  async recoverTrajectory(): Promise<TrajectoryPoint[]> {
    try {
      const cachePath = this.getCachePath();
      const content = await this.readFile(cachePath);
      const points: TrajectoryPoint[] = JSON.parse(content);
      
      hilog.info(DOMAIN, TAG, 'Recovered %d cached points', points.length);
      
      // 清除缓存
      await this.deleteFile(cachePath);
      
      return points;
    } catch (error) {
      hilog.debug(DOMAIN, TAG, 'No cached trajectory to recover');
      return [];
    }
  }

  /**
   * 清除缓存
   */
  async clearCache(): Promise<void> {
    this.cacheBuffer = [];
    
    try {
      const cachePath = this.getCachePath();
      await this.deleteFile(cachePath);
      hilog.info(DOMAIN, TAG, 'Cache cleared');
    } catch (e) {
      // ignore
    }
  }

  // ========== 私有方法 ==========

  private getCachePath(): string {
    if (!this.context) {
      return '/tmp/trajectory_cache.json';
    }
    return `${this.context.filesDir}/running/cache/current_trajectory.json`;
  }

  private async ensureDir(path: string): Promise<void> {
    // 使用 fs 模块确保目录存在
    const fs = await import('@ohos.file.fs');
    try {
      fs.accessSync(path);
    } catch (e) {
      fs.mkdirSync(path, true);
    }
  }

  private async readFile(path: string): Promise<string> {
    const fs = await import('@ohos.file.fs');
    const file = fs.openSync(path, fs.OpenMode.READ_ONLY);
    const stat = fs.statSync(path);
    const buffer = new ArrayBuffer(stat.size);
    fs.readSync(file.fd, buffer);
    fs.closeSync(file);
    return String.fromCharCode(...new Uint8Array(buffer));
  }

  private async writeFile(path: string, content: string): Promise<void> {
    const fs = await import('@ohos.file.fs');
    const file = fs.openSync(path, fs.OpenMode.CREATE | fs.OpenMode.WRITE_ONLY);
    const encoder = new TextEncoder();
    const buffer = encoder.encode(content).buffer;
    fs.writeSync(file.fd, buffer);
    fs.closeSync(file);
  }

  private async deleteFile(path: string): Promise<void> {
    const fs = await import('@ohos.file.fs');
    try {
      fs.unlinkSync(path);
    } catch (e) {
      // ignore
    }
  }

  private async listFiles(dir: string, extension: string): Promise<string[]> {
    const fs = await import('@ohos.file.fs');
    const files: string[] = [];
    
    try {
      const list = fs.listFileSync(dir);
      for (const name of list) {
        if (name.endsWith(extension)) {
          files.push(`${dir}/${name}`);
        }
      }
    } catch (e) {
      // 目录不存在
    }
    
    return files;
  }
}

export const trajectoryStore = TrajectoryStore.getInstance();