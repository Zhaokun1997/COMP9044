#!/bin/sh

option_flag=0
if test $# = 0
then
    echo "Usage $0: <pathname>"
    exit 1
elif test $# = 1
then
    pathname=$(echo $1 | sed 's/\/$//')
elif test $# = 2
then
    pathname=$(echo $1 | sed 's/\/$//')
    option=$2
    option_flag=1
fi

# simple/Makefile
# medium/a/Makefile
all_files=$(find $pathname -type f | grep "Makefile")

for makefile in $all_files
do
    # simple
    # medium/a
    dirname=$(echo $makefile | sed 's/\/Makefile$//')
    echo "Running make in $dirname"
    # for c_file in $dirname/*.c
    # do
    #     c_file=$(echo "$c_file" | sed 's/.*\///')
    #     o_file=$(echo "$c_file"| sed 's/\.c/\.o/')
    # done
    if test "$option_flag" = 0
    then
        # echo "$makefile"
        pushd . > /dev/null
        # make -C "$dirname"
        cd "$dirname" && make
        popd > /dev/null
    else
        pushd . > /dev/null
        # make -C "$dirname" "$option"
        cd "$dirname" && make "$option"
        popd > /dev/null
        # echo "$dirname" "$option"
    fi
done