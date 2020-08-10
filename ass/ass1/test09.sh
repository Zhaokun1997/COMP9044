#!/bin/dash

rm -rf .shrug
./shrug-init
touch a b c d e f
./shrug-add a b c d 
./shrug-commit -m 'first commit'
./shrug-rm --force c
./shrug-rm --force --cached d
./shrug-commit -a -m 'second commit'
rm a
rm b
./shrug-add a b
touch a
./shrug-status
