tell application "QQMusic"
    activate
end tell
delay 2
tell application "System Events"
    tell process "QQMusic"
        -- 按 Cmd+F 搜索
        keystroke "f" using command down
        delay 1
        -- 输入周杰伦
        keystroke "zhoujielun"
        delay 1
        -- 按回车搜索
        keystroke return
        delay 3
        -- 按向下箭头选择第一个结果
        key code 125
        delay 0.5
        -- 按回车播放
        keystroke return
    end tell
end tell
