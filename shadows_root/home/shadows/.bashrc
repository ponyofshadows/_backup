# If not running interactively, don't do anything
[[ $- != *i* ]] && return


#if [ -f ~/.bash/env.sh ]; then
#    . ~/.bash/env.sh
#fi
if [ -f ~/.bash/interactive.sh ]; then
    . ~/.bash/interactive.sh
fi

