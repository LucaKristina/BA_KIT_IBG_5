
#!/usr/bin/env python

import os
import subprocess
from time import strptime
import pandas as pd

#subprocess.run(['for i in HMM/HMM_Output/*out;do sed -i "/^#/d" $i;done'], shell=True, stdout=subprocess.PIPE, universal_newlines=True)

def stripLines(lines_in):
	lines_out = []
	for e in lines_in:
		lines_out.append(e.strip())
	return lines_out

hmmlist_=open('hmmlist',"r").readlines()
hmmlist = stripLines(hmmlist_)

genomelist_=open('genomelist',"r").readlines()
genomelist = stripLines(genomelist_)

df=pd.DataFrame(index=pd.Index(genomelist),columns=pd.Index(hmmlist))

for h in hmmlist:
	if h[4] == "_":
		for g in genomelist:
			try:
				m=h[0:4]
				infile=open(str(("HMM/HMM_Output/%s/%s_%s") % (m, h, g)),"r")
				inlines=infile.readlines()
				result=len(inlines)
				df.loc[g,h] = result
			except FileNotFoundError:
				result="ND"
				df.loc[g,h] = result

df.to_csv('hmmhits.csv')


