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

# Use fzf, if available
if [[ -f /usr/share/fzf/completion.bash ]]; then
  . /usr/share/fzf/completion.bash
fi
if [[ -f /usr/share/fzf/key-bindings.bash ]]; then
  . /usr/share/fzf/key-bindings.bash
fi


# Use z (https://github.com/rupa/z), if available
if [[ -f ~/.local/bin/z/z.sh ]]; then
  . ~/.local/bin/z/z.sh
fi
