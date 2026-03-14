/*
 * Copyright (c) 2026 Huawei Device Co., Ltd.
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not obtain a copy of the License at
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
import { RhythmMode, RhythmCalculator, type RhythmConfig } from './RhythmMode';

const TAG = 'PaceBpmLinkage';
const DOMAIN = 0x0000;

/**
 * 配速数据接口
 */
export interface PaceData {
  /** 当前配速（分钟/公里） */
  currentPace: number;

  /** 平均配速（分钟/公里） */
  averagePace: number;

  /** 距离（米） */
  distance: number;

  /** 时长（秒） */
  duration: number;
}

/**
 * 配速BPM联动配置接口
 */
export interface PaceBpmConfig {
  /** 是否启用联动 */
  enabled: boolean;

  /** 目标配速（分钟/公里） */
  targetPace: number;

  /** 配速调整灵敏度（0.1-1.0） */
  sensitivity: number;

  /** 最小BPM */
  minBpm: number;

  /** 最大BPM */
  maxBpm: number;

  /** BPM调整平滑度（0.1-1.0，越小越平滑） */
  smoothing: number;
}

/**
 * 默认联动配置
 * 目标配速 6:00/km（10公里/小时），对应 180 BPM
 */
export const DEFAULT_PACE_BPM_CONFIG: PaceBpmConfig = {
  enabled: false,
  targetPace: 6.0,
  sensitivity: 0.5,
  minBpm: 140,
  maxBpm: 200,
  smoothing: 0.3
};

/**
 * 配速BPM联动服务
 * 根据实时配速自动调整BPM
 */
export class PaceBpmLinkageService {
  private static instance: PaceBpmLinkageService;
  private config: PaceBpmConfig;
  private currentBpm: number = 160;
  private targetBpm: number = 160;

  private constructor() {
    this.config = { ...DEFAULT_PACE_BPM_CONFIG };
  }

  static getInstance(): PaceBpmLinkageService {
    if (!PaceBpmLinkageService.instance) {
      PaceBpmLinkageService.instance = new PaceBpmLinkageService();
    }
    return PaceBpmLinkageService.instance;
  }

  /**
   * 设置联动配置
   */
  setConfig(config: Partial<PaceBpmConfig>): void {
    this.config = { ...this.config, ...config };
    hilog.info(DOMAIN, TAG, 'Config updated: enabled=%s', this.config.enabled);
  }

  /**
   * 获取配置
   */
  getConfig(): PaceBpmConfig {
    return { ...this.config };
  }

  /**
   * 根据配速计算目标BPM
   *
   * 算法：
   * 1. 配速转速度（公里/小时）= 60 / pace
   * 2. 速度转BPM = speed * 18 （近似公式）
   * 3. 修正后：BPM = (60 / pace) * 18
   *
   * 示例：
   * - 6:00/km → 10 km/h → 180 BPM
   * - 5:00/km → 12 km/h → 216 BPM（限制到200）
   * - 8:00/km → 7.5 km/h → 135 BPM（限制到140）
   */
  private calculateTargetBpm(pace: number): number {
    const speed = 60 / pace; // 公里/小时
    const bpm = speed * 18; // 转换为BPM

    // 限制范围
    return Math.max(this.config.minBpm, Math.min(this.config.maxBpm, bpm));
  }

  /**
   * 更新BPM（根据配速数据）
   * 返回调整后的BPM
   */
  updateBpm(paceData: PaceData): number {
    if (!this.config.enabled) {
      hilog.debug(DOMAIN, TAG, 'Linkage disabled');
      return this.currentBpm;
    }

    // 计算目标BPM
    this.targetBpm = this.calculateTargetBpm(paceData.currentPace);

    // 平滑调整BPM
    const adjustment = (this.targetBpm - this.currentBpm) * this.config.smoothing;
    this.currentBpm = this.currentBpm + adjustment;

    hilog.info(DOMAIN, TAG, 'Pace: %.2f → BPM: %.1f (target: %.1f)',
      paceData.currentPace, this.currentBpm, this.targetBpm);

    return Math.round(this.currentBpm);
  }

  /**
   * 重置BPM
   */
  resetBpm(bpm: number): void {
    this.currentBpm = bpm;
    this.targetBpm = bpm;
    hilog.info(DOMAIN, TAG, 'BPM reset to %d', bpm);
  }

  /**
   * 获取当前BPM
   */
  getCurrentBpm(): number {
    return Math.round(this.currentBpm);
  }

  /**
   * 获取目标BPM
   */
  getTargetBpm(): number {
    return Math.round(this.targetBpm);
  }

  /**
   * 检查是否需要调整BPM
   */
  needsAdjustment(paceData: PaceData): boolean {
    if (!this.config.enabled) return false;

    const targetBpm = this.calculateTargetBpm(paceData.currentPace);
    const difference = Math.abs(targetBpm - this.currentBpm);

    // 只有差异大于阈值才调整（避免频繁微调）
    return difference > 2;
  }
}

export const paceBpmLinkageService = PaceBpmLinkageService.getInstance();