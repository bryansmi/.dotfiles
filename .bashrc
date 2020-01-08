# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
    debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
    xterm-color|*-256color) color_prompt=yes;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
    if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
	# We have color support; assume it's compliant with Ecma-48
	# (ISO/IEC-6429). (Lack of such support is extremely rare, and such
	# a case would tend to support setf rather than setaf.)
	color_prompt=yes
    else
	color_prompt=
    fi
fi

GIT_PS1_SHOWDIRTYSTATE=true
if [ "$color_prompt" = yes ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
else
    PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*)
    PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
    ;;
*)
    ;;
esac

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

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

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
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

#PATH
export PATH="/usr/local/bin:$PATH"
export PATH="/usr/local/share/dotnet:$PATH"
export PATH="/Library/Frameworks/Mono.framework/Versions/Current/Commands:$PATH"

#vim >> vi
export EDITOR=/usr/bin/vim
export VISUAL=/usr/bin/vim

#nvm
export NVM_DIR=~/.nvm
source $(brew --prefix nvm)/nvm.sh
export NODE_PATH=`which node`

#android
export ANDROID_HOME=/Users/smith.bryan/Library/Android/sdk

#alias git to g with autocomplete enabled
alias g='git'
complete -o default -o nospace -F _git g
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion

#bash-completion
if [ -f $(brew --prefix)/etc/bash_completion ]; then
. $(brew --prefix)/etc/bash_completion
fi

#aws
export PATH="~/Library/Python/3.7/bin:$PATH"

#factorio
export PATH="~/Library/Application Support/Steam/steamapps/common/Factorio/factorio.app/Contents/MacOS:$PATH"

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f /Users/smith.bryan/.nvm/versions/node/v8.2.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . /Users/smith.bryan/.nvm/versions/node/v8.2.1/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f /Users/smith.bryan/.nvm/versions/node/v8.2.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . /Users/smith.bryan/.nvm/versions/node/v8.2.1/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash

# WORK STUFF ONLY HERE
SRC_PATH=${HOME}/Code/appcenter/dockercompose
if [ -d ${SRC_PATH} ]; then
 declare -a arr=("build" "restart" "integration" "logs" "ps" "reset" "stop" "tests" "here" "clean")
 for cmd in "${arr[@]}"
 do
   eval "c${cmd}() { ${SRC_PATH}/${cmd}.ps1 crashes-docker \$*; }"
 done
fi

if [ -d ${SRC_PATH} ]; then
 declare -a arr=("build" "restart" "integration" "logs" "ps" "reset" "stop" "tests" "here" "clean")
 for cmd in "${arr[@]}"
 do
   eval "di${cmd}() { ${SRC_PATH}/${cmd}.ps1 diagnostics/docker \$*; }"
 done
fi
alias nuget="mono /usr/local/bin/nuget.exe"

# force new line
###
# Configure PS1 by using the old value but ensuring it starts on a new line.
###
__configure_prompt() {
  PS1=""

  if [ "$(__get_terminal_column)" != 0 ]; then
    PS1="\n"
  fi

  PS1+="$PS1_WITHOUT_PREPENDED_NEWLINE"
}

###
# Get the current terminal column value.
#
# From https://stackoverflow.com/a/2575525/549363.
###
__get_terminal_column() {
  exec < /dev/tty
  local oldstty=$(stty -g)
  stty raw -echo min 0
  echo -en "\033[6n" > /dev/tty
  local pos
  IFS=';' read -r -d R -a pos
  stty $oldstty
  echo "$((${pos[1]} - 1))"
}

# Save the current PS1 for later.
PS1_WITHOUT_PREPENDED_NEWLINE="$PS1"

# Use our prompt configuration function, preserving whatever existing
# PROMPT_COMMAND might be configured.
PROMPT_COMMAND="__configure_prompt;$PROMPT_COMMAND"

# did
alias did="vim +'normal Go' +'r!date' ~/vimwiki/did.wiki"
