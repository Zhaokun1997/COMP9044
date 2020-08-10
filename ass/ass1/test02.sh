#!/bin/dash

rm -rf .shrug
./shrug-init
echo "aaa line 1" > a
echo "bbb line 1" >b
./shrug-add a b
./shrug-commit -m 'first commit'
echo  "aaa line 2" >>a
./shrug-add a
./shrug-commit -m 'second commit'
./shrug-show 0:a
./shrug-show 1:a
./shrug-show :a
cat a
./shrug-show 0:b
./shrug-show 1:b