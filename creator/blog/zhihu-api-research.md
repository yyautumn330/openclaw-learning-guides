# 知乎 API 自动发布方案研究

> **作者**: 小白 (XiaoBai)  
> **研究时间**: 2026-03-04  
> **状态**: 🔍 调研中

---

## 📋 研究目标

探索 OpenClaw 自动发布文章到知乎的技术方案

---

## 🔍 知乎开放平台

### 官方 API 文档

- **网址**: https://open.zhihu.com/
- **状态**: ⚠️ 部分开放
- **申请**: 需要开发者资质审核

### 可用 API

| API | 状态 | 说明 |
|------|------|------|
| 用户信息 | ✅ 开放 | 获取用户资料 |
| 内容获取 | ✅ 开放 | 读取回答、文章 |
| 内容发布 | ⚠️ 限制 | 需要特殊权限 |
| 评论互动 | ⚠️ 限制 | 需要审核 |

---

## 🛠️ 技术方案

### 方案 1: 官方 API (推荐) ⭐⭐⭐⭐

**优点**:
- ✅ 合法合规
- ✅ 稳定性高
- ✅ 无封号风险

**缺点**:
- ❌ 申请门槛高
- ❌ 发布权限难获取
- ❌ 审核周期长

**实现步骤**:

1. **注册开发者账号**
   ```
   https://open.zhihu.com/developer/apply
   ```

2. **创建应用**
   - 填写应用信息
   - 说明用途 (技术分享、自动化工具)
   - 等待审核 (3-7 工作日)

3. **获取 OAuth Token**
   ```bash
   # 授权 URL
   https://www.zhihu.com/oauth/authorize?client_id=XXX&redirect_uri=XXX&response_type=code
   ```

4. **调用发布 API**
   ```bash
   POST https://api.zhihu.com/articles
   Authorization: Bearer <token>
   
   {
     "title": "文章标题",
     "content": "Markdown 内容"
   }
   ```

---

### 方案 2: 第三方库 ⭐⭐⭐

**现有工具**:

| 库名 | 语言 | 状态 | 链接 |
|------|------|------|------|
| zhihu-oauth | Python | ⚠️ 维护中 | GitHub |
| zhihu-api | Node.js | ❌ 已废弃 | GitHub |
| justauth | Java | ✅ 活跃 | GitHub |

**实现示例** (Python):

```python
from zhihu_oauth import ZhihuAPI

api = ZhihuAPI()
api.login_in_zhihu('phone', 'password')

# 发布文章
api.publish_article(
    title='文章标题',
    content='文章内容',
    topics=['Python', '编程']
)
```

**风险**:
- ⚠️ 可能违反用户协议
- ⚠️ 账号可能被封
- ⚠️ API 变动导致失效

---

### 方案 3: 浏览器自动化 ⭐⭐

**工具**:
- Puppeteer (Node.js)
- Playwright (多语言)
- Selenium (Python)

**流程**:
```
1. 启动浏览器
2. 扫码/密码登录知乎
3. 导航到创作页面
4. 填充标题和内容
5. 点击发布
```

**示例** (Playwright):

```javascript
const { chromium } = require('playwright');

async function publishToZhihu(title, content) {
  const browser = await chromium.launch();
  const page = await browser.newPage();
  
  // 登录
  await page.goto('https://www.zhihu.com/signin');
  // ... 登录逻辑
  
  // 发布文章
  await page.goto('https://zhuanlan.zhihu.com/create');
  await page.fill('.Post-Title', title);
  await page.fill('.Post-RichText', content);
  await page.click('.PublishButton');
  
  await browser.close();
}
```

**风险**:
- ⚠️ 高封号风险
- ⚠️ 需要处理验证码
- ⚠️ 维护成本高

---

### 方案 4: 半自动 (最实用) ⭐⭐⭐⭐⭐

**流程**:
```
1. OpenClaw 生成文章 → 保存为 Markdown
2. 生成发布预览 (HTML)
3. 人工审核 + 手动发布
4. 记录发布状态
```

**优点**:
- ✅ 无封号风险
- ✅ 内容质量可控
- ✅ 符合平台规范
- ✅ 立即可用

**实现**:

```bash
# 生成文章
openclaw "写一篇 OpenClaw 入门指南"

# 保存到 blog/drafts/
# 人工审核后发布
```

---

## 📊 方案对比

| 方案 | 难度 | 风险 | 成本 | 推荐度 |
|------|------|------|------|--------|
| 官方 API | ⭐⭐⭐⭐ | ✅ 低 | 时间成本 | ⭐⭐⭐⭐ |
| 第三方库 | ⭐⭐⭐ | ⚠️ 中 | 低 | ⭐⭐⭐ |
| 浏览器自动化 | ⭐⭐ | ❌ 高 | 中 | ⭐⭐ |
| 半自动 | ⭐ | ✅ 低 | 人工成本 | ⭐⭐⭐⭐⭐ |

---

## 🎯 推荐方案

### 短期 (立即可用): 半自动

**实施计划**:

1. **OpenClaw 技能开发**
   ```
   - 文章生成技能
   - Markdown 格式化
   - 预览生成
   ```

2. **工作流**
   ```
   选题 → 生成 → 审核 → 发布 → 记录
   ```

3. **工具支持**
   - 文章模板
   - 配图生成
   - 标签推荐

### 长期 (3-6 个月): 官方 API

**实施计划**:

1. **申请开发者资质**
   - 准备材料
   - 提交申请
   - 等待审核

2. **开发发布技能**
   ```bash
   openclaw plugins install zhihu-publisher
   ```

3. **配置 OAuth**
   ```bash
   openclaw config set channels.zhihu.enabled true
   openclaw config set channels.zhihu.client_id XXX
   openclaw config set channels.zhihu.client_secret XXX
   ```

---

## 📝 实施建议

### 第一阶段 (本周)

- [x] 文章系列规划
- [x] 创作 2 篇入门文章
- [ ] 建立发布工作流
- [ ] 人工发布测试

### 第二阶段 (下周)

- [ ] 申请知乎开发者
- [ ] 开发文章生成技能
- [ ] 配置配图生成
- [ ] 建立内容日历

### 第三阶段 (3 月内)

- [ ] 获取 API 权限
- [ ] 开发自动发布技能
- [ ] 配置定时任务
- [ ] 数据追踪分析

---

## 🔗 相关资源

- **知乎开放平台**: https://open.zhihu.com/
- **API 文档**: https://open.zhihu.com/docs
- **开发者申请**: https://open.zhihu.com/developer/apply

---

## ⚠️ 风险提示

1. **内容合规**: 确保内容符合平台规范
2. **发布频率**: 避免短时间大量发布
3. **版权保护**: 原创内容，避免抄袭
4. **账号安全**: 优先使用官方 API

---

*研究状态*: 🔍 持续更新中  
*最后更新*: 2026-03-04
