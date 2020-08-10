#!/bin/sh


if test $# = 0
then
    echo "Usage: $0: <files>" 1>$2
fi

for image in "$@"
do
    if test -r $image
    then
        display "$image"
        echo -n "Address to e-mail this image to? "
        read Address
        echo -n "Message to accompany image? "
        read Message
        subject=`echo "$image" | cut -d '.' -f1`

        if echo "$Message"|mutt -s "$subject" -e 'set copy=no' -a $image -- "$Address" >/dev/null
        then
            echo "$image sent to $Address"
        else
            echo "failed to sent $image to $Address"
        fi
    fi
done
