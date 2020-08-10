#!/bin/dash

rm -rf .shrug
./shrug-init
echo "line 1" > a
echo "hello world" >b
./shrug-add a b
./shrug-commit -m 'first commit'
echo  "line 2" >>a
./shrug-add a
./shrug-commit -m 'second commit'
./shrug-log
