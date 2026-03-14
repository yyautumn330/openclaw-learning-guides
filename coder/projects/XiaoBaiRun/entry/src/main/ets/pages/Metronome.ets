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

import { metronomeBackgroundService } from '../services/MetronomeBackgroundService';
import { RhythmMode, RhythmCalculator, CONSTANT_CONFIG, GRADUAL_ACCEL_CONFIG, INTERVAL_CONFIG, type RhythmConfig } from '../services/RhythmMode';
import { SoundType, ELECTRONIC_CONFIG, DRUM_CONFIG, VOICE_CONFIG, getSoundTypeName, type SoundConfig } from '../services/SoundType';
import { paceBpmLinkageService, DEFAULT_PACE_BPM_CONFIG, type PaceData } from '../services/PaceBpmLinkage';
import { voicePromptService, DEFAULT_VOICE_CONFIG, VoicePromptType } from '../services/VoicePromptService';
import { DesignTokens, type ColorTheme } from '../constants/DesignTokens';
import { ToastComponent } from '../components/Toast';

/**
 * 节奏模式按钮项
 */
interface RhythmModeItem {
  mode: RhythmMode;
  name: string;
  icon: string;
}

/**
 * 声音类型按钮项
 */
interface SoundTypeItem {
  type: SoundType;
  name: string;
  icon: string;
}

@Component
export struct Metronome {
  @State isPlaying: boolean = false;
  @State bpm: number = 180;
  @State volume: number = 0.7;
  @State isDarkMode: boolean = false;
  @State beatCount: number = 0;
  @State isBeatPulsing: boolean = false;
  @State buttonScale: number = 1;
  @State bpmDisplayScale: number = 1;

  // 节奏模式
  @State rhythmMode: RhythmMode = RhythmMode.CONSTANT;
  @State currentPhase: string = '匀速保持';

  // 声音类型
  @State soundType: SoundType = SoundType.ELECTRONIC;

  // 联动功能
  @State linkageEnabled: boolean = false;
  @State voicePromptEnabled: boolean = false;

  private colors: ColorTheme = {
    backgroundColor: '#F7F7F7',
    cardBackground: '#FFFFFF',
    primaryColor: '#FF6B6B',
    primaryColorPressed: '#EE5A5A',
    secondaryColor: '#4ECDC4',
    secondaryColorPressed: '#3DBDB5',
    textPrimary: '#333333',
    textSecondary: '#666666',
    textTertiary: '#999999',
    borderColor: '#E0E0E0',
    dividerColor: '#E8E8E8',
    successColor: '#52C41A',
    warningColor: '#FAAD14',
    errorColor: '#FF4D4F',
    infoColor: '#1890FF',
    shadowColor: 'rgba(0, 0, 0, 0.1)',
  };

  private beatTimer: number = -1;
  private pulseAnimationTimer: number = -1;

  aboutToAppear() {
    this.isDarkMode = this.getIsDarkMode();
    this.updateColors();
    this.bpm = metronomeBackgroundService.getCurrentBpm();
    this.volume = 0.7; // 默认音量
    this.isPlaying = metronomeBackgroundService.isCurrentlyPlaying();

    // 加载配置
    const linkageConfig = paceBpmLinkageService.getConfig();
    this.linkageEnabled = linkageConfig.enabled;

    const voiceConfig = voicePromptService.getConfig();
    this.voicePromptEnabled = voiceConfig.enabled;

    // 启动状态刷新
    this.startStatusRefresh();
  }

  aboutToDisappear() {
    this.stopBeatTimer();
    this.stopPulseAnimation();
    this.stopStatusRefresh();
  }

  getIsDarkMode(): boolean {
    return false;
  }

  updateColors() {
    this.colors = DesignTokens.getThemeColors(this.isDarkMode);
  }

  /**
   * 启动状态刷新
   */
  startStatusRefresh() {
    setInterval(() => {
      if (!this.isPlaying) return;

      this.bpm = metronomeBackgroundService.getCurrentBpm();
      this.beatCount = metronomeBackgroundService.getBeatCount();
      this.currentPhase = metronomeBackgroundService.getCurrentPhase();

      // 检查语音提示
      if (voicePromptService.shouldPrompt(this.beatCount)) {
        voicePromptService.speakBeatCount(this.beatCount, this.bpm);
      }
    }, 1000);
  }

