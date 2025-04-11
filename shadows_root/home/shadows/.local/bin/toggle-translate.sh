#!/bin/bash
# toggle-clipboard-listener.sh


# 检查监听进程是否正在运行
if pgrep -x wl-paste; then
    # 如果监听进程正在运行，结束翻译引擎并杀死进程
    hyprctl notify 6 3000 'rgb(FF5555)' $'❌ 翻译模式关闭中...'
    docker stop libretranslate
    pkill wl-paste
    echo "监听模式已停止"
    hyprctl notify 6 1500 'rgb(FF5555)' $'❌ 翻译模式已关闭'
else
    # 如果没有运行，启动监听进程
    nohup bash /home/shadows/.local/bin/clipboard-listener.sh > /dev/null 2>&1 &
    bash ~/.local/bin/start_libretranslate.sh
    echo "监听模式已启动"
    hyprctl notify 6 3000 'rgb(55FF55)' $'🔠 翻译模式已开启'
fi
