#!/bin/bash
# set -x

versioninfo="v0.2-dev"

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
    if [ -n "$var" ]; then
        echo $var
    fi
    if [ -n "$isPrintAll" ]; then
        real-th "$var";
        real-fg "$var";
        real-qq "$var";
        real-fs "$var";
    fi
}

function printHelp(){
    echo "Help";
    echo -e '\t-a\t输出所有支持的链接形式';
    echo -e '\t-c\t输入需要转换的链接';
    echo -e '\t-h\t输出此帮助信息';
    echo -e '\t-v\t输出版本信息';
    echo "用法"；
    echo -e '\tthunderdecoder link';
    echo -e '\t\t转化为真实链接';
    echo -e '\tthunder -ac link';
    echo -e '\t\t转化为所有支持的链接形式';


    exit 0;
}

function printVersion(){
    echo $versioninfo;
    exit 0;
}

case $# in
    1)
        main "$1";
        ;;
    0)
        printHelp;
        ;;
esac

while getopts "ac:hv" arg; do
    case $arg in
        a)  #转换成所有形式
            isPrintAll=ture;
            ;;
        c)  #直接转换成真实链接
            link=$OPTARG;
            isRun=ture;#传入了必要的参数脚本可以运行
            ;;
        h)
            printHelp;
            exit 2;
            ;;
        v)
            printVersion;
            exit 3;
            ;;
        ?)
            echo "unkonw argument"
            exit 1
            ;;
    esac
done

if [ -n "$isPrintVersion" ]; then
    printVersion;
fi

if [ -n "$isRun" ]; then
    main "$link";
fi
