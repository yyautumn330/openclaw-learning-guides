# GUI 自动化技能 - 详细说明

**日期**: 2026-03-09  
**技能**: desktop-control  
**状态**: 🟡 部分就绪（缺 OpenCV）

---

## 📦 依赖检查

### 已安装 ✅
| 依赖 | 版本 | 用途 |
|------|------|------|
| PyAutoGUI | 0.9.54 | 核心自动化引擎 |
| Pillow | 12.1.1 | 图像处理 |
| PyGetWindow | 0.0.9 | 窗口管理 |
| Python | 3.13.2 | 运行环境 |

### 未安装 ❌
| 依赖 | 用途 | 是否必需 |
|------|------|---------|
| opencv-python | 图像识别（找按钮/图标） | 可选 |

**安装命令**:
```bash
pip3 install opencv-python
```

---

## 🎯 核心功能详解

### 1. 鼠标控制

#### 绝对定位移动
```python
# 移动到屏幕坐标 (500, 300)
dc.move_mouse(500, 300)

# 平滑移动（1 秒）
dc.move_mouse(500, 300, duration=1.0)

# 瞬时移动
dc.move_mouse(500, 300, duration=0)
```

#### 相对移动
```python
# 从当前位置向右 100px，向下 50px
dc.move_relative(100, 50, duration=0.3)
```

#### 点击操作
```python
# 当前位置左键单击
dc.click()

# 指定位置双击
dc.click(500, 300, clicks=2)

# 右键点击
dc.click(button='right')

# 中键点击
dc.click(button='middle')
```

#### 拖放操作
```python
# 从 (200, 300) 拖到 (800, 500)
dc.drag(200, 300, 800, 500, duration=1.0)
```

#### 滚动
```python
# 向下滚动 5 格
dc.scroll(-5)

# 向上滚动 10 格
dc.scroll(10)

# 水平滚动
dc.scroll(5, direction='horizontal')
```

#### 获取位置
```python
x, y = dc.get_mouse_position()
print(f"鼠标位置：{x}, {y}")
```

---

### 2. 键盘控制

#### 文字输入
```python
# 瞬时输入
dc.type_text("Hello World")

# 模拟人工速度（60 字/分钟）
dc.type_text("Hello World", wpm=60)

# 每键间隔 0.1 秒
dc.type_text("Hello World", interval=0.1)
```

#### 按键
```python
# 按 Enter
dc.press('enter')

# 按 3 次空格
dc.press('space', presses=3)

# 方向键
dc.press('down')
dc.press('up')
dc.press('left')
dc.press('right')
```

#### 快捷键
```python
# 复制 (Ctrl+C / Cmd+C)
dc.hotkey('ctrl', 'c')

# 粘贴
dc.hotkey('ctrl', 'v')

# 保存 (Ctrl+S / Cmd+S)
dc.hotkey('ctrl', 's')

# 打开 (Ctrl+O / Cmd+O)
dc.hotkey('ctrl', 'o')

# 运行 (Shift+F10)
dc.hotkey('shift', 'f10')

# 全选
dc.hotkey('ctrl', 'a')

# 切换应用 (Cmd+Tab)
dc.hotkey('cmd', 'tab')
```

#### 按住/释放
```python
# 按住 Shift 输入大写
dc.key_down('shift')
dc.type_text("hello")  # 输出 "HELLO"
dc.key_up('shift')

# 按住 Ctrl 多选
dc.key_down('ctrl')
dc.click(100, 200)
dc.click(200, 200)
dc.key_up('ctrl')
```

---

### 3. 屏幕操作

#### 截图
```python
# 全屏截图
img = dc.screenshot()

# 保存为文件
dc.screenshot(filename="screen.png")

# 截取区域 (left, top, width, height)
img = dc.screenshot(region=(100, 100, 500, 300))
```

#### 获取像素颜色
```python
r, g, b = dc.get_pixel_color(500, 300)
print(f"RGB({r}, {g}, {b})")
```

#### 图像识别（需 OpenCV）
```python
# 在屏幕上找按钮图标
location = dc.find_on_screen("run_button.png", confidence=0.8)
if location:
    x, y, w, h = location
    # 点击按钮中心
    dc.click(x + w//2, y + h//2)
```

