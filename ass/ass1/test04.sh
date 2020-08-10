#!/bin/dash

rm -rf .shrug
./shrug-init
touch a b c 
./shrug-add a b c 
./shrug-commit -m 'first commit'
echo "aaa" > a
echo "bbb" > b
echo "ccc" > c
./shrug-add a
./shrug-add b
echo "aaa" >> a
echo "ccc" >> c
./shrug-commit -m 'second commit'
rm c
touch d
./shrug-add d
touch e
echo "eee" > e
./shrug-status