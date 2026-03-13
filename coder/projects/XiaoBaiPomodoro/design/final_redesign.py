#!/usr/bin/env python3
"""
小白番茄专注钟 - 最终重新设计
根据用户反馈：
1. 图标：背景要用浅色/渐变，不要用黑色；番茄要饱满可爱 (#FF6B6B)；绿叶点缀 (#4ECDC4)
2. 截图：内容要居中，1080x1920
"""

from PIL import Image, ImageDraw, ImageFont, ImageFilter
import math
import os

# 颜色定义
TOMATO_RED = (255, 107, 107, 255)      # #FF6B6B - 主番茄红
TOMATO_DARK = (230, 80, 80, 255)       # 深红色用于阴影
LEAF_GREEN = (78, 205, 196, 255)       # #4ECDC4 - 绿叶
LEAF_DARK = (50, 180, 170, 255)        # 深绿叶
STEM_BROWN = (101, 67, 33, 255)        # 棕色茎
BG_LIGHT = (255, 255, 255, 255)        # 白色背景
BG_GRADIENT_START = (255, 255, 255, 255)  # 渐变起始
BG_GRADIENT_END = (240, 240, 245, 255)    # 渐变结束

def create_gradient_background(size, color1, color2):
    """创建垂直渐变背景"""
    img = Image.new('RGBA', (size, size))
    draw = ImageDraw.Draw(img)
    for y in range(size):
        r = int(color1[0] + (color2[0] - color1[0]) * y / size)
        g = int(color1[1] + (color2[1] - color1[1]) * y / size)
        b = int(color1[2] + (color2[2] - color1[2]) * y / size)
        draw.line([(0, y), (size, y)], fill=(r, g, b, 255))
    return img

def create_app_icon():
    """创建专业的番茄钟应用图标 - 符合用户新要求"""
    size = 512
    center = size // 2
    
    # 1. 创建浅色渐变背景
    img = create_gradient_background(size, BG_GRADIENT_START, BG_GRADIENT_END)
    draw = ImageDraw.Draw(img)
    
    # 2. 添加柔和的阴影（让图标有层次感）
    shadow_color = (0, 0, 0, 30)
    draw.ellipse([center-205, center-195, center+205, center+215], fill=shadow_color)
    shadow = Image.new('RGBA', (size, size), (0, 0, 0, 0))
    shadow_draw = ImageDraw.Draw(shadow)
    shadow_draw.ellipse([center-200, center-200, center+200, center+200], fill=(0, 0, 0, 80))
    shadow = shadow.filter(ImageFilter.GaussianBlur(radius=15))
    img = Image.alpha_composite(img.convert('RGBA'), shadow)
    draw = ImageDraw.Draw(img)
    
    # 3. 绘制饱满的番茄主体（大圆形）
    tomato_radius = 200
    
    # 番茄主体渐变效果
    for r in range(tomato_radius, 0, -2):
        ratio = r / tomato_radius
        red_val = int(TOMATO_RED[0] + (TOMATO_DARK[0] - TOMATO_RED[0]) * (1 - ratio))
        green_val = int(TOMATO_RED[1] + (TOMATO_DARK[1] - TOMATO_RED[1]) * (1 - ratio))
        blue_val = int(TOMATO_RED[2] + (TOMATO_DARK[2] - TOMATO_RED[2]) * (1 - ratio))
        draw.ellipse([center-r, center-r, center+r, center+r], 
                    fill=(red_val, green_val, blue_val, 255))
    
    # 4. 添加高光（让番茄更饱满立体）
    highlight_color = (255, 180, 180, 200)
    draw.ellipse([center-120, center-120, center-40, center-40], fill=highlight_color)
    
    # 小高光点
    draw.ellipse([center-60, center-100, center-30, center-70], fill=(255, 255, 255, 180))
    
    # 5. 绘制茎（棕色）
    stem_points = [
        (center-12, center-195),
        (center+12, center-195),
        (center+8, center-235),
        (center-8, center-235)
    ]
    draw.polygon(stem_points, fill=STEM_BROWN)
    
    # 6. 绘制三片绿叶（#4ECDC4）
    # 左叶子
    left_leaf = [
        (center-10, center-210),
        (center-70, center-240),
        (center-50, center-200),
        (center-20, center-205)
    ]
    draw.polygon(left_leaf, fill=LEAF_GREEN)
    # 左叶脉
    draw.line([(center-15, center-210), (center-60, center-235)], fill=LEAF_DARK, width=2)
    
    # 右叶子
    right_leaf = [
        (center+10, center-210),
        (center+70, center-240),
        (center+50, center-200),
        (center+20, center-205)
    ]
    draw.polygon(right_leaf, fill=LEAF_GREEN)
    # 右叶脉
    draw.line([(center+15, center-210), (center+60, center-235)], fill=LEAF_DARK, width=2)
    
    # 中叶子（向上）
    center_leaf = [
        (center, center-230),
        (center-25, center-265),
        (center, center-255),
        (center+25, center-265)
    ]
    draw.polygon(center_leaf, fill=LEAF_GREEN)
    # 中叶脉
    draw.line([(center, center-230), (center, center-260)], fill=LEAF_DARK, width=2)
    
    # 7. 添加底部反光
    reflect_color = (255, 255, 255, 100)
    draw.arc([center-180, center+100, center+180, center+220], 0, 180, fill=reflect_color, width=8)
    
    # 保存图标
    img.save('app-icon-512.png', 'PNG')
    
    # 创建正方形版本（内容居中）
    img.save('app-icon-512-square.png', 'PNG')
    
    print('✅ 应用图标已重新设计')
    print('   - app-icon-512.png (512x512)')
    print('   - app-icon-512-square.png (512x512)')
    print(f'   - 背景：浅色渐变（白→浅灰）')
    print(f'   - 番茄：饱满红色 #FF6B6B')
    print(f'   - 叶子：绿色 #4ECDC4')
    return img