  stopStatusRefresh() {
    // 定时器会自动清理
  }

  togglePlay() {
    this.animateButtonPress();

    if (this.isPlaying) {
      metronomeBackgroundService.stop();
      this.isPlaying = false;
      this.stopBeatTimer();
      this.stopPulseAnimation();
      ToastComponent.info('节拍器已停止', 1500);
    } else {
      metronomeBackgroundService.start();
      this.isPlaying = true;
      this.beatCount = 0;
      this.startBeatTimer();
      this.startPulseAnimation();
      ToastComponent.success(`节拍器已启动 ${this.bpm} BPM`, 1500);
    }
  }

  startBeatTimer() {
    this.stopBeatTimer();
    const intervalMs = 60000 / this.bpm;
    this.beatTimer = setInterval(() => {
      this.beatCount++;
    }, intervalMs);
  }

  stopBeatTimer() {
    if (this.beatTimer !== -1) {
      clearInterval(this.beatTimer);
      this.beatTimer = -1;
    }
  }

  startPulseAnimation() {
    this.stopPulseAnimation();
    const intervalMs = 60000 / this.bpm;
    this.pulseAnimationTimer = setInterval(() => {
      animateTo({
        duration: 100,
        curve: Curve.EaseOut
      }, () => {
        this.bpmDisplayScale = 1.15;
        this.isBeatPulsing = true;
      });

      if (this.isPlaying) {
        animateTo({
          duration: 100,
          curve: Curve.EaseOut
        }, () => {
          this.buttonScale = 1.02;
        });
      }

      setTimeout(() => {
        animateTo({
          duration: 150,
          curve: Curve.EaseIn
        }, () => {
          this.bpmDisplayScale = 1;
          this.isBeatPulsing = false;
          this.buttonScale = 1;
        });
      }, 150);
    }, intervalMs);
  }

  stopPulseAnimation() {
    if (this.pulseAnimationTimer !== -1) {
      clearInterval(this.pulseAnimationTimer);
      this.pulseAnimationTimer = -1;
    }
    animateTo({
      duration: 150
    }, () => {
      this.isBeatPulsing = false;
      this.bpmDisplayScale = 1;
      this.buttonScale = 1;
    });
  }

  animateButtonPress() {
    animateTo({
      duration: 100,
      curve: Curve.EaseOut
    }, () => {
      this.buttonScale = 0.95;
    });

    setTimeout(() => {
      animateTo({
        duration: 150,
        curve: Curve.EaseIn
      }, () => {
        this.buttonScale = 1;
      });
    }, 100);
  }

  onBpmChange(value: number) {
    const oldValue = this.bpm;
    this.bpm = Math.round(value);

    // 更新后台服务
    const config: RhythmConfig = {
      mode: this.rhythmMode,
      startBpm: this.bpm,
      targetBpm: this.bpm,
      accelDurationMinutes: 0,
      sprintDurationSeconds: 0,
      recoveryDurationSeconds: 0,
      intervalCycles: 0
    };
    metronomeBackgroundService.setRhythmMode(config);

    animateTo({
      duration: 150,
      curve: Curve.EaseOut
    }, () => {
      this.bpmDisplayScale = 1.2;
    });

    setTimeout(() => {
      animateTo({
        duration: 150,
        curve: Curve.EaseIn
      }, () => {
        this.bpmDisplayScale = 1;
      });
    }, 150);

    if (this.isPlaying) {
      this.stopBeatTimer();
      this.startBeatTimer();
      this.stopPulseAnimation();
      this.startPulseAnimation();
    }

    if (Math.abs(value - oldValue) >= 4) {
      ToastComponent.info(`${this.bpm} BPM`, 800);
    }
  }

  onVolumeChange(value: number) {
    this.volume = value;
    metronomeBackgroundService.setVolume(value);
  }

