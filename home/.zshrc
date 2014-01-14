
source ~/zshfiles/alias
source ~/zshfiles/env

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

#SBT
export SBT_OPTS="-Xms512M -Xmx1536M -Xss1M -XX:ReservedCodeCacheSize=192m -XX:+CMSClassUnloadingEnabled -XX:MaxPermSize=512M -Dfile.encoding=UTF-8" 

# python
export PYTHONDONTWRITEBYTECODE=1

# android
export ANDROID_HOME=/Applications/adt-bundle-mac-x86_64-20130917/sdk/
PATH=${PATH}:$ANDROID_HOME

. `brew --prefix`/etc/profile.d/z.sh
function precmd () {
  _z --add "$(pwd -P)"
}



eval "$(rbenv init -)"

# git completion
fpath=($(brew --prefix)/share/zsh/site-functions $fpath)

autoload -U compinit
compinit -u


#
# Show current branch.
# if uncommited files is exists then branch name turns a red color.
#
setopt prompt_subst
autoload -Uz VCS_INFO_get_data_git; VCS_INFO_get_data_git 2> /dev/null

function rprompt-git-current-branch {
  local name st color gitdir action
  if [[ "$PWD" =~ '/¥.git(/.*)?$' ]]; then
    return
  fi
  name=$(basename "`git symbolic-ref HEAD 2> /dev/null`")
  if [[ -z $name ]]; then
    return
  fi

  gitdir=`git rev-parse --git-dir 2> /dev/null`
  action=`VCS_INFO_git_getaction "$gitdir"` && action="($action)"

  st=`git status 2> /dev/null`
  if [[ -n `echo "$st" | grep "^nothing to"` ]]; then
    color=%F{green}
  elif [[ -n `echo "$st" | grep "^nothing added"` ]]; then
    color=%F{yellow}
  elif [[ -n `echo "$st" | grep "^# Untracked"` ]]; then
    color=%B%F{red}
  else
     color=%F{red}
  fi
  echo "$color$name$action%f%b "
}

# RPROMPT='`rprompt-git-current-branch`'



# vcs_info 設定

RPROMPT=""

autoload -Uz vcs_info
autoload -Uz add-zsh-hook
autoload -Uz is-at-least
autoload -Uz colors

# 以下の3つのメッセージをエクスポートする
#   $vcs_info_msg_0_ : 通常メッセージ用 (緑)
#   $vcs_info_msg_1_ : 警告メッセージ用 (黄色)
#   $vcs_info_msg_2_ : エラーメッセージ用 (赤)
zstyle ':vcs_info:*' max-exports 3

zstyle ':vcs_info:*' enable git svn hg bzr
# 標準のフォーマット(git 以外で使用)
# misc(%m) は通常は空文字列に置き換えられる
zstyle ':vcs_info:*' formats '(%s)-[%b]'
zstyle ':vcs_info:*' actionformats '(%s)-[%b]' '%m' '<!%a>'
zstyle ':vcs_info:(svn|bzr):*' branchformat '%b:r%r'
zstyle ':vcs_info:bzr:*' use-simple true


if is-at-least 4.3.10; then
    # git 用のフォーマット
    # git のときはステージしているかどうかを表示
    zstyle ':vcs_info:git:*' formats '(%s)-[%b]' '%c%u %m'
    zstyle ':vcs_info:git:*' actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    zstyle ':vcs_info:git:*' check-for-changes true
    zstyle ':vcs_info:git:*' stagedstr "stage[!]"    # %c で表示する文字列
    zstyle ':vcs_info:git:*' unstagedstr "unstage[!]"  # %u で表示する文字列
fi

