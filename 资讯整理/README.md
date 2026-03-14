# AI 资讯每日归档系统

## 📁 目录结构

```
资讯整理/
├── 2026-03/
│   ├── 2026-03-14.md    # 每日资讯
│   └── ...              # 每日资讯
├── collect_daily_ai_news.sh  # 收集脚本
└── README.md            # 本文件
```

---

## ⏰ 定时任务

**执行时间**: 每天早上 9:00

**任务内容**:
1. 创建当日资讯文件
2. 归档到 `资讯整理/YYYY-MM/YYYY-MM-DD.md`
3. 提供资讯来源链接

---

## 🔧 配置说明

### ✅ 无需 API Key

本系统**不需要**任何 API Key，使用以下方式收集资讯：

1. **自动创建模板**: 每日自动生成资讯模板
2. **推荐资讯源**: 提供常用 AI 资讯网站链接
3. **手动/自动填充**: 可选择手动整理或自动抓取

---

## 📰 推荐资讯来源

### 英文资讯
| 网站 | 链接 |
|------|------|
| Hacker News | https://news.ycombinator.com/ |
| Reddit ML | https://www.reddit.com/r/MachineLearning/ |
| Twitter AI | https://twitter.com/search?q=AI |
| MIT Tech Review | https://www.technologyreview.com/topic/artificial-intelligence/ |

### 中文资讯
| 网站 | 链接 |
|------|------|
| 知乎 AI | https://www.zhihu.com/topic/19552819 |
| 机器之心 | https://www.jiqizhixin.com/ |
| 量子位 | https://www.qbitai.com/ |
| 新智元 | https://www.ainext.com.cn/ |

---

## 📝 手动执行

```bash
# 执行今日资讯收集
/Users/autumn/.openclaw/workspace/资讯整理/collect_daily_ai_news.sh

# 查看生成的文件
cat /Users/autumn/.openclaw/workspace/资讯整理/2026-03/2026-03-14.md
```

---

## 📊 查看历史资讯

```bash
# 查看本月所有资讯
ls -la /Users/autumn/.openclaw/workspace/资讯整理/2026-03/

# 查看特定日期
cat /Users/autumn/.openclaw/workspace/资讯整理/2026-03/2026-03-14.md
```

---

## 📋 资讯分类

每日资讯包含以下分类：

| 分类 | 说明 |
|------|------|
| 🔥 今日热点 | 当日最重要的 AI 新闻 |
| 📰 大模型动态 | GPT/Claude/Gemini/开源模型更新 |
| 🛠️ 技术工具 | 新工具发布、框架更新 |
| 📱 应用案例 | 行业应用、产品发布 |
| 📊 数据资源 | 新数据集、研究论文 |
| 💡 学习资源 | 教程、视频、播客 |

---

## ⚠️ 注意事项

1. **无需 API**: 系统不依赖任何付费 API
2. **网络**: 自动抓取时需要网络连接
3. **权限**: 确保脚本有执行权限 (`chmod +x`)

---

## 📞 问题排查

### 脚本无法执行？
```bash
chmod +x /Users/autumn/.openclaw/workspace/资讯整理/collect_daily_ai_news.sh
```

### 目录不存在？
脚本会自动创建所需目录

---

*创建时间：2026-03-14*  
*维护：AI Assistant*
