#!/bin/sh


if test $# != 1
then
    echo "Usage: $0 <filename>"
    exit 1
fi

filename=$1
back_version=0
while test -e ".$filename.$back_version"
do
    back_version=$((back_version + 1))
done
cp "$filename" ".$filename.$back_version"
echo "Backup of '$filename' saved as '.$filename.$back_version'"
exit 0
