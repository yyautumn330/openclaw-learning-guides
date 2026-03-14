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

/**
 * 节奏模式枚举
 */
export enum RhythmMode {
  /** 匀速 - 固定BPM */
  CONSTANT = 'constant',

  /** 渐进加速 - 从起始BPM线性增加到目标BPM */
  GRADUAL_ACCEL = 'gradual_accel',

  /** 间歇训练 - 高BPM冲刺 + 低BPM恢复，循环 */
  INTERVAL = 'interval'
}

/**
 * 节奏模式配置接口
 */
export interface RhythmConfig {
  /** 节奏模式 */
  mode: RhythmMode;

  /** 起始BPM */
  startBpm: number;

  /** 目标BPM（渐进加速/间歇训练的高强度段） */
  targetBpm: number;

  /** 渐进加速时长（分钟） */
  accelDurationMinutes: number;

  /** 间歇训练冲刺时长（秒） */
  sprintDurationSeconds: number;

  /** 间歇训练恢复时长（秒） */
  recoveryDurationSeconds: number;

  /** 间歇训练循环次数 */
  intervalCycles: number;
}

/**
 * 默认匀速模式配置
 */
export const CONSTANT_CONFIG: RhythmConfig = {
  mode: RhythmMode.CONSTANT,
  startBpm: 160,
  targetBpm: 160,
  accelDurationMinutes: 0,
  sprintDurationSeconds: 0,
  recoveryDurationSeconds: 0,
  intervalCycles: 0
};

/**
 * 默认渐进加速模式配置
 * 从 160 BPM 逐渐加速到 180 BPM，持续 30 分钟
 */
export const GRADUAL_ACCEL_CONFIG: RhythmConfig = {
  mode: RhythmMode.GRADUAL_ACCEL,
  startBpm: 160,
  targetBpm: 180,
  accelDurationMinutes: 30,
  sprintDurationSeconds: 0,
  recoveryDurationSeconds: 0,
  intervalCycles: 0
};

/**
 * 默认间歇训练配置
 * 180 BPM 冲刺 60 秒 → 160 BPM 恢复 120 秒，循环 5 次
 */
export const INTERVAL_CONFIG: RhythmConfig = {
  mode: RhythmMode.INTERVAL,
  startBpm: 160,
  targetBpm: 180,
  accelDurationMinutes: 0,
  sprintDurationSeconds: 60,
  recoveryDurationSeconds: 120,
  intervalCycles: 5
};

/**
 * 节奏模式计算器
 * 根据当前时间和模式计算实时BPM
 */
export class RhythmCalculator {
  private config: RhythmConfig;
  private startTime: number = 0;

  constructor(config: RhythmConfig) {
    this.config = config;
  }

  /**
   * 开始节奏计算
   */
  start(): void {
    this.startTime = Date.now();
  }

  /**
   * 获取当前BPM
   */
  getCurrentBpm(): number {
    const elapsedMs = Date.now() - this.startTime;
    const elapsedSeconds = elapsedMs / 1000;

    switch (this.config.mode) {
      case RhythmMode.CONSTANT:
        return this.config.startBpm;

      case RhythmMode.GRADUAL_ACCEL:
        return this.calculateGradualAccelBpm(elapsedSeconds);

      case RhythmMode.INTERVAL:
        return this.calculateIntervalBpm(elapsedSeconds);

      default:
        return this.config.startBpm;
    }
  }

  /**
   * 计算渐进加速BPM
   * 线性插值从 startBpm 到 targetBpm
   */
  private calculateGradualAccelBpm(elapsedSeconds: number): number {
    const durationSeconds = this.config.accelDurationMinutes * 60;
    const progress = Math.min(elapsedSeconds / durationSeconds, 1);

    const bpmRange = this.config.targetBpm - this.config.startBpm;
    const currentBpm = this.config.startBpm + (bpmRange * progress);

    return Math.round(currentBpm);
  }

  /**
   * 计算间歇训练BPM
   * 冲刺段 → 恢复段，循环
   */
  private calculateIntervalBpm(elapsedSeconds: number): number {
    const cycleDuration = this.config.sprintDurationSeconds + this.config.recoveryDurationSeconds;
    const cycleProgress = elapsedSeconds % cycleDuration;

    // 冲刺段（高强度）
    if (cycleProgress < this.config.sprintDurationSeconds) {
      return this.config.targetBpm;
    }
    // 恢复段（低强度）
    else {
      return this.config.startBpm;
    }
  }

  /**
   * 获取当前节奏阶段描述
   */
  getCurrentPhase(): string {
    const elapsedMs = Date.now() - this.startTime;
    const elapsedSeconds = elapsedMs / 1000;

    switch (this.config.mode) {
      case RhythmMode.CONSTANT:
        return '匀速保持';

      case RhythmMode.GRADUAL_ACCEL:
        const durationSeconds = this.config.accelDurationMinutes * 60;
        if (elapsedSeconds >= durationSeconds) {
          return '已达目标';
        }
        const progress = Math.round((elapsedSeconds / durationSeconds) * 100);
        return `加速中 ${progress}%`;

      case RhythmMode.INTERVAL:
        const cycleDuration = this.config.sprintDurationSeconds + this.config.recoveryDurationSeconds;
        const cycleProgress = elapsedSeconds % cycleDuration;
        const cycleNumber = Math.floor(elapsedSeconds / cycleDuration) + 1;

        if (cycleProgress < this.config.sprintDurationSeconds) {
          return `冲刺 ${cycleNumber}/${this.config.intervalCycles}`;
        } else {
          return `恢复 ${cycleNumber}/${this.config.intervalCycles}`;
        }

      default:
        return '未知';
    }
  }

  /**
   * 获取节奏模式名称
   */
  public static getModeName(mode: RhythmMode): string {
    switch (mode) {
      case RhythmMode.CONSTANT:
        return '匀速模式';
      case RhythmMode.GRADUAL_ACCEL:
        return '渐进加速';
      case RhythmMode.INTERVAL:
        return '间歇训练';
      default:
        return '未知模式';
    }
  }

  /**
   * 更新配置
   */
  updateConfig(config: RhythmConfig): void {
    this.config = config;
    this.startTime = Date.now(); // 重置开始时间
  }
}