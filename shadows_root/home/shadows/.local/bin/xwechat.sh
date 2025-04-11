#!/bin/bash
# 启动 xwayland-satellite
xwayland-satellite &  # 在后台启动

# 获取 xwayland-satellite 的 PID
xwayland_pid=$!

# 启动 WeChat
wechat-universal &

# 等待 WeChat 进程退出
wait $!

# 如果 WeChat 退出，终止 xwayland-satellite
kill $xwayland_pid

