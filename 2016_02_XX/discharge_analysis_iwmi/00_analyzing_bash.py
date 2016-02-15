#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys

# starting and last_run code
sta_run = int(sys.argv[1]) # 0
end_run = int(sys.argv[2]) # 224 

# maximum number of cores (must be an even number)
max_cores = 32

# making command lines
cmd = ''
for i_run in range(sta_run, end_run + 1):

   cmd += "python 0_main_analyze_discharge_IWMI.py " + "/scratch-shared/edwin/30min_sensitivity_analysis_non_natural/2016_02_XX/code__a__" + str(i_run) + " iwmi_calibration"
   cmd = cmd +" & \n"
   
   cmd += "python 0_main_analyze_discharge_IWMI.py " + "/scratch-shared/edwin/30min_sensitivity_analysis_non_natural/2016_02_XX/code__a__" + str(i_run) + " iwmi_validation"
   cmd = cmd +" & \n"

   if ((i_run + 1)%(max_cores/2) == 0) or (i_run == end_run): cmd = cmd + "wait \n"       

print cmd

# execute the command line
os.system(cmd)      
