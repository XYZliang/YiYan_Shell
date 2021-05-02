#!/bin/zsh
#若使用bash，则会出错

Api="https://v1.hitokoto.cn/?"
#API链接

IsOk="Yes"

isok() {
    NoMean="null NULL 自己 原创 其它 其他 网络 来自网络"
    result=$(echo "$NoMean" | grep "$1")
    if [ "$result" != "" ]
    then
    # echo "包含"
    IsOk="No"
    return 0;
    else
    # echo "不包含"
    IsOk="Yes"
    return 1;
    fi
}
yiyan=$(curl "$Api" -s)
#调用api

word=$(echo "$yiyan" | grep -Eo 'hitoko.*?type')
word=${word:11:-7}
#句子

creator=$(echo "$yiyan" | grep -Eo 'creator.*?creator_uid')
creator=${creator:10:-14}
#添加者

from=$(echo "$yiyan" | grep -Eo 'from.*?from_who')
from=${from:7:-11}
#一言出处

fromwho=$(echo "$yiyan" | grep -Eo 'from_who.*?creator')
fromwho=${fromwho:11:-10}
#一言作者

#debug参数
# echo 原："$yiyan"
# echo 文案："$word"
# echo 一言出处："$from"
# echo 一言作者："$fromwho"
# echo 添加者："$creator"

show=$word

isok "$from"
if [ "$IsOk" = "Yes" ] ; then
# echo from+1
    show=$show"\n「 $from 」"
fi

isok "$fromwho"
if [ "$IsOk" = "Yes" ] ; then
# echo fromwho+1
    show=$show"\n—— $fromwho ——"
fi

isok "$creator"
if [ "$IsOk" = "Yes" ] ; then
# echo creator+1
    show=$show"\nBy $creator"
fi

echo "$show"
