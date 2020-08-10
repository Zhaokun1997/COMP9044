#!/bin/dash

rm -rf .shrug
./shrug-init
touch a b c d e f g h
./shrug-add a b c d e f
./shrug-commit -m 'first commit'
echo "aaa" >a
echo "ccc" >c
./shrug-add a c
echo "aaa" >a
rm d
./shrug-rm e
./shrug-commit -m 'second commit'
./shrug-add g
./shrug-add f
./shrug-status