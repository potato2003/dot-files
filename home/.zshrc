
source ~/zshfiles/alias
source ~/zshfiles/env

setopt AUTO_PUSHD

# zsh
export ZSH=$HOME/.zsh

# colors
None='\e[0m'
Red='\e[40m\e[31m'
Yellow='\e[40m\e[1;33m'
Green='\e[40m\e[32m'
Cyan='\e[40m\e[36m'
Blue='\e[40m\e[34m'
Purple='\e[40m\e[35m'
LightBlue='\e[40m\e[1;34m'
LightCyan='\e[40m\e[1;36m'
LightGreen='\e[40m\e[1;32m'
LightPurple='\e[40m\e[1;35m'
LightRed='\e[40m\e[1;31m'
DarkGray='\e[40m\e[1;30m'
Blue='\e[40m\e[34m'
Brown='\e[40m\e[0;33m'
Black='\e[40m\e[0;30m'
BackGroundRed='\e[40m\e[41m'
White='\e[40m\e[1;37m'

# JAVA
export JAVA_HOME=$(/usr/libexec/java_home)

# SBT
export SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:ReservedCodeCacheSize=192m -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512M -Dfile.encoding=UTF-8" 

# python
export PYTHONDONTWRITEBYTECODE=1

# android
export ANDROID_HOME=/Applications/adt-bundle-mac-x86_64-20130917/sdk/
PATH=${PATH}:$ANDROID_HOME

# Docker
export DOCKER_HOST=tcp://localhost:4243

# general
PATH=/usr/sbin:${PATH}

# brew
. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}

# Python -- pyenv
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"

# Ruby -- rbenv
eval "$(rbenv init -)"

# git completion
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -U compinit
compinit -u

# vcs-info
source ~/zshfiles/function/vcs-info

# History
# history file location
export HISTFILE=${HOME}/.zsh_history

# history record on memory
export HISTSIZE=1000

# history record on disk
export SAVEHIST=100000

# ignore duplication
setopt hist_ignore_dups

# 開始と終了を記録
setopt EXTENDED_HISTORY

# 
# peco
#
function peco_and_writeback() {
  echo hello
  zle -R -c
}
zle -N peco_and_writeback
#bindkey '^l' peco_and_writeback

# 
function reload_zshrc() {
  echo "loading .zshrc"
  source ~/.zshrc
  echo "done."
}

zle -N reload_zshrc
bindkey '^[r' reload_zshrc

# 
function percol-select-history() {
    local tac
    if which tac > /dev/null; then
        tac="tac"
    else
        tac="tail -r"
    fi
    BUFFER=$(history -n 1 | \
        eval $tac | \
        peco)
    CURSOR=$#BUFFER
    zle clear-screen
}

zle -N percol-select-history
bindkey '^r' percol-select-history

# complition
unsetopt menu_complete   # do not autoselect the first completion entry
unsetopt flowcontrol
setopt auto_menu         # show completion menu on succesive tab press
setopt complete_in_word
setopt always_to_end

WORDCHARS=''

zmodload -i zsh/complist

## case-insensitive (all),partial-word and then substring completion
if [ "x$CASE_SENSITIVE" = "xtrue" ]; then
  zstyle ':completion:*' matcher-list 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
  unset CASE_SENSITIVE
else
  zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*' 'l:|=* r:|=*'
fi

zstyle ':completion:*' list-colors ''

# should this be in keybindings?
bindkey -M menuselect '^o' accept-and-infer-next-history

zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#) ([0-9a-z-]#)*=01;34=0=01'
zstyle ':completion:*:*:*:*:processes' command "ps -u `whoami` -o pid,user,comm -w -w"

# disable named-directories autocompletion
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories
cdpath=(.)

# Use caching so that commands like apt and dpkg complete are useable
zstyle ':completion::complete:*' use-cache 1
zstyle ':completion::complete:*' cache-path ${ZSH}/cache/

# Don't complete uninteresting users
zstyle ':completion:*:*:*:users' ignored-patterns \
        adm amanda apache at avahi avahi-autoipd beaglidx bin cacti canna \
        clamav daemon dbus distcache dnsmasq dovecot fax ftp games gdm \
        gkrellmd gopher hacluster haldaemon halt hsqldb ident junkbust kdm \
        ldap lp mail mailman mailnull man messagebus  mldonkey mysql nagios \
        named netdump news nfsnobody nobody nscd ntp nut nx obsrun openvpn \
        operator pcap polkitd postfix postgres privoxy pulse pvm quagga radvd \
        rpc rpcuser rpm rtkit scard shutdown squid sshd statd svn sync tftp \
        usbmux uucp vcsa wwwrun xfs

# ... unless we really want to.
zstyle '*' single-ignored show

if [ "x$COMPLETION_WAITING_DOTS" = "xtrue" ]; then
  expand-or-complete-with-dots() {
    echo -n "\e[31m......\e[0m"
    zle expand-or-complete
    zle redisplay
  }
  zle -N expand-or-complete-with-dots
  bindkey "^I" expand-or-complete-with-dots
fi


# parger
export PAGER="less"
export LESS="-R"


export NVM_DIR="/Users/ryuji_ito/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm
