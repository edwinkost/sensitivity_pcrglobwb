
# global folder for all scenarios
global_folder = "/projects/0/dfguu/users/edwin/30min_sensitivity_analysis_non_natural/2016_01_XX/"

first_run_to_be_analyzed = TRUE
for (i in seq(0,224,1)) {

# run code/name:
run_code = paste("code__a__",i,sep="")

# read table containing discharge analysis
discharge_table_file = paste(global_folder, run_code,"/analysis_iwmi/calibration/monthly_discharge/summary.txt",sep="") 
discharge_table = read.table(discharge_table_file, header=T, sep= ";")

# read table containing baseflow analysis
baseflow_table_file  = paste(global_folder, run_code,"/analysis_iwmi/calibration/annual_baseflow/baseflow_summary.txt",sep="") 
baseflow_table = read.table(baseflow_table_file, header=T, sep= ";")

# calculate baseflow_deviation_relative and use only this performance value for further analyses:
baseflow_deviation_relative = abs(baseflow_table$avg_baseflow_deviation/baseflow_table$average_iwmi_opt_baseflow)
baseflow_table = data.frame(baseflow_table$id_from_grdc, baseflow_deviation_relative)
# and 


# calculate composite performance values
bfdev = 
correlation_bfdev       = 
R2_bfdev
R2_adjusted_bfdev
ns_efficiency_bfdev
ns_efficiency_log_bfdev
kge_2009_bfdev
kge_2012_bfdev                     






















#
ns_discharge = discharge_table$ns_efficiency
ns_discharge[which(ns_discharge < 0.00)] = 0.00
average_ns_discharge = mean(ns_discharge, na.rm = TRUE)
#
baseflow_deviation_relative = abs(baseflow_table$avg_baseflow_deviation/baseflow_table$average_iwmi_opt_baseflow)
baseflow_deviation_relative[which(baseflow_deviation_relative > 1.00)] = 1.00
baseflow_deviation = mean(baseflow_deviation_relative, na.rm = TRUE)
baseflow_deviation = floor(baseflow_deviation*10)/10
#
general_performance = average_ns_discharge / (baseflow_deviation)

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
parameter_table_1st = read.table("/home/edwinhs/github/edwinkost/calibration_log_IWMI/runs_for_IWMI_calibration_code_A/table_24_nov_2014.txt",header=TRUE)
parameter_table_2nd = read.table("/home/edwinhs/github/edwinkost/calibration_log_IWMI/runs_for_IWMI_calibration_code_A/table_26_nov_2014.txt",header=TRUE)
reference_run = c("code__a__0",1.0,0.0,0.0,1.0)
#
parameter_table = rbind(reference_run, parameter_table_1st, parameter_table_2nd) 
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
final_table[1:15,]

write.table(final_table,file = "scatterplot_dec_2014.txt", col.names=TRUE,row.names=FALSE,sep=";")