#### 获取屏幕尺寸
```python
width, height = dc.get_screen_size()
print(f"屏幕分辨率：{width}x{height}")
```

---

### 4. 窗口管理

#### 获取所有窗口
```python
windows = dc.get_all_windows()
for title in windows:
    print(f"窗口：{title}")
```

#### 激活窗口
```python
# 通过标题 substring 激活
dc.activate_window("DevEco Studio")
dc.activate_window("Chrome")
dc.activate_window("Visual Studio Code")
```

#### 获取当前活动窗口
```python
active = dc.get_active_window()
print(f"当前窗口：{active}")
```

---

### 5. 剪贴板操作

#### 复制到剪贴板
```python
dc.copy_to_clipboard("要复制的文字")
```

#### 从剪贴板读取
```python
text = dc.get_from_clipboard()
print(f"剪贴板内容：{text}")
```

---

## 🛡️ 安全特性

### 紧急停止（Failsafe）
- **触发方式**: 将鼠标移到**任意屏幕角落**
- **效果**: 立即停止所有自动化操作
- **默认**: 已启用

```python
# 创建时启用（默认）
dc = DesktopController(failsafe=True)

# 禁用（不推荐）
dc = DesktopController(failsafe=False)
```

### 操作确认模式
```python
# 每次操作前询问确认
dc = DesktopController(require_approval=True)

# 点击前会弹出："允许点击 (500, 500)? [y/n]"
dc.click(500, 500)
```

### 暂停控制
```python
# 暂停 2 秒
dc.pause(2.0)

# 检查是否安全
if dc.is_safe():
    dc.click(500, 500)
```

---

## 🎯 实际应用场景

### 场景 1: DevEco Studio 自动构建

```python
dc = DesktopController()

# 1. 激活 DevEco Studio
dc.activate_window("DevEco Studio")
time.sleep(1)

# 2. 打开项目 (Cmd+O)
dc.hotkey('cmd', 'o')
time.sleep(0.5)

# 3. 输入项目路径
project_path = "/Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiPomodoro"
dc.type_text(project_path, wpm=60)
time.sleep(0.3)

# 4. 按 Enter 确认
dc.press('enter')
time.sleep(5)  # 等待项目同步

# 5. 运行构建 (Shift+F10)
dc.hotkey('shift', 'f10')

# 6. 等待构建完成
time.sleep(30)

# 7. 截图构建结果
dc.screenshot(filename="build_result.png")
```

### 场景 2: 自动填写表单

```python
dc = DesktopController()

# 点击姓名输入框
dc.click(300, 200)
dc.type_text("张三", wpm=40)

# Tab 到邮箱
dc.press('tab')
dc.type_text("zhangsan@example.com", wpm=50)

# Tab 到密码
dc.press('tab')
dc.type_text("SecurePass123")

# 提交
dc.press('enter')
```

### 场景 3: 批量文件操作

```python
dc = DesktopController()

# 激活 Finder
dc.activate_window("Finder")

# 按住 Ctrl 多选文件
dc.key_down('ctrl')
dc.click(100, 200)  # 文件 1
dc.click(100, 250)  # 文件 2
dc.click(100, 300)  # 文件 3
dc.key_up('ctrl')

# 复制到剪贴板
dc.hotkey('cmd', 'c')

# 导航到目标文件夹
dc.click(800, 200)  # 点击文件夹

# 粘贴
dc.hotkey('cmd', 'v')
```

### 场景 4: 图像识别点击

```python
dc = DesktopController()

# 找屏幕上的"运行"按钮图标
button_location = dc.find_on_screen("run_icon.png", confidence=0.85)

if button_location:
    x, y, w, h = button_location
    # 点击按钮中心
    center_x = x + w // 2
    center_y = y + h // 2
    dc.click(center_x, center_y)
    print("✅ 找到并点击了运行按钮")
else:
    print("❌ 未找到运行按钮")
```

---

## ⌨️ 完整按键名称参考

### 字母数字
- 字母：`'a'` - `'z'`
- 数字：`'0'` - `'9'`

### 功能键
- `'f1'` - `'f24'`

