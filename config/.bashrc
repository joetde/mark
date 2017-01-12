
_source_if_exists() {
    f=$(ls "$@" 2> /dev/null)
    if [ -f "$f" ]
    then
        source "$f"
    fi
}

### Global variables ###
# Mark paths
export MARK_PATH=~/.mark.config
export MARK_DEPS=$MARK_PATH/deps
export MARK_REPO=$MARK_PATH/repo
export MARK_DATA=$MARK_PATH/data
export MARK_CONFIG=$MARK_REPO/config
export MARK_AUTOC=$MARK_CONFIG/autocomplete

### Load code
# Autocomplete code
_source_if_exists {/usr/local,}/etc/bash_completion
source $MARK_AUTOC/*.autoc

### Basic aliases ###
alias ls='ls --color=auto'
alias ll='ls -al'
alias l='ll'
alias lrt='ls -lrt'
alias grep='grep --color=auto'
alias v='vim'
alias countsort='sort | uniq -c | sort -rnb'
alias fls='for f in $(ls); do '
alias remake='make re'
# To remember
alias gcc_defines='gcc -E -dM - < /dev/null'
# OS specific aliases
case $(uname -o 2> /dev/null || uname) in
  "Cygwin")
    alias n='explorer .'
    ;;
  "Darwin")
    alias n='open .'
    ;;
  "Linux")
    ;;
esac

### Bash prompt ###
# Gentoo prefix
if [ -z "$EPREFIX" ]
then
    export PROMPT_SUFFIX="•"
else
    export PROMPT_SUFFIX="≈"
fi
# Custom
export SHORT_PROMPT=1
__prompt_prefix () {
    local h=$(hostname -s)
    local u=$USER
    local w=$(basename $PWD)
    if [ -z "$SHORT_PROMPT" ]
    then
        printf "[\033[01;32m$u@$h\033[00m:\033[01;34m$w\033[00m]"
    else
        printf "@[\033[01;34m$w\033[00m]"
    fi
}
# Git
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
source $MARK_DEPS/git-prompt.sh
# Prompt
PS1='$(__prompt_prefix)$(__git_ps1 " (%s)")]$PROMPT_SUFFIX '

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

# Improved cd
c () {
    if [ -z "$1" ]
    then
        cd
    else
        local extended_dir=$(ls -d $PROJECT_DIRECTORIES/$1 2> /dev/null)
        cd "$1" 2> /dev/null || cd "$extended_dir" 2> /dev/null || cd "$1"
        #echo $(pwd) >> $MARK_DATA/autoc_stats
    fi
}

# Find first directory match and move
D () {
  local first_dir=$(find -L . -name $1 -not -path '*.*' | head -n 1)
  cd $first_dir
}

