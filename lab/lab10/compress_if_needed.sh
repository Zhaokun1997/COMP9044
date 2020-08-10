#!/bin/sh

if test $# = 0
then
    echo "Usage: $0 <pathnames>"
    exit 1
fi

# file1.bin
# file1.bin.xz
for pathname in "$@"
do
    size_origin=$(ls -l $pathname | cut -c 31- | sed 's/^ *//' | cut -d ' ' -f1)
    xz -k $pathname
    size_compress=$(ls -l $pathname.xz | cut -c 31- | sed 's/^ *//' | cut -d ' ' -f1)
    if test $size_compress -lt $size_origin
    then
        # delete origin file, keep compressed file
        rm -rf "$pathname"
        echo "$pathname $size_origin bytes, compresses to $size_compress bytes, compressed"
    else
        # delete compressed file, keep origin file
        rm -rf "$pathname.xz"
        echo "$pathname $size_origin bytes, compresses to $size_compress bytes, left uncompressed"
    fi
done