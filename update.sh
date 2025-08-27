#!/bin/bash

# 目标备份目录
BACKUP_DIR="$HOME/._backup/shadows_root"

# 路径列表
paths=(
  /etc/default/grub
  /etc/fonts/local.conf
  /etc/pacman.d/hooks/update_snapshot.hook
  /etc/default/grub
  /etc/systemd/system/docker.service.d
  /etc/pacman.d/hooks/update_snapshot.hook
  /etc/vconsole.conf
  /etc/issue
  /etc/NetworkManager/NetworkManager.conf

  /usr/local/bin/create_btrfs_snapshot.sh

  /home/shadows/.local/share/applications/kitty-yazi.desktop
  /home/shadows/.config/user-dirs.conf
  /home/shadows/.config/user-dirs.dirs
  /home/shadows/.config/yazi
  /home/shadows/.config/hypr
  /home/shadows/.config/waybar
  /home/shadows/.config/systemd/user/
  /home/shadows/.bash_profile
  /home/shadows/.bashrc
  /home/shadows/.bash
  /home/shadows/.local/bin/*.sh
  /home/shadows/.local/bin/z
  /home/shadows/.pip
  /home/shadows/.config/nvim
  /home/shadows/.config/papis
  /home/shadows/.config/fcitx5/
  /home/shadows/.config/mako
  /home/shadows/.local/share/fcitx5/rime/default.custom.yaml
  /home/shadows/.local/share/fcitx5/rime/flypy.custom.yaml
  /home/shadows/.config/zathuraadows/.config/hypr
  /home/shadows/.bash_profile
  /home/shadows/.bashrc
  /home/shadows/.bash
  /home/shadows/.ssh/config
  /home/shadows/.pip
  /home/shadows/.config/nvim
  /home/shadows/.config/papis
  /home/shadows/.config/fcitx5
  /home/shadows/.local/share/fcitx5/rime/default.yaml
  /home/shadows/.local/share/fcitx5/rime/default.custom.yaml
  /home/shadows/.config/zathura
  /home/shadows/.config/mimeapps.list
)

# 复制文件和目录
for path in "${paths[@]}"; do
    if [[ -e "$path" ]]; then
        # 计算目标路径
        dest="$BACKUP_DIR/"$(dirname $path)""
        
        # 创建目标目录
        mkdir -p "$dest"
        
        # 复制文件或目录
        cp -a "$path" "$dest"
        echo "Copied: $path -> $dest"
    else
        echo "Warning: $path does not exist, skipping."
    fi
done

# 保存到github
git add -A
echo "===================================================="
git commit -a -m "backup: $(date)"
echo "===================================================="
git push origin master

echo "Backup completed."
