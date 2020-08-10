#!/bin/dash

if test $# -ne 0
then
    echo "Usage: $0..."
    exit 1
fi


if cat .shrug/shrug.log
then
    exit 0
else
    echo "Failed to access .shrug/shrug.log"
    exit 1
fi