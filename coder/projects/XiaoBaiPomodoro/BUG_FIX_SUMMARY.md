# Bug 修复总结 - 番茄钟统计和持久化问题

## 修复日期
2026-03-08

## 问题描述

### Bug 1: 完成番茄钟后没有统计到统计页
**现象**: 完成一个番茄钟后，统计页面的数据没有增加

### Bug 2: 重启应用后完成数据丢失未落盘
**现象**: 重启应用后，完成的番茄钟数据丢失

## 根本原因

1. **多实例问题**: `Index.ets`、`Statistics.ets`、`Achievements.ets`、`Settings.ets` 各自创建了独立的 `PomodoroModel` 实例，导致数据不同步
2. **初始化时机**: `EntryAbility` 没有在应用启动时初始化全局的 `PomodoroModel`
3. **数据持久化**: `todayCompleted` 字段没有保存到 Preferences
4. **页面刷新**: 统计页面没有在每次显示时重新加载数据

## 修复方案

### 1. PomodoroModel 单例模式 (`entry/src/main/ets/utils/PomodoroModel.ts`)

**修改内容**:
- 添加私有构造函数，防止外部直接实例化
- 添加 `getInstance()` 静态方法获取单例实例
- 添加 `isInitialized` 标志，防止重复初始化
- 添加 `resetInstance()` 方法用于测试

```typescript
private static instance: PomodoroModel | null = null;

private constructor() {}

static getInstance(): PomodoroModel {
  if (!PomodoroModel.instance) {
    PomodoroModel.instance = new PomodoroModel();
  }
  return PomodoroModel.instance;
}

async initialize(context: common.UIAbilityContext): Promise<void> {
  if (this.isInitialized) {
    console.info('PomodoroModel already initialized, skipping');
    return;
  }
  // ... 初始化逻辑
  this.isInitialized = true;
}
```

### 2. 更新所有页面使用单例 (`Index.ets`, `Statistics.ets`, `Achievements.ets`, `Settings.ets`)

**修改内容**:
```typescript
// 之前
private pomodoroModel: PomodoroModel = new PomodoroModel();

// 之后
private pomodoroModel: PomodoroModel = PomodoroModel.getInstance();
```

### 3. EntryAbility 初始化全局单例 (`entry/src/main/ets/entryability/EntryAbility.ets`)

**修改内容**:
```typescript
async onCreate(want: Want, launchParam: AbilityConstant.LaunchParam): Promise<void> {
  hilog.info(DOMAIN, TAG, '%{public}s', 'Ability onCreate');
  
  if (this.context) {
    this.backgroundTaskService.init(this.context);
    
    // 初始化全局 PomodoroModel 单例，确保统计数据加载
    const pomodoroModel = PomodoroModel.getInstance();
    await pomodoroModel.initialize(this.context);
    hilog.info(DOMAIN, TAG, 'PomodoroModel initialized in EntryAbility');
  }
}
```

### 4. 增强数据持久化 (`PomodoroModel.ts`)

**修改内容**:
- `saveToPreferences()`: 添加保存 `todayCompleted` 和 `lastUpdateDate`
- `loadFromPreferences()`: 添加加载 `todayCompleted` 和 `lastUpdateDate`
- 添加调试日志，便于排查问题

```typescript
// saveToPreferences
await this.preferencesInstance.put('todayCompleted', this.todayCompleted);
await this.preferencesInstance.put('lastUpdateDate', this.lastUpdateDate);
await this.preferencesInstance.flush();
console.info('PomodoroModel saveToPreferences: flush completed, totalCompleted=', this.totalCompleted, ', todayCompleted=', this.todayCompleted);

// loadFromPreferences
this.todayCompleted = await this.preferencesInstance.get('todayCompleted', 0) as number || 0;
this.lastUpdateDate = await this.preferencesInstance.get('lastUpdateDate', '') as string || '';
console.info('PomodoroModel loadFromPreferences: data loaded successfully, totalCompleted=', this.totalCompleted);
```

