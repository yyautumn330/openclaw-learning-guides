# 构建指南

## 快速开始

### 1. 环境准备

确保已安装以下工具：

- **DevEco Studio 4.0+** 
  - 下载地址：https://developer.harmonyos.com/cn/tools
  - 安装后配置 HarmonyOS SDK API 12+

- **Node.js 14+**
  ```bash
  node -v  # 检查版本
  ```

### 2. 打开项目

1. 启动 DevEco Studio
2. `File` -> `Open`
3. 选择 `XiaoBaiPomodoro` 文件夹
4. 等待项目同步完成

### 3. 配置签名

#### 方式一：自动签名（推荐开发测试使用）

1. `File` -> `Project Structure`
2. 选择 `Signing Configs`
3. 勾选 `Automatically generate signature`
4. 点击 `OK`

#### 方式二：手动签名

1. 准备签名证书文件
2. `File` -> `Project Structure` -> `Signing Configs`
3. 配置证书路径和密码
4. 点击 `OK`

### 4. 准备图标资源

在以下位置添加应用图标：

```
entry/src/main/resources/base/media/
├── app_icon.png  (512x512)
└── icon.png      (512x512)
```

**临时方案**：可以使用任意 512x512 PNG 图片重命名替代

### 5. 构建运行

#### 运行到模拟器

1. `Tools` -> `Device Manager`
2. 下载并启动 HarmonyOS 模拟器
3. 点击运行按钮 (▶️) 或 `Shift + F10`

#### 运行到真机

1. 手机开启开发者模式
2. USB 连接电脑
3. 点击运行按钮 (▶️)

### 6. 构建 HAP 包

#### 方法一：DevEco Studio

```
Build -> Build Hap(s) / APP(s) -> Build Hap(s)
```

#### 方法二：命令行

```bash
cd /path/to/XiaoBaiPomodoro
hvigorw assembleHap
```

构建产物位置：
```
entry/build/default/outputs/default/entry-default-signed.hap
```

## 常见问题

### Q1: 项目同步失败

**解决方案**:
```bash
# 清理缓存
hvigorw clean

# 重新同步
hvigorw --refresh
```

### Q2: SDK 版本不匹配

**解决方案**:
1. 打开 DevEco Studio
2. `File` -> `Settings` -> `SDK`
3. 安装或更新 HarmonyOS SDK API 12

### Q3: 签名配置错误

**解决方案**:
1. 删除旧的签名配置
2. 重新生成自动签名
3. 确保设备在信任列表中

### Q4: 通知权限无法获取

**解决方案**:
1. 检查 `module.json5` 中的权限声明
2. 确保在真机上测试（模拟器可能有限制）
3. 手动在系统设置中授权

### Q5: 构建产物找不到

**解决方案**:
```bash
# 检查构建输出目录
ls -la entry/build/default/outputs/

# 重新构建
hvigorw assembleHap --mode release
```

## 构建产物说明

### HAP 文件

- **文件名**: `entry-default-signed.hap`
- **大小**: 约 1-2 MB
- **用途**: 安装到 HarmonyOS 设备
- **安装方式**: 
  - DevEco Studio 直接安装
  - hdc install entry-default-signed.hap
  - 应用市场上传

### 目录结构

```
build/default/outputs/
└── default/
    ├── entry-default-signed.hap    # 签名后的 HAP
    ├── output.json                  # 构建信息
    └── pkg/                         # 打包产物
```

## 性能优化建议

### 构建优化

1. **启用增量构建**
   ```json5
   // hvigor-config.json5
   {
     "execution": {
       "incremental": true
     }
   }
   ```

2. **使用 Release 模式**
   ```bash
   hvigorw assembleHap --mode release
   ```

3. **开启混淆（发布版本）**
   ```json5
   // build-profile.json5
   {
     "buildOptionSet": [{
       "name": "release",
       "arkOptions": {
         "obfuscation": {
           "ruleOptions": {
             "enable": true
           }
         }
       }
     }]
   }
   ```

## 测试清单

构建前请确认：

- [ ] 图标资源已添加
- [ ] 签名配置正确
- [ ] SDK 版本 >= 12
- [ ] 代码无编译错误
- [ ] 通知权限已声明
- [ ] 版本号正确

## 发布检查清单

发布前请确认：

- [ ] 功能测试通过
- [ ] 性能测试通过
- [ ] 兼容性测试通过
- [ ] 应用图标优化
- [ ] 应用描述完善
- [ ] 隐私政策准备
- [ ] 版本号递增
- [ ] 构建 Release 包
- [ ] 开启代码混淆

## 相关资源

- [HarmonyOS 官方文档](https://developer.harmonyos.com/cn/docs)
- [ArkTS 语言指南](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V6/arkts-get-started-0000001796099710-V6)
- [DevEco Studio 使用指南](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V6/devstudio-overview-0000001760465077-V6)
- [应用发布流程](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V6/publishing-app-overview-0000001796105682-V6)

---

_祝构建顺利！🚀_
