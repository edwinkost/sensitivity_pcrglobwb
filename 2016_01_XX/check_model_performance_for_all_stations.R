
# clear the memory
rm(list=ls()); # ls()

# packages needed and clear all available existing objects:
require('ggplot2');require('RColorBrewer');require(scales);require(grid)


########################################################################################################################
# list of parameters
parameters = data.frame()
parameters = rbind(parameters, read.table("table_02_january_2016_cartesius.txt"        , header=T)[1:6])            
parameters = rbind(parameters, read.table("table_02_january_2016_cartesius_edwinhs.txt", header=T)[1:6])                   

# the first column is character
parameters[,1] = as.character(parameters[,1])

# reference run  
parameters = rbind(parameters, c("code__a__0", 1.0, 0.0, 0.0, 1.0, 1.0))

# the first column is code
names(parameters)[1] <- "code"

# make sure formats are correct
parameters[,1] <- as.character(parameters[,1])
parameters[,2:ncol(parameters)] <- lapply(parameters[,2:ncol(parameters)], as.numeric)
########################################################################################################################

# path of output folder
main_path = "/projects/0/dfguu/users/edwin/30min_sensitivity_analysis_non_natural/2016_01_XX/"

# station type: folder from the analysis results:
type_folder = "analysis_iwmi/calibration/"

# get the list of all rivers/stations used (from the monthly discharge analysis folder)
file_for_list_of_rivers = paste(main_path, "code__a__", as.character(0), type_folder, "/monthly_discharge/summary.txt", sep = "")
river = read.table(file_for_list_of_rivers, sep=";", header = T)

#~ # select rivers with number of months > 12
#~ river = river[which(river$num_of_month_pairs > 12), ]

# sort river based on grdc catchment area and use only the river name
river = as.character(river$river_name[order(-river$grdc_catchment_area_in_km2)])

