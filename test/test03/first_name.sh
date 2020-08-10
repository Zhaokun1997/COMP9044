#!/bin/sh

if test "$#" != 1
then
    echo "Usage: $0 <file>"
    exit 1
fi

cat "$1" | egrep -i "comp[2-9]041" | 
cut -d '|' -f3 | cut -d ',' -f2 | 
sed 's/^ *//' | cut -d ' ' -f1 |
sort | uniq -c | sort | tail -1 |
sed 's/^ *[0-9]* *//'



# this is a file of recording first name
# this is a file of recording first name
# this is a file of recording first name
# this is a file of recording first name 