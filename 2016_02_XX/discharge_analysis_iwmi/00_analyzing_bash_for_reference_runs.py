#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys

# maximum number of cores (must be an even number)
max_cores = 4

# directories for reference runs
directory = [
"with_fossil_limit_and_with_pumping_limit",
"with_fossil_limit_and_without_pumping_limit",
"without_fossil_limit_and_with_pumping_limit",
"without_fossil_limit_and_without_pumping_limit"
]

directory = [
"with_fossil_limit_and_with_pumping_limit"]

# making command lines
cmd = ''
for i_run in range(0, len(directory)):

   cmd += "python 0_main_analyze_discharge_IWMI.py " + "/scratch-shared/edwin/30min_sensitivity_analysis_non_natural/2016_02_XX/" + str(directory[i_run]) + "/ iwmi_calibration"
   cmd = cmd +" & \n"
   
   cmd += "python 0_main_analyze_discharge_IWMI.py " + "/scratch-shared/edwin/30min_sensitivity_analysis_non_natural/2016_02_XX/" + str(directory[i_run]) + "/ iwmi_validation"
   cmd = cmd +" & \n"

   if ((i_run + 1)%(max_cores/2) == 0) or (i_run == len(directory)): cmd = cmd + "wait \n"       

print cmd

# execute the command line
os.system(cmd)      
