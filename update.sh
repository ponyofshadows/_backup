#!/bin/bash

# 目标备份目录
BACKUP_DIR="$HOME/._backup/shadows_root"

# 路径列表
paths=(
  /etc/default/grub
  /etc/systemd/system/wpa_supplicant@wlp4s0.service
  /etc/fonts/conf.d/64-language-selector-prefer.conf
  /etc/pacman.d/hooks/update_snapshot.hook
  /usr/local/bin/create_btrfs_snapshot.sh

  /home/shadows/.config/user-dirs.conf
  /home/shadows/.config/user-dirs.user-dirs
  /home/sh/etc/default/grub
  /etc/systemd/system/wpa_supplicant@wlp4s0.service
  /etc/fonts/conf.d/64-language-selector-prefer.conf
  /etc/pacman.d/hooks/update_snapshot.hook
  /usr/local/bin/create_btrfs_snapshot.sh

  /home/shadows/.config/user-dirs.conf
  /home/shadows/.config/user-dirs.user-dirs
  /home/shadows/.config/hypr
  /home/shadows/.config/systemd/user/battery-warning.timer
  /home/shadows/.config/systemd/user/battery-warning.service
  /home/shadows/.local/bin/xwechat
  /home/shadows/.bash_profile
  /home/shadows/.bashrc
  /home/shadows/.bash
  /home/shadows/.local/bin/z
  /home/shadows/.local/bin/home_sync.sh
  /home/shadows/.pip
  /home/shadows/.config/nvim
  /home/shadows/.config/papis
  /home/shadows/.config/fcitx5
  /home/shadows/.local/share/fcitx5/rime/default.yaml
  /home/shadows/.local/share/fcitx5/rime/default.custom.yaml
  /home/shadows/.config/zathuraadows/.config/hypr
  /home/shadows/.config/systemd/user/battery-warning.timer
  /home/shadows/.config/systemd/user/battery-warning.service
  /home/shadows/.local/bin/xwechat
  /home/shadows/.bash_profile
  /home/shadows/.bashrc
  /home/shadows/.bash
  /home/shadows/.local/bin/z
  /home/shadows/.local/bin/home_sync.sh
  /home/shadows/.pip
  /home/shadows/.config/nvim
  /home/shadows/.config/papis
  /home/shadows/.config/fcitx5
  /home/shadows/.local/share/fcitx5/rime/default.yaml
  /home/shadows/.local/share/fcitx5/rime/default.custom.yaml
  /home/shadows/.config/zathura
)

# 复制文件和目录
for path in "${paths[@]}"; do
    if [[ -e "$path" ]]; then
        # 计算目标路径
        dest="$BACKUP_DIR/$path"
        
        # 创建目标目录
        mkdir -p "$(dirname "$dest")"
        
        # 复制文件或目录
        cp -a "$path" "$dest"
        echo "Copied: $path -> $dest"
    else
        echo "Warning: $path does not exist, skipping."
    fi
done

echo "Backup completed."
