#!/bin/sh

num=$#
if (($# != 2))
then
    echo "Usage: $0 <number of lines> <string>"
else
    count=$1
    content=$2
    if test $count -ge 0 2>/dev/null
    then
        while test $count -ge 1 2>/dev/null #(( $content >= 0 ))
        do
            echo $content
            count=$(($count - 1))
        done
    else
        echo "$0: argument 1 must be a non-negative integer"
        exit 1
    fi
fi