### 5. 统计页面主动刷新 (`Statistics.ets`)

**修改内容**:
- 添加 `onPageShow()` 生命周期方法
- 添加 `loadStatisticsAsync()` 方法
- 每次页面显示时重新加载统计数据

```typescript
async onPageShow() {
  // 每次页面显示时重新加载统计数据，确保数据最新
  await this.loadStatisticsAsync();
}

async loadStatisticsAsync() {
  // 确保模型已初始化
  if (!this.pomodoroModel) {
    this.pomodoroModel = PomodoroModel.getInstance();
  }
  
  const stats = this.pomodoroModel.getStats();
  this.todayCount = stats.today.count;
  // ... 更新其他状态
}
```

### 6. 成就页面主动刷新 (`Achievements.ets`)

**修改内容**:
- 添加 `onPageShow()` 生命周期方法
- 添加 `loadAchievementsAsync()` 方法

### 7. 后台任务服务使用单例 (`BackgroundTaskService.ts`)

**修改内容**:
```typescript
init(context: common.UIAbilityContext): void {
  this.context = context;
  // 使用单例模式获取 PomodoroModel，确保数据一致性
  this.pomodoroModel = PomodoroModel.getInstance();
  hilog.info(DOMAIN, TAG, 'BackgroundTaskService initialized');
}
```

## 测试验证步骤

### 测试 Bug 1 修复
1. 启动应用
2. 开始一个番茄钟（可缩短测试时间）
3. 等待番茄钟完成
4. 切换到"统计"页面
5. **预期结果**: 统计数据立即更新，显示新增的番茄数 ✅

### 测试 Bug 2 修复
1. 完成 1-2 个番茄钟
2. 查看统计页面，确认数据已增加
3. 完全关闭应用（从后台清除）
4. 重新启动应用
5. 查看统计页面
6. **预期结果**: 统计数据保持，没有丢失 ✅

### 额外测试
1. 修改设置（番茄时长）
2. 完成一个番茄钟
3. 检查统计是否使用新时长计算专注时间 ✅
4. 重启应用后检查设置是否保持 ✅

## 修改文件列表

1. `entry/src/main/ets/utils/PomodoroModel.ts` - 核心数据模型（单例模式 + 持久化增强）
2. `entry/src/main/ets/pages/Index.ets` - 首页（使用单例）
3. `entry/src/main/ets/pages/Statistics.ets` - 统计页（使用单例 + onPageShow 刷新）
4. `entry/src/main/ets/pages/Achievements.ets` - 成就页（使用单例 + onPageShow 刷新）
5. `entry/src/main/ets/pages/Settings.ets` - 设置页（使用单例）
6. `entry/src/main/ets/entryability/EntryAbility.ets` - 应用入口（初始化全局单例）
7. `entry/src/main/ets/services/BackgroundTaskService.ts` - 后台服务（使用单例）

## 技术要点

1. **单例模式**: 确保全局只有一个 `PomodoroModel` 实例，所有页面共享同一份数据
2. **延迟初始化**: `initialize()` 方法只执行一次，避免重复加载 Preferences
3. **数据持久化**: 所有关键数据都保存到 Preferences，包括 `todayCompleted`
4. **页面生命周期**: 利用 `onPageShow()` 确保页面显示时数据最新
5. **调试日志**: 添加详细日志，便于后续问题排查

## 注意事项

1. 单例模式要求 `EntryAbility.onCreate()` 先于任何页面加载执行
2. `Preferences.flush()` 是异步操作，必须 `await` 确保数据落盘
3. `onPageShow()` 在每次页面显示时都会调用，包括从其他 Tab 切换回来
4. 测试时需要完全关闭应用（清除后台）来验证持久化效果

## 后续优化建议

1. 添加数据导出/导入功能
2. 添加云同步功能
3. 添加数据统计图表
4. 添加番茄钟历史记录查看
