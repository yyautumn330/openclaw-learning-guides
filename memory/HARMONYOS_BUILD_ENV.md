# HarmonyOS 命令行编译环境配置

## 问题
命令行 `hvigorw` 编译报错 `SDK component missing`

## 原因
HarmonyOS SDK 需要通过 DevEco Studio 的 SDK Manager 下载完整组件，包括：
- HarmonyOS SDK (HMS)
- OpenHarmony SDK
- 工具链

## 解决方案

### 方法 1：使用 DevEco Studio 编译（推荐）
1. 打开 DevEco Studio
2. 打开项目
3. 点击 `Build > Build Hap(s)`
4. 验证编译通过
5. 点击运行按钮测试

### 方法 2：命令行编译
需要先在 DevEco Studio 中下载 SDK：
1. 打开 DevEco Studio
2. `Preferences > HarmonyOS SDK`
3. 下载 HarmonyOS SDK 6.0.1(21) 及以上版本
4. 设置环境变量：
   ```bash
   export DEVECO_SDK_HOME=~/Library/Huawei/Sdk
   ```

## 当前状态
- ✅ DevEco Studio 编译可用
- ⚠️ 命令行编译需要完整 SDK

---

*创建时间：2026-03-15*