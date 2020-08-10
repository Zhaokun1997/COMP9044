#!/bin/sh

# test for while and argv

$b=$1

while test $a -lt $b
do
    echo $a
done