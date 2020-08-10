#!/bin/sh

small_files=()
medium_files=()
large_files=()
small_i=0
medium_i=0
large_i=0

for file in `ls`
do
    nb_lines=`wc -l <$file`
    # echo "$nb_lines"
    if [ $nb_lines -lt 10 ]
    then
        small_files[$small_i]=$file
        small_i=$(($small_i + 1))
    elif [ $nb_lines -ge 10 -a $nb_lines -lt 100 ]
    then
        medium_files[$medium_i]=$file
        medium_i=`expr $medium_i + 1`
    else
        large_files[$large_i]=$file
        large_i=$(($large_i + 1))
    fi
done

echo -n "Small files: "
for(( i=0;i<${#small_files[@]};i++))
do
    echo -n "${small_files[i]} "
done
echo 
echo -n "Medium-sized files: "
for(( i=0;i<${#medium_files[@]};i++))
do
    echo -n "${medium_files[i]} "
done
echo 
echo -n "Large files: "
for(( i=0;i<${#large_files[@]};i++))
do
    echo -n "${large_files[i]} "
done
echo 



