#!/bin/sh

if test $# = 0
then
    echo "Usage $0: <urls>"
    exit 1
fi

for url in "$@"
do
    server=$(curl -Is "$url" | grep "[sS]erver: " | sed "s/^[sS]erver: //")
    # https://www.unsw.edu.au Apache/2.4.34 (Red Hat) OpenSSL/1.0.1e-fips PHP/5.6.25
    echo "$url $server"
done