  setQuickBpm(bpm: number) {
    this.animateButtonPress();
    this.bpm = bpm;

    const config: RhythmConfig = {
      mode: this.rhythmMode,
      startBpm: bpm,
      targetBpm: bpm,
      accelDurationMinutes: 0,
      sprintDurationSeconds: 0,
      recoveryDurationSeconds: 0,
      intervalCycles: 0
    };
    metronomeBackgroundService.setRhythmMode(config);

    animateTo({
      duration: 150,
      curve: Curve.EaseOut
    }, () => {
      this.bpmDisplayScale = 1.2;
    });

    setTimeout(() => {
      animateTo({
        duration: 150,
        curve: Curve.EaseIn
      }, () => {
        this.bpmDisplayScale = 1;
      });
    }, 150);

    ToastComponent.success(`${bpm} BPM`, 800);

    if (this.isPlaying) {
      this.stopBeatTimer();
      this.startBeatTimer();
      this.stopPulseAnimation();
      this.startPulseAnimation();
    }
  }

  /**
   * 设置节奏模式
   */
  setRhythmMode(mode: RhythmMode) {
    this.rhythmMode = mode;

    let config: RhythmConfig | undefined;
    switch (mode) {
      case RhythmMode.CONSTANT:
        config = {
          mode: RhythmMode.CONSTANT,
          startBpm: this.bpm,
          targetBpm: this.bpm,
          accelDurationMinutes: 0,
          sprintDurationSeconds: 0,
          recoveryDurationSeconds: 0,
          intervalCycles: 0
        };
        break;
      case RhythmMode.GRADUAL_ACCEL:
        config = {
          mode: RhythmMode.GRADUAL_ACCEL,
          startBpm: this.bpm,
          targetBpm: GRADUAL_ACCEL_CONFIG.targetBpm,
          accelDurationMinutes: GRADUAL_ACCEL_CONFIG.accelDurationMinutes,
          sprintDurationSeconds: 0,
          recoveryDurationSeconds: 0,
          intervalCycles: 0
        };
        break;
      case RhythmMode.INTERVAL:
        config = {
          mode: RhythmMode.INTERVAL,
          startBpm: this.bpm,
          targetBpm: INTERVAL_CONFIG.targetBpm,
          accelDurationMinutes: 0,
          sprintDurationSeconds: INTERVAL_CONFIG.sprintDurationSeconds,
          recoveryDurationSeconds: INTERVAL_CONFIG.recoveryDurationSeconds,
          intervalCycles: INTERVAL_CONFIG.intervalCycles
        };
        break;
    }

    if (config) {
      metronomeBackgroundService.setRhythmMode(config);
      ToastComponent.success(`已切换到${RhythmCalculator.getModeName(mode)}`, 1500);
    }
  }

  /**
   * 设置声音类型
   */
  setSoundType(type: SoundType) {
    this.soundType = type;

    let config: SoundConfig | undefined;
    switch (type) {
      case SoundType.ELECTRONIC:
        config = ELECTRONIC_CONFIG;
        break;
      case SoundType.DRUM:
        config = DRUM_CONFIG;
        break;
      case SoundType.VOICE:
        config = VOICE_CONFIG;
        break;
    }

    if (config) {
      metronomeBackgroundService.setSoundType(config);
      ToastComponent.success(`已切换到${getSoundTypeName(type)}`, 1500);
    }
  }

  /**
   * 切换配速联动
   */
  toggleLinkage() {
    this.linkageEnabled = !this.linkageEnabled;
    paceBpmLinkageService.setConfig({ enabled: this.linkageEnabled });
    ToastComponent.info(this.linkageEnabled ? '配速联动已开启' : '配速联动已关闭', 1500);
  }

  /**
   * 切换语音提示
   */
  toggleVoicePrompt() {
    this.voicePromptEnabled = !this.voicePromptEnabled;
    voicePromptService.setConfig({ enabled: this.voicePromptEnabled });
    ToastComponent.info(this.voicePromptEnabled ? '语音提示已开启' : '语音提示已关闭', 1500);
  }

  formatBeatCount(count: number): string {
    if (count < 60) {
      return count.toString();
    } else if (count < 3600) {
      const min = Math.floor(count / 60);
      const sec = count % 60;
      return `${min}:${sec.toString().padStart(2, '0')}`;
    } else {
      const hour = Math.floor(count / 3600);
      const min = Math.floor((count % 3600) / 60);
      const sec = count % 60;
      return `${hour}:${min.toString().padStart(2, '0')}:${sec.toString().padStart(2, '0')}`;
    }
  }

