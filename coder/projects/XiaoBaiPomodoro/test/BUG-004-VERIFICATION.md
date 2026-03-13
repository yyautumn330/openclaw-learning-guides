# BUG-004 修复验证指南

## 修复内容

### 1. 新增文件
- `entry/src/main/ets/services/BackgroundTaskService.ts` - 后台任务服务

### 2. 修改文件
- `entry/src/main/ets/entryability/EntryAbility.ets` - 添加应用状态监听和后台任务管理
- `entry/src/main/ets/pages/Index.ets` - 与后台服务同步计时器状态
- `entry/src/main/module.json5` - 添加后台任务权限
- `entry/src/main/resources/base/element/string.json` - 添加权限说明

## 修复要点

### 1. 后台任务能力 (BackgroundTask)
✅ 使用 `@kit.BackgroundTaskKit` 的 `backgroundTaskManager.startTask()` 申请后台任务
✅ 设置任务类型为 `TYPE_SHORT_TERM`（短期后台任务）
✅ 在计时器启动时申请后台任务，暂停/停止时释放

### 2. 计时器后台运行
✅ 计时器逻辑移至 `BackgroundTaskService` 单例服务
✅ 后台服务独立于 UI 运行，不受页面生命周期影响
✅ UI 层只负责显示，实际计时由后台服务管理

### 3. 应用状态监听
✅ `EntryAbility.onForeground()` - 应用回到前台时恢复 UI 同步
✅ `EntryAbility.onBackground()` - 应用进入后台时确保后台任务继续
✅ `Index.aboutToAppear()` - 页面加载时从后台服务恢复状态

### 4. 状态同步机制
✅ 后台服务通过回调通知 UI 更新
✅ 页面从后台切回时自动同步计时器状态
✅ 计时器完成时同时通知 UI 和发送通知

## 测试步骤

### 测试 1: 基本后台运行测试
1. 启动应用
2. 点击"开始"按钮启动计时器
3. 等待 5 秒，确认计时器正常倒计时
4. **切换到后台**（按 Home 键或手势）
5. 等待 1 分钟
6. **切回前台**
7. ✅ **预期结果**: 计时器应显示减少了约 60 秒的时间

### 测试 2: 多次前后台切换测试
1. 启动计时器
2. 切换到后台，等待 30 秒
3. 切回前台，确认时间正确
4. 再次切换到后台，等待 30 秒
5. 再次切回前台
6. ✅ **预期结果**: 计时器累计减少约 60 秒，时间连续准确

### 测试 3: 后台暂停测试
1. 启动计时器，运行 10 秒
2. 切换到后台
3. 立即切回前台
4. 点击"暂停"按钮
5. 等待 30 秒
6. ✅ **预期结果**: 计时器应保持在暂停时的时间，不会继续减少

### 测试 4: 后台完成测试
1. 修改计时器为 1 分钟（临时测试用）
2. 启动计时器
3. 立即切换到后台
4. 等待 1 分钟
5. ✅ **预期结果**: 
   - 应收到番茄钟完成通知
   - 切回前台时计时器已重置为 25:00
   - 今日完成数增加 1

### 测试 5: 应用重启恢复测试
1. 启动计时器，运行 30 秒
2. 切换到后台
3. 从任务管理器完全关闭应用
4. 重新启动应用
5. ✅ **预期结果**: 
   - 当前版本：计时器重置（需要未来版本支持持久化）
   - 日志中应看到后台任务清理记录

## 日志检查

运行以下命令查看日志：

```bash
# 查看后台任务相关日志
hdc shell hilog | grep "BackgroundTaskService"

# 查看 Ability 状态日志
hdc shell hilog | grep "EntryAbility"

# 查看计时器日志
hdc shell hilog | grep "Timer"
```

### 关键日志点
- `BackgroundTaskService initialized` - 服务初始化成功
- `Background task started, taskId: XXX` - 后台任务启动成功
- `Timer started, remaining time: XXX` - 计时器启动
- `Timer tick, remaining: XXX` - 计时器正常运行
- `App went to background, ensuring background task continues` - 后台切换处理
- `App returned to foreground, timer is running` - 前台切换处理

## 代码审查清单

- [x] 后台任务服务使用单例模式
- [x] 计时器逻辑与 UI 分离
- [x] 应用状态变化正确处理
- [x] 权限配置完整
- [x] 回调机制避免内存泄漏
- [x] 日志记录便于调试
- [x] 异常处理完善

## 已知限制

1. **长期后台运行**: 当前使用短期后台任务（TYPE_SHORT_TERM），适合番茄钟场景。如需更长时间后台运行，需申请长期后台任务权限。

2. **状态持久化**: 当前版本未在应用完全关闭后保存计时器状态。未来版本可添加本地数据存储。

3. **精确计时**: 极端情况下（系统资源紧张），后台任务可能被系统限制。建议配合通知提醒作为双重保险。

## 回滚方案

如需回滚到修复前版本：

```bash
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro
git stash  # 或 git checkout <commit-hash>
```

---

**修复完成时间**: 2026-03-08  
**修复工程师**: 小新 (XiaoXin)  
**Bug ID**: BUG-004  
**优先级**: P1 (高)
