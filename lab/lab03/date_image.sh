#!/bin/sh

if test $# = 0
then
    echo "Usage $0: <list of images>"
    exit 1
fi

for image in "$@"
do
    image_date=`ls -l "$image" | cut -d ' ' -f6,7,8`
    temp_file="$image.tmp"
    # month=`echo "$image_date" | cut -d ' ' -f1`
    # day=`echo "$image_date" | cut -d ' ' -f2`
    # time=`echo "$image_date" | cut -d ' ' -f3`
    convert  -gravity south -pointsize 36 -draw "text 0,10 '$image_date'"  "$image" "$temp_file"
    mv "$temp_file" "$image"
dones

exit 0