# loop through all rivers to get model performances from all runs and their corresponding model parameters
#~ for (i_river in seq(1, length(river), 1)) {
for (i_river in seq(1, 5, 1)) {

print("")
print(i_river)
print("")

# initiate model performance indicators (all NA)
code         = array(NA, length(parameters$code))          
ns_eff       = array(NA, length(parameters$code))
ns_log       = array(NA, length(parameters$code))
kge_2009     = array(NA, length(parameters$code))
kge_2012     = array(NA, length(parameters$code))
R2           = array(NA, length(parameters$code))
one_min_bfdv = array(NA, length(parameters$code))

# loop through all model runs
for (i_code in seq(1, length(parameters$code), 1)) {

# code for this run and their parameter/pre-factor values
code[i_code]      = parameters$code[i_code]

# open/read monthly discharge file 
file_name = paste(main_path, as.character(code[i_code]), "/", type_folder, "/monthly_discharge/summary.txt", sep = "")
print(file_name)
performance_table = read.table(file_name, sep=";", header = T)

# discharge model performance indicators
ns_eff[i_code]   = performance_table$ns_efficiency    [which(performance_table$river_name == river[i_river])]
ns_log[i_code]   = performance_table$ns_efficiency_log[which(performance_table$river_name == river[i_river])]
kge_2009[i_code] = performance_table$kge_2009         [which(performance_table$river_name == river[i_river])]
kge_2012[i_code] = performance_table$kge_2012         [which(performance_table$river_name == river[i_river])]
R2[i_code]       = performance_table$R2               [which(performance_table$river_name == river[i_river])]

# open/read annual baseflow performance file 
file_name = paste(main_path, as.character(code[i_code]), "/", type_folder, "/annual_baseflow/baseflow_summary.txt", sep = "")
print(file_name)
performance_table = read.table(file_name, sep=";", header = T)

# annual baseflow performance indicator
bfdev_relative_value = performance_table$avg_baseflow_deviation[which(performance_table$river_name == river[i_river])]/performance_table$average_iwmi_opt_baseflow[which(performance_table$river_name == river[i_river])]
one_min_bfdv[i_code] = 1 - bfdev_relative_value

# set minimum value of model performance indicator
ns_eff      [i_code][which(ns_eff       [i_code] < 0.0)] = 0.0
ns_log      [i_code][which(ns_log       [i_code] < 0.0)] = 0.0
kge_2009    [i_code][which(kge_2009     [i_code] < 0.0)] = 0.0
kge_2012    [i_code][which(kge_2012     [i_code] < 0.0)] = 0.0
R2          [i_code][which(R2           [i_code] < 0.0)] = 0.0 
one_min_bfdv[i_code][which(one_min_bfdv [i_code] < 0.0)] = 0.0

# set all NA and NaN to 0.0
ns_eff      [i_code][is.nan(ns_eff      [i_code])]       = 0.0
ns_log      [i_code][is.nan(ns_log      [i_code])]       = 0.0
kge_2009    [i_code][is.nan(kge_2009    [i_code])]       = 0.0
kge_2012    [i_code][is.nan(kge_2012    [i_code])]       = 0.0
R2          [i_code][is.nan(R2          [i_code])]       = 0.0
one_min_bfdv[i_code][is.nan(one_min_bfdv[i_code])]       = 0.0
ns_eff      [i_code][ is.na(ns_eff      [i_code])]       = 0.0
ns_log      [i_code][ is.na(ns_log      [i_code])]       = 0.0
kge_2009    [i_code][ is.na(kge_2009    [i_code])]       = 0.0
kge_2012    [i_code][ is.na(kge_2012    [i_code])]       = 0.0
R2          [i_code][ is.na(R2          [i_code])]       = 0.0
one_min_bfdv[i_code][ is.na(one_min_bfdv[i_code])]       = 0.0

}

table_for_this_river = data.frame()


plot(c(parameters$min_soil_depth_frac, 10), array(i_river, length(parameters$code) + 1), cex = c(kge_2009, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(min(parameters$min_soil_depth_frac), max(parameters$min_soil_depth_frac)))
text(mean(parameters$min_soil_depth_frac), i_river - 0.25, labels = as.character(river[i_river]), cex = 1.5)
plot(c(parameters$log_ksat           , 10), array(i_river, length(parameters$code) + 1), cex = c(kge_2009, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(min(parameters$log_ksat           ), max(parameters$log_ksat           )))
plot(c(parameters$log_recession_coef , 10), array(i_river, length(parameters$code) + 1), cex = c(kge_2009, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(min(parameters$log_recession_coef ), max(parameters$log_recession_coef )))
plot(c(parameters$degree_day_factor  , 10), array(i_river, length(parameters$code) + 1), cex = c(kge_2009, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(min(parameters$degree_day_factor  ), max(parameters$degree_day_factor  )))


#~ plot(c(parameters$min_soil_depth_frac, 10), array(i_river, length(parameters$code) + 1), cex = c(ns_log, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(min(parameters$min_soil_depth_frac), max(parameters$min_soil_depth_frac)))
#~ text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 1.5)
#~ plot(c(parameters$log_ksat           , 10), array(i_river, length(parameters$code) + 1), cex = c(ns_log, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(min(parameters$log_ksat           ), max(parameters$log_ksat           )))
#~ plot(c(parameters$log_recession_coef , 10), array(i_river, length(parameters$code) + 1), cex = c(ns_log, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(min(parameters$log_recession_coef ), max(parameters$log_recession_coef )))
#~ plot(c(parameters$stor_cap           , 10), array(i_river, length(parameters$code) + 1), cex = c(ns_log, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(min(parameters$stor_cap           ), max(parameters$stor_cap           )))

#~ plot(parameters$min_soil_depth_frac, array(i_river, length(parameters$code)), cex = ns_log * 7., yaxt = 'n', ylab = substr(as.character(river[i_river]), 1, 5), ylim = c(i_river - 0.5, i_river + 0.5))
#~ text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 2.5)
#~ plot(parameters$log_ksat           , array(i_river, length(parameters$code)), cex = ns_log * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$log_recession_coef , array(i_river, length(parameters$code)), cex = ns_log * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$stor_cap           , array(i_river, length(parameters$code)), cex = ns_log * 7., yaxt = 'n', ylab = "")

#~ plot(parameters$min_soil_depth_frac, array(i_river, length(parameters$code)), cex = kge_2009 * 7., yaxt = 'n', ylab = substr(as.character(river[i_river]), 1, 5), ylim = c(i_river - 0.5, i_river + 0.5))
#~ text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 2.5)
#~ plot(parameters$log_ksat           , array(i_river, length(parameters$code)), cex = kge_2009 * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$log_recession_coef , array(i_river, length(parameters$code)), cex = kge_2009 * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$stor_cap           , array(i_river, length(parameters$code)), cex = kge_2009 * 7., yaxt = 'n', ylab = "")

#~ plot(parameters$min_soil_depth_frac, array(i_river, length(parameters$code)), cex = kge_2012 * 7., yaxt = 'n', ylab = substr(as.character(river[i_river]), 1, 5), ylim = c(i_river - 0.5, i_river + 0.5))
#~ text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 2.5)
#~ plot(parameters$log_ksat           , array(i_river, length(parameters$code)), cex = kge_2012 * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$log_recession_coef , array(i_river, length(parameters$code)), cex = kge_2012 * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$stor_cap           , array(i_river, length(parameters$code)), cex = kge_2012 * 7., yaxt = 'n', ylab = "")

#~ plot(parameters$min_soil_depth_frac, array(i_river, length(parameters$code)), cex = R2 * 7., yaxt = 'n', ylab = substr(as.character(river[i_river]), 1, 5), ylim = c(i_river - 0.5, i_river + 0.5))
#~ text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 2.5)
#~ plot(parameters$log_ksat           , array(i_river, length(parameters$code)), cex = R2 * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$log_recession_coef , array(i_river, length(parameters$code)), cex = R2 * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$stor_cap           , array(i_river, length(parameters$code)), cex = R2 * 7., yaxt = 'n', ylab = "")


#~ symbols(parameters$min_soil_depth_frac, array(i_river, length(parameters$code)), circles = kge_2009, yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), bg=NULL, fg="black")
#~ text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 1.5)
#~ symbols(parameters$log_ksat           , array(i_river, length(parameters$code)), circles = kge_2009, yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), bg=NULL, fg="black")
#~ symbols(parameters$log_recession_coef , array(i_river, length(parameters$code)), circles = kge_2009, yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), bg=NULL, fg="black")
#~ symbols(parameters$stor_cap           , array(i_river, length(parameters$code)), circles = kge_2009, yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), bg=NULL, fg="black")


#~ plot(parameters$min_soil_depth_frac, ns_eff, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
#~ plot(parameters$log_ksat           , ns_eff, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$log_recession_coef , ns_eff, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$stor_cap           , ns_eff, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ 
#~ plot(parameters$min_soil_depth_frac, ns_log, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
#~ plot(parameters$log_ksat           , ns_log, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$log_recession_coef , ns_log, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$stor_cap           , ns_log, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ 
#~ plot(parameters$min_soil_depth_frac, kge_2009, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
#~ plot(parameters$log_ksat           , kge_2009, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$log_recession_coef , kge_2009, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$stor_cap           , kge_2009, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ 
#~ plot(parameters$min_soil_depth_frac, kge_2012, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
#~ plot(parameters$log_ksat           , kge_2012, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$log_recession_coef , kge_2012, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$stor_cap           , kge_2012, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ 
#~ plot(parameters$min_soil_depth_frac, R2, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
#~ plot(parameters$log_ksat           , R2, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$log_recession_coef , R2, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
#~ plot(parameters$stor_cap           , R2, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")



}

dev.off()
