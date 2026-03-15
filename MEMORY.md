# MEMORY.md - Long-Term Memory

> Your curated memories. Distill from daily notes. Remove when outdated.

---

## About Autumn (今天)

### Key Context
- 开发者，专注于鸿蒙应用开发
- 已发布应用：小白番茄专注钟
- 正在开发：小白快跑（跑步记录应用）
- 使用 OpenClaw 作为 AI 开发助手

### Preferences Learned
- 喜欢简洁美观的 UI 设计
- 重视真机测试验证
- 希望功能开发有清晰的进展报告
- 使用飞书进行进展汇报

### Important Dates
- 2026-03-15：小白番茄专注钟发布
- 2026-03-15：小白快跑核心功能开发完成

---

## Lessons Learned

### 2026-03-15 - HarmonyOS 音频播放
**问题**：SoundPool API 参数复杂，AVPlayer 不支持 resource:// 协议
**解决**：使用 AudioRenderer + 程序生成正弦波（880Hz, 30ms）
**经验**：HarmonyOS 音频 API 文档不完善，需要多次尝试不同方案

### 2026-03-15 - HarmonyOS 命令行编译
**问题**：`DEVECO_SDK_HOME` 路径错误（多了 `/default` 后缀）
**解决**：正确路径是 `/Applications/DevEco-Studio.app/Contents/sdk`
**经验**：IDE 内部编译使用完整 SDK 配置，命令行需要正确设置环境变量

### 2026-03-15 - 高德地图集成
**问题**：动态地图 SDK 需要复杂配置
**解决**：使用高德静态地图 API（无需 SDK，URL 直接渲染）
**经验**：静态地图 API 足够满足轨迹展示需求，且更轻量

### 2026-03-15 - 模拟测试功能
**问题**：跑步功能需要真机户外测试
**解决**：开发 SimulatedTrajectoryService 模拟轨迹生成
**经验**：为测试困难的功能提供模拟模式，提高开发效率

---

## Ongoing Context

### Active Projects

#### 🏃 小白快跑 (XiaoBaiRun)
- **状态**：核心功能开发完成，待真机验证
- **已实现**：GPS定位、轨迹记录、节拍器、地图显示、模拟测试
- **待开发**：后台运行、语音播报、实时轨迹Canvas绘制
- **目标发布**：2026-03-24

#### 🍅 小白番茄专注钟
- **状态**：✅ 已发布
- **平台**：华为应用市场

#### 🌲 专注森林 (FocusForest)
- **状态**：核心功能完成，待后台服务集成
- **已实现**：专注计时器、树木展示、白噪音

### Key Decisions Made

#### 音频方案选择
- 决策：使用 AudioRenderer + 正弦波生成
- 原因：SoundPool/AVPlayer API 不稳定
- 权衡：音质简单但可靠

#### 地图方案选择
- 决策：使用高德静态地图 API
- 原因：无需 SDK 集成，URL 直接渲染
- 权衡：无交互但轻量稳定

#### 测试策略
- 决策：开发模拟轨迹功能
- 原因：跑步功能需要户外测试
- 权衡：增加代码量但提高开发效率

### Things to Remember

#### 技术栈
- HarmonyOS API 10+
- ArkTS / ArkUI
- 高德静态地图 API
- AudioRenderer 音频播放

#### 关键文件位置
- 首页：`entry/src/main/ets/pages/Index.ets`
- 节拍器服务：`entry/src/main/ets/services/MetronomeService.ts`
- 轨迹服务：`entry/src/main/ets/services/RunTrackerService.ts`
- 模拟轨迹：`entry/src/main/ets/services/SimulatedTrajectoryService.ts`
- 编译脚本：`sdk-env.sh`, `build.sh`

#### OpenClaw 技能
- 位置：`~/.openclaw/skills/`
- 跑步轨迹技能：`run_tracker.trajectory` v1.0.0

---

## Relationships & People

### 开发协作
- 使用飞书进行进展汇报
- 使用 OpenClaw 进行 AI 辅助开发

---

*最后更新：2026-03-15 21:35*