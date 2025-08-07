#!/bin/bash
# required by ~/.config/hypr/hyprland.conf

# 检查监听进程是否正在运行
if pgrep -x wl-paste; then
    # 如果监听进程正在运行，结束翻译引擎并杀死进程
    #docker stop libretranslate
    pkill -x wl-paste
    hyprctl notify 6 3000 'rgb(FF5555)' $'⏸️ 复制后翻译已关闭，但libretranslate仍在运行'
else
    # 如果没有运行，启动监听进程
    nohup bash ~/.local/bin/clipboard-listener.sh > /dev/null 2>&1 &
    wl-copy --clear
    bash ~/.local/bin/start_libretranslate.sh
    hyprctl notify 6 3000 'rgb(55FF55)' $'🔤 复制后翻译已开启'
fi
