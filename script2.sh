#!/bin/bash

touch data.txt

grep -v "^#" data.csv > data.tmp
sed -n 's/,//gp' data.tmp > data.txt
rm data.tmp

count=0
grep -o '[0-9]\+' data.txt | while read num; do
    if (( $num % 2 == 0)); then
       let count+=1;
    fi
done
echo $?
