#!/bin/bash
# toggle-clipboard-listener.sh

# 临时文件存储PID
PID_FILE="$HOME/.cache/clipboard-listener.pid"

# 检查临时文件是否存在（即监听进程是否正在运行）
if [ -f "$PID_FILE" ]; then
    # 如果监听进程正在运行，读取PID并杀死进程
    pid=$(cat "$PID_FILE")
    if pkill "wl-paste"; then
        echo "监听模式已停止"
        rm "$PID_FILE"  # 删除临时文件
        hyprctl notify 1 3000 'rgb(FF5555)' $'❌ 翻译模式关闭'
    else
        echo "无法停止监听模式，进程不存在"
    fi
else
    # 如果没有运行，启动监听进程并保存PID
    nohup bash /home/shadows/.local/bin/clipboard-listener.sh > /dev/null 2>&1 &
    echo $! > "$PID_FILE"  # 保存监听进程的PID
    echo "监听模式已启动"
    hyprctl notify 1 3000 'rgb(55FF55)' $'🌐 翻译模式开启'
fi
