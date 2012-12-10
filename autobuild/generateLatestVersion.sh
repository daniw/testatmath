#!/bin/bash
currpwd=$(pwd)
tmpdir=tmp
cd $tmpdir
git pull
hash=$(git log | head -n1 | sed -e 's/ /\n/g' | tail -n1)

echo latest pdf hash:  $(cat $currpwd/latesthash)
echo new hash: $hash

if [ x$(cat $currpwd/latesthash) = x$hash ]; then
 echo already latest version
else
 pdflatex testat_main
 hash=$(git log | head -n1 | sed -e 's/ /\n/g' | tail -n1)
 cp testat_main.pdf $currpwd/build/testat_$hash.pdf
 cp testat_main.pdf $currpwd/build/testat_latest.pdf
 cd $currpwd
 echo $hash > latesthash
fi
#rm -Rf $tmpdir
