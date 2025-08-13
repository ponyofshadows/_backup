# editor
export EDITOR=nvim

# fcitx5

#comment these for wayland
#export GTK_IM_MODULE=fcitx
#export QT_IM_MODULE=fcitx

export XMODIFIERS=@im=fcitx
export SDL_IM_MODULE=fcitx

# path of bin
export PATH="$HOME/.local/bin:$PATH"

# pythob shadowslib
export PYTHONPATH=/home/shadows/workspace/lib/python/shadowslib/.venv/lib/python3.13/site-packages:$PYTHONPATH
