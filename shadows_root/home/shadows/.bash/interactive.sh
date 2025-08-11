# interactive environment
alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# Use bash-completion, if available
[[ $PS1 && -f /usr/share/bash-completion/bash_completion ]] && \
    . /usr/share/bash-completion/bash_completion

# Use powerline, if available
if [[ -f /usr/share/powerline/bindings/bash/powerline.sh ]]; then
  powerline-daemon -q
  POWERLINE_BASH_CONTINUATION=1
  POWERLINE_BASH_SELECT=1
  . /usr/share/powerline/bindings/bash/powerline.sh
fi

# Use z (https://github.com/rupa/z), if available
if [[ -f ~/.local/bin/z/z.sh ]]; then
  . ~/.local/bin/z/z.sh
fi

# -----------------------------
# fzf + fd + bat 高性能配置
# -----------------------------

# 1. 定义要忽略的目录和文件
FZF_IGNORE="--exclude .git --exclude node_modules --exclude target --exclude dist --exclude build --exclude .cache --exclude '*.lock' --exclude .local"

# 2. fd 作为 fzf 默认搜索命令
export FZF_DEFAULT_COMMAND="fd --type f --hidden --follow $FZF_IGNORE"

# 3. 全局 fzf 配置
export FZF_DEFAULT_OPTS="
  --height 40%
  --layout=reverse
  --border
  --ansi
  --preview '~/.local/bin/fzf-preview.sh {}'
  --preview-window 'right:60%:wrap'
"

# 4. Ctrl+T 文件选择配置 - 移除了自定义的enter绑定，恢复默认文件名补全行为
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_CTRL_T_OPTS="
  --multi
"

# 5. Alt+C 目录选择配置
export FZF_ALT_C_COMMAND="fd --type d --hidden --follow $FZF_IGNORE"
export FZF_ALT_C_OPTS="
  --preview 'ls --color=always {} | head -200'
  --preview-window 'right:45%'
"

# 6. 启用 fzf 快捷键 & 自动补全
if [[ -f /usr/share/fzf/completion.bash ]]; then
  source /usr/share/fzf/completion.bash
fi
if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
  source /usr/share/fzf/key-bindings.bash
fi