# hooks 設定
if is-at-least 4.3.11; then
    # git のときはフック関数を設定する

    # formats '(%s)-[%b]' '%c%u %m' , actionformats '(%s)-[%b]' '%c%u %m' '<!%a>'
    # のメッセージを設定する直前のフック関数
    # 今回の設定の場合はformat の時は2つ, actionformats の時は3つメッセージがあるので
    # 各関数が最大3回呼び出される。
    zstyle ':vcs_info:git+set-message:*' hooks \
                                            git-hook-begin \
                                            git-untracked \
                                            git-push-status \
                                            git-nomerge-branch 
                                            #git-stash-count

    # フックの最初の関数
    # git の作業コピーのあるディレクトリのみフック関数を呼び出すようにする
    # (.git ディレクトリ内にいるときは呼び出さない)
    # .git ディレクトリ内では git status --porcelain などがエラーになるため
    function +vi-git-hook-begin() {
        if [[ $(command git rev-parse --is-inside-work-tree 2> /dev/null) != 'true' ]]; then
            # 0以外を返すとそれ以降のフック関数は呼び出されない
            return 1
        fi

        return 0
    }

    # untracked フィアル表示
    #
    # untracked ファイル(バージョン管理されていないファイル)がある場合は
    # unstaged (%u) に ? を表示
    function +vi-git-untracked() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        untrackedCount=$(command git status --porcelain 2> /dev/null \
            | awk '{print $1}' \
            | command grep -F '??' &>/dev/null \
            | wc -l \
            | tr -d ' ')

        if [[ $untrackedCount != '0' ]]; then

            # unstaged (%u) に追加
            hook_com[unstaged]+=" untracked(${untrackedCount})"
        fi
    }

    # push していないコミットの件数表示
    #
    # リモートリポジトリに push していないコミットの件数を
    # pN という形式で misc (%m) に表示する
    function +vi-git-push-status() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" != "master" ]]; then
            # master ブランチでない場合は何もしない
            return 0
        fi

        # push していないコミット数を取得する
        local ahead
        ahead=$(command git rev-list origin/master..master 2>/dev/null \
            | wc -l \
            | tr -d ' ')

        if [[ "$ahead" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+="unpushed(${ahead})"
        fi
    }

    # マージしていない件数表示
    #
    # master 以外のブランチにいる場合に、
    # 現在のブランチ上でまだ master にマージしていないコミットの件数を
    # (mN) という形式で misc (%m) に表示
    function +vi-git-nomerge-branch() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        if [[ "${hook_com[branch]}" == "master" ]]; then
            # master ブランチの場合は何もしない
            return 0
        fi

        local nomerged
        nomerged=$(command git rev-list master..${hook_com[branch]} 2>/dev/null | wc -l | tr -d ' ')

        if [[ "$nomerged" -gt 0 ]] ; then
            # misc (%m) に追加
            hook_com[misc]+="(m${nomerged})"
        fi
    }


    # stash 件数表示
    #
    # stash している場合は :SN という形式で misc (%m) に表示
    function +vi-git-stash-count() {
        # zstyle formats, actionformats の2番目のメッセージのみ対象にする
        if [[ "$1" != "1" ]]; then
            return 0
        fi

        local stash
        stash=$(command git stash list 2>/dev/null | wc -l | tr -d ' ')
        if [[ "${stash}" -gt 0 ]]; then
            # misc (%m) に追加
            hook_com[misc]+=":S${stash}"
        fi
    }

fi

function _update_vcs_info_msg() {
    local -a messages
    local prompt

    LANG=en_US.UTF-8 vcs_info

    if [[ -z ${vcs_info_msg_0_} ]]; then
        # vcs_info で何も取得していない場合はプロンプトを表示しない
        prompt=""
    else
        # vcs_info で情報を取得した場合
        # $vcs_info_msg_0_ , $vcs_info_msg_1_ , $vcs_info_msg_2_ を
        # それぞれ緑、黄色、赤で表示する
        [[ -n "$vcs_info_msg_0_" ]] && messages+=( "%F{cyan}${vcs_info_msg_0_}%f" )
        [[ -n "$vcs_info_msg_1_" ]] && messages+=( "%F{yellow}${vcs_info_msg_1_}%f" )
        [[ -n "$vcs_info_msg_2_" ]] && messages+=( "%F{red}${vcs_info_msg_2_}%f" )

        # 間にスペースを入れて連結する
        prompt="${(j: :)messages}"
    fi

    RPROMPT="$prompt"
}
add-zsh-hook precmd _update_vcs_info_msg




function google () {
        local str opt
        if [ $# != 0 ]
        then
                for i in $*
                do
                        str="$str+$i" 
                done
                str=`echo $str | sed 's/^\+//'` 
                opt='search?num=50&hl=ja&ie=euc-jp&oe=euc-jp&lr=lang_ja' 
                opt="${opt}&q=${str}" 
        fi
        w3m http://www.google.co.jp/$opt
}


function RandColor () {
        COLORS=($Red $Yellow $Green $Cyan $Blue $Purple) 
        echo $COLORS[$(($(date +%s) % ${#COLORS[*]} + 1))]
}

function ps1 () {
        CurrentDir=($(pwd | tr -s '/', $IFS)) 
        Depth=${#CurrentDir[*]} 
        if [ $Depth -lt 6 ]
        then
                echo $PWD
        else
                echo "/${CurrentDir[1]}/.../${CurrentDir[$Depth - 1]}/${CurrentDir[$Depth]}"
        fi
}


precmd () {
  psvar=()
  psvar[1]=$(date +'%m/%d %H:%M:%S');
  psvar[1]=$(ps1)
}
PS1='%1v %2v'

