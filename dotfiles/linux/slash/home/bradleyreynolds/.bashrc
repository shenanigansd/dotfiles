#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
PS1='[\u@\h \W]\$ '

GPG_TTY=$(tty)
export GPG_TTY

. "$HOME/.cargo/env"

source /usr/share/nvm/init-nvm.sh
