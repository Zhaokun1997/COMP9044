#!/bin/sh

# part of the code is from lecture example

if test -r /dir/file
then
    echo /dir/file is readable
fi
if test -r somefile
then
    echo some file is readable
fi

if [ -d /dir/file ]
then
    echo it is a directory
fi
if [ -d /dir ]
then
    echo it is a directory
fi