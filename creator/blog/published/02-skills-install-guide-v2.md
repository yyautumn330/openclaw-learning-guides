# OpenClaw 技能安装指南 - 52 个官方技能深度评测（2026 最新版）

> **作者**: 小白 (XiaoBai)  
> **版本**: v2.0 配图完整版  
> **发布时间**: 2026-03-07  
> **难度**: ⭐⭐ 初级  
> **预计阅读**: 12 分钟  
> **字数**: ~5,500 字

---

> **💡 读完这篇文章你能：**
> - 了解 52 个官方技能完整清单
> - 根据场景选择合适的技能
> - 避开安装过程中的常见坑
> - 10 分钟完成技能配置

---

## 🎯 文章亮点

- ✅ 52 个官方技能完整清单
- ✅ 按场景分类推荐
- ✅ 每个技能详细评测
- ✅ 避坑指南 + 最佳实践
- ✅ 6 张配图说明

---

## 📊 技能生态概览

OpenClaw 技能分为两类：

| 类型 | 数量 | 来源 | 质量 |
|------|------|------|------|
| **官方技能** | 52 个 | OpenClaw 团队 | ⭐⭐⭐⭐⭐ |
| **社区技能** | 14000+ | 社区贡献 | ⭐⭐⭐ |

![配图 1: ClawHub 技能市场概览](../assets/article-02-v2/01-clawhub-overview.png)
*图 1: ClawHub 技能市场 - 52 个官方技能 + 14000+ 社区技能*

**本文重点**: 52 个官方技能深度评测

---

## 🏆 必装 Top 10 (新手推荐)

### 1. weather ⭐⭐⭐⭐⭐
- **用途**: 天气查询和预报
- **亮点**: 无需 API key，数据准确
- **安装**: `npx clawhub@latest install weather`
- **使用**: `/weather 北京`
- **评价**: 日常实用，推荐指数 100%

### 2. github ⭐⭐⭐⭐⭐
- **用途**: GitHub 操作 (issues, PRs, CI)
- **亮点**: 完整 GitHub API 支持
- **安装**: `npx clawhub@latest install github`
- **使用**: `/github trending`
- **评价**: 开发者必备

### 3. brave-search ⭐⭐⭐⭐⭐
- **用途**: Web 搜索和内容提取
- **亮点**: 让 AI 获取最新信息
- **安装**: `npx clawhub@latest install brave-search`
- **使用**: `/search OpenClaw 教程`
- **评价**: 突破 AI 知识截止时间

### 4. summarize ⭐⭐⭐⭐⭐
- **用途**: 总结 URL、PDF、音频、视频
- **亮点**: 多格式支持，节省时间
- **安装**: `npx clawhub@latest install summarize`
- **使用**: `/summarize https://example.com`
- **评价**: 信息处理神器

### 5. gog ⭐⭐⭐⭐
- **用途**: Google Workspace 集成
- **亮点**: Gmail、Calendar、Drive 一站式
- **安装**: `npx clawhub@latest install gog`
- **使用**: 需要 Google OAuth
- **评价**: Google 用户必备

### 6. notion ⭐⭐⭐⭐
- **用途**: Notion API 集成
- **亮点**: 创建页面、管理数据库
- **安装**: `npx clawhub@latest install notion`
- **使用**: 需要 Notion Token
- **评价**: 知识工作者推荐

### 7. nano-pdf ⭐⭐⭐⭐
- **用途**: PDF 编辑
- **亮点**: 自然语言指令
- **安装**: `npx clawhub@latest install nano-pdf`
- **使用**: `/pdf 合并 file1.pdf file2.pdf`
- **评价**: 办公场景实用

### 8. openai-whisper ⭐⭐⭐⭐
- **用途**: 语音转文字
- **亮点**: 本地运行，无需 API
- **安装**: `npx clawhub@latest install openai-whisper`
- **使用**: `/transcribe audio.mp3`
- **评价**: 会议记录神器

### 9. obsidian ⭐⭐⭐⭐
- **用途**: Obsidian 知识库管理
- **亮点**: 自动化笔记整理
- **安装**: `npx clawhub@latest install obsidian`
- **使用**: 需要 Obsidian 仓库路径
- **评价**: 双链笔记用户推荐

### 10. auto-updater ⭐⭐⭐⭐
- **用途**: 自动更新 OpenClaw 和技能
- **亮点**: 省心省力
- **安装**: `npx clawhub@latest install auto-updater`
- **使用**: 自动运行
- **评价**: 懒人必备

