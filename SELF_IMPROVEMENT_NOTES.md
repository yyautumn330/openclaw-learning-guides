# 自我提升学习笔记 - 鸿蒙开发与 UX 设计

_创建时间：2026-03-09_

---

## 一、鸿蒙 HarmonyOS 开发最佳实践

### 1.1 ArkTS 语言规范

#### 核心原则
- **严格类型安全**：禁止使用 `any`、动态类型或类型断言
- **不可变更新**：状态变更必须创建新对象，不能直接修改
- **Stage 模型**：使用 UIAbility，弃用 FA 模型

#### 常见错误与解决方案

| 错误类型 | ❌ 错误写法 | ✅ 正确写法 |
|---------|-----------|-----------|
| 动态类型 | `let data: any = fetchData()` | `interface Data { ... }; let data: Data = fetchData()` |
| 直接修改状态 | `this.user.age = 26` | `this.user = { ...this.user, age: 26 }` |
| 数组直接修改 | `this.items.push('c')` | `this.items = [...this.items, 'c']` |
| 动态属性访问 | `obj['dynamicKey'] = value` | 使用 `Record<string, string>` 类型 |

#### 类型安全要点
```typescript
// ✅ 使用接口定义明确类型
interface UserData {
  id: string;
  name: string;
  email?: string;  // 可选字段
}

// ✅ 使用 Record 处理动态键
let dynamicObj: Record<string, string> = {};
dynamicObj['key'] = 'value';  // 允许

// ✅ 使用泛型定义 API 响应
interface ApiResponse<T> {
  code: number;
  message: string;
  data: T;
}
```

### 1.2 ArkUI 装饰器使用指南

#### 装饰器选择决策树

```
需要组件本地状态？
├─ 是 → @State
└─ 否 → 需要父子组件通信？
    ├─ 单向传递（父→子） → @Prop
    ├─ 双向绑定 → @Link
    └─ 跨层级共享 → @Provide/@Consume

需要全局状态？
├─ 应用级 → AppStorage + @StorageLink/@StorageProp
└─ 用户偏好 → PersistentStorage + @StorageLink

需要观察嵌套对象？
└─ @Observed（类装饰器）+ @ObjectLink（属性装饰器）
```

#### 装饰器详解

| 装饰器 | 所有权 | 数据流向 | 适用场景 |
|--------|--------|---------|---------|
| `@State` | 组件所有 | 内部触发更新 | 计数器、表单输入 |
| `@Prop` | 父组件所有 | 单向（父→子） | 只读配置、展示数据 |
| `@Link` | 父组件所有 | 双向 | 可编辑的子组件数据 |
| `@Provide` | 祖先组件 | 向下传递 | 主题、用户上下文 |
| `@Consume` | 后代组件 | 接收值 | 消费祖先提供的数据 |
| `@StorageLink` | AppStorage | 双向同步 | 登录状态、全局配置 |
| `@StorageProp` | AppStorage | 单向读取 | 只读全局配置 |

#### 使用示例

```typescript
// 状态管理最佳实践
@Entry
@Component
struct ProductPage {
  // 组件本地状态
  @State count: number = 0;
  @State isLoading: boolean = false;
  
  // 父组件传递（只读）
  @Prop productId: string;
  
  // 父组件传递（可修改）
  @Link selectedItems: string[];
  
  // 全局状态
  @StorageLink('isLoggedIn') isLoggedIn: boolean = false;
  @StorageProp('theme') theme: string = 'light';
  
  // 嵌套对象观察
  @State @Observed user: User = new User();
  
  build() {
    Column() {
      Text(`Count: ${this.count}`)
      Text(`Theme: ${this.theme}`)
    }
  }
}

// @Observed 类定义
@Observed
class User {
  @ObjectLink profile: Profile;
  
  constructor() {
    this.profile = new Profile();
  }
}
```

### 1.3 异步编程最佳实践

#### async/await 规范

