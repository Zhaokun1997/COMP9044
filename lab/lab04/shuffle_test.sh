#!/bin/sh


echo "seq 0 10" > commands.txt
echo "seq 2 8" >> commands.txt
echo "seq 25 53" >> commands.txt

cat commands.txt |
while read cmd
do
    $($cmd > numbers.txt)
    $(cat numbers.txt | sort > output1.txt)
    $(cat numbers.txt | ./shuffle.pl | sort > output2.txt)

    # $output1=`cat output1.txt`
    # $output2=`cat output2.txt`
    # echo "===> output1 <===:\n$output1\n"
    # echo "===> output2 <===:\n$output2\n"

    # n_line1=$(echo "$output1" | wc -l)
    # n_line2=$(echo "$output2" | wc -l)

    if diff "output1.txt" "output2.txt" >/dev/null
    then
        echo "test $cmd_string passed..."
    else
        echo "test failed on '$cmd_string'!"
    fi
done