  build() {
    Column() {
      // 顶部标题
      Row() {
        Text('🎵 跑步节拍器')
          .fontSize(DesignTokens.FONT_SIZE.xxl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.colors.textPrimary)
      }
      .width('100%')
      .padding({ top: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.md })
      .justifyContent(FlexAlign.Center)

      Scroll() {
        Column() {
          // BPM 显示卡片
          Column() {
            Row() {
              Text('当前步频')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontColor(this.colors.textSecondary)

              Text(`${this.bpm} BPM`)
                .fontSize(DesignTokens.FONT_SIZE.xxl)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.colors.primaryColor)
                .scale({ x: this.bpmDisplayScale, y: this.bpmDisplayScale })
                .margin({ left: 'auto' })
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })

            // 节奏阶段
            if (this.rhythmMode !== RhythmMode.CONSTANT) {
              Row() {
                Text(this.currentPhase)
                  .fontSize(DesignTokens.FONT_SIZE.sm)
                  .fontColor(this.colors.infoColor)
                  .margin({ left: 'auto' })
              }
              .width('100%')
              .margin({ bottom: DesignTokens.SPACING.md })
            }

            // 节拍计数
            Row() {
              Text('节拍数')
                .fontSize(DesignTokens.FONT_SIZE.sm)
                .fontColor(this.colors.textTertiary)

              Text(this.formatBeatCount(this.beatCount))
                .fontSize(DesignTokens.FONT_SIZE.lg)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.isBeatPulsing ? this.colors.primaryColor : this.colors.textPrimary)
                .margin({ left: 'auto' })
            }
            .width('100%')
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })
          .shadow(this.isBeatPulsing ? {
            radius: 12,
            color: `rgba(255, 107, 107, ${this.isDarkMode ? 0.3 : 0.15})`
          } : {
            radius: 8,
            color: this.colors.shadowColor
          })

