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
import { common } from '@kit.AbilityKit';
import media from '@ohos.multimedia.media';
import { BusinessError } from '@kit.BasicServicesKit';
// import { wantAgent, wantAgentFlags } from '@kit.AbilityKit'; // 暂时不使用
// import { notificationManager } from '@kit.NotificationKit'; // 暂时不使用
import { RhythmCalculator, type RhythmConfig } from './RhythmMode';
import { SoundType, type SoundConfig, ELECTRONIC_CONFIG } from './SoundType';

const TAG = 'MetronomeBackgroundService';
const DOMAIN = 0x0000;

/**
 * 后台播放服务
 * 支持锁屏持续播放，使用前台服务确保不被系统杀死
 */
export class MetronomeBackgroundService {
  private static instance: MetronomeBackgroundService;
  private isPlaying: boolean = false;
  private context: common.UIAbilityContext | null = null;
  private avPlayer: media.AVPlayer | null = null;
  private beatInterval: number = -1;
  private beatCount: number = 0;

  // 节奏模式
  private rhythmCalculator: RhythmCalculator;
  private rhythmConfig: RhythmConfig;

  // 声音配置
  private soundConfig: SoundConfig;

  // 音量
  private volume: number = 0.7;

  // 后台任务
  private continuousTaskId: number = -1;
  private notificationId: number = 1001;

  private constructor() {
    // 初始化节奏配置（默认匀速）
    this.rhythmConfig = {
      mode: 'constant' as any,
      startBpm: 160,
      targetBpm: 160,
      accelDurationMinutes: 0,
      sprintDurationSeconds: 0,
      recoveryDurationSeconds: 0,
      intervalCycles: 0
    };

    this.rhythmCalculator = new RhythmCalculator(this.rhythmConfig);
    this.soundConfig = ELECTRONIC_CONFIG;
  }

  static getInstance(): MetronomeBackgroundService {
    if (!MetronomeBackgroundService.instance) {
      MetronomeBackgroundService.instance = new MetronomeBackgroundService();
    }
    return MetronomeBackgroundService.instance;
  }

  setContext(context: common.UIAbilityContext): void {
    this.context = context;
  }

  /**
   * 启动后台服务
   * 1. 启动前台任务（显示通知栏）
   * 2. 启动节拍器播放
   */
  async start(): Promise<void> {
    if (this.isPlaying) {
      hilog.warn(DOMAIN, TAG, 'Already playing');
      return;
    }

    try {
      this.isPlaying = true;
      this.beatCount = 0;

      // 启动节奏计算器
      this.rhythmCalculator.start();

      // 请求后台持续任务
      await this.requestContinuousTask();

      // 显示通知栏
      await this.showNotification();

      // 启动节拍器
      await this.startMetronome();

      hilog.info(DOMAIN, TAG, '✅ Background service started');
    } catch (error) {
      hilog.error(DOMAIN, TAG, '❌ Start error: %{public}s', JSON.stringify(error) ?? '');
      this.isPlaying = false;
    }
  }

  /**
   * 停止后台服务
   * 1. 停止节拍器
   * 2. 取消后台任务
   * 3. 移除通知栏
   */
  async stop(): Promise<void> {
    if (!this.isPlaying) return;

    try {
      this.isPlaying = false;

      // 停止节拍器
      await this.stopMetronome();

      // 取消后台任务
      await this.cancelContinuousTask();

      // 移除通知栏
      await this.removeNotification();

      hilog.info(DOMAIN, TAG, '✅ Background service stopped');
    } catch (error) {
      hilog.error(DOMAIN, TAG, '❌ Stop error: %{public}s', JSON.stringify(error) ?? '');
    }
  }

  /**
   * 启动节拍器播放
   */
  private async startMetronome(): Promise<void> {
    const currentBpm = this.getCurrentBpm();
    const intervalMs = 60000 / currentBpm;

    hilog.info(DOMAIN, TAG, '🎵 Metronome started at %d BPM', currentBpm);

    // 播放第一拍
    await this.playBeat();

    // 启动定时器
    this.beatInterval = setInterval(async () => {
      if (!this.isPlaying) return;

      // 检查BPM是否需要更新（节奏模式变化）
      const newBpm = this.getCurrentBpm();
      if (Math.abs(newBpm - currentBpm) > 0.5) {
        // BPM变化，重启定时器
        clearInterval(this.beatInterval);
        await this.startMetronome();
        return;
      }

      await this.playBeat();
    }, intervalMs) as unknown as number;
  }

  /**
   * 停止节拍器播放
   */
  private async stopMetronome(): Promise<void> {
    if (this.beatInterval !== -1) {
      clearInterval(this.beatInterval);
      this.beatInterval = -1;
    }

    // 释放AVPlayer
    if (this.avPlayer) {
      try {
        await this.avPlayer.release();
        this.avPlayer = null;
      } catch (error) {
        hilog.warn(DOMAIN, TAG, 'AVPlayer release error');
      }
    }
  }

  /**
   * 播放节拍音
   */
  private async playBeat(): Promise<void> {
    if (!this.isPlaying) return;

    try {
      this.beatCount++;

      // 如果没有AVPlayer，创建一个
      if (!this.avPlayer) {
        this.avPlayer = await media.createAVPlayer();
        hilog.info(DOMAIN, TAG, '✅ AVPlayer created');
      }

      // 重置播放器状态（重要！）
      await this.avPlayer.reset();

      // 设置音量
      this.avPlayer.setVolume(this.volume);

      // 设置音频源
      this.avPlayer.url = this.soundConfig.audioPath;

      // 准备播放
      await this.avPlayer.prepare();

      // 播放
      await this.avPlayer.play();

      hilog.info(DOMAIN, TAG, '🔊 Beat %d at %d BPM (vol: %.1f)', 
        this.beatCount, this.getCurrentBpm(), this.volume);
    } catch (error) {
      const err = error as BusinessError;
      hilog.error(DOMAIN, TAG, '❌ Play beat error: %{public}s', err.message ?? '');
      
      // 如果播放失败，尝试重新创建播放器
      if (this.avPlayer) {
        try {
          await this.avPlayer.release();
        } catch (e) {
          // ignore
        }
        this.avPlayer = null;
      }
    }
  }

