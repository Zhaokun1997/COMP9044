#!/bin/dash

# print a integer sequence

echo 'line 1'
echo 'line 2'
echo 'line 3'

aaa=$1
bbb=$2
mynumber=$start
while test $mynumber -le $bbb do
echo $mynumber
    mynumber=$((mynumber + 1))  # increment number
done