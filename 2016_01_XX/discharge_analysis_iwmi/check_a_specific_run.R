
# folder for a specific scenario
folder = "/scratch/edwin/IWMI_calibration/version_01_dec_2014/uncalibrated/code__a__0/analysis/calibration/"
folder = "/scratch/edwin/30min_22_jun_2015/rerun_for_iwmi/calibration_27_june_2015/code__a__0/analysis/calibration/"

# folder is defined based on the system argument
args <- commandArgs()
print(args)
folder = args[4]
print(folder)

# read table containing discharge analysis
discharge_table_file = paste(folder, "/monthly_discharge/summary.txt", sep="") 
discharge_table = read.table(discharge_table_file, header=T, sep= ";")

# read table containing baseflow analysis
baseflow_table_file  = paste(folder, "/annual_baseflow/baseflow_summary.txt", sep="") 
baseflow_table = read.table(baseflow_table_file, header=T, sep= ";")

# calculate performance values
source("calculate_performance.R")

print(average_ns_discharge)
print(baseflow_deviation)
print(general_performance)
