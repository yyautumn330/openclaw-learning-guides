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

import { PomodoroModel, PomodoroSettings, ThemeMode } from '../utils/PomodoroModel';
import { eventBus } from '../utils/EventBus';
import { ToastComponent } from '../components/Toast';
import { DesignTokens } from '../constants/DesignTokens';
import { common } from '@kit.AbilityKit';

@Component
export struct Settings {
  @State pomodoroDuration: number = 25;
  @State shortBreakDuration: number = 5;
  @State longBreakDuration: number = 15;
  @State longBreakInterval: number = 4;
  @State themeMode: ThemeMode = ThemeMode.LIGHT;
  @State isDarkMode: boolean = false;
  
  @State isSaving: boolean = false;
  
  private pomodoroModel: PomodoroModel = PomodoroModel.getInstance();
  private context: common.UIAbilityContext | null = null;
  
  getColors() {
    return DesignTokens.getThemeColors(this.isDarkMode);
  }
  
  getThemeModeText(): string {
    return this.themeMode === ThemeMode.DARK ? '深色' : '浅色';
  }
  
  async onThemeModeChange(mode: ThemeMode): Promise<void> {
    this.themeMode = mode;
    await this.pomodoroModel.setThemeMode(mode);
    // 从 PomodoroModel 获取更新后的深色模式状态
    this.isDarkMode = this.pomodoroModel.getIsDarkMode();
    // 不需要再发送事件，setThemeMode 已经发送了
    ToastComponent.info(this.getThemeModeText(), 2000);
  }
  
  async aboutToAppear() {
    this.loadSettings();
  }
  
  onPageShow() {
    this.loadSettings();
  }
  
  loadSettings() {
    const settings = this.pomodoroModel.getSettings();
    this.pomodoroDuration = settings.pomodoroDuration;
    this.shortBreakDuration = settings.shortBreakDuration;
    this.longBreakDuration = settings.longBreakDuration;
    this.longBreakInterval = settings.longBreakInterval;
    this.themeMode = settings.themeMode;
    this.isDarkMode = this.pomodoroModel.getIsDarkMode();
  }
  
  async saveSettings() {
    if (this.isSaving) return;
    
    this.isSaving = true;
    
    try {
      const newSettings: PomodoroSettings = {
        pomodoroDuration: this.pomodoroDuration,
        shortBreakDuration: this.shortBreakDuration,
        longBreakDuration: this.longBreakDuration,
        longBreakInterval: this.longBreakInterval,
        themeMode: this.themeMode
      };
      
      const wasRunning = this.pomodoroModel.getIsRunning();
      await this.pomodoroModel.updateSettings(newSettings);
      await this.pomodoroModel.reloadSettings();
      
      if (wasRunning) {
        console.info('Settings saveSettings: timer was running, resetting to new duration');
      }
      
      ToastComponent.success('设置已保存', 2000);
      eventBus.emitSettingsChanged(newSettings);
    } catch (error) {
      console.error('Settings save error:', error);
      ToastComponent.error('保存失败，请重试', 3000);
    } finally {
      this.isSaving = false;
    }
  }
  
  async resetSettings() {
    try {
      await this.pomodoroModel.resetSettings();
      this.loadSettings();
      ToastComponent.info('已重置为默认设置', 2000);
      eventBus.emitSettingsChanged(this.pomodoroModel.getSettings());
    } catch (error) {
      console.error('Settings reset error:', error);
      ToastComponent.error('重置失败', 3000);
    }
  }
  
