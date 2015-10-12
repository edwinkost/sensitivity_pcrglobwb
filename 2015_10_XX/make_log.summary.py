# This script is for making the summary of log file. 

import os
import sys
import glob
import datetime
import numpy as np

# input log file based on the given system argurment
log_file_name = sys.argv[1]
log_file_name = glob.glob(log_file_name) # example: glob.glob("/scratch/edwin/IWMI_run_07_nov/natural_run/log/*.log")
log_file_name = log_file_name[0]
print log_file_name

# default output summary file (in the current directory)
txt_summary = str(os.path.basename)+".txt"

# output summary file based on the given system argument
if len(sys.argv) > 2: txt_summary = sys.argv[2]

# variables that will be reported
variable_list = ['precipitation',\
                 'groundwater_recharge',\
                 'total_water_demand',\
                 'irrigation_demand',\
                 'livestock_demand',\
                 'domestic_demand',\
                 'industry_demand',\
                 'desalination_abstraction',\
                 'non_fossil_groundwater_abstraction',\
                 'fossil_groundwater_abstraction',\
                 'surface_water_abstraction'
                 ]

# initiating dictionaries that will contain annual values
# - the key for this dictionary is "year"
# - all values have the unit km3/year
for var in variable_list: vars()[str(var)] = {}

# opening the log file and reading all lines 
f = open(log_file_name, "r")
lines = f.read().split("\n")
f.close()

# skipping all lines belonging to the spinUp period 
spinUpPeriod = True

# read line by line 
for i in range(len(lines)):

	line = lines[i]

	# start the analysis after spinUp period
	if "Transient simulation" in line: spinUpPeriod = False

	if spinUpPeriod == False:

		# identify year and annual precipitation
		if "Accumulated precipitation" in line: 
			year = int(line.split(" ")[11])
			precipitation[year] = float(line.split(" ")[13])

		# identify annual groundwater recharge
		if "Accumulated gwRecharge" in line: 
			year = int(line.split(" ")[11])
			groundwater_recharge[year] = line.split(" ")[13]

		# identify total water demand
		if "Accumulated totalPotentialGrossDemand" in line:
			year = int(line.split(" ")[11])
			total_water_demand[year] = line.split(" ")[13]

		# identify annual irrigation demand
		if "Accumulated irrGrossDemand" in line: 
			year = int(line.split(" ")[11])
			irrigation_demand[year] = line.split(" ")[13]

		# identify annual livestock demand
		if "Accumulated livestockWaterWithdrawal" in line: 
			year = int(line.split(" ")[11])
			livestock_demand[year] = line.split(" ")[13]

		# identify annual domestic demand
		if "Accumulated domesticWaterWithdrawal" in line: 
			year = int(line.split(" ")[11])
			domestic_demand[year] = line.split(" ")[13]

		# identify annual industry demand
		if "Accumulated industryWaterWithdrawal" in line: 
			year = int(line.split(" ")[11])
			industry_demand[year] = line.split(" ")[13]

		# identify annual desalinated water abstraction
		if "Accumulated desalinationAbstraction" in line:
			year = int(line.split(" ")[11])
			desalination_abstraction[year] = line.split(" ")[13]

		# identify annual non fossil groundwater abstraction
		if "Accumulated nonFossilGroundwaterAbs" in line: 
			year = int(line.split(" ")[11])
			non_fossil_groundwater_abstraction[year] = line.split(" ")[13]

		# identify annual fossil groundwater abstraction
		if "Accumulated unmetDemand" in line: 
			year = int(line.split(" ")[11])
			fossil_groundwater_abstraction[year] = line.split(" ")[13]

		# identify surface water abstraction
		if "Accumulated actSurfaceWaterAbstract" in line:
			year = int(line.split(" ")[11])
			surface_water_abstraction[year] = line.split(" ")[13]

# save results in a txt file:
#
# - opening a txt file in the "write" mode
f = open(txt_summary, "w")
# 
# - write header
text  = "year"+";"
for var in variable_list:
	if var != variable_list[-1]: text += str(var)+";"
	if var == variable_list[-1]:
		text += str(var)+"\n"
		text = str(text)
		f.write(text)
# 
# - write values for every year
years = np.sort(precipitation.keys())
for year in years:
	text = str(year)+";"
	for var in variable_list:
		# print var
		value = vars()[str(var)][int(year)]
		if var != variable_list[-1]: text += str(value)+";"
		if var == variable_list[-1]:
			text += str(value)+"\n"
			text = str(text)
			f.write(text)
f.close()
