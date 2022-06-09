#!/bin/bash

echo "Input Document url"

read url

curl -s $url -o myfile.txt

sed -i -e 's/-/ /g' -e 's/[^ ][^ ]*/"&",/g'  myfile.txt

echo "Removing punctuations"

cat myfile.txt | tr -d '[:punct:]' > OUTFILE


echo "Spell Check in  Progress"

for WORD in `cat OUTFILE`; do echo $WORD; curl -sI http://outside-interview.herokuapp.com/spelling/$WORD; done > 1.log

echo "Parsing  the results"

grep -B 1 "404" 1.log > result1.txt

grep -v "404 Not Found" result1.txt > results2.txt

sed -i -e  '/--/d' results2.txt

sed -i -e ':1;N;/\n$/!{$!b1};s/\s*\n/ /g' -e "s/ /","/g" -e 's/[^ ][^ ]*/"&"/g'  results2.txt 

echo "Here are misspelled words"
cat results2.txt

value=`cat results2.txt`

echo "####################"

echo "Here is the md5sum of the result"

echo -n  "$value" | md5sum

echo "Cleaning up tmp files"

rm -rf OUTFILE myfile.txt results2.txt result1.txt 1.log 
