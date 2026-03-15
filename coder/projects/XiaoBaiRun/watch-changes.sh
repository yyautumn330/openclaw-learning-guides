#!/bin/bash
# 文件变化监控脚本
# 检测到代码变化时提醒在 DevEco Studio 中编译

PROJECT_DIR="/Users/autumn/.openclaw/workspace/coder/projects/XiaoBaiRun"
LAST_CHECK_FILE="/tmp/xiaobai-run-last-check"
CHECK_INTERVAL=5  # 秒

# 初始化
touch "$LAST_CHECK_FILE"
echo "🔍 监控文件变化..."
echo "📁 项目: $PROJECT_DIR"
echo "⏱️  检查间隔: ${CHECK_INTERVAL}秒"
echo ""
echo "修改代码后，请在 DevEco Studio 中点击 Build > Build Hap(s)/APP(s) > Build Hap(s)"
echo "按 Ctrl+C 停止监控"
echo ""

while true; do
    # 查找最近修改的 .ets/.ts 文件
    RECENT_FILE=$(find "$PROJECT_DIR/entry/src/main/ets" -name "*.ets" -o -name "*.ts" 2>/dev/null | xargs ls -t 2>/dev/null | head -1)
    
    if [ -n "$RECENT_FILE" ]; then
        FILE_TIME=$(stat -f %m "$RECENT_FILE" 2>/dev/null)
        LAST_TIME=$(cat "$LAST_CHECK_FILE" 2>/dev/null || echo 0)
        
        if [ "$FILE_TIME" -gt "$LAST_TIME" ]; then
            FILE_NAME=$(basename "$RECENT_FILE")
            MOD_TIME=$(stat -f "%H:%M:%S" "$RECENT_FILE")
            echo ""
            echo "📝 [$MOD_TIME] 检测到文件变化: $FILE_NAME"
            echo "   📂 路径: ${RECENT_FILE#$PROJECT_DIR/}"
            echo "   🔧 请在 DevEco Studio 中编译验证"
            echo ""
            echo "$FILE_TIME" > "$LAST_CHECK_FILE"
        fi
    fi
    
    sleep $CHECK_INTERVAL
done