#!/bin/bash
function toReal(){
    case ${1%%://*} in
        thunder)
            echo `th-real $1`;
            ;;
        flashget)
            echo `fg-real $1`;
            ;;
        qqdl)
            echo `qq-real $1`;
            ;;
        fs2you)
            echo `fs-real $1`;
            ;;
        http)
            echo $1;
            ;;
        https)
            echo $1;
            ;;
        ftp)
            echo $1;
            ;;
        ftps)
            echo $1;
            ;;
        *)
            echo "bad link";
            exit 1;
            ;;
    esac
}

function th-real(){
    echo -n $1'Cg==' | sed 's?thunder://??' | base64 -d | sed 's/^AA//; s/ZZ$//';
}

function fg-real(){
    echo -n $1'Cg==' | sed 's?flashget://??' | base64 -d | sed 's/^\[FLASHGET\]//; s/\[FLASHGET\]$//'
}

function qq-real(){
    echo -n $1'Cg==' | sed 's?qqdl://??' | base64 -d;
}

function fs-real(){
    echo -n $1'Cg==' | sed 's?fs2you://??' | base64 -d | sed 's?^?http://?';
}

function real-th(){
    echo -n $1 | sed 's/^/AA/; s/$/ZZ/' | base64 | sed ':a;N;s/\n//;ba;' | sed 's?^?thunder://?';
}

function real-fg(){
    echo -n $1 | sed 's/^/\[FLASHGET\]/; s/$/\[FLASHGET\]/' | base64 | sed ':a;N;s/\n//;ba;' | sed 's?^?flashget://?';
}

function real-qq(){
    echo -n $1 | base64 | sed ':a;N;s/\n//;ba;' | sed 's?^?qqdl://?';
}

function real-fs(){
    echo -n $1 | sed 's?http://??; s?https://??; s?ftp://??; s?ftps://??' | base64 | sed ':a;N;s/\n//;ba;' | sed 's?^?fs2you://?';
}

function main(){
    var=`toReal $1`;
    echo $var
    if [ -n "$isPrintAll" ]; then
        real-th "$var";
        real-fg "$var";
        real-qq "$var";
        real-fs "$var";
    fi
}
while getopts "ac:" arg; do
    case $arg in
        a)  #转换成所有形式
            isPrintAll=ture;
            ;;
        c)  #直接转换成真实链接
            main "$OPTARG";
            ;;
        ?)
            echo "unkonw argument"
            exit 1
            ;;
    esac
done
