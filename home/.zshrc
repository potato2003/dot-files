
source ~/zshfiles/alias
source ~/zshfiles/env

None='%{\e[0m%}'
Red='%{\e[40m\e[31m%}'
Yellow='%{\e[40m\e[1;33m%}'
Green='%{\e[40m\e[32m%}'
Cyan='%{\e[40m\e[36m%}'
Blue='%{\e[40m\e[34m%}'
Purple='%{\e[40m\e[35m%}'
LightBlue='%{\e[40m\e[1;34m%}'
LightCyan='%{\e[40m\e[1;36m%}'
LightGreen='%{\e[40m\e[1;32m%}'
LightPurple='%{\e[40m\e[1;35m%}'
LightRed='%{\e[40m\e[1;31m%}'
DarkGray='%{\e[40m\e[1;30m%}'
Blue='%{\e[40m\e[34m%}'
Brown='%{\e[40m\e[0;33m%}'
Black='%{\e[40m\e[0;30m%}'
BackGroundRed='%{\e[40m\e[41m%}'
White='%{\e[40m\e[1;37m%}'

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

