#!/bin/sh

for file in "$@"
do
    temporary_file="$file.tmp.$$"
    if test -e "$temporary_file"
    then
        echo "$temporary_file" already exists
        exit 1
    fi
    sed 's/COMP2041/COMP2042/g;s/COMP9044/COMP9042/g' $file >$temporary_file &&
    mv $temporary_file $file
done