```typescript
// ✅ 正确的异步处理
async loadProducts(): Promise<void> {
  this.isLoading = true;
  this.errorMessage = '';
  
  try {
    const products = await this.productRepository.getAll();
    this.products = products;
  } catch (error) {
    this.errorMessage = `加载失败：${error.message}`;
  } finally {
    this.isLoading = false;
  }
}

// ✅ 并行请求优化
async loadDashboardData(): Promise<void> {
  try {
    // 并行执行独立请求
    const [user, products, notifications] = await Promise.all([
      this.userService.getCurrentUser(),
      this.productService.getFeatured(),
      this.notificationService.getUnread()
    ]);
    
    this.user = user;
    this.products = products;
    this.notifications = notifications;
  } catch (error) {
    // 统一错误处理
    this.handleError(error);
  }
}

// ❌ 避免：串行请求（除非有依赖关系）
async loadData(): Promise<void> {
  const user = await this.getUser();      // 等待
  const products = await this.getProducts();  // 再等待
  // 应该用 Promise.all 并行
}
```

#### 常见异步错误

| 问题 | 描述 | 解决方案 |
|-----|------|---------|
| 未捕获的 Promise | 异步错误导致应用崩溃 | 始终使用 try-catch |
| 状态更新丢失 | await 后状态被覆盖 | 使用不可变更新 |
| 内存泄漏 | 组件销毁后异步完成 | aboutToDisappear 中清理 |
| 竞态条件 | 多次请求结果乱序 | 使用请求取消或版本号 |

### 1.4 数据持久化

#### Preferences 持久化流程

```typescript
// 1. 初始化（在 EntryAbility 中）
import { Preferences } from '@kit.ArkData';

export default class EntryAbility extends UIAbility {
  async onCreate() {
    // 初始化持久化配置
    Preferences.getPreferences({ name: 'app_settings' }).then(prefs => {
      // 读取已有配置
      const darkMode = prefs.get('darkMode', false);
      const notifications = prefs.get('notifications', true);
      
      // 同步到 AppStorage
      AppStorage.setOrCreate('darkMode', darkMode);
      AppStorage.setOrCreate('notifications', notifications);
    });
  }
}

// 2. 在组件中使用
@Entry
@Component
struct SettingsPage {
  @StorageLink('darkMode') darkMode: boolean = false;
  
  async toggleDarkMode(isOn: boolean): Promise<void> {
    try {
      // 更新 UI
      this.darkMode = isOn;
      
      // 持久化
      const prefs = await Preferences.getPreferences({ name: 'app_settings' });
      await prefs.put('darkMode', isOn);
      await prefs.flush();  // 确保写入
      
      // 验证
      const saved = prefs.get('darkMode', false);
      if (saved !== isOn) {
        console.error('持久化失败');
      }
    } catch (error) {
      console.error('保存设置失败:', error);
    }
  }
}
```

#### 持久化检查清单
- [ ] 在应用启动时加载持久化数据
- [ ] 使用 AppStorage 作为内存缓存
- [ ] 修改后立即调用 flush()
- [ ] 关键操作后验证数据
- [ ] 错误处理包含回滚逻辑

### 1.5 单例模式实现

```typescript
// ✅ 正确的单例模式
class DataManager {
  private static instance: DataManager | null = null;
  private constructor() {}
  
  static getInstance(): DataManager {
    if (!DataManager.instance) {
      DataManager.instance = new DataManager();
    }
    return DataManager.instance;
  }
  
  // 业务方法
  async fetchData(): Promise<Data> {
    // ...
  }
}

// 使用
const dataManager = DataManager.getInstance();
```

---

## 二、UX/UI 设计原则

### 2.1 HarmonyOS Design 核心原则

#### 设计价值观
1. **自然直观** - 符合用户心智模型
2. **一致连贯** - 统一的视觉语言
3. **灵活适应** - 多设备自适应
4. **情感共鸣** - 有温度的交互

### 2.2 8px 网格系统

#### 间距规范