          // 节奏模式选择
          Column() {
            Row() {
              Text('节奏模式')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.textPrimary)
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })

            Row() {
              ForEach([
                { mode: RhythmMode.CONSTANT, name: '匀速', icon: '🔁' },
                { mode: RhythmMode.GRADUAL_ACCEL, name: '渐进加速', icon: '📈' },
                { mode: RhythmMode.INTERVAL, name: '间歇训练', icon: '⚡' }
              ], (item: RhythmModeItem) => {
                Column() {
                  Text(item.icon)
                    .fontSize(24)
                    .margin({ bottom: 4 })

                  Text(item.name)
                    .fontSize(DesignTokens.FONT_SIZE.xs)
                    .fontColor(this.rhythmMode === item.mode ? '#FFFFFF' : this.colors.textPrimary)
                }
                .width(70)
                .padding(8)
                .backgroundColor(this.rhythmMode === item.mode ? this.colors.primaryColor : this.colors.cardBackground)
                .borderRadius(DesignTokens.RADIUS.md)
                .margin({ right: DesignTokens.SPACING.sm })
                .onClick(() => {
                  this.setRhythmMode(item.mode);
                })
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })

          // BPM 调节滑块
          Column() {
            Row() {
              Text('步频调节')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.textPrimary)

              Text(`${this.bpm}`)
                .fontSize(DesignTokens.FONT_SIZE.lg)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.colors.primaryColor)
                .margin({ left: 'auto' })
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })

            Slider({
              value: this.bpm,
              min: 60,
              max: 200,
              step: 2
            })
              .onChange((value: number) => {
                this.onBpmChange(value);
              })
              .blockColor(this.colors.primaryColor)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })

          // 快速选择按钮
          Column() {
            Row() {
              Text('快速选择')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.textPrimary)
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })

            Row() {
              ForEach([60, 180, 200], (bpmValue: number) => {
                Button(`${bpmValue}`)
                  .fontSize(DesignTokens.FONT_SIZE.md)
                  .backgroundColor(bpmValue === this.bpm ? this.colors.primaryColor : this.colors.cardBackground)
                  .fontColor(bpmValue === this.bpm ? '#FFFFFF' : this.colors.textPrimary)
                  .borderWidth(2)
                  .borderColor(bpmValue === this.bpm ? this.colors.primaryColor : this.colors.borderColor)
                  .borderRadius(DesignTokens.RADIUS.md)
                  .width(80)
                  .height(40)
                  .margin({ right: DesignTokens.SPACING.sm })
                  .scale({ x: bpmValue === this.bpm ? 1.05 : 1, y: bpmValue === this.bpm ? 1.05 : 1 })
                  .onClick(() => {
                    this.setQuickBpm(bpmValue);
                  })
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.Center)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })

          // 声音类型选择
          Column() {
            Row() {
              Text('声音类型')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.textPrimary)
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })

            Row() {
              ForEach([
                { type: SoundType.ELECTRONIC, name: '电子音', icon: '🔊' },
                { type: SoundType.DRUM, name: '鼓点', icon: '🥁' },
                { type: SoundType.VOICE, name: '人声', icon: '🗣️' }
              ], (item: SoundTypeItem) => {
                Column() {
                  Text(item.icon)
                    .fontSize(24)
                    .margin({ bottom: 4 })

                  Text(item.name)
                    .fontSize(DesignTokens.FONT_SIZE.xs)
                    .fontColor(this.soundType === item.type ? '#FFFFFF' : this.colors.textPrimary)
                }
                .width(70)
                .padding(8)
                .backgroundColor(this.soundType === item.type ? this.colors.secondaryColor : this.colors.cardBackground)
                .borderRadius(DesignTokens.RADIUS.md)
                .margin({ right: DesignTokens.SPACING.sm })
                .onClick(() => {
                  this.setSoundType(item.type);
                })
              })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })

          // 音量调节
          Column() {
            Row() {
              Text('🔊 音量')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.colors.textPrimary)

              Text(`${Math.round(this.volume * 100)}%`)
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Bold)
                .fontColor(this.colors.textPrimary)
                .margin({ left: 'auto' })
            }
            .width('100%')
            .margin({ bottom: DesignTokens.SPACING.md })

            Slider({
              value: this.volume,
              min: 0,
              max: 1,
              step: 0.1
            })
              .onChange((value: number) => {
                this.onVolumeChange(value);
              })
              .blockColor(this.colors.secondaryColor)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })

          // 智能功能开关
          Column() {
            // 配速联动
            Row() {
              Text('配速联动')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontColor(this.colors.textPrimary)

              Toggle({ type: ToggleType.Switch, isOn: this.linkageEnabled })
                .selectedColor(this.colors.primaryColor)
                .onChange((isOn: boolean) => {
                  this.toggleLinkage();
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
            .margin({ bottom: DesignTokens.SPACING.md })

            // 语音提示
            Row() {
              Text('语音提示')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontColor(this.colors.textPrimary)

              Toggle({ type: ToggleType.Switch, isOn: this.voicePromptEnabled })
                .selectedColor(this.colors.secondaryColor)
                .onChange((isOn: boolean) => {
                  this.toggleVoicePrompt();
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceBetween)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.xl })

          // 播放/停止按钮
          Button(this.isPlaying ? '⏹ 停止节拍器' : '▶ 启动节拍器')
            .width('100%')
            .height(DesignTokens.BUTTON.height)
            .fontSize(DesignTokens.FONT_SIZE.xl)
            .fontWeight(FontWeight.Bold)
            .backgroundColor(this.isPlaying ? this.colors.secondaryColor : this.colors.primaryColor)
            .fontColor('#FFFFFF')
            .borderRadius(DesignTokens.RADIUS.xl)
            .scale({ x: this.buttonScale, y: this.buttonScale })
            .shadow(this.isPlaying ? {
              radius: 16,
              color: `rgba(78, 205, 196, ${this.isBeatPulsing ? 0.5 : 0.3})`
            } : {
              radius: 8,
              color: this.colors.shadowColor
            })
            .onClick(() => {
              this.togglePlay();
            })

          // 使用说明
          Column() {
            Text('💡 使用说明')
              .fontSize(DesignTokens.FONT_SIZE.md)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.colors.textPrimary)
              .margin({ bottom: DesignTokens.SPACING.sm })

            Text('• 推荐步频：慢跑 150-160 BPM，快跑 170-180 BPM')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.colors.textSecondary)
              .margin({ bottom: DesignTokens.SPACING.xs })

            Text('• 配速联动：根据实时配速自动调整BPM')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.colors.textSecondary)
              .margin({ bottom: DesignTokens.SPACING.xs })

            Text('• 后台播放：锁屏状态下继续播放')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.colors.textSecondary)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.colors.cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ top: DesignTokens.SPACING.lg })
        }
        .width('100%')
        .padding({ left: DesignTokens.SPACING.lg, right: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.xl })
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.colors.backgroundColor)
  }
}