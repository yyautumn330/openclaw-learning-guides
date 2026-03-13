# 代码审查清单 - 鸿蒙开发

_创建时间：2026-03-09 | 版本：1.0_

---

## 一、类型安全检查

### 1.1 变量和函数类型

- [ ] 所有变量有明确的类型声明
- [ ] 函数参数和返回值有类型注解
- [ ] 未使用 `any` 类型
- [ ] 未使用类型断言（`as Type`）
- [ ] 对象字面量对应显式接口或类

```typescript
// ✅ 检查通过示例
interface User {
  id: string;
  name: string;
  email?: string;
}

const user: User = { id: '1', name: 'John' };

function getUser(id: string): Promise<User> {
  return fetchUser(id);
}

// ❌ 检查失败示例
const user = { id: '1', name: 'John' };  // 缺少类型
const data: any = fetchData();  // 使用 any
const result = obj as SomeType;  // 类型断言
```

### 1.2 泛型使用

- [ ] 泛型参数有明确约束
- [ ] API 响应使用泛型包装
- [ ] 数组和集合有元素类型

```typescript
// ✅ 检查通过
interface ApiResponse<T> {
  code: number;
  data: T;
  message: string;
}

const users: User[] = [];
const map: Map<string, Product> = new Map();
```

---

## 二、异步处理检查

### 2.1 async/await 使用

- [ ] 异步函数使用 `async` 标记
- [ ] Promise 调用使用 `await` 等待
- [ ] 并行请求使用 `Promise.all`
- [ ] 避免嵌套的 `.then()` 链

```typescript
// ✅ 检查通过
async loadData(): Promise<void> {
  try {
    const [user, products] = await Promise.all([
      this.getUser(),
      this.getProducts()
    ]);
    // 处理数据
  } catch (error) {
    this.handleError(error);
  }
}

// ❌ 检查失败
loadData() {
  this.getUser().then(user => {
    this.getProducts().then(products => {
      // 嵌套回调
    });
  });
}
```

### 2.2 错误处理

- [ ] 所有 async 函数包含 try-catch
- [ ] catch 块有具体的错误处理逻辑
- [ ] 错误信息传递到 UI 层
- [ ] finally 块用于清理状态

```typescript
// ✅ 检查通过
async submitForm(): Promise<void> {
  this.isLoading = true;
  this.errorMessage = '';
  
  try {
    await this.api.submit(this.formData);
    this.showSuccessToast();
  } catch (error) {
    this.errorMessage = `提交失败：${error.message}`;
    this.showErrorToast();
  } finally {
    this.isLoading = false;
  }
}
```

### 2.3 竞态条件预防

- [ ] 多次请求有取消机制
- [ ] 使用请求版本号或时间戳
- [ ] 组件销毁时清理异步任务

```typescript
// ✅ 检查通过
@Entry
@Component
struct SearchPage {
  private currentRequestId: number = 0;
  private cancellable: Cancellable | null = null;
  
  async search(query: string): Promise<void> {
    const requestId = ++this.currentRequestId;
    
    try {
      const results = await this.searchApi.search(query);
      
      // 检查是否是最新请求
      if (requestId === this.currentRequestId) {
        this.results = results;
      }
    } catch (error) {
      if (requestId === this.currentRequestId) {
        this.handleError(error);
      }
    }
  }
  
  aboutToDisappear(): void {
    if (this.cancellable) {
      this.cancellable.cancel();
    }
  }
}
```

---

## 三、状态管理检查

### 3.1 装饰器使用

- [ ] 组件本地状态使用 `@State`
- [ ] 父子单向传递使用 `@Prop`
- [ ] 父子双向绑定使用 `@Link`
- [ ] 跨层级共享使用 `@Provide/@Consume`
- [ ] 全局状态使用 `@StorageLink/@StorageProp`
- [ ] 嵌套对象使用 `@Observed/@ObjectLink`

