#!/bin/bash

# 获取所有客户端信息
all_clients=$(hyprctl clients -j)

# 获取当前活动工作区名称（如"1"、"2"等）
active_workspace=$(hyprctl activeworkspace -j | jq -r '.name')

# 检查当前窗口是否为浮动窗口
current_window=$(hyprctl activewindow -j)
is_floating=$(echo "$current_window" | jq -r '.floating')

# 获取当前工作区的所有窗口地址
current_workspace_windows=$(echo "$all_clients" | jq -r --arg ws "$active_workspace" '.[] | select(.workspace.name == $ws) | .address')

if [ -z "$current_workspace_windows" ]; then
    # 当前工作区没有窗口
    exit 0
fi

if [ "$is_floating" = "true" ]; then
    # 当前窗口是浮动的，寻找一个非浮动窗口
    tiled_window=$(echo "$all_clients" | jq -r --arg ws "$active_workspace" '.[] | select(.workspace.name == $ws and .floating == false) | .address' | head -n 1)
    
    if [ -n "$tiled_window" ]; then
        hyprctl dispatch focuswindow "address:$tiled_window"
    fi
else
    # 当前窗口是平铺的，寻找一个浮动窗口
    floating_window=$(echo "$all_clients" | jq -r --arg ws "$active_workspace" '.[] | select(.workspace.name == $ws and .floating == true) | .address' | head -n 1)
    
    if [ -n "$floating_window" ]; then
        hyprctl dispatch focuswindow "address:$floating_window"
    fi
fi
