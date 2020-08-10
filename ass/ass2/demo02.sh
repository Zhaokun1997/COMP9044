#!/bin/sh

# this is test for if contains if 
# this is also test for argument

echo My first argument is $1
echo My second argument is $2
echo My third argument is $3
i=0
name=$2
name_2=$3

if test $name = great
    echo Successed compliment
elif test $name_2 = Again
    echo Successed Again
else
    echo Fail
fi