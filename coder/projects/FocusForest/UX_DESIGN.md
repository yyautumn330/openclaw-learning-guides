# 专注森林 (FocusForest) - UX 设计规范

**版本**: 1.0.0  
**创建日期**: 2026-03-11

---

## 🎨 设计系统

### 色彩系统

#### DesignTokens 定义
```typescript
// 浅色主题
LIGHT: {
  primaryColor: '#4CAF50',      // 森林绿
  secondaryColor: '#8BC34A',    // 嫩芽绿
  accentColor: '#FF9800',       // 阳光橙
  backgroundColor: '#F1F8E9',   // 浅绿背景
  cardBackground: '#FFFFFF',    // 白色卡片
  textPrimary: '#333333',       // 主文字
  textSecondary: '#666666',     // 次要文字
  textTertiary: '#999999',      // 辅助文字
  borderColor: '#E0E0E0',       // 边框
  dividerColor: '#E8E8E8',      // 分割线
  successColor: '#52C41A',      // 成功
  warningColor: '#FAAD14',      // 警告
  errorColor: '#FF4D4F',        // 错误
  infoColor: '#1890FF'          // 信息
}

// 深色主题
DARK: {
  primaryColor: '#66BB6A',
  secondaryColor: '#9CCC65',
  accentColor: '#FFB74D',
  backgroundColor: '#1A1A1A',
  cardBackground: '#2D2D2D',
  textPrimary: '#E8E8E8',
  textSecondary: '#BFBFBF',
  textTertiary: '#8C8C8C',
  borderColor: '#434343',
  dividerColor: '#303030',
  successColor: '#73D13D',
  warningColor: '#D4B106',
  errorColor: '#FF7875',
  infoColor: '#40A9FF'
}
```

### 字体系统

```typescript
FONT_SIZE: {
  xs: 12,    // 小字
  sm: 14,    // 辅助文字
  md: 16,    // 正文
  lg: 18,    // 卡片标题
  xl: 20,    // 页面标题
  xxl: 24,   // 大标题
  timer: 72, // 计时器
  icon: 80   // 图标
}
```

### 间距系统

```typescript
SPACING: {
  xs: 4,   // 微间距
  sm: 8,   // 小组件间距
  md: 16,  // 元素间距
  lg: 24,  // 卡片内边距
  xl: 32,  // 大间距
  xxl: 48  // 超大间距
}
```

### 圆角系统

```typescript
RADIUS: {
  sm: 4,    // 小元素
  md: 8,    // 一般元素
  lg: 12,   // 卡片
  xl: 25,   // 按钮
  full: 999 // 圆形
}
```

---

## 📐 页面设计规范

### 1. 首页 (Index)

#### 布局结构
```
┌──────────────────────────────┐
│ 顶部标题栏 (60px)             │
│ "专注森林" 24px Bold         │
├──────────────────────────────┤
│                              │
│ 树木展示区 (200px)            │
│ 🌲 树木 Emoji 80px           │
│ 树名 16px Medium             │
│                              │
├──────────────────────────────┤
│                              │
│ 计时器区域 (150px)            │
│ ⏱️ 25:00 72px Bold          │
│ 🎵 雨声 16px                 │
│                              │
├──────────────────────────────┤
│                              │
│ 控制按钮区 (80px)             │
│ [开始 140x50] [重置 100x50]  │
│                              │
├──────────────────────────────┤
│                              │
│ 底部导航栏 (60px)             │
│ 🏠 🌲 🎵 👤                 │
│                              │
└──────────────────────────────┘
```

#### 交互规范
- **开始按钮**: 点击开始专注，显示 Toast 提示
- **重置按钮**: 点击重置计时器
- **树木展示**: 根据专注时长显示不同树种
- **滑动回弹**: ScrollView 添加 `.edgeEffect(EdgeEffect.Spring)`

### 2. 森林页 (Forest)

#### 布局结构
```
┌──────────────────────────────┐
│ 页面标题 "我的森林" 20px Bold │
├──────────────────────────────┤
│                              │
│ 树木网格 (自适应)              │
│ 🌲 🌲 🌲 🌲 🌲              │
│ 🌲 🌲 🌲 🌲 🌲              │
│ 🌲 🌲 🌲 🌲 🌲              │
│ (每行 5 棵，间距 16px)          │
│                              │
├──────────────────────────────┤
│ 统计信息栏                    │
│ 总计：15 棵 | 健康：14 | 枯萎：1│
├──────────────────────────────┤
│ 底部导航栏                    │
└──────────────────────────────┘
```

