
#!/usr/bin/env python

import os
import subprocess
import pandas as pd

subprocess.run(['for e in ~/HMM/HMM_Output/*;do for i in $e/*out;do sed -i "/^#/d" $i;done;done'], shell=True, stdout=subprocess.PIPE, universal_newlines=True)
