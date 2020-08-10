#!/bin/sh

if test "$#" = 0
then
    echo "Usage : $0 <files>"
    exit 1
fi

for c_file in "$@"
do
    cat "$c_file" | egrep '#include "' | sed 's/#include //' | sed 's/"//g' |
    while read line
    do
        if test -e "$line" 
        then
            continue
        else
            echo "$line included into $c_file does not exist"
        fi
    done
done

# echo "hello world!"


