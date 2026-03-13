# 小白番茄专注钟 - Bug 列表

**项目名称**: 小白番茄专注钟 (XiaoBai Pomodoro)  
**测试工程师**: 正男 (ZhengNan)  
**报告日期**: 2026-03-08  
**Bug 总数**: 4

---

## Bug 汇总

| 严重程度 | 数量 | 占比 |
|----------|------|------|
| 🔴 致命 | 0 | 0% |
| 🟠 严重 | 0 | 0% |
| 🟡 中等 | 3 | 75% |
| 🟢 轻微 | 1 | 25% |

---

## Bug 详情

### BUG-001: 通知发送无错误处理

| 项目 | 内容 |
|------|------|
| **严重程度** | 🟡 中等 |
| **模块** | NotificationUtil.ts |
| **发现日期** | 2026-03-08 |
| **状态** | 待修复 |
| **优先级** | P2 |

**问题描述**:
`publishNotification()` 方法虽然有 try-catch，但捕获错误后只在 console 中打印，没有给用户任何反馈。如果通知权限被拒绝或通知服务不可用，用户不会知道提醒已失败。

**复现步骤**:
1. 在系统设置中拒绝应用的通知权限
2. 完成一个番茄钟
3. 观察用户是否能得知通知失败

**预期结果**:
- 通知发送失败时，应在 UI 上提示用户

**实际结果**:
- 静默失败，用户不知道通知未发送

**影响范围**:
- 用户可能错过番茄结束的提醒
- 用户体验下降

**修复建议**:
```typescript
// Index.ets - onTimerComplete() 方法
async onTimerComplete() {
  this.stopTimer();
  
  this.pomodoroModel.incrementCompleted();
  this.todayCompleted = this.pomodoroModel.getTodayCompleted();
  
  try {
    await NotificationUtil.publishNotification(
      '🍅 番茄钟完成！',
      '恭喜完成一个番茄钟，休息一下吧！'
    );
  } catch (error) {
    // 在 UI 上显示提示
    this.showCompletionToast();
  }
  
  this.pomodoroModel.reset();
  this.updateTimeDisplay();
}

// 添加一个备用的 UI 提示方法
showCompletionToast() {
  // 使用 Toast 或 Dialog 提示用户
}
```

**相关文件**:
- `entry/src/main/ets/utils/NotificationUtil.ts` (第 28-45 行)
- `entry/src/main/ets/pages/Index.ets` (第 124-140 行)

---

### BUG-002: PomodoroModel 的 lastUpdateDate 初始化问题

| 项目 | 内容 |
|------|------|
| **严重程度** | 🟢 轻微 |
| **模块** | PomodoroModel.ts |
| **发现日期** | 2026-03-08 |
| **状态** | 待修复 |
| **优先级** | P3 |

**问题描述**:
`lastUpdateDate` 初始值为空字符串，在首次调用 `getTodayCompleted()` 或 `incrementCompleted()` 时会被设置为当前日期。这本身没有问题，但如果 Model 对象被序列化存储后再反序列化，可能会出现边界情况。

**复现步骤**:
1. 完成几个番茄钟
2. 应用被杀死（Model 状态丢失）
3. 第二天重新启动应用
4. 检查统计是否正确重置

**预期结果**:
- 新的一天，统计应自动重置为 0

**实际结果**:
- 当前实现基本正确，但初始化不够明确

**影响范围**:
- 边界情况下可能出现统计不准确
- 代码可读性降低

**修复建议**:
```typescript
export class PomodoroModel {
  private static readonly STANDARD_POMODORO_DURATION: number = 25 * 60;
  private remainingTime: number = PomodoroModel.STANDARD_POMODORO_DURATION;
  private isRunning: boolean = false;
  private isPaused: boolean = false;
  private todayCompleted: number = 0;
  // 改进：在构造函数中初始化
  private lastUpdateDate: string;
  
  constructor() {
    this.lastUpdateDate = new Date().toLocaleDateString('zh-CN');
  }
  
  // ... 其他方法保持不变
}
```

**相关文件**:
- `entry/src/main/ets/utils/PomodoroModel.ts` (第 25 行)

---

### BUG-003: 固定字体大小，小屏设备适配问题

| 项目 | 内容 |
|------|------|
| **严重程度** | 🟡 中等 |
| **模块** | Index.ets |
| **发现日期** | 2026-03-08 |
| **状态** | 待修复 |
| **优先级** | P2 |

**问题描述**:
主页面使用固定字体大小（时间显示 72px，标题 24px，番茄图标 80px），在小屏设备（5.0 英寸或更小）上可能导致内容显示不全或被截断。

**复现步骤**:
1. 在 5.0 英寸小屏设备上运行应用
2. 观察时间显示和番茄图标
3. 检查是否有内容超出屏幕

**预期结果**:
- 所有内容在小屏设备上完整显示
- 无截断、无重叠

**实际结果**:
- 大字体可能在小屏上显示不全（需真机验证）

**影响范围**:
- 小屏设备用户体验差
- 可能无法看到完整的时间显示

**修复建议**:

