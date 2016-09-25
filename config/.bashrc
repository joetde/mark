
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
alias countsort='sort | uniq -c | sort -rnb'
alias fls='for f in $(ls); do '
# OS specific aliases
case $(uname -o) in
  "Cygwin")
    alias n='explorer .'
    ;;
  "Linux")
    ;;
esac

### Bash prompt ###
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
source $MARK_DEPS/git-prompt.sh
PS1='[\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\W\[\033[00m\]$(__git_ps1 " (%s)")]\$ '

### Display functions ###
sep () {
  for i in $(seq 1 $(stty size | cut -d' ' -f2)); do
    echo -n "$1"
  done
}

boom () {
  for i in $(seq 1 $(stty size | cut -d' ' -f1)); do
    echo "";
  done
  sep "#";
}

### Navigation function ###
# Create directory and move
mkcd () {
  mkdir $1
  cd $1
}

# Find first directory match and move
D () {
  local first_dir=$(find -L . -name $1 -not -path '*.*' | head -n 1)
  cd $first_dir
}

## File functions
# Rename files with timestamp
rename-to-date () {
  for f in $(ls); do
    local epoch=$(stat -c "%W" $f)
    mv -i $f $epoch-$1-$f
  done
}

