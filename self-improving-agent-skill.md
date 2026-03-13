# Self-Improving Agent 技能

## 功能说明

Self-Improving Agent 是一个能够自我学习和改进的 AI 代理技能。它会：

1. **记录错误和失败** - 当命令或操作意外失败时
2. **捕获用户纠正** - 当用户纠正 AI 时（"不，那是错的..."，"实际上..."）
3. **记录新发现** - 当发现更好的方法时
4. **持续改进** - 基于历史经验优化未来的响应

## 使用方法

### 自动触发

当以下情况发生时，自动记录到学习日志：

1. 命令执行失败
2. 用户明确纠正
3. API 或工具失败
4. 发现更好的方法

### 手动记录

使用以下命令手动记录学习内容：

```
/learn [学习内容]
```

### 查看学习历史

```
/learnings
```

### 应用学习

```
/apply-learning [主题]
```

## 安装

由于 ClawHub 速率限制，暂时手动安装：

1. 创建技能目录：
```bash
mkdir -p ~/.agents/skills/self-improving-agent
```

2. 将本文件保存为 `SKILL.md`

3. 创建主程序 `index.ts`

## 配置

在 `~/.agents/skills/self-improving-agent/config.json` 中配置：

```json
{
  "enabled": true,
  "autoLearn": true,
  "logFile": "~/.agents/skills/self-improving-agent/learnings.md"
}
```

## 学习日志格式

学习日志保存在 `learnings.md` 中，格式如下：

```markdown
# 学习日志

## [日期] - [主题]

### 问题
[描述遇到的问题]

### 解决方案
[记录的解决方案]

### 应用
[如何应用到未来场景]
```

## 示例

### 示例 1：记录命令失败

```
/learn 当使用 npm install 时，如果超时，使用 --registry https://registry.npmmirror.com 镜像
```

### 示例 2：记录用户纠正

```
/learn 用户 prefers 使用简体中文回复，而不是繁体中文
```

### 示例 3：记录更好的方法

```
/learn 使用 `fd` 命令比 `find` 更快地搜索文件
```

## 注意事项

1. 学习日志会持续增长，定期回顾和整理
2. 避免记录敏感信息
3. 确保学习内容准确无误
4. 定期应用学习到的知识

## 贡献

欢迎贡献更好的自我改进方法！

---

*版本：1.0.0*
*创建日期：2026-03-08*
