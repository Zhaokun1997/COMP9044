#!/bin/dash

rm -rf .shrug
./shrug-init
touch a b c d e f
./shrug-add a b c d 
./shrug-commit -a -m 'first commit'
./shrug-commit -m 'second commit'
./shrug-status