### 特殊键
```
'enter' / 'return'     # 回车
'esc' / 'escape'       # 退出
'space' / 'spacebar'   # 空格
'tab'                  # 制表
'backspace'            # 退格
'delete' / 'del'       # 删除
'insert'               # 插入
'home'                 # 首页
'end'                  # 末尾
'pageup' / 'pgup'      # 上页
'pagedown' / 'pgdn'    # 下页
```

### 方向键
```
'up' / 'down' / 'left' / 'right'
```

### 修饰键
```
'ctrl' / 'control'     # 控制
'shift'                # 换档
'alt'                  # 交替
'cmd' / 'command'      # Mac 命令键
'win' / 'winleft'      # Windows 键
```

---

## ⚠️ Mac 特殊说明

### 修饰键映射
| Windows | Mac | 代码 |
|---------|-----|------|
| Ctrl | Cmd | `'ctrl'` 或 `'cmd'` |
| Alt | Option | `'alt'` |
| Win | Cmd | `'win'` 或 `'cmd'` |

### 推荐 Mac 快捷键
```python
# 保存
dc.hotkey('cmd', 's')

# 打开
dc.hotkey('cmd', 'o')

# 复制
dc.hotkey('cmd', 'c')

# 粘贴
dc.hotkey('cmd', 'v')

# 切换应用
dc.hotkey('cmd', 'tab')

# 关闭窗口
dc.hotkey('cmd', 'w')

# 退出应用
dc.hotkey('cmd', 'q')

# 最小化
dc.hotkey('cmd', 'm')
```

---

## 🔧 权限要求 (Mac)

### 必需权限
1. **辅助功能权限**
   - 系统设置 → 隐私与安全性 → 辅助功能
   - 添加：终端 (Terminal) 或 Python

2. **屏幕录制权限**
   - 系统设置 → 隐私与安全性 → 屏幕录制
   - 添加：终端 (Terminal) 或 Python

### 授予权限步骤
1. 打开 **系统设置**
2. 进入 **隐私与安全性**
3. 找到 **辅助功能**
4. 点击 `+` 添加 **终端**
5. 同样步骤添加 **屏幕录制** 权限
6. 重启终端生效

---

## 📊 性能对比

| 操作类型 | 瞬时模式 | 平滑模式 | 人工模拟 |
|---------|---------|---------|---------|
| 鼠标移动 | 0ms | 500-1000ms | 1000-2000ms |
| 文字输入 | 0ms/键 | 50ms/键 | 100-200ms/键 |
| 点击 | 即时 | 即时 | 即时 |
| 快捷键 | 即时 | 即时 | 即时 |

---

## 🚀 快速开始示例

```python
# 1. 导入并初始化
from skills.desktop_control import DesktopController
dc = DesktopController(failsafe=True)

# 2. 获取屏幕尺寸
width, height = dc.get_screen_size()
print(f"屏幕：{width}x{height}")

# 3. 截图
dc.screenshot(filename="test.png")

# 4. 激活窗口
dc.activate_window("Safari")

# 5. 输入文字
dc.type_text("Hello from OpenClaw!", wpm=60)

# 6. 按 Enter
dc.press('enter')

# 7. 完成
print("✅ 操作完成!")
```

---

## ❓ 常见问题

### Q: 鼠标不动？
**A**: 检查辅助功能权限是否授予

### Q: 坐标不对？
**A**: 多显示器可能有负坐标，使用 `get_screen_size()` 确认

### Q: 输入没反应？
**A**: 确保目标应用有焦点，使用 `activate_window()` 激活

### Q: 如何紧急停止？
**A**: 将鼠标移到任意屏幕角落

---

## 📝 下一步

1. **安装 OpenCV** (可选，用于图像识别):
   ```bash
   pip3 install opencv-python
   ```

2. **授予权限** (Mac):
   - 辅助功能
   - 屏幕录制

3. **测试基本操作**:
   ```python
   dc = DesktopController()
   dc.screenshot(filename="test.png")
   print("✅ 截图成功!")
   ```

4. **尝试 DevEco Studio 自动化**:
   - 激活窗口
   - 快捷键打开项目
   - 运行构建

---

*文档版本*: 1.0  
*适用技能*: desktop-control v1.0.0
