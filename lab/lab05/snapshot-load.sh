#!/bin/dash

if test $# != 1
then
    echo "Usage: $0 <target_version>"
    exit 1
fi

# get target_version
target_version=$1

# preserve current data
snapshot-save.sh 

# restore processing
# step 1: delete files in current directory
for file in *
do
    # ignore filenames started with '.' and two special files
    if echo "$file" | 
    egrep -v "^\..*" | 
    egrep -v "(snapshot-save.sh)|(snapshot-load.sh)" > /dev/null  
    then
        rm -rf "$file"
    fi
done

# step 2: restore files in target repository
for file in ./.snapshot.$target_version/*
do
    cp "$file" "./"
done

echo "Restoring snapshot $target_version"
exit 0
