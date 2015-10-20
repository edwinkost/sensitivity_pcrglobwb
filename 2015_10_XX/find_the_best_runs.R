
# NOT FINISH YET

# packages needed and clear all available existing objects:
rm(list=ls()); # ls()

# global folder for all scenarios
global_folder = "/scratch/edwin/30min_22_jun_2015/rerun_for_iwmi/calibration_27_june_2015/"

first_run_to_be_analyzed = TRUE
for (i in seq(0,1124,1)) {

# run code/name:
run_code = paste("code__a__",i,sep="")

# read table containing discharge analysis
discharge_table_file =paste(global_folder, run_code,"/analysis/calibration/monthly_discharge/summary.txt",sep="") 
discharge_table = read.table(discharge_table_file, header=T, sep= ";")

# calculate performance values
source("calculate_performance.R")

if (first_run_to_be_analyzed == TRUE) {
summary = cbind(run_code, average_ns_discharge, baseflow_deviation, general_performance)
first_run_to_be_analyzed = FALSE
} else {
summary = rbind(summary, 
          cbind(run_code, average_ns_discharge, baseflow_deviation, general_performance))
}
}

# convert summary table to data frame
summary_df = data.frame(summary)
summary_df$run_code             = as.character(summary_df$run_code)
summary_df$baseflow_deviation   = as.numeric(as.character(summary_df$baseflow_deviation))
summary_df$average_ns_discharge = as.numeric(as.character(summary_df$average_ns_discharge))
summary_df$general_performance  = as.numeric(as.character(summary_df$general_performance))

# merge it to parameters table
parameter_table_1st = read.table("/home/sutan101/github/edwinkost/calibration_log_IWMI/runs_for_IWMI_calibration_code_AA/table_27_june_2014_speedy.txt",header=TRUE)
parameter_table_2nd = read.table("/home/sutan101/github/edwinkost/calibration_log_IWMI/runs_for_IWMI_calibration_code_AA/table_27_june_2014_speedy_2.txt",header=TRUE)
parameter_table_3rd = read.table("/home/sutan101/github/edwinkost/calibration_log_IWMI/runs_for_IWMI_calibration_code_AA/table_30_june_2014_cartesius.txt",header=TRUE)
reference_run = c("code__a__0",1.0,0.0,0.0,1.0)
#
parameter_table = rbind(reference_run, parameter_table_1st, parameter_table_2nd, parameter_table_3rd) 
parameter_table[ ,1] <- as.character(parameter_table[,1])
parameter_table[1,1] <- "code__a__0"
parameter_table[ ,2] <- as.numeric(parameter_table[,2])
parameter_table[ ,3] <- as.numeric(parameter_table[,3])
parameter_table[ ,4] <- as.numeric(parameter_table[,4])
names(parameter_table)[1] <- "run_code"
names(parameter_table)[2] <- "min_soil_depth_frac"
names(parameter_table)[3] <- "log_ksat"
names(parameter_table)[4] <- "log_recession_coef"
names(parameter_table)[5] <- "degree_day_factor"
#
final_table = merge(parameter_table, summary_df, by = "run_code")

# order it based on performance values
#~ final_table = final_table[order(final_table$general_performance), ]
final_table = final_table[order(-final_table$general_performance), ]
final_table[1:40,]

write.table(final_table,file = "scatterplot_july_2015.txt", col.names=TRUE,row.names=FALSE,sep=";")



