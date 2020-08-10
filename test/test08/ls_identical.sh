#!/bin/sh

#It should print in alphabetical order the names of all files
# which occur in both directories and have exactly the same contents.


if test $# -ne 2
then
    echo "Usage: $0 dirname1 dirname2..."
    exit 1
fi

dirname1=$1
dirname2=$2

for file in $dirname1/*
do
    # filename = "dirname1/example.c"
    filename=$(echo "$file" | sed 's/^.*\///')
    if test -e "$dirname2/$filename"  # test if filename exists in dirname2
    then
        if diff -q "$dirname1/$filename" "$dirname2/$filename" > /dev/null
        then
            echo "$filename"
        fi
    fi
done
