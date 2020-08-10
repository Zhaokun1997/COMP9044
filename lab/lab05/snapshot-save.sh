#!/bin/dash

if test $# != 0
then
    echo "Usage: $0"
    exit 1
fi

back_version=0

while test -r ".snapshot.$back_version" -a -d ".snapshot.$back_version"
do
    back_version=$((back_version + 1))
done

# create directory
mkdir ".snapshot.$back_version"

for file in *
do
    # ignore filenames started with '.' and two special files
    if echo "$file" | 
    egrep -v "^\..*" | 
    egrep -v "(snapshot-save.sh)|(snapshot-load.sh)" > /dev/null  
    then
        # backup current dir
        cp "$file" "./.snapshot.$back_version/"
    fi
done

echo "Creating snapshot $back_version"
exit 0