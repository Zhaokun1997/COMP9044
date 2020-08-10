#!/bin/sh

filename=$1
cat "$filename" | grep "name" | cut -d ':' -f2 | cut -d ',' -f1 |
sed 's/^ //' | sed 's/[^ a-zA-Z]//g' | sort | uniq | sort