```typescript
// ✅ 装饰器选择检查
@Entry
@Component
struct ProductPage {
  @State count: number = 0;              // 本地状态
  @Prop productId: string;               // 父传只读
  @Link selectedIds: string[];           // 双向绑定
  @StorageLink('theme') theme: string;   // 全局状态
  
  build() { /* ... */ }
}
```

### 3.2 不可变更新

- [ ] 未直接修改 `@State` 对象属性
- [ ] 数组更新使用展开运算符
- [ ] 对象更新创建新实例
- [ ] 嵌套对象深度拷贝

```typescript
// ✅ 检查通过
@State user: User = { name: 'John', age: 25 };
@State items: string[] = ['a', 'b'];

updateUser() {
  this.user = { ...this.user, age: 26 };  // 创建新对象
}

addItem(item: string) {
  this.items = [...this.items, item];     // 创建新数组
}

// ❌ 检查失败
updateUser() {
  this.user.age = 26;   // 直接修改，UI 不更新
}

addItem(item: string) {
  this.items.push(item); // 直接修改，UI 不更新
}
```

### 3.3 状态所有权

- [ ] 状态所有者明确（组件 or 全局）
- [ ] 避免多个组件同时修改同一状态
- [ ] 复杂状态逻辑使用 ViewModel

```typescript
// ✅ ViewModel 模式
@Observed
class ProductViewModel {
  products: Product[] = [];
  isLoading: boolean = false;
  
  async load(): Promise<void> {
    this.isLoading = true;
    this.products = await this.repository.getAll();
    this.isLoading = false;
  }
}

@Entry
@Component
struct ProductPage {
  @State viewModel: ProductViewModel = new ProductViewModel();
  
  aboutToAppear(): void {
    this.viewModel.load();
  }
}
```

---

## 四、数据持久化检查

### 4.1 Preferences 使用

- [ ] 在 EntryAbility 中初始化持久化
- [ ] 读取后同步到 AppStorage
- [ ] 修改后调用 `flush()`
- [ ] 保存后立即验证
- [ ] 错误处理包含回滚

```typescript
// ✅ 检查通过
async saveSetting(key: string, value: any): Promise<void> {
  try {
    const prefs = await Preferences.getPreferences({ name: 'app_settings' });
    await prefs.put(key, value);
    await prefs.flush();
    
    // 验证
    const saved = prefs.get(key, null);
    if (saved !== value) {
      throw new Error('持久化验证失败');
    }
    
    // 更新内存
    AppStorage.setOrCreate(key, value);
  } catch (error) {
    // 回滚内存状态
    console.error('保存失败:', error);
  }
}
```

### 4.2 数据同步

- [ ] 内存与持久化数据一致
- [ ] 多设备同步考虑冲突解决
- [ ] 敏感数据加密存储

---

## 五、边界条件检查

### 5.1 空值处理

- [ ] 可选字段使用 `?` 标记
- [ ] 使用空值合并运算符 `??`
- [ ] API 响应验证非空
- [ ] 列表渲染前检查长度

```typescript
// ✅ 检查通过
interface User {
  id: string;
  name: string;
  avatar?: string;  // 可选
}

const userName = user.name ?? '匿名用户';
const avatarUrl = user.avatar ?? 'default.png';

// 列表渲染
if (this.items.length > 0) {
  ForEach(this.items, (item) => { /* ... */ });
} else {
  EmptyState();
}
```

### 5.2 边界值处理

- [ ] 数值范围验证
- [ ] 字符串长度限制
- [ ] 数组索引边界检查
- [ ] 分页参数验证

```typescript
// ✅ 检查通过
function getPageItems(page: number, size: number): void {
  const safePage = Math.max(1, page);
  const safeSize = Math.min(100, Math.max(1, size));
  
  const startIndex = (safePage - 1) * safeSize;
  if (startIndex >= this.items.length) {
    return;  // 超出范围
  }
}
```

---

## 六、错误处理检查

### 6.1 异常捕获

