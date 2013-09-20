google () {
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

ps1 () {
        CurrentDir=($(pwd | tr -s '/', $IFS)) 
        Depth=${#CurrentDir[*]} 
        if [ $Depth -lt 6 ]
        then
                echo $PWD
        else
                echo "/${CurrentDir[1]}/.../${CurrentDir[$Depth - 1]}/${CurrentDir[$Depth]}"
        fi
}

