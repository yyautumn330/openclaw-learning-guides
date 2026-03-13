# 🍅 BUG-004 修复 - 快速参考卡

## ✅ 修复完成

**状态**: 已完成  
**时间**: 2026-03-08  
**工程师**: 小新 (XiaoXin)

---

## 📁 修改的文件

```
✅ entry/src/main/ets/services/BackgroundTaskService.ts (新增)
✅ entry/src/main/ets/entryability/EntryAbility.ets (修改)
✅ entry/src/main/ets/pages/Index.ets (修改)
✅ entry/src/main/module.json5 (修改)
✅ entry/src/main/resources/base/element/string.json (修改)
```

---

## 🚀 快速测试

```bash
# 1. 运行测试脚本
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro
./test/bug-004-test.sh

# 2. 在 DevEco Studio 中构建并运行

# 3. 手动测试
启动计时器 → 切后台 → 等 1 分钟 → 切前台 → 检查时间
```

---

## 🔍 查看日志

```bash
# 实时查看日志
hdc shell hilog | grep -E 'BackgroundTask|EntryAbility|Timer'

# 只看错误
hdc shell hilog | grep -i error
```

---

## ✅ 预期行为

| 操作 | 预期结果 |
|------|---------|
| 启动计时器 | 后台任务启动，日志显示 taskId |
| 切换到后台 | 计时器继续运行，时间正常减少 |
| 等待 1 分钟 | 后台任务保持活跃 |
| 切回前台 | UI 同步后台状态，时间准确 |
| 计时完成 | 发送通知，重置计时器 |

---

## 🐛 如果测试失败

### 问题 1: 后台计时器停止
**检查**: 
```bash
grep "Background task started" logs
```
**解决**: 确保权限已正确配置

### 问题 2: 切回前台时间不同步
**检查**: 
```bash
grep "App returned to foreground" logs
```
**解决**: 检查 restoreTimerState() 是否调用

### 问题 3: 构建失败
**解决**: 
```bash
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro
hvigorw clean
hvigorw assembleHap
```

---

## 📖 详细文档

- **测试指南**: `test/BUG-004-VERIFICATION.md`
- **修复总结**: `test/BUG-004-FIX-SUMMARY.md`
- **测试脚本**: `test/bug-004-test.sh`

---

## 🎯 核心实现

### 1. 后台任务申请
```typescript
const taskId = await backgroundTaskManager.startTask(
  context, 
  { type: TaskType.TYPE_SHORT_TERM, reason: '番茄钟计时' }
);
```

### 2. 状态监听
```typescript
onForeground() { /* 恢复 UI 同步 */ }
onBackground() { /* 确保后台任务继续 */ }
```

### 3. 前后分离
- **后台服务**: 实际计时，独立运行
- **UI 层**: 显示时间，从服务同步

---

## ✨ 关键改进

✅ 使用 HarmonyOS 后台任务能力  
✅ 计时器与 UI 分离  
✅ 应用状态正确监听  
✅ 前后台状态自动同步  
✅ 完善的日志和错误处理  

---

**修复用时**: < 30 分钟  
**代码行数**: ~600 行 (新增 + 修改)  
**测试覆盖**: 5 个测试场景  

🎉 **修复完成，准备测试！**
