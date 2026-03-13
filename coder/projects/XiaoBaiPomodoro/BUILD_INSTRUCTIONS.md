# 小白番茄专注钟 - HAP 构建说明

## 项目信息
- **项目名称**: XiaoBaiPomodoro
- **包名**: com.aixiaobai.pomodoro
- **版本**: 1.0.0
- **API 版本**: 12 (HarmonyOS NEXT)
- **项目位置**: `/Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro/`

## 构建环境
- **DevEco Studio**: 已安装 (`/Applications/DevEco-Studio.app`)
- **Hvigor 版本**: 6.22.3
- **Node.js**: v25.6.1

## 当前状态

### ✅ 已完成
1. 项目结构检查 - 完整
2. 入口模块配置 - 完整 (entry/)
3. 应用配置文件 - 完整 (app.json5, module.json5)
4. 构建配置文件 - 已创建 (build-profile.json5, hvigor-config.json5)
5. Hvigor 插件依赖 - 已配置符号链接

### ⚠️ 构建问题
当前遇到 Hvigor 6.x 配置兼容性问题：
- `hvigor-config.json5` 的 `modelVersion` 无法被正确读取
- 需要 DevEco Studio 项目迁移工具升级配置

## 构建方法

### 方法一：使用 DevEco Studio GUI（推荐）

1. **打开项目**
   ```
   打开 DevEco Studio
   File → Open → 选择 /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro/
   ```

2. **等待项目同步**
   - DevEco Studio 会自动检测配置问题
   - 按照提示升级项目结构（如有需要）

3. **配置签名**
   ```
   File → Project Structure → Signing Configs
   - 选择 "Automatically generate signature" (自动生成签名)
   - 或者使用调试证书
   ```

4. **构建 HAP**
   ```
   Build → Build Hap(s) / APP(s) → Build Hap(s)
   或使用快捷键：Build → Build Hap(s)
   ```

5. **获取 HAP 包**
   - 构建成功后，HAP 包位于：
   ```
   entry/build/default/outputs/default/entry-default-signed.hap
   ```

### 方法二：使用命令行（需要修复配置）

```bash
cd /Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro

# 使用 DevEco Studio 的 hvigor 构建
/Applications/DevEco-Studio.app/Contents/tools/hvigor/hvigor/bin/hvigor.js assembleHap --no-daemon
```

## HAP 输出位置

构建成功后，HAP 包将在以下位置：
```
/Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro/entry/build/default/outputs/default/entry-default-signed.hap
```

## 项目结构

```
XiaoBaiPomodoro/
├── entry/                      # 主模块
│   ├── src/main/
│   │   ├── ets/               # ArkTS 源代码
│   │   ├── resources/         # 资源文件
│   │   ├── app.json5          # 应用配置
│   │   └── module.json5       # 模块配置
│   ├── build-profile.json5    # 模块构建配置
│   └── hvigorfile.ts          # 模块构建脚本
├── build-profile.json5         # 项目构建配置
├── hvigor-config.json5         # Hvigor 配置
├── hvigorfile.ts              # 项目构建脚本
└── oh-package.json5           # 依赖配置
```

## 签名配置

当前配置使用调试签名（开发环境）：
- **签名类型**: Debug
- **签名算法**: SHA256withECDSA
- **自动签名**: 建议在 DevEco Studio 中配置自动生成

## 下一步操作

1. **使用 DevEco Studio 打开项目**
2. **让 IDE 自动修复配置问题**
3. **执行构建**
4. **获取 HAP 安装包**

## 联系信息

如有构建问题，请检查：
- DevEco Studio 版本是否最新
- HarmonyOS SDK 是否已安装
- 项目配置是否与 SDK 版本匹配

---
**构建时间**: 2026-03-08
**构建工程师**: 小新 (XiaoXin)