- [ ] 网络请求有 try-catch
- [ ] 文件操作有 try-catch
- [ ] 第三方 SDK 调用有 try-catch
- [ ] 未捕获异常有全局处理

```typescript
// ✅ 检查通过
try {
  await this.httpClient.get('/api/data');
} catch (error) {
  if (error.responseCode === 401) {
    this.navigateToLogin();
  } else if (error.responseCode === 404) {
    this.showNotFound();
  } else {
    this.showNetworkError();
  }
}
```

### 6.2 用户提示

- [ ] 错误信息对用户友好
- [ ] 提供解决建议
- [ ] 技术细节记录到日志
- [ ] 可重试操作提供重试按钮

---

## 七、日志记录检查

### 7.1 日志级别

- [ ] 使用正确的日志级别（info/warn/error）
- [ ] 关键操作有日志记录
- [ ] 错误日志包含堆栈信息
- [ ] 生产环境过滤敏感信息

```typescript
// ✅ 检查通过
console.info('加载用户数据', { userId: user.id });
console.warn('缓存未命中，从网络加载');
console.error('保存失败', error, { stack: error.stack });

// ❌ 检查失败
console.log('调试信息：', sensitiveData);  // 泄露敏感信息
```

### 7.2 日志内容

- [ ] 包含操作上下文
- [ ] 包含时间戳（自动）
- [ ] 包含唯一标识（如请求 ID）
- [ ] 不包含密码、token 等敏感信息

---

## 八、代码结构检查

### 8.1 组件拆分

- [ ] 组件职责单一
- [ ] build() 方法不超过 100 行
- [ ] 复杂 UI 提取为独立组件
- [ ] 业务逻辑提取到 ViewModel

```typescript
// ✅ 检查通过
@Component
struct UserCard {
  @Prop user: User;
  
  build() {
    Row() {
      Avatar({ src: this.user.avatar })
      UserInfo({ name: this.user.name, email: this.user.email })
    }
  }
}

@Entry
@Component
struct UserListPage {
  @State users: User[] = [];
  
  build() {
    Column() {
      ForEach(this.users, (user) => UserCard({ user }))
    }
  }
}
```

### 8.2 文件组织

- [ ] 按功能模块组织文件
- [ ] 组件、服务、模型分离
- [ ] 工具函数放在 utils 目录
- [ ] 常量集中管理

---

## 九、性能检查

### 9.1 列表性能

- [ ] 长列表使用 `LazyForEach`
- [ ] 设置合理的 `cachedCount`
- [ ] 提供稳定的 key 生成函数
- [ ] 避免在 build 中创建对象

```typescript
// ✅ 检查通过
List() {
  LazyForEach(this.dataSource, (item: Item, index: number) => {
    ListItem() {
      ItemCard({ item: item })
    }
  }, (item: Item) => item.id)  // 稳定 key
}
.cachedCount(4)
```

### 9.2 渲染优化

- [ ] 避免不必要的状态更新
- [ ] 图片使用缓存
- [ ] 复杂计算使用 memoization
- [ ] 动画使用硬件加速

---

## 十、代码规范检查

### 10.1 命名规范

- [ ] 变量使用 camelCase
- [ ] 类和组件使用 PascalCase
- [ ] 常量使用 UPPER_SNAKE_CASE
- [ ] 文件名与组件名一致

### 10.2 注释规范

- [ ] 公共 API 有文档注释
- [ ] 复杂逻辑有行内注释
- [ ] TODO 标记有负责人和日期
- [ ] 不使用无意义注释

---

## 审查评分标准

| 等级 | 通过项 | 处理建议 |
|-----|-------|---------|
| ✅ 优秀 | 95-100% | 直接合并 |
| ⚠️ 良好 | 80-94% | 修复关键问题后合并 |
| 🔄 需改进 | 60-79% | 修复后重新审查 |
| ❌ 不合格 | <60% | 重构后重新提交 |

---

_审查人：__________ | 日期：__________ | 结果：___________
