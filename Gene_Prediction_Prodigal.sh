#!/bin/bash

for i in ./*.fna;do
	name=$(basename $i)
	shortname=${name:0:13}
	echo $shortname
	head $i
	contigs=$(grep ">" $i | wc -l)
	#echo $contigs
	cat $i > tempfna
	head tempfna
	for e in $(seq 1 $contigs);do
		#echo $e
		echo ${shortname}_${e}
		#sed -i "s/>/test/" tempfna
		sed -i "0,/>/{s/>/${shortname}_${e}/}" tempfna
	done
	sed -i "s/GCA_/>GCA_/g" tempfna
	head tempfna
	newname=${name::-4}
	echo $newname
	prodigal -a ${newname}.faa -i tempfna
	rm tempfna
done