  @Builder
  buildPomodoroDurationSetting(): void {
    Column() {
      Row() {
        Column() {
          Text('番茄时长')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getColors().textPrimary)
          
          Text('每个专注时段的时长')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
            .margin({ top: DesignTokens.SPACING.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        
        Text(`${this.pomodoroDuration}分钟`)
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().primaryColor)
          .width(80)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .padding({ left: DesignTokens.SPACING.md, right: DesignTokens.SPACING.md, top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.sm })
      
      Slider({
        value: this.pomodoroDuration,
        min: 5,
        max: 60,
        step: 1
      })
      .width('100%')
      .height(30)
      .selectedColor(this.getColors().primaryColor)
      .onChange((value: number) => {
        this.pomodoroDuration = Math.round(value);
      })
      .padding({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
      
      Row() {
        Text('5 分钟')
          .fontSize(DesignTokens.FONT_SIZE.xs)
          .fontColor(this.getColors().textSecondary)
        
        Text('60 分钟')
          .fontSize(DesignTokens.FONT_SIZE.xs)
          .fontColor(this.getColors().textSecondary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
    }
    .width('100%')
  }
  
  @Builder
  buildShortBreakSetting(): void {
    Column() {
      Row() {
        Column() {
          Text('短休息时长')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getColors().textPrimary)
          
          Text('番茄之间的短暂休息')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
            .margin({ top: DesignTokens.SPACING.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        
        Text(`${this.shortBreakDuration}分钟`)
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().primaryColor)
          .width(80)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .padding({ left: DesignTokens.SPACING.md, right: DesignTokens.SPACING.md, top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.sm })
      
      Slider({
        value: this.shortBreakDuration,
        min: 3,
        max: 15,
        step: 1
      })
      .width('100%')
      .height(30)
      .selectedColor(this.getColors().primaryColor)
      .onChange((value: number) => {
        this.shortBreakDuration = Math.round(value);
      })
      .padding({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
      
      Row() {
        Text('3 分钟')
          .fontSize(DesignTokens.FONT_SIZE.xs)
          .fontColor(this.getColors().textSecondary)
        
        Text('15 分钟')
          .fontSize(DesignTokens.FONT_SIZE.xs)
          .fontColor(this.getColors().textSecondary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
    }
    .width('100%')
  }
  
  @Builder
  buildLongBreakSetting(): void {
    Column() {
      Row() {
        Column() {
          Text('长休息时长')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getColors().textPrimary)
          
          Text('完成多个番茄后的长休息')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
            .margin({ top: DesignTokens.SPACING.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        
        Text(`${this.longBreakDuration}分钟`)
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().primaryColor)
          .width(80)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .padding({ left: DesignTokens.SPACING.md, right: DesignTokens.SPACING.md, top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.sm })
      
      Slider({
        value: this.longBreakDuration,
        min: 10,
        max: 30,
        step: 1
      })
      .width('100%')
      .height(30)
      .selectedColor(this.getColors().primaryColor)
      .onChange((value: number) => {
        this.longBreakDuration = Math.round(value);
      })
      .padding({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
      
      Row() {
        Text('10 分钟')
          .fontSize(DesignTokens.FONT_SIZE.xs)
          .fontColor(this.getColors().textSecondary)
        
        Text('30 分钟')
          .fontSize(DesignTokens.FONT_SIZE.xs)
          .fontColor(this.getColors().textSecondary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
    }
    .width('100%')
  }
  
  @Builder
  buildLongBreakIntervalSetting(): void {
    Column() {
      Row() {
        Column() {
          Text('长休息间隔')
            .fontSize(DesignTokens.FONT_SIZE.md)
            .fontWeight(FontWeight.Medium)
            .fontColor(this.getColors().textPrimary)
          
          Text('每完成几个番茄后长休息')
            .fontSize(DesignTokens.FONT_SIZE.sm)
            .fontColor(this.getColors().textSecondary)
            .margin({ top: DesignTokens.SPACING.xs })
        }
        .alignItems(HorizontalAlign.Start)
        .layoutWeight(1)
        
        Text(`${this.longBreakInterval}个`)
          .fontSize(DesignTokens.FONT_SIZE.lg)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().primaryColor)
          .width(80)
          .textAlign(TextAlign.End)
      }
      .width('100%')
      .padding({ left: DesignTokens.SPACING.md, right: DesignTokens.SPACING.md, top: DesignTokens.SPACING.md, bottom: DesignTokens.SPACING.sm })
      
      Slider({
        value: this.longBreakInterval,
        min: 3,
        max: 6,
        step: 1
      })
      .width('100%')
      .height(30)
      .selectedColor(this.getColors().primaryColor)
      .onChange((value: number) => {
        this.longBreakInterval = Math.round(value);
      })
      .padding({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
      
      Row() {
        Text('3 个')
          .fontSize(DesignTokens.FONT_SIZE.xs)
          .fontColor(this.getColors().textSecondary)
        
        Text('6 个')
          .fontSize(DesignTokens.FONT_SIZE.xs)
          .fontColor(this.getColors().textSecondary)
      }
      .width('100%')
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ left: DesignTokens.SPACING.sm, right: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
    }
    .width('100%')
  }
  
  build() {
    Column() {
      Row() {
        Text('设置')
          .fontSize(DesignTokens.FONT_SIZE.xxl)
          .fontWeight(FontWeight.Bold)
          .fontColor(this.getColors().textPrimary)
      }
      .width('100%')
      .padding({ top: DesignTokens.SPACING.lg, bottom: DesignTokens.SPACING.lg, left: DesignTokens.SPACING.lg })
      
      Scroll() {
        Column() {
          Column() {
            Text('🌗 外观设置')
              .fontSize(DesignTokens.FONT_SIZE.lg)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: DesignTokens.SPACING.md })
            
            // 主题模式选择
            Column() {
              Text('主题模式')
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .fontColor(this.getColors().textPrimary)
                .margin({ bottom: DesignTokens.SPACING.sm })
              
              Text('选择浅色/深色/跟随系统')
                .fontSize(DesignTokens.FONT_SIZE.sm)
                .fontColor(this.getColors().textSecondary)
                .margin({ bottom: DesignTokens.SPACING.md })
              
              // 使用 Button 组选择
              Row() {
                Button('浅色')
                  .width('45%')
                  .height(40)
                  .fontSize(DesignTokens.FONT_SIZE.md)
                  .backgroundColor(this.themeMode === ThemeMode.LIGHT ? this.getColors().primaryColor : this.getColors().backgroundColor)
                  .fontColor(this.themeMode === ThemeMode.LIGHT ? '#FFFFFF' : this.getColors().textPrimary)
                  .borderRadius(DesignTokens.RADIUS.md)
                  .borderWidth(2)
                  .borderColor(this.themeMode === ThemeMode.LIGHT ? this.getColors().primaryColor : this.getColors().textSecondary)
                  .onClick(() => {
                    this.onThemeModeChange(ThemeMode.LIGHT);
                  })
                
                Button('深色')
                  .width('45%')
                  .height(40)
                  .fontSize(DesignTokens.FONT_SIZE.md)
                  .backgroundColor(this.themeMode === ThemeMode.DARK ? this.getColors().primaryColor : this.getColors().backgroundColor)
                  .fontColor(this.themeMode === ThemeMode.DARK ? '#FFFFFF' : this.getColors().textPrimary)
                  .borderRadius(DesignTokens.RADIUS.md)
                  .borderWidth(2)
                  .borderColor(this.themeMode === ThemeMode.DARK ? this.getColors().primaryColor : this.getColors().textSecondary)
                  .onClick(() => {
                    this.onThemeModeChange(ThemeMode.DARK);
                  })
              }
              .width('100%')
              .justifyContent(FlexAlign.SpaceBetween)
            }
            .width('100%')
            .padding(DesignTokens.SPACING.lg)
            .backgroundColor(this.getColors().cardBackground)
            .borderRadius(DesignTokens.RADIUS.lg)
            .margin({ bottom: DesignTokens.SPACING.md })
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.md })
          
          Column() {
            Text('⏱️ 时间设置')
              .fontSize(DesignTokens.FONT_SIZE.lg)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: DesignTokens.SPACING.md })
            
            this.buildPomodoroDurationSetting()
            
            Divider()
              .width('100%')
              .color(this.getColors().dividerColor)
              .margin({ top: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
            
            this.buildShortBreakSetting()
            
            Divider()
              .width('100%')
              .color(this.getColors().dividerColor)
              .margin({ top: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
            
            this.buildLongBreakSetting()
            
            Divider()
              .width('100%')
              .color(this.getColors().dividerColor)
              .margin({ top: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.sm })
            
            this.buildLongBreakIntervalSetting()
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ bottom: DesignTokens.SPACING.lg })
          
          Column() {
            Row() {
              Button(this.isSaving ? '保存中...' : '保存设置')
                .width('45%')
                .height(DesignTokens.BUTTON.height)
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(this.getColors().primaryColor)
                .fontColor('#FFFFFF')
                .borderRadius(DesignTokens.RADIUS.xl)
                .enabled(!this.isSaving)
                .onClick(() => {
                  this.saveSettings();
                })
              
              Button('重置默认')
                .width('45%')
                .height(DesignTokens.BUTTON.height)
                .fontSize(DesignTokens.FONT_SIZE.md)
                .fontWeight(FontWeight.Medium)
                .backgroundColor(this.getColors().cardBackground)
                .fontColor(this.getColors().textSecondary)
                .borderRadius(DesignTokens.RADIUS.xl)
                .borderWidth(1)
                .borderColor(this.getColors().borderColor)
                .onClick(() => {
                  this.resetSettings();
                })
            }
            .width('100%')
            .justifyContent(FlexAlign.SpaceEvenly)
            .padding({ top: DesignTokens.SPACING.sm, bottom: DesignTokens.SPACING.lg })
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          
          Column() {
            Text('💡 提示')
              .fontSize(DesignTokens.FONT_SIZE.md)
              .fontWeight(FontWeight.Bold)
              .fontColor(this.getColors().textPrimary)
              .margin({ bottom: DesignTokens.SPACING.sm })
            
            Text('• 番茄时长建议 25 分钟，可根据个人专注力调整')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.getColors().textSecondary)
              .margin({ bottom: DesignTokens.SPACING.xs })
            
            Text('• 短休息建议 5 分钟，起身活动、喝水')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.getColors().textSecondary)
              .margin({ bottom: DesignTokens.SPACING.xs })
            
            Text('• 长休息建议 15-30 分钟，让大脑充分放松')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.getColors().textSecondary)
              .margin({ bottom: DesignTokens.SPACING.xs })
            
            Text('• 完成 4 个番茄后建议长休息一次')
              .fontSize(DesignTokens.FONT_SIZE.sm)
              .fontColor(this.getColors().textSecondary)
          }
          .width('100%')
          .padding(DesignTokens.SPACING.lg)
          .backgroundColor(this.getColors().cardBackground)
          .borderRadius(DesignTokens.RADIUS.lg)
          .margin({ top: DesignTokens.SPACING.lg })
        }
        .width('100%')
      }
      .layoutWeight(1)
    }
    .width('100%')
    .height('100%')
    .backgroundColor(this.getColors().backgroundColor)
  }
}