**方案 1: 使用响应式字体**
```typescript
// 根据屏幕宽度动态计算字体大小
@State screenWidth: number = 0;

aboutToAppear() {
  // 获取屏幕宽度
  const display = window.getWindowStage()?.getDefaultWindow();
  this.screenWidth = display?.getWindowSize().width ?? 360;
  
  // 计算合适的字体大小
  this.timeFontSize = Math.min(72, this.screenWidth * 0.2);
}

// 在 build 中使用
Text(this.remainingTime)
  .fontSize(this.timeFontSize)
```

**方案 2: 添加最小宽度约束**
```typescript
Column() {
  // ... 内容
}
.minWidth('100%')
.scrollable(ScrollDirection.Vertical)
```

**方案 3: 使用相对单位**
```typescript
// 使用 vp (virtual pixels) 而非 px
Text('小白番茄专注钟')
  .fontSize('6vp')  // 而非 24
```

**相关文件**:
- `entry/src/main/ets/pages/Index.ets` (第 155-200 行)

---

### BUG-004: 后台运行时计时器未正确处理

| 项目 | 内容 |
|------|------|
| **严重程度** | 🟡 中等 |
| **模块** | EntryAbility.ets |
| **发现日期** | 2026-03-08 |
| **状态** | 待修复 |
| **优先级** | P1 (发布前必须修复) |

**问题描述**:
当应用进入后台时，`EntryAbility` 的 `onBackground()` 方法只记录日志，没有暂停计时器。这会导致：
1. 后台继续耗电
2. 如果系统杀死后台进程，计时器状态丢失
3. 用户切回前台时，时间可能不准确（取决于系统是否暂停了 setInterval）

**复现步骤**:
1. 启动番茄钟计时器
2. 按 Home 键将应用切换到后台
3. 等待 5 分钟
4. 切回应用，检查计时器状态

**预期结果**:
- 方案 A: 计时器在后台暂停，切回后继续
- 方案 B: 计时器在后台继续运行，时间准确

**实际结果**:
- 当前行为不确定（取决于 HarmonyOS 系统策略）
- 没有明确的后台管理逻辑

**影响范围**:
- 电量消耗增加
- 计时器可能不准确
- 用户体验下降

**修复建议**:

**方案 1: 后台暂停（推荐，简单）**
```typescript
// EntryAbility.ets
import { PomodoroModel } from '../utils/PomodoroModel';

// 使用单例或全局状态管理
let pomodoroModel: PomodoroModel | null = null;

export default class EntryAbility extends UIAbility {
  onBackground(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onBackground');
    
    // 暂停计时器
    if (pomodoroModel && pomodoroModel.getIsRunning() && !pomodoroModel.getIsPaused()) {
      pomodoroModel.setIsPaused(true);
      // 通知页面暂停
    }
  }
  
  onForeground(): void {
    hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onForeground');
    
    // 恢复计时器（如果之前是暂停状态）
    if (pomodoroModel && pomodoroModel.getIsPaused()) {
      pomodoroModel.setIsPaused(false);
      // 通知页面恢复
    }
  }
}
```

**方案 2: 使用时间戳校准（更准确）**
```typescript
// 在 Model 中记录开始时间戳
private startTime: number = 0;

startTimer() {
  this.startTime = Date.now();
  // ...
}

// 每次更新时计算实际经过的时间
getActualRemainingTime(): number {
  if (!this.isRunning || this.isPaused) {
    return this.remainingTime;
  }
  
  const elapsed = Math.floor((Date.now() - this.startTime) / 1000);
  return Math.max(0, this.remainingTime - elapsed);
}
```

**方案 3: 使用后台任务服务（最复杂，但最可靠）**
```typescript
// 使用 HarmonyOS 的后台任务服务
import { taskManager } from '@kit.TaskManagerKit';

// 注册后台任务
await taskManager.startTask({
  type: 'timer',
  // ...
});
```

**推荐**: 方案 1（简单实用）或方案 2（时间准确）

**相关文件**:
- `entry/src/main/ets/entryability/EntryAbility.ets` (第 53-62 行)
- `entry/src/main/ets/pages/Index.ets` (需要添加状态同步)

---

## Bug 趋势

```
严重程度分布:
中等 (🟡): ████████████████████ 75%
轻微 (🟢): █████ 25%

模块分布:
Index.ets:         ██████████ 25%
PomodoroModel.ts:  █████ 25%
NotificationUtil.ts: █████ 25%
EntryAbility.ets:  ██████████ 25%
```

---

## 修复优先级

### 发布前必须修复 (P1)
- [ ] BUG-004: 后台运行时计时器管理

### 尽快修复 (P2)
- [ ] BUG-001: 通知错误处理
- [ ] BUG-003: 小屏适配问题

### 可延后修复 (P3)
- [ ] BUG-002: Model 初始化问题

---

## 验证计划

每个 Bug 修复后需要验证：

| Bug 编号 | 验证方法 | 验收标准 |
|----------|----------|----------|
| BUG-001 | 模拟通知失败场景 | UI 显示备用提示 |
| BUG-002 | 代码审查 + 单元测试 | 构造函数正确初始化 |
| BUG-003 | 小屏设备真机测试 | 内容完整显示 |
| BUG-004 | 后台切换测试 | 计时器正确暂停/恢复 |

---

*文档版本：1.0*  
*最后更新：2026-03-08 11:35*
