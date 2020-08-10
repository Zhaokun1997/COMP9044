#!/bin/dash

rm -rf .shrug
./shrug-init
touch a b c d e f
./shrug-add a b c d 
./shrug-rm --cached a b
./shrug-commit -a -m 'first commit'
./shrug-status