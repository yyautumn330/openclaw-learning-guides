# 小白番茄专注钟 - 鸿蒙版

🍅 基于番茄工作法的专注计时器应用

## 项目信息

- **项目名称**: XiaoBaiPomodoro
- **包名**: com.aixiaobai.pomodoro
- **版本**: 1.0.0
- **SDK**: HarmonyOS SDK API 12+
- **开发工具**: DevEco Studio 4.0+
- **开发语言**: ArkTS + ArkUI

## MVP 功能

✅ **番茄计时器**
- 标准 25 分钟倒计时
- 精确到秒的时间显示

✅ **控制功能**
- 开始/暂停/继续按钮
- 重置按钮

✅ **提醒功能**
- 番茄结束通知提醒
- 系统通知推送

✅ **统计功能**
- 今日完成番茄数统计
- 可视化番茄图标展示
- 跨天自动重置统计

## 项目结构

```
XiaoBaiPomodoro/
├── entry/                          # 主模块
│   ├── src/main/
│   │   ├── ets/
│   │   │   ├── entryability/       # Ability 入口
│   │   │   │   └── EntryAbility.ets
│   │   │   ├── pages/              # 页面
│   │   │   │   └── Index.ets       # 主页面
│   │   │   ├── components/         # 组件（预留）
│   │   │   └── utils/              # 工具类
│   │   │       ├── PomodoroModel.ts    # 番茄钟数据模型
│   │   │       └── NotificationUtil.ts # 通知工具
│   │   ├── resources/              # 资源文件
│   │   │   └── base/
│   │   │       ├── element/        # 元素资源
│   │   │       │   ├── string.json
│   │   │       │   └── color.json
│   │   │       ├── media/          # 媒体资源
│   │   │       └── profile/        # 配置文件
│   │   ├── app.json5               # 应用配置
│   │   └── module.json5            # 模块配置
│   ├── build-profile.json5         # 构建配置
│   ├── hvigorfile.ts               # 构建脚本
│   └── oh-package.json5            # 依赖配置
├── hvigorfile.ts                   # 根构建脚本
├── hvigor-config.json5             # 构建配置
└── oh-package.json5                # 项目依赖
```

## 核心代码说明

### 1. PomodoroModel.ts - 数据模型

**职责**: 管理番茄钟状态和统计数据

**主要功能**:
- 计时器状态管理（运行、暂停、停止）
- 时间计算和格式化
- 今日完成数统计
- 跨天自动重置

**关键方法**:
```typescript
getRemainingTime()      // 获取剩余时间
getFormattedTime()      // 获取格式化时间 (MM:SS)
incrementCompleted()    // 增加完成数
reset()                 // 重置计时器
```

### 2. NotificationUtil.ts - 通知工具

**职责**: 处理系统通知推送

**主要功能**:
- 创建通知渠道
- 发布通知
- 请求通知权限
- 取消通知

**使用场景**:
- 番茄钟完成时发送提醒
- 通知用户休息

### 3. Index.ets - 主页面

**职责**: UI 展示和用户交互

**主要组件**:
- 计时器显示（大字体时间）
- 控制按钮（开始/暂停、重置）
- 统计展示（番茄图标）
- 提示信息

**状态管理**:
```typescript
@State remainingTime: string    // 剩余时间显示
@State isRunning: boolean       // 运行状态
@State isPaused: boolean        // 暂停状态
@State todayCompleted: number   // 今日完成数
```

### 4. EntryAbility.ets - 应用入口

**职责**: 应用生命周期管理

**主要功能**:
- 加载主页面
- 请求通知权限
- 生命周期回调处理

## 技术实现

### 倒计时实现

使用 `setInterval` 实现精确倒计时：

```typescript
this.timerId = setInterval(() => {
  const currentTime = this.pomodoroModel.getRemainingTime();
  if (currentTime > 0) {
    this.pomodoroModel.setRemainingTime(currentTime - 1);
    this.updateTimeDisplay();
  } else {
    this.onTimerComplete();
  }
}, 1000);
```

### 状态管理

使用 ArkUI 的 `@State` 装饰器实现响应式状态管理：
- 状态变化自动触发 UI 刷新
- 组件间状态隔离

### 通知权限

在应用启动时主动请求通知权限：
```typescript
await NotificationUtil.requestNotificationPermission();
```

## 构建和运行

### 环境要求

- DevEco Studio 4.0+
- HarmonyOS SDK API 12+
- Node.js 14+

### 构建步骤

1. **打开项目**
   ```
   启动 DevEco Studio
   File -> Open -> 选择 XiaoBaiPomodoro 目录
   ```

2. **同步依赖**
   ```
   等待项目自动同步完成
   或手动点击：File -> Sync Project
   ```

3. **配置签名**
   ```
   File -> Project Structure -> Signing Configs
   配置自动签名或手动签名
   ```

4. **构建运行**
   ```
   点击运行按钮 (Shift + F10)
   选择目标设备或模拟器
   ```

### 构建 HAP 包

**命令行方式**:
```bash
cd XiaoBaiPomodoro
hvigorw assembleHap
```

**DevEco Studio**:
```
Build -> Build Hap(s) / APP(s) -> Build Hap(s)
```

构建产物位置：
```
entry/build/default/outputs/default/entry-default-signed.hap
```

## 使用说明

### 基本操作

1. **开始专注**
   - 点击「开始」按钮
   - 倒计时 25 分钟开始

2. **暂停/继续**
   - 运行中点击「暂停」
   - 暂停后点击「继续」

3. **重置**
   - 点击「重置」按钮
   - 计时器恢复到 25:00

4. **完成提醒**
   - 倒计时结束时自动发送通知
   - 统计数自动 +1

### 统计查看

- 主页面底部显示今日完成的番茄数
- 最多显示 5 个番茄图标
- 跨天后自动重置为 0

## UI 设计

### 配色方案

```
主色调：#FF6B6B (番茄红)
辅助色：#4ECDC4 (清新绿)
背景色：#F7F7F7 (浅灰)
文字色：#333333 / #666666
```

### 界面布局

```
┌─────────────────────┐
│   小白番茄专注钟     │
│                     │
│        🍅           │
│                     │
│      25:00          │
│                     │
│  [开始]  [重置]     │
│                     │
│  ─────────────      │
│   今日完成          │
│   🍅 🍅 🍅         │
│   3 个番茄钟        │
│                     │
│ 专注 25 分钟，休息 5 分钟│
└─────────────────────┘
```

## 后续优化方向

### 功能扩展

- [ ] 自定义番茄时长
- [ ] 短休息/长休息计时
- [ ] 历史记录统计
- [ ] 数据持久化
- [ ] 白噪音背景音
- [ ] 专注目标设定

### 体验优化

- [ ] 动画效果
- [ ] 主题切换
- [ ] 桌面小组件
- [ ] 手表端适配

### 技术优化

- [ ] 后台计时保活
- [ ] 首选项存储数据
- [ ] 单元测试覆盖
- [ ] 性能优化

## 许可证

Apache License 2.0

## 联系方式

开发者：小白 (XiaoBai)
项目地址：[待添加]

---

_专注当下，高效工作 🍅_
