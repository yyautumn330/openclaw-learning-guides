# 小白番茄专注钟 - 快速构建指南

## 前置要求

- DevEco Studio 4.0+
- HarmonyOS SDK API 10+
- Node.js 16+

## 构建步骤

### 1. 打开项目
```bash
# 在 DevEco Studio 中打开项目
open -a "DevEco Studio" /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro
```

### 2. 同步依赖
在 DevEco Studio 中：
- 点击 `File` > `Sync Project`
- 或点击工具栏的 🔄 同步按钮

### 3. 构建项目
```bash
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro
hvigorw assembleHap
```

### 4. 运行应用
- 连接 HarmonyOS 设备或启动模拟器
- 在 DevEco Studio 中点击 ▶️ 运行按钮
- 或使用命令：`hvigorw assembleHap -p mode=debug`

## 新增功能测试

### 测试设置功能
1. 启动应用
2. 点击底部「设置」标签 (⚙️)
3. 调整番茄时长滑块 (15-60 分钟)
4. 点击「保存设置」
5. 返回首页，验证计时器时长已更新
6. 点击「重置默认」，验证恢复为 25 分钟

### 测试成就系统
1. 点击底部「成就」标签 (🏆)
2. 查看成就列表和进度
3. 完成一个番茄钟
4. 返回成就页面，验证「新手入门」成就已解锁
5. 查看解锁日期显示

### 测试统计功能
1. 点击底部「统计」标签 (📊)
2. 查看今日统计数据
3. 切换周/月视图
4. 查看柱状图显示
5. 完成多个番茄后验证数据更新

### 测试数据持久化
1. 修改设置并保存
2. 关闭应用
3. 重新启动应用
4. 验证设置、成就、统计数据已恢复

## 文件结构

```
XiaoBaiPomodoro/
├── entry/
│   └── src/
│       └── main/
│           ├── ets/
│           │   ├── pages/
│           │   │   ├── Index.ets          # 主页面
│           │   │   ├── Statistics.ets     # 统计页面 ⭐新增
│           │   │   ├── Achievements.ets   # 成就页面 ⭐新增
│           │   │   └── Settings.ets       # 设置页面 ⭐新增
│           │   ├── utils/
│           │   │   └── PomodoroModel.ts   # 数据模型 ⭐已扩展
│           │   ├── services/
│           │   │   └── BackgroundTaskService.ts
│           │   └── entryability/
│           │       └── EntryAbility.ets
│           └── resources/
├── design/                    # 设计稿
├── IMPLEMENTATION_SUMMARY.md  # 实现总结 ⭐新增
└── QUICK_START.md            # 本文件 ⭐新增
```

## 常见问题

### Q: 设置保存后不生效？
A: 确保点击了「保存设置」按钮，然后返回首页查看计时器时长是否更新。

### Q: 成就没有自动解锁？
A: 完成番茄钟后会自动检测成就条件。检查成就页面查看解锁状态。

### Q: 统计数据不准确？
A: 统计数据在番茄完成后自动更新。确保应用有足够权限访问系统时间。

### Q: 应用崩溃？
A: 检查日志：
```bash
hdc shell hilog
```

## 代码质量检查

### 编译检查
```bash
# 在 DevEco Studio 中
# 点击 Build > Make Project
```

### 代码规范
- 使用 ArkTS 严格模式
- 遵循 HarmonyOS 代码规范
- 关键代码已添加注释

## 下一步

1. ✅ 完成核心功能开发
2. ⏳ 进行功能测试
3. ⏳ 优化 UI/UX
4. ⏳ 准备应用市场发布

## 联系支持

如有问题，请查看：
- `IMPLEMENTATION_SUMMARY.md` - 详细实现文档
- 设计稿目录 `design/` - UI 设计参考

---

*最后更新：2026-03-08*
*开发者：小新 (XiaoXin)*