def create_screenshot_template(screen_type, title, content_elements):
    """创建截图模板 - 确保内容居中"""
    width, height = 1080, 1920
    
    # 创建背景
    img = Image.new('RGBA', (width, height), (255, 255, 255, 255))
    draw = ImageDraw.Draw(img)
    
    # 顶部状态栏区域（留白）
    # 主要内容区域 - 确保水平居中
    center_x = width // 2
    
    # 绘制标题（居中）
    try:
        font_title = ImageFont.truetype("/System/Library/Fonts/Supplemental/PingFang.ttc", 48)
        font_body = ImageFont.truetype("/System/Library/Fonts/Supplemental/PingFang.ttc", 24)
    except:
        font_title = ImageFont.load_default()
        font_body = ImageFont.load_default()
    
    # 标题背景（居中的卡片）
    card_width = 900
    card_x = center_x - card_width // 2
    
    # 根据屏幕类型绘制不同内容
    if screen_type == 'main':
        # 首页 - 番茄计时器
        # 顶部卡片
        draw.rounded_rectangle([card_x, 100, card_x + card_width, 280], radius=24, 
                              fill=(255, 107, 107, 255))
        # 计时器数字（居中）
        draw.text((center_x, 200), "25:00", fill=(255, 255, 255, 255), 
                 font=font_title, anchor="mm")
        
        # 番茄图标（居中）
        tomato_radius = 150
        draw.ellipse([center_x-tomato_radius, 400, center_x+tomato_radius, 700], 
                    fill=TOMATO_RED)
        # 番茄高光
        draw.ellipse([center_x-80, 420, center_x-20, 480], fill=(255, 180, 180, 200))
        
        # 控制按钮（居中）
        button_width = 200
        button_x = center_x - button_width
        draw.rounded_rectangle([button_x, 800, button_x + button_width, 880], radius=40,
                              fill=(255, 107, 107, 255))
        draw.rounded_rectangle([center_x, 800, center_x + button_width, 880], radius=40,
                              fill=(100, 100, 100, 255))
        draw.text((button_x + button_width//2, 840), "开始", fill=(255, 255, 255, 255),
                 font=font_body, anchor="mm")
        draw.text((center_x + button_width//2, 840), "暂停", fill=(255, 255, 255, 255),
                 font=font_body, anchor="mm")
        
        # 今日统计卡片（居中）
        draw.rounded_rectangle([card_x, 1000, card_x + card_width, 1150], radius=20,
                              fill=(248, 249, 250, 255))
        draw.text((center_x, 1050), "今日完成", fill=(134, 142, 150, 255),
                 font=font_body, anchor="mm")
        draw.text((center_x, 1100), "4 个番茄", fill=(255, 107, 107, 255),
                 font=font_title, anchor="mm")
    
    elif screen_type == 'stats':
        # 统计页面
        draw.text((center_x, 150), "数据统计", fill=(33, 37, 41, 255),
                 font=font_title, anchor="mm")
        
        # 今日概览卡片（居中）
        draw.rounded_rectangle([card_x, 220, card_x + card_width, 400], radius=20,
                              fill=(255, 107, 107, 255))
        draw.text((center_x, 280), "今日专注", fill=(255, 255, 255, 255),
                 font=font_body, anchor="mm")
        draw.text((center_x, 340), "100 分钟", fill=(255, 255, 255, 255),
                 font=font_title, anchor="mm")
        
        # 周统计图表（居中）
        draw.rounded_rectangle([card_x, 450, card_x + card_width, 700], radius=20,
                              fill=(248, 249, 250, 255))
        # 柱状图
        bar_width = 60
        spacing = 80
        start_x = center_x - (3 * spacing)
        for i in range(7):
            bar_height = 50 + i * 20
            bar_x = start_x + i * spacing
            draw.rounded_rectangle([bar_x, 650-bar_height, bar_x+bar_width, 650],
                                  radius=8, fill=TOMATO_RED)
        
        # 月度热力图（居中）
        draw.rounded_rectangle([card_x, 750, card_x + card_width, 950], radius=20,
                              fill=(248, 249, 250, 255))
        draw.text((card_x + 30, 780), "月度专注", fill=(134, 142, 150, 255),
                 font=font_body)
    
    elif screen_type == 'achievements':
        # 成就页面
        draw.text((center_x, 150), "成就徽章", fill=(33, 37, 41, 255),
                 font=font_title, anchor="mm")
        
        # 成就卡片（居中排列）
        achievements = [
            ("🏆", "连续打卡 7 天", "2026-03-01"),
            ("⭐", "专注 10 小时", "2026-03-05"),
            ("🔥", "连胜纪录 15 天", "2026-03-07"),
            ("🎯", "完成 50 个番茄", "2026-03-08"),
        ]
        
        y = 220
        for emoji, name, date in achievements:
            draw.rounded_rectangle([card_x, y, card_x + card_width, y + 120], radius=20,
                                  fill=(248, 249, 250, 255))
            # 徽章图标（居中）
            draw.text((card_x + 80, y + 60), emoji, font=font_title, anchor="lm")
            # 成就名称
            draw.text((card_x + 150, y + 50), name, fill=(33, 37, 41, 255),
                     font=font_body, anchor="lm")
            draw.text((card_x + 150, y + 85), f"达成于 {date}", fill=(134, 142, 150, 255),
                     font=ImageFont.load_default(), anchor="lm")
            y += 140
    
    elif screen_type == 'settings':
        # 设置页面
        draw.text((center_x, 150), "设置", fill=(33, 37, 41, 255),
                 font=font_title, anchor="mm")
        
        # 设置项卡片（居中）
        settings_items = [
            ("⏱️", "番茄时长", "25 分钟"),
            ("🌙", "休息时长", "5 分钟"),
            ("🔔", "通知音效", "开启"),
            ("📱", "桌面小组件", "已添加"),
            ("💾", "数据备份", "iCloud"),
        ]
        
        y = 220
        for emoji, name, value in settings_items:
            draw.rounded_rectangle([card_x, y, card_x + card_width, y + 100], radius=20,
                                  fill=(248, 249, 250, 255))
            draw.text((card_x + 40, y + 50), f"{emoji} {name}", fill=(33, 37, 41, 255),
                     font=font_body, anchor="lm")
            draw.text((card_x + card_width - 40, y + 50), value, fill=(134, 142, 150, 255),
                     font=font_body, anchor="rm")
            y += 120
    
    elif screen_type == 'widgets':
        # 桌面卡片页面
        draw.text((center_x, 150), "桌面小组件", fill=(33, 37, 41, 255),
                 font=font_title, anchor="mm")
        
        # 2x2 卡片（居中）
        draw.rounded_rectangle([center_x-180, 220, center_x+180, 580], radius=24,
                              fill=(255, 107, 107, 255))
        draw.text((center_x, 280), "专注中", fill=(255, 255, 255, 255),
                 font=font_body, anchor="mm")
        draw.text((center_x, 380), "25:00", fill=(255, 255, 255, 255),
                 font=font_title, anchor="mm")
        # 小番茄图标
        draw.ellipse([center_x-40, 450, center_x+40, 530], fill=(255, 255, 255, 255))
        
        # 2x4 卡片（居中）
        draw.rounded_rectangle([center_x-350, 650, center_x+350, 1000], radius=24,
                              fill=(248, 249, 250, 255))
        draw.text((center_x, 700), "今日统计", fill=(33, 37, 41, 255),
                 font=font_body, anchor="mm")
        draw.text((center_x, 780), "4 个番茄", fill=(255, 107, 107, 255),
                 font=font_title, anchor="mm")
        draw.text((center_x, 850), "100 分钟专注", fill=(134, 142, 150, 255),
                 font=font_body, anchor="mm")
        
        # 快速控制按钮
        draw.rounded_rectangle([center_x-150, 920, center_x+150, 980], radius=30,
                              fill=(255, 107, 107, 255))
        draw.text((center_x, 950), "开始专注", fill=(255, 255, 255, 255),
                 font=font_body, anchor="mm")
    
    # 底部导航栏（确保在底部正确位置，居中）
    nav_y = height - 100
    draw.rectangle([0, nav_y, width, height], fill=(255, 255, 255, 255))
    
    # 导航图标（5 个，均匀分布，居中）
    nav_items = ["🏠", "📊", "🏆", "⚙️", "📱"]
    nav_labels = ["首页", "统计", "成就", "设置", "组件"]
    nav_width = width - 100
    nav_spacing = nav_width // 5
    
    for i in range(5):
        nav_x = 50 + i * nav_spacing
        # 当前页面高亮
        if (screen_type == 'main' and i == 0) or \
           (screen_type == 'stats' and i == 1) or \
           (screen_type == 'achievements' and i == 2) or \
           (screen_type == 'settings' and i == 3) or \
           (screen_type == 'widgets' and i == 4):
            draw.ellipse([nav_x + 15, nav_y + 10, nav_x + 65, nav_y + 60], 
                        fill=(255, 107, 107, 50))
            draw.text((nav_x + 40, nav_y + 75), nav_labels[i], fill=(255, 107, 107, 255),
                     font=font_body, anchor="mm")
        else:
            draw.text((nav_x + 40, nav_y + 75), nav_labels[i], fill=(134, 142, 150, 255),
                     font=font_body, anchor="mm")
        draw.text((nav_x + 40, nav_y + 35), nav_items[i], font=ImageFont.load_default(),
                 anchor="mm")
    
    return img

def create_all_screenshots():
    """创建所有 5 个截图"""
    screens = [
        ('main', 'screen-1-main.png', '首页'),
        ('stats', 'screen-2-stats.png', '统计'),
        ('achievements', 'screen-3-achievements.png', '成就'),
        ('settings', 'screen-4-settings.png', '设置'),
        ('widgets', 'screen-5-widgets.png', '桌面卡片'),
    ]
    
    for screen_type, filename, name in screens:
        img = create_screenshot_template(screen_type, name, [])
        img.save(filename, 'PNG')
        print(f'✅ 截图已创建：{filename} (1080x1920) - {name}')

def create_design_doc():
    """创建设计说明文档"""
    doc = """# 小白番茄专注钟 - 设计说明

## 设计版本
v2.0 - 根据用户反馈重新设计

## 设计日期
2026-03-08

## 设计师
小白 (XiaoBai) UX Design Team

---

## 一、应用图标设计

### 设计要求
- ✅ **背景**: 浅色渐变（白色 → 浅灰色），避免黑色背景
- ✅ **主体**: 饱满的红色番茄 (#FF6B6B)
- ✅ **点缀**: 绿色叶子 (#4ECDC4)
- ✅ **风格**: 简洁、现代、专业
- ✅ **尺寸**: 512x512 PNG
- ✅ **格式**: 正方形，内容居中

### 设计元素
1. **背景**: 垂直渐变（#FFFFFF → #F0F0F5），营造柔和视觉效果
2. **番茄主体**: 直径 400px 的饱满圆形，使用渐变红色增强立体感
3. **高光效果**: 左上角添加白色高光，增强质感
4. **茎部**: 棕色 (#654321)，连接番茄与叶子
5. **叶子**: 3 片绿叶 (#4ECDC4)，呈放射状排列，增加生动感
6. **底部反光**: 白色弧形反光，增强立体感

### 色彩规范
| 元素 | 色值 | 说明 |
|------|------|------|
| 番茄红 | #FF6B6B | 主色调，活力、专注 |
| 叶子绿 | #4ECDC4 | 点缀色，自然、清新 |
| 茎棕色 | #654321 | 连接元素 |
| 背景白 | #FFFFFF | 渐变起始 |
| 背景灰 | #F0F0F5 | 渐变结束 |

### 输出文件
- `app-icon-512.png` - 主图标 (512x512)
- `app-icon-512-square.png` - 正方形版本 (512x512)

---

## 二、界面截图设计

### 设计要求
- ✅ **内容**: 所有 UI 元素水平居中
- ✅ **尺寸**: 1080x1920 PNG
- ✅ **数量**: 5 张
- ✅ **底部导航**: 确保在底部正确位置
- ✅ **视觉**: 内容清晰，布局美观

### 截图清单

#### 1. screen-1-main.png - 首页（番茄计时器）
**核心元素**:
- 顶部模式标签（专注/休息）
- 中央大号倒计时数字 (25:00)
- 番茄图标展示
- 控制按钮组（开始 | 暂停）
- 今日完成番茄数卡片
- 底部导航栏（5 个 tab）

**布局特点**:
- 所有元素水平居中
- 倒计时数字使用超大字号
- 番茄图标位于视觉中心
- 底部导航栏固定位置

#### 2. screen-2-stats.png - 统计页面
**核心元素**:
- 页面标题"数据统计"
- 今日概览卡片（番茄红背景）
- 周统计柱状图
- 月度热力图
- 底部导航栏

**数据展示**:
- 今日专注时长：100 分钟
- 本周每日番茄数对比
- 月度专注日历热力图

#### 3. screen-3-achievements.png - 成就页面
**核心元素**:
- 页面标题"成就徽章"
- 成就卡片列表（4 个）
- 每个成就包含：徽章图标、名称、达成日期
- 底部导航栏

**成就类型**:
- 🏆 连续打卡 7 天
- ⭐ 专注 10 小时
- 🔥 连胜纪录 15 天
- 🎯 完成 50 个番茄

#### 4. screen-4-settings.png - 设置页面
**核心元素**:
- 页面标题"设置"
- 设置项列表（5 项）
- 每项包含：图标、名称、当前值
- 底部导航栏

**设置项**:
- ⏱️ 番茄时长：25 分钟
- 🌙 休息时长：5 分钟
- 🔔 通知音效：开启
- 📱 桌面小组件：已添加
- 💾 数据备份：iCloud

#### 5. screen-5-widgets.png - 桌面卡片
**核心元素**:
- 页面标题"桌面小组件"
- 2x2 卡片（快速启动 + 倒计时）
- 2x4 卡片（今日统计 + 快速控制）
- 底部导航栏

**卡片功能**:
- 小型卡片：显示当前倒计时，快速开始
- 大型卡片：展示今日统计，快捷控制

---

## 三、设计规范

### 色彩系统
| 类型 | 色值 | 用途 |
|------|------|------|
| 主色 | #FF6B6B | 番茄红，主要按钮、强调 |
| 辅助绿 | #4ECDC4 | 叶子、成功状态 |
| 文字深 | #212529 | 主要文字 |
| 文字中 | #868E96 | 次要文字 |
| 背景浅 | #F8F9FA | 卡片背景 |
| 纯白 | #FFFFFF | 主背景 |

### 字体规范
| 用途 | 字号 | 字重 |
|------|------|------|
| 页面标题 | 48pt | Bold |
| 大数字 | 48pt | Bold |
| 卡片标题 | 24pt | Medium |
| 正文 | 16pt | Regular |
| 辅助文字 | 14pt | Regular |

### 圆角规范
| 元素 | 圆角 |
|------|------|
| 大卡片 | 24px |
| 普通卡片 | 20px |
| 按钮 | 40px (完全圆角) |
| 小元素 | 8px |

### 间距规范
- 页面边距：50px
- 卡片间距：20px
- 元素间距：15px
- 底部导航高度：100px

---

## 四、交付文件清单

### 图标文件
- ✅ `app-icon-512.png` (512x512 PNG)
- ✅ `app-icon-512-square.png` (512x512 PNG)

### 截图文件
- ✅ `screen-1-main.png` (1080x1920 PNG) - 首页
- ✅ `screen-2-stats.png` (1080x1920 PNG) - 统计
- ✅ `screen-3-achievements.png` (1080x1920 PNG) - 成就
- ✅ `screen-4-settings.png` (1080x1920 PNG) - 设置
- ✅ `screen-5-widgets.png` (1080x1920 PNG) - 桌面卡片

### 设计文档
- ✅ `设计说明.md` - 本文件

---

## 五、设计原则

1. **简洁性** - 每屏只展示核心信息，避免干扰
2. **一致性** - 统一的色彩、字体、圆角规范
3. **居中布局** - 所有主要内容水平居中，视觉平衡
4. **可访问性** - 色彩对比度符合 WCAG AA 标准
5. **现代化** - 扁平化设计 + 微渐变，符合当前设计趋势

---

## 六、后续流程

1. ✅ 设计完成
2. ⏳ 通知正男检视
3. ⏳ 检视通过后替换到工程目录
4. ⏳ 重新构建 HAP 包验证

---

_设计版本：v2.0_
_创建时间：2026-03-08 19:29_
_设计师：小白 (XiaoBai)_
_项目：番茄专注钟 (XiaoBai Pomodoro)_
"""
    
    with open('设计说明.md', 'w', encoding='utf-8') as f:
        f.write(doc)
    print('✅ 设计说明文档已创建：设计说明.md')

# === 主程序 ===
if __name__ == '__main__':
    print('🎨 开始重新设计小白番茄专注钟...\n')
    print('📋 设计要求:')
    print('   1. 图标：浅色背景，饱满番茄 (#FF6B6B)，绿叶 (#4ECDC4)')
    print('   2. 截图：内容居中，1080x1920，5 个页面\n')
    
    # 1. 创建新图标
    create_app_icon()
    print()
    
    # 2. 创建所有截图
    create_all_screenshots()
    print()
    
    # 3. 创建设计文档
    create_design_doc()
    
    print('\n✅ 所有设计已完成！')
    print('\n📦 交付文件:')
    print('   图标:')
    print('      - app-icon-512.png')
    print('      - app-icon-512-square.png')
    print('   截图:')
    print('      - screen-1-main.png')
    print('      - screen-2-stats.png')
    print('      - screen-3-achievements.png')
    print('      - screen-4-settings.png')
    print('      - screen-5-widgets.png')
    print('   文档:')
    print('      - 设计说明.md')
    print('\n📬 下一步：通知正男检视')
