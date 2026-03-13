# 测试检查清单

## 快速验证（5 分钟）

### ✅ 代码检查
- [x] 所有页面使用 `PomodoroModel.getInstance()` 而非 `new PomodoroModel()`
- [x] `EntryAbility` 在 `onCreate()` 中初始化全局单例
- [x] `saveToPreferences()` 保存 `todayCompleted` 和 `lastUpdateDate`
- [x] `loadFromPreferences()` 加载 `todayCompleted` 和 `lastUpdateDate`
- [x] `Statistics.ets` 和 `Achievements.ets` 有 `onPageShow()` 方法

### 🧪 功能测试

#### Bug 1: 统计更新测试
1. 启动应用
2. 切换到"统计"标签页，记录当前番茄数（假设是 N 个）
3. 切换回"首页"标签页
4. 开始一个番茄钟（可临时修改设置为 1 分钟以便快速测试）
5. 等待番茄钟完成
6. 切换到"统计"标签页
7. **检查**: 番茄数应该是 N+1 个
8. **检查**: 专注时长应该增加了设置的分钟数

#### Bug 2: 持久化测试
1. 完成 1-2 个番茄钟
2. 切换到"统计"标签页，确认数据已更新
3. 切换到"成就"标签页，查看成就进度
4. **完全关闭应用**（从后台清除，不是按 Home 键）
5. 等待 5 秒
6. 重新启动应用
7. 切换到"统计"标签页
8. **检查**: 数据应该和关闭前一致
9. 切换到"成就"标签页
10. **检查**: 成就进度应该和关闭前一致

#### 设置持久化测试
1. 进入"设置"标签页
2. 修改番茄时长为 30 分钟
3. 点击"保存设置"
4. 完全关闭应用
5. 重新启动应用
6. 进入"设置"标签页
7. **检查**: 番茄时长应该还是 30 分钟

### 🔍 日志检查

运行应用后，在 HiLog 中应该看到以下日志：

```
PomodoroModel initialized successfully
PomodoroModel loadFromPreferences: data loaded successfully, totalCompleted=X
PomodoroModel incrementCompleted: todayCompleted=Y, totalCompleted=Z
PomodoroModel saveToPreferences: flush completed, totalCompleted=Z, todayCompleted=Y
Statistics loadStatisticsAsync: todayCount=Y, totalCount=Z
```

## 常见问题排查

### 问题 1: 统计不更新
**检查**: 
- `Index.ets` 的 `onTimerComplete()` 是否调用了 `incrementCompleted()`
- `Statistics.ets` 是否使用 `PomodoroModel.getInstance()`
- 切换到统计页时是否触发 `onPageShow()`

### 问题 2: 重启后数据丢失
**检查**:
- `saveToPreferences()` 是否调用了 `flush()`
- `loadFromPreferences()` 是否正确加载 `todayCompleted`
- `EntryAbility.onCreate()` 是否调用了 `initialize()`

### 问题 3: 多个页面数据不一致
**检查**:
- 是否还有地方使用 `new PomodoroModel()`
- 单例的 `isInitialized` 标志是否正确设置

## 构建命令

```bash
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro
hvigorw assembleHap
```

## 部署命令

```bash
hdc install entry/build/default/outputs/hap/entry-default-signed.hap
```

## 查看日志

```bash
hdc shell hilog
```

过滤日志：
```bash
hdc shell hilog | grep "PomodoroModel"
```
