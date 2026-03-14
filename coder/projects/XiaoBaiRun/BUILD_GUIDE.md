# DevEco Studio 构建指南

由于命令行构建环境配置复杂（需要 `DEVECO_SDK_HOME` 等环境变量），推荐使用 DevEco Studio GUI 进行构建。

---

## 🚀 构建步骤

### 1. 打开项目

1. 启动 DevEco Studio
2. File → Open
3. 选择 `/Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiRun`
4. 等待项目同步完成

### 2. 构建项目

**方法一：菜单构建**
1. Build → Build Hap(s) / APP(s) → Build Hap(s)
2. 等待构建完成

**方法二：快捷键**
- 按 `Cmd + F9` (Mac) 或 `Ctrl + F9` (Windows)

**方法三：工具栏**
- 点击右上角绿色锤子图标 📦

### 3. 查看构建结果

- 构建日志：底部 Build 标签页
- HAP 包位置：`entry/build/default/outputs/default/entry-default-signed.hap`

---

## ⚠️ 预期编译错误

由于新增了音频文件引用，可能会出现以下错误：

```
Error: Resource not found: drum_beat.mp3
Error: Resource not found: voice_beat_count.mp3
...
```

### 解决方案

#### 选项 A：临时注释音频引用

修改 `VoicePromptService.ts`，返回预录制音频文件路径：

```typescript
private getAudioPath(text: string, type: VoicePromptType): string | null {
  // 临时使用电子音代替
  switch (type) {
    case VoicePromptType.BEAT_COUNT:
    case VoicePromptType.BPM_CHANGE:
    case VoicePromptType.PHASE_CHANGE:
    case VoicePromptType.PACE_REMINDER:
      return 'resource://rawfile/metronome_beep.mp3'; // 临时统一使用电子音
    default:
      return null;
  }
}
```

#### 选项 B：生成音频文件

使用以下方法生成缺失的音频：

1. **鼓点 (drum_beat.mp3)**
   ```bash
   ffmpeg -f lavfi -i "sine=frequency=200:duration=0.2" \
          -af "highpass=f=100,lowpass=f=500" drum_beat.mp3
   ```

2. **人声提示**
   - 使用在线 TTS 工具生成
   - 或暂时跳过语音提示功能

#### 选项 C：禁用语音提示（推荐）

临时禁用语音提示功能，先验证核心功能：

1. 在 `Metronome.ets` 中禁用语音提示开关
2. 设置 `voicePromptEnabled = false`
3. 构建验证

---

## ✅ 构建成功标志

```
BUILD SUCCESSFUL in X.XXXs
XX warnings, X errors
```

---

## 🧪 真机测试

### 1. 安装 HAP 包

1. 连接 HarmonyOS 设备（USB 调试已开启）
2. DevEco Studio 顶部工具栏选择设备
3. 点击绿色运行按钮 ▶️ 或按 `Ctrl + R`

### 2. 测试项

#### P0 功能
- [ ] 启动节拍器，播放正常
- [ ] 锁屏后继续播放（通知栏显示）
- [ ] 切换节奏模式（匀速/渐进加速/间歇训练）
- [ ] BPM 实时更新（渐进加速/间歇训练）

#### P1 功能
- [ ] 切换声音类型（电子音/鼓点）
- [ ] 开关配速联动
- [ ] 开关语音提示（如果有音频文件）

#### 基础功能
- [ ] BPM 调节（60-200）
- [ ] 快速选择按钮
- [ ] 音量调节
- [ ] 深色模式

---

## 📝 后续步骤

1. **首次构建验证** - 确认代码无语法错误
2. **生成音频文件** - 补全鼓点/人声提示音频
3. **真机测试** - 验证后台播放/节奏模式
4. **Bug 修复** - 根据测试结果调整

---

## 🆘 常见问题

### Q1: 构建失败，提示 "Resource not found"

**A**: 临时注释音频引用，或生成缺失的音频文件

### Q2: 权限错误

**A**: 检查 `module.json5` 中的 `requestPermissions` 配置

### Q3: 通知栏不显示

**A**: 检查是否授予通知权限，以及 `KEEP_BACKGROUND_RUNNING` 权限

### Q4: 锁屏后停止播放

**A**: 确认前台服务（ContinuousTask）已启动

---

**构建完成后，请返回构建结果截图或日志。**