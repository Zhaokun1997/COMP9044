#!/bin/sh

for file in *.htm
do
    new_file="$file"l
    if test -e "$new_file"
    then
        echo "$new_file exists"
        exit 1
    else
        mv -- "$file" "$new_file"
    fi
done
exit 0