| 类型 | 数值 | 使用场景 |
|-----|------|---------|
| 微间距 | 4px | 图标与文字、紧密元素 |
| 小间距 | 8px | 列表项内元素、表单控件 |
| 中间距 | 16px | 卡片内边距、段落间距 |
| 大间距 | 24px | 模块间距、页面边距 |
| 超大间距 | 32px+ | 页面分区、内容组 |

#### 布局示例

```typescript
// ✅ 符合 8px 网格
Column() {
  Text('标题')
    .fontSize(20)
    .margin({ bottom: 16 })  // 2 * 8px
  
  Text('内容')
    .fontSize(16)
    .margin({ bottom: 24 })  // 3 * 8px
  
  Button('操作')
    .width('100%')
    .height(48)  // 6 * 8px
    .margin({ top: 16 })
}
.padding(24)  // 3 * 8px
```

### 2.3 色彩对比度与可访问性

#### 对比度要求

| 内容类型 | 最小对比度 | 示例 |
|---------|-----------|------|
| 普通文本 | 4.5:1 | 正文、说明文字 |
| 大文本（>18px） | 3:1 | 标题 |
| UI 组件 | 3:1 | 按钮、图标 |
| 装饰元素 | 无要求 | 背景图案 |

#### 色彩使用原则
- **主色**：品牌色，用于主要操作按钮、关键信息
- **辅助色**：补充主色，用于次要操作
- **语义色**：成功（绿）、警告（橙）、错误（红）、信息（蓝）
- **中性色**：文字、背景、分割线

### 2.4 交互反馈设计

#### 反馈类型

| 场景 | 反馈方式 | 持续时间 |
|-----|---------|---------|
| 点击 | 按压态 + 触觉 | 100-200ms |
| 加载 | 进度指示器 | 直到完成 |
| 成功 | Toast + 对勾动画 | 2-3s |
| 错误 | 错误提示 + 震动 | 3-5s |
| 空状态 | 插图 + 引导文案 | 持久 |

---

## 三、常见错误和解决方案

### 3.1 类型错误

**问题**：对象字面量未对应显式类型
```typescript
// ❌ 错误
const user = { name: 'John', age: 25 };

// ✅ 正确
interface User {
  name: string;
  age: number;
}
const user: User = { name: 'John', age: 25 };
```

### 3.2 状态更新不触发 UI

**问题**：直接修改嵌套对象
```typescript
// ❌ 错误
@State user: User = { profile: { name: 'John' } };
updateName() {
  this.user.profile.name = 'Jane';  // UI 不更新
}

// ✅ 正确
updateName() {
  this.user = { ...this.user, profile: { ...this.user.profile, name: 'Jane' } };
}
```

### 3.3 异步方法未等待

**问题**：忘记 await 导致时序错误
```typescript
// ❌ 错误
async saveData() {
  this.saveToStorage();  // 未等待
  this.navigateToNext();  // 可能数据未保存
}

// ✅ 正确
async saveData() {
  await this.saveToStorage();
  this.navigateToNext();
}
```

### 3.4 内存泄漏

**问题**：组件销毁后异步回调仍执行
```typescript
// ✅ 正确：添加清理逻辑
@Entry
@Component
struct DataPage {
  private cancellable: Cancellable | null = null;
  
  aboutToAppear() {
    this.cancellable = this.loadData();
  }
  
  aboutToDisappear() {
    if (this.cancellable) {
      this.cancellable.cancel();
    }
  }
}
```

---

## 四、学习资源

### 官方文档
- [HarmonyOS 开发者官网](https://developer.harmonyos.com/)
- [ArkTS 语言指南](https://developer.harmonyos.com/cn/docs/documentation/doc-guides-V6/arkts-get-started-0000017406042485-V6)
- [ArkUI 组件文档](https://developer.harmonyos.com/cn/docs/documentation/doc-references-V6/arkui-overview-0000007405860469-V6)
- [HarmonyOS Design](https://design.harmonyos.com/)

### 社区资源
- 鸿蒙开发者社区
- Gitee 鸿蒙开源项目
- 知乎鸿蒙开发话题

---

_持续更新中..._
