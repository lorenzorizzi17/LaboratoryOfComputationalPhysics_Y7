#!/bin/bash

mkdir -p students
cd students

if [ ! -f "data.csv" ]; then
    wget https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7 -O data.csv
else
    echo "File already exists"
fi

grep "PoD" data.csv > "PoD.csv"
grep "Physics" data.csv > "Physics.csv"


highest=0
charhigh="A"
for char in {A..Z}; do
    count=$(grep -c "^${char}" data.csv)
    echo "${char} ${count}"
    if [ $count -gt $highest ]; then
        highest=${count}
        charhigh=${char}
    fi
done
echo "Most frequently occurring letter: ${charhigh}"


nstudents=$(sed -n '$=' data.csv)
for (( i=2; i<=nstudents; i++ )); do
    ngroup=$(( (${i}-2) % 19 ))
    sed -n "${i}p" data.csv >> "group${ngroup}.csv"
done

