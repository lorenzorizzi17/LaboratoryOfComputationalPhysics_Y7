#!/bin/bash

cd 
mkdir -p "students"
cd students

if [ -f "students.csv" ]; then
	echo "The file already exists";
else
	echo "Downloading students data...";
	wget "https://www.dropbox.com/scl/fi/bxv17nrbrl83vw6qrkiu9/LCP_22-23_students.csv?rlkey=47fakvatrtif3q3qw4q97p5b7&e=1" -q -O "students.csv"
fi

touch "PoD.csv"
touch "Physics.csv"

grep "PoD" students.csv > PoD.csv
grep "Physics" students.csv > Physics.csv

counter=0
letter="0"
for char in {A..Z}; do
	occ=$(grep -c "^$char" students.csv);
	echo "starting with $char: $occ";
	if [ $occ -gt $counter ]; then
		counter=$occ;
		letter=$char
	fi
done
echo "most recurring letter: $letter"

nlines=$(sed -n '$=' students.csv)

idgroup=1
while [ $idgroup -lt 19 ]; do
	touch group$idgroup.txt
	idstudent=$(( $idgroup + 1 ))
	while [ $idstudent -le $nlines ]; do
		echo $(sed -n "${idstudent} p" students.csv) >> group$idgroup.txt
		idstudent=$(( $idstudent + 18 ))
	done
	let idgroup+=1
done
	
