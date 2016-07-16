
### Global variables ###
export MARK_PATH=~/.mark.config
export MARK_DEPS=$MARK_PATH/deps
export MARK_REPO=$MARK_PATH/repo

### Basic aliases ###
alias ls='ls --color=auto'
alias ll='ls -al'
alias l='ll'
alias lrt='ls -lrt'
alias grep='grep --color=auto'
alias v='vim'

### Bash prompt ###
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
source $MARK_DEPS/git-prompt.sh
PS1='[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1 " (%s)")]\$ '