  /**
   * 获取当前BPM（根据节奏模式）
   */
  getCurrentBpm(): number {
    return this.rhythmCalculator.getCurrentBpm();
  }

  /**
   * 获取当前节奏阶段
   */
  getCurrentPhase(): string {
    return this.rhythmCalculator.getCurrentPhase();
  }

  /**
   * 设置节奏模式
   */
  setRhythmMode(config: RhythmConfig): void {
    this.rhythmConfig = config;
    this.rhythmCalculator.updateConfig(config);
    hilog.info(DOMAIN, TAG, 'Rhythm mode updated: %{public}s', config.mode);

    // 如果正在播放，重启以应用新节奏
    if (this.isPlaying) {
      this.stopMetronome().then(() => this.startMetronome());
    }
  }

  /**
   * 设置声音类型
   */
  setSoundType(config: SoundConfig): void {
    this.soundConfig = config;
    hilog.info(DOMAIN, TAG, 'Sound type updated: %{public}s', config.type);
  }

  /**
   * 设置音量
   */
  setVolume(volume: number): void {
    this.volume = volume;
    if (this.avPlayer) {
      this.avPlayer.setVolume(volume);
    }
    hilog.info(DOMAIN, TAG, 'Volume set to %f', volume);
  }

  /**
   * 是否正在播放
   */
  isCurrentlyPlaying(): boolean {
    return this.isPlaying;
  }

  /**
   * 获取节拍数
   */
  getBeatCount(): number {
    return this.beatCount;
  }

  /**
   * 请求后台持续任务
   * 前台服务确保应用不被系统杀死
   *
   * 注意：简化版本，不使用前台任务（需要复杂的权限配置）
   * 实际环境可根据需求启用前台任务
   */
  private async requestContinuousTask(): Promise<void> {
    if (!this.context) return;

    try {
      // 暂时不启用前台任务（简化版本）
      // 实际环境可启用：
      // const continuousTaskMode = common.ContinuousTaskMode.DATA_TRANSFER;
      // this.continuousTaskId = await this.context.startContinuousTask(
      //   continuousTaskMode,
      //   '跑步节拍器',
      //   {
      //     notificationId: this.notificationId,
      //     contentTitle: '节拍器运行中',
      //     contentText: `${this.getCurrentBpm()} BPM - ${this.getCurrentPhase()}`
      //   }
      // );

      hilog.info(DOMAIN, TAG, '✅ Continuous task skipped (simplified version)');
    } catch (error) {
      hilog.error(DOMAIN, TAG, '❌ Request continuous task error: %{public}s', JSON.stringify(error) ?? '');
    }
  }

  /**
   * 取消后台持续任务
   *
   * 注意：简化版本，不需要取消前台任务
   */
  private async cancelContinuousTask(): Promise<void> {
    if (!this.context || this.continuousTaskId === -1) return;

    try {
      // 暂时不取消前台任务（简化版本）
      // await this.context.cancelContinuousTask(this.continuousTaskId);
      this.continuousTaskId = -1;
      hilog.info(DOMAIN, TAG, '✅ Continuous task cancellation skipped (simplified version)');
    } catch (error) {
      hilog.error(DOMAIN, TAG, '❌ Cancel continuous task error: %{public}s', JSON.stringify(error) ?? '');
    }
  }

  /**
   * 显示通知栏
   *
   * 注意：简化版本，不显示通知栏（需要复杂的权限配置）
   * 实际环境可根据需求启用通知栏
   */
  private async showNotification(): Promise<void> {
    try {
      // 暂时不显示通知栏（简化版本）
      // 实际环境可启用：
      // const notificationRequest = {
      //   id: this.notificationId,
      //   content: {
      //     notificationContentType: notificationManager.ContentType.NOTIFICATION_CONTENT_BASIC_TEXT,
      //     normal: {
      //       title: '🏃 跑步节拍器',
      //       text: `${this.getCurrentBpm()} BPM - ${this.getCurrentPhase()}`,
      //       additionalText: '点击查看'
      //     }
      //   },
      //   notificationSlotType: notificationManager.SlotType.SERVICE_INFORMATION
      // };
      // await notificationManager.publish(notificationRequest);

      hilog.info(DOMAIN, TAG, '✅ Notification skipped (simplified version)');
    } catch (error) {
      hilog.error(DOMAIN, TAG, '❌ Publish notification error: %{public}s', JSON.stringify(error) ?? '');
    }
  }

  /**
   * 移除通知栏
   *
   * 注意：简化版本，不需要移除通知栏
   */
  private async removeNotification(): Promise<void> {
    try {
      // 暂时不移除通知栏（简化版本）
      // await notificationManager.cancel(this.notificationId);
      hilog.info(DOMAIN, TAG, '✅ Notification removal skipped (simplified version)');
    } catch (error) {
      hilog.error(DOMAIN, TAG, '❌ Remove notification error: %{public}s', JSON.stringify(error) ?? '');
    }
  }
}

export const metronomeBackgroundService = MetronomeBackgroundService.getInstance();