#!/bin/sh

# test argument form
if test $# != 0
then
    echo "Usage $0: <nothing>" 1>&2
    exit 1
fi

# save original old png files
old_files=`ls -l | egrep " [^ ]*\.png"`
# echo echo "old_files is : $old_files"

for filename in *
do
    # if it is .jpg files
    if echo "$filename" | egrep "[^ ]*.jpg" > /dev/null || continue
    then 
        # then change names
        new_filename=`echo "$filename" | sed 's/\.jpg/.png/'`

        # test if this new name exists before
        if echo "$old_files" | egrep "$new_filename" > /dev/null
        then
            echo "$new_filename already exists"
        else
            convert "$filename" "$new_filename"  # rename jpg2png
        fi
    fi
    
done

exit 0
