ls *.txt |
    while read f;
    do tit=$(grep '^\S' $f | head -1);
       printf "%s %s\n" $f "$tit";
    done | sort -t\  -k2 | grep -i internet
