#!/bin/sh

# if test "$#" != 2
# then
#     echo "Usage $0: <mp3_file> <directory>"
#     exit 1
# fi


mp3_file=$1
basic_directory=$2

wget -q -O- 'https://en.wikipedia.org/wiki/Triple_J_Hottest_100?action=raw' | 
while read line
do
    case "$line" in
    '|'*'[[Triple J'*\|[0-9][0-9][0-9][0-9]']]'*) ;; # echo "$line" ;;
    *) continue 
    esac

    
     # get coresponding album and year
    album=`echo "$line"|sed 's/.*\[\[//' | sed 's/|.*//'`
    year=`echo "$album"|sed 's/.* //'`

    # echo "album is : $album"
    # echo "year is : $year"
    
    # create directory for fake music
    directory="$basic_directory/Triple J Hottest 100, $year"
    mkdir -p -m 755 "$directory"


    track=1
    while read line && test $track -le 10
    do
        case "$line" in
        '#'*) ;;
        *) continue ;;
        esac
        
        # regular useful information on one line
        # echo "$line"
        line=`echo "$line"|sed 's/[^[]*|//g'`
        # echo "$line"
        line=`echo "$line"|sed 's/\//-/g'`
        # echo "$line"
        line=`echo "$line"|tr -d '[]"#'`
        # echo "$line"


        # extract artists and titles
        artist=`echo "$line"| sed 's/\xe2\x80\x93.*//' | sed 's/^ *//' | sed 's/ *$//'`
        title=`echo "$line"| sed 's/.*\xe2\x80\x93//' | sed 's/^ *//' | sed 's/ *$//'`
        # echo "$artist"
        # echo "$title"
        new_file="$directory/$track - $title - $artist.mp3"
        cp -p "$mp3_file" "$new_file"

        track=$((track + 1))
    done


done