#### 树木卡片设计
```typescript
TreeCard {
  width: '18%',
  height: 100,
  backgroundColor: colors.cardBackground,
  borderRadius: 12,
  padding: 12,
  
  TreeEmoji {
    fontSize: 40,
    marginBottom: 8
  },
  
  TreeName {
    fontSize: 12,
    fontColor: colors.textPrimary
  },
  
  TreeStatus {
    fontSize: 10,
    fontColor: isWithered ? colors.errorColor : colors.successColor
  }
}
```

### 3. 音效页 (Sounds)

#### 布局结构
```
┌──────────────────────────────┐
│ 页面标题 "白噪音" 20px Bold   │
├──────────────────────────────┤
│                              │
│ 音效列表                      │
│ ┌──────────────────────┐    │
│ │ 🌧️ 雨声      [选择]  │    │
│ └──────────────────────┘    │
│ ┌──────────────────────┐    │
│ │ ☕ 咖啡馆    [选择]  │    │
│ └──────────────────────┘    │
│ ... (6 个音效项)              │
│                              │
├──────────────────────────────┤
│ 音量控制                      │
│ 音量：[━━━━━○━━] 60%       │
├──────────────────────────────┤
│ 底部导航栏                    │
└──────────────────────────────┘
```

#### 音效项设计
```typescript
SoundItem {
  width: '100%',
  height: 60,
  backgroundColor: colors.cardBackground,
  borderRadius: 12,
  padding: 16,
  marginBottom: 12,
  
  Row {
    SoundIcon { fontSize: 24 },
    SoundName { 
      fontSize: 16,
      marginLeft: 16,
      layoutWeight: 1
    },
    SelectButton {
      backgroundColor: isSelected ? colors.primaryColor : 'transparent',
      fontColor: isSelected ? '#FFFFFF' : colors.textPrimary
    }
  }
}
```

### 4. 个人中心页 (Profile)

#### 布局结构
```
┌──────────────────────────────┐
│ 页面标题 "个人中心" 20px Bold │
├──────────────────────────────┤
│                              │
│ 用户信息卡片                  │
│ 👤 头像 (80px)               │
│ 专注达人                     │
│ LV.5                         │
│                              │
├──────────────────────────────┤
│ 功能列表                      │
│ 📊 统计                       │
│ 🏆 成就 (8/10)               │
│ ⚙️ 设置                       │
│ 🌗 深色模式 [开关]            │
│ ℹ️ 关于                       │
│                              │
├──────────────────────────────┤
│ 底部导航栏                    │
└──────────────────────────────┘
```

---

## 🎭 动效规范

### 页面切换动效
```typescript
.pageTransition {
  duration: 300ms,
  curve: Curve.EaseInOut
}
```

### 按钮点击动效
```typescript
.buttonPress {
  duration: 150ms,
  curve: Curve.EaseOut,
  scale: 0.95
}
```

### 滑动回弹动效
```typescript
ScrollView {
  .edgeEffect(EdgeEffect.Spring)
}
```

### 树木成长动效
```typescript
.treeGrowth {
  duration: 500ms,
  curve: Curve.EaseOut,
  scale: 1.2 → 1.0
}
```

---

## 📱 响应式设计

### 屏幕适配

#### 小屏 (<360px)
- 树木网格：每行 4 棵
- 按钮宽度：120px
- 字体缩小 10%

#### 中屏 (360px-480px)
- 树木网格：每行 5 棵
- 按钮宽度：140px (标准)
- 字体标准大小

#### 大屏 (>480px)
- 树木网格：每行 6 棵
- 按钮宽度：160px
- 字体放大 10%

### 深色模式适配

所有页面必须支持深色模式：
- 使用 `DesignTokens.getThemeColors(isDarkMode)`
- 所有颜色从 DesignTokens 获取
- 禁止使用硬编码颜色值

---

## ✅ 设计检查清单

### 视觉检查
- [ ] 所有颜色使用 DesignTokens
- [ ] 字体大小符合规范
- [ ] 间距符合规范
- [ ] 圆角符合规范
- [ ] 深色模式正确适配

### 交互检查
- [ ] 按钮点击有反馈动效
- [ ] 页面切换流畅
- [ ] 滑动有回弹效果
- [ ] Toast 提示正确显示
- [ ] 加载状态正确显示

### 性能检查
- [ ] 页面启动 <2 秒
- [ ] 页面切换 <300ms
- [ ] 滚动帧率 60fps
- [ ] 内存占用 <150MB
- [ ] 包大小 <50MB

---

*创建时间*: 2026-03-11 13:49  
*版本*: 1.0.0
