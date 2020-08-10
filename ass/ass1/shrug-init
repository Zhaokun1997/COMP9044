#!/bin/dash

if test $# != 0
then
    echo "Usage: $0 "
    exit 1
fi



if test -d ".shrug"  # if .shrug exists
then
    echo "$0: error: .shrug already exists"
    exit 1
fi

if mkdir ".shrug" ".shrug/index" ".shrug/repo" && touch ".shrug/shrug.log"
then
    echo "Initialized empty shrug repository in .shrug"
    exit 0
fi