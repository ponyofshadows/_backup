#!/bin/bash

# 获取根文件系统的设备
system_root_device=$(findmnt -n -o SOURCE /)
system_root_device=${system_root_device%%[*}

# 获取当前日期（不包含时间）
snapshot_date=$(date +'%Y-%m-%d')

# 挂载 Btrfs 顶级子卷
mount -m "$system_root_device" /mnt/@top_subvol || {
    echo "[user's script] Failed to mount $system_root_device"
    exit 1
}

# 检查当天的快照是否已存在
if ls /mnt/@top_subvol/@snapshot${snapshot_date}_* &>/dev/null; then
    echo "Snapshot for today ($snapshot_date) already exists. Skipping creation."
else
    # 创建新的快照
    snapshot_name="@snapshot${snapshot_date}_$(date +'%H:%M:%S')"
    btrfs subvolume snapshot / "/mnt/@top_subvol/$snapshot_name" &&
    echo "[user's script] Created snapshot: /mnt/@top_subvol/$snapshot_name"
fi

# 获取所有快照并按时间降序排序
snapshots=( $(ls -dr /mnt/@top_subvol/@snapshot* 2>/dev/null) )

# 保留最近的 1 个快照
max_snapshots=1
if (( ${#snapshots[@]} > max_snapshots )); then
    for snapshot in "${snapshots[@]:max_snapshots}"; do
        echo "[user's script] Deleting old snapshot: $snapshot"
        btrfs subvolume delete "$snapshot"
    done
fi

# 清理挂载点
umount /mnt/@top_subvol
rmdir /mnt/@top_subvol
