# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

if [[ -z $HOSTTYPE ]]; then
   HOSTTYPE=unknown
fi

if [[ $OSTYPE == *"linux"* ]]; then
    PLATFORM=linux.$HOSTTYPE
elif [[ $OSTYPE == *"darwin"* ]]; then
    PLATFORM=darwin.$HOSTTYPE
fi

# Switch iterm2 profile to remote
if [ "$TERM" = "xterm-256color-iterm2" ]; then
    export TERM=xterm-256color
    echo -e "\033]50;SetProfile=Remote\a"
    source /home/yromanenko/.iterm2_shell_integration.bash
fi

# If not running interactively, don't do anything
[ -z "$PS1" ] && return

# VI mode
set -o vi

# don't put duplicate lines in the history. See bash(1) for more options
# ... or force ignoredups and ignorespace
HISTCONTROL=ignoredups:ignorespace

# append to the history file, don't overwrite it
shopt -s histappend

PROMPT_COMMAND='history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=5000000
HISTFILESIZE=50000000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

export PS1='\[\033]2;\h:\w\007\]\[\033[01;32m\]\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\] \$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'
alias less='less -FXr'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
    . ~/.bash_aliases
fi

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
    . /etc/bash_completion
fi

for F in ~/.bashrc.*;
do
    if [[ -O $F ]];
    then
        source $F
    fi
done

alias pbcopy='xsel --clipboard --input'
alias pbpaste='xsel --clipboard --output'

export MANPATH=":$HOME/bin"

# neovim setup
alias vim=nvim
export EDITOR=nvim

# shell color
export CLICOLOR=1

# Setup XDG_DATA_DIRS
if [ -d "$HOME/.linuxbrew/share" ]; then
    export XDG_DATA_DIRS="/home/yromanenko/.linuxbrew/share:$XDG_DATA_DIRS"
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.linuxbrew/sbin" ] ; then
    PATH="$HOME/.linuxbrew/sbin:$PATH"
fi

if [ -d "$HOME/.linuxbrew/bin" ] ; then
    PATH="$HOME/.linuxbrew/bin:$PATH"
fi

if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH"
fi

if [ -f "$HOME/.dircolors" ]
then
    eval $(dircolors -b $HOME/.dircolors)
fi

# Set up the back channel for SSH
# This overwrites the .ssh/config which apparently doesn't support some sort of "include"
SSH_HOSTNAME=$(echo $SSH_CLIENT | cut -d ' ' -f 1)

if [ "$SSH_HOSTNAME" != "" ]; then
    echo "" >> ~/.ssh/config.back
    echo "# Autogenerated return host entry" >> ~/.ssh/config.back
    echo "Host back" >> ~/.ssh/config.back
    echo "Port 22" >> ~/.ssh/config.back
    echo "HostName $SSH_HOSTNAME" >> ~/.ssh/config.back
    echo "User yromanenko" >> ~/.ssh/config.back

    if [ "x$DISPLAY" == "x" ]; then
        export DISPLAY=$SSH_HOSTNAME:0.0
    fi
fi

# fasd init
eval "$(fasd --init auto)"


[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Python startupt
export PYTHONSTARTUP=$HOME/.pythonrc
