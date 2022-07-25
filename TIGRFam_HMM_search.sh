#!/bin/bash

for i in ./HMM_Modelle_TIGRFam/*HMM;do
	queryname=$(basename $i)
	hmmname=${queryname::-4}
	echo $hmmname
	nc=$(grep "NC" $i | cut -f 5 -d " ")
	echo $nc
	tc=$(grep "TC" $i | cut -f 5 -d " ")
	echo $tc
	cutoff=$(echo "($nc + $tc)/2" | bc -l)
	echo $cutoff
	for e in ~/missing_genomes/*faa;do
		subjectname=$(basename $e)
		genomename=${subjectname:0:13}
		echo $genomename
		
		hmmsearch --tblout ${hmmname}_${genomename}.out -T $cutoff --acc $i $e
	done
done
