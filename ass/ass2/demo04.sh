#!/bin/dash

# this is test for special commands

ls -las "$@" exit 0
cd /tmp
pwd
a=hello
b=world
echo $a $b

if [ -d /dev/null ]
then
    echo /dev/null
fi
if [ -d /dev ]
then
    echo /dev
fi