![配图 2: 批量安装技能过程](../assets/article-02-v2/02-batch-install.png)
*图 2: 使用 clawhub 批量安装技能，终端实时显示进度*

---

## 📁 按场景分类

### 💼 办公生产力

| 技能 | 用途 | 推荐度 | 难度 |
|------|------|--------|------|
| gog | Google Workspace | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| notion | Notion 集成 | ⭐⭐⭐⭐ | ⭐⭐ |
| obsidian | Obsidian 管理 | ⭐⭐⭐⭐ | ⭐⭐ |
| trello | Trello 看板 | ⭐⭐⭐ | ⭐⭐ |
| slack | Slack 集成 | ⭐⭐⭐ | ⭐⭐ |

**推荐组合**: `gog + notion + summarize`

![配图 3: 按场景分类的技能架构](../assets/article-02-v2/03-skills-category.png)
*图 3: 技能按场景分类 - 办公/开发/创作/数据/家居/通讯*

### 💻 开发者工具

| 技能 | 用途 | 推荐度 | 难度 |
|------|------|--------|------|
| github | GitHub 操作 | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| mcporter | MCP 服务器管理 | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| discord | Discord 集成 | ⭐⭐⭐ | ⭐⭐ |
| tmux | Tmux 终端复用 | ⭐⭐⭐ | ⭐⭐⭐ |

**推荐组合**: `github + mcporter + brave-search`

### 🎨 创意创作

| 技能 | 用途 | 推荐度 | 难度 |
|------|------|--------|------|
| nano-banana-pro | 图像生成/编辑 | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| openai-image-gen | AI 绘画 | ⭐⭐⭐⭐ | ⭐⭐ |
| video-frames | 视频帧提取 | ⭐⭐⭐ | ⭐⭐ |
| sag | ElevenLabs TTS | ⭐⭐⭐⭐ | ⭐⭐ |

**推荐组合**: `nano-banana-pro + video-frames`

### 📊 数据处理

| 技能 | 用途 | 推荐度 | 难度 |
|------|------|--------|------|
| nano-pdf | PDF 编辑 | ⭐⭐⭐⭐ | ⭐⭐ |
| feishu_bitable | 飞书多维表格 | ⭐⭐⭐⭐ | ⭐⭐ |
| feishu_doc | 飞书文档 | ⭐⭐⭐⭐ | ⭐⭐ |
| oracle | 数据查询 | ⭐⭐⭐ | ⭐⭐⭐ |

**推荐组合**: `nano-pdf + feishu_bitable`

### 🏠 智能家居

| 技能 | 用途 | 推荐度 | 难度 |
|------|------|--------|------|
| sonoscli | Sonos 音箱控制 | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| openhue | Philips Hue 灯光 | ⭐⭐⭐⭐ | ⭐⭐⭐ |
| spotify-player | Spotify 播放 | ⭐⭐⭐ | ⭐⭐ |

**推荐组合**: `sonoscli + openhue`

### 📱 通讯社交

| 技能 | 用途 | 推荐度 | 难度 |
|------|------|--------|------|
| wechat | 微信接入 | ⭐⭐⭐⭐ | ⭐⭐⭐⭐ |
| feishu | 飞书集成 | ⭐⭐⭐⭐⭐ | ⭐⭐ |
| telegram | Telegram 机器人 | ⭐⭐⭐⭐ | ⭐⭐ |
| discord | Discord 机器人 | ⭐⭐⭐ | ⭐⭐ |
| imsg | iMessage | ⭐⭐⭐ | ⭐⭐⭐ |

**推荐组合**: `feishu + telegram`

---

## 🔧 安装方法

### 单个安装

```bash
npx clawhub@latest install <技能名>

# 示例
npx clawhub@latest install weather
npx clawhub@latest install github
```

### 批量安装

```bash
# 基础包
npx clawhub@latest install weather github brave-search summarize

# 办公包
npx clawhub@latest install gog notion obsidian

# 开发者包
npx clawhub@latest install github mcporter discord
```

![配图 4: 技能安装验证](../assets/article-02-v2/04-verify-install.png)
*图 4: 使用 `openclaw skills list` 验证已安装技能*

### 从特定作者安装

```bash
# 基础包
npx clawhub@latest install weather github brave-search summarize

# 办公包
npx clawhub@latest install gog notion obsidian

# 开发者包
npx clawhub@latest install github mcporter discord
```

### 从特定作者安装

```bash
npx clawhub@latest install steipete/summarize
npx clawhub@latest install steipete/weather
```

---

## ⚠️ 避坑指南

### 1. 速率限制问题

**现象**: 安装时提示 "Rate limit exceeded"

**原因**: ClawHub 服务器限制频繁请求

**解决**:
- 等待 15-30 分钟后重试
- 使用代理切换 IP
- 手动从 GitHub 克隆

### 2. 技能冲突

**现象**: 多个技能功能重叠

**示例**: `humanizer` vs `humanize-ai-text`

**建议**: 选择一个即可，避免冗余

### 3. 需要额外配置

**需要 API Key 的技能**:
- gog (Google OAuth)
- notion (Notion Token)
- nano-banana-pro (Gemini API)
- sag (ElevenLabs API)

**建议**: 先安装免费技能，再配置付费服务

### 4. 版本兼容性

**现象**: 技能安装后无法使用

**检查**:
```bash
openclaw --version
openclaw plugins list
```

**解决**: 更新 OpenClaw 到最新版

![配图 5: 技能配置界面](../assets/article-02-v2/05-skill-config.png)
*图 5: 配置需要 API Key 的技能（如 Gemini/Notion）*

---

## 📊 技能质量评估

### 高质量技能特征

✅ **文档完善** - README 清晰，有使用示例  
✅ **版本活跃** - 定期更新，bug 修复及时  
✅ **社区反馈** - 下载量高，星标多  
✅ **作者信誉** - 知名作者或官方出品  

### 低质量技能特征

❌ **无文档** - 不知道如何使用  
❌ **长期未更新** - 可能已废弃  
❌ **功能单一** - 几行代码的包装  
❌ **无 issue 追踪** - 问题无法反馈  

---

## 🎯 我的推荐配置

### 新手入门 (4 个)

```bash
npx clawhub@latest install weather github brave-search summarize
```

**总评**: 覆盖日常 80% 需求

### 知识工作者 (7 个)

```bash
npx clawhub@latest install weather github brave-search summarize gog notion auto-updater
```

**总评**: 办公效率翻倍

### 开发者 (7 个)

```bash
npx clawhub@latest install github mcporter brave-search discord tmux sag auto-updater
```

**总评**: 开发全流程覆盖

### 创意工作者 (6 个)

```bash
npx clawhub@latest install nano-banana-pro video-frames openai-whisper sag summarize obsidian
```

**总评**: 创作效率提升

---

## 📈 技能统计

**官方技能总数**: 52 个

**分类统计**:
- 办公生产力：12 个
- 开发者工具：8 个
- 创意创作：10 个
- 数据处理：6 个
- 智能家居：5 个
- 通讯社交：8 个
- 系统工具：3 个

**下载 Top 5**:
1. self-improving-agent (95.1k)
2. tavily-search (81.2k)
3. gog (79.9k)
4. find-skills (78.1k)
5. summarize (70.1k)

---

## 🚀 立即开始

**行动清单**：
1. 选择适合你的技能包（见上方推荐）
2. 复制安装命令 → 终端执行
3. 配置需要的 API Key
4. 遇到问题？→ 评论区留言

**系列下一篇**: 《[让 AI 主动帮你干活 - 心跳任务配置](#)》📖

---

## 📚 相关资源

- **技能市场**: https://clawhub.ai (14000+ 社区技能)
- **官方文档**: https://docs.openclaw.ai
- **GitHub**: https://github.com/openclaw/openclaw
- **Discord 社区**: https://discord.com/invite/clawd

![配图 6: 技能安装完成验证](../assets/article-02-v2/06-install-complete.png)
*图 6: 使用 `openclaw skills list` 验证所有技能已安装*

---

**关于作者**：小白 (XiaoBai) - 全栈移动开发工程师，专注 iOS/鸿蒙/安卓开发，热爱开源和 AI 技术。

**喜欢这篇文章吗？**
- ❤️ 点赞 - 让更多人看到
- ⭐ 收藏 - 方便以后查阅
- 💬 评论 - 留下你的问题和建议
- 📢 分享 - 帮助更多需要的朋友

---

## 📊 更新日志

**v2.0 (2026-03-07)** - 配图完整版
- ✨ 新增 6 张配图及位置标注
- ✨ 新增"读完你能得到什么"预览框
- ✨ 新增"立即开始"行动号召
- ✨ 优化代码块格式
- ✨ 更新技能统计数据

**v1.0 (2026-03-04)** - 初版
- 52 个官方技能评测
- 按场景分类推荐

---

*版本*: v2.0 配图完整版  
*字数*: ~5,500 字  
*预计阅读*: 12 分钟  
*更新时间*: 2026-03-07  
*标签*: #OpenClaw #AI 技能 #效率工具 #自动化 #技术教程 #AI 助手
