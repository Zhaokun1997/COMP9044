#!/bin/sh

# this is test for sub_function and return

sum_list() {
    total=0
    while test $element -le 5
    do
        echo  $element
        total=$((total + element))
        element=$((element + 1))
    done
    return 0
}

i = 0
for i in 1 2 3
do
    sum_list $i && echo $i
done