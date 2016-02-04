#!/usr/bin/env python
# -*- coding: utf-8 -*-

import os
import sys

# starting and last_run code
sta_run = 0
end_run = 20 

# maximum number of cores
max_cores = 5

# making command lines
cmd = ''
for i_run in range(sta_run, end_run + 1):

   cmd += "python 0_main_analyze_discharge_IWMI.py " + "/projects/0/dfguu/users/edwin/30min_sensitivity_analysis_non_natural/2016_01_XX/code__a__" + str(i_run) + " iwmi_calibration"
   cmd = cmd +" & \n"
   
   cmd += "python 0_main_analyze_discharge_IWMI.py " + "/projects/0/dfguu/users/edwin/30min_sensitivity_analysis_non_natural/2016_01_XX/code__a__" + str(i_run) + " iwmi_validation"
   cmd = cmd +" & \n"

   if ((i_run + 1)%max_cores == 0) or (i_run == end_run): cmd = cmd + "wait \n"       

print cmd

# execute the command line
os.system(cmd)      
