
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
export MARK_TOOLS=$MARK_REPO/tools

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
alias m5='make -j5'
alias rank='awk "{t = t+1; print t,\$1}"'
# To remember
alias gcc_defines='gcc -E -dM - < /dev/null'
alias gcc_asm='gcc -S -xc - -o -'
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
    local t=$(date +"%T")
    local h=$(hostname -s)
    local u=$USER
    local w=$(basename $PWD)
    if [ -z "$SHORT_PROMPT" ]
    then
        printf "[$t][$u@$h:$w]"
    else
        printf "[$t][$w]"
    fi
}
# Git
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWSTASHSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1
export GIT_PS1_SHOWUPSTREAM="auto"
source $MARK_DEPS/git-prompt.sh
# Prompt
PS1='$(__prompt_prefix)$(__git_ps1 " (%s)")$PROMPT_SUFFIX '

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
  clear
}

### Navigation function ###
# Create directory and move
mkcd () {
  mkdir $1
  cd $1
}

# Most visited directories (helper for improved cd)
_most_visited_directories () {
    cat $MARK_DATA/.c_history | sort | uniq -c | sort -rnb | head | awk '{print $2}' | head -n 9
}

# Improved cd
c () {
    if [ -z "$1" ]
    then
        cd
    elif echo $1 | egrep -q '^\+[1-9]$';
    then
        local arg=$1
        cd $(_most_visited_directories | sed -n "${arg:1}p")
    else
        local extended_dir=$(ls -d $PROJECT_DIRECTORIES/$1 2> /dev/null)
        cd "$1" 2> /dev/null || cd "$extended_dir" 2> /dev/null || cd "$1"
    fi
    echo $(pwd) >> $MARK_DATA/.c_history
}

# find names
# f () {
#    find . -name "*$1*"
# }

# find and search exetensions
feg () {
    find . -name "*.$1" -exec grep -Hn "$2" {} \;
}

# Find first directory match and move
D () {
  local first_dir=$(find -L . -name $1 -not -path '*.*' | head -n 1)
  cd $first_dir
}

### Git ###
gdl () {
    git diff $1~..$1
}

### Do things ###
for_n () {
  local successes=0
  for i in $(seq $1); do
    ${@:2}
    if [ $? -eq 0 ]; then
      ((successes=successes+1))
    fi
  done
  echo "$successes / $1"
}

retry() {
  for i in $(seq $1); do
    ${@:2} && break
    sleep 1
  done
}

twice () {
  for_n 2 $@
}

gpid () {
  ps aux | grep $1 | grep -v grep | awk '{print $2}'
}

kn () {
  kill $(gpid $1)
}

### Compilation ###
# Get C prototypes from file
c_proto () {
    ctags -x --c-kinds=fp $1 | awk '{$1=$2=$3=$4=""; print}' | cut -c 5-
}

# Binary manipulation
p () {
  python -c "$*"
}

hex_to_bin () {
  local h=$(echo $1 | tr -d " ")
  p "print bin(int('$h', 16))[2:]"
}

hex_xor () {
  local h=$(echo $1 | tr -d " ")
  p "h='$h'; xl=[int(h[i:i+2], 16) for i in range(0, len(h), 2)]; x=reduce(lambda a,b: a ^ b, xl, 0); print hex(x)[2:].upper()"
}

### AI crap ###
# ChatGPT
G () {
  $MARK_TOOLS/gpt-query.py "$*"
}

