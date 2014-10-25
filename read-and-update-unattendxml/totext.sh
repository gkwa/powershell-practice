#!/bin/sh

for kb in `ls [0-9][0-9][0-9][0-9]*|grep -v -F .txt`
do
    txt="$kb.txt"
    if [ ! -f $txt ]
    then
	lynx -force_html -dump -width=1000 $kb >$txt
	printf "%s -> %s\n" $kb $txt
    fi
done
