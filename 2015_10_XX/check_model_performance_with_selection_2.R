
# packages needed and clear all available existing objects:
require('ggplot2');require('RColorBrewer');require(scales)
rm(list=ls()); # ls()


########################################################################################################################
# list of parameters
parameters = data.frame()
parameters = rbind(parameters, read.table("../table_05_october_2015_speedy_and_rapid.txt", header=T)[1:5])            
parameters = rbind(parameters, read.table("../table_05_october_2015_cartesius.txt", header=T)[1:5])                   
parameters = rbind(parameters, read.table("../table_06_october_2015_cartesius_and_speedy_rapid.txt", header=T)[1:5])
parameters = rbind(parameters, read.table("../table_08_october_2015_cartesius.txt", header=T)[1:5])
parameters = rbind(parameters, read.table("../table_12_october_2015_cartesius.txt", header=T)[1:5])
parameters = rbind(parameters, read.table("../table_14_october_2015_cartesius.txt", header=T)[1:5])

# the first column is character
parameters[,1] = as.character(parameters[,1])

# reference run  
parameters = rbind(parameters, c("code__a__0", 1.0, 0.0, 0.0, 1.0))

# the first column is code
names(parameters)[1] <- "code"

# make sure formats are correct
parameters[,1] <- as.character(parameters[,1])
parameters[,2:ncol(parameters)] <- lapply(parameters[,2:ncol(parameters)], as.numeric)
########################################################################################################################


########################################################################################################################
# make table of average values 

# main path
main_path = "~/github/edwinkost/sensitivity_pcrglobwb/2015_10_XX/summary_0to674/summary_"

average_values = data.frame()

for( i_run in seq(0,674,1)) {

# open the log_summary file
file_name = paste(main_path , as.character(i_run), ".sum", sep = "")
print(file_name)

# scenario_code
code = paste("code__a__", as.character(i_run), sep = "")

# open the log_summary file
summary_table = read.table(file_name, sep = ";", header = T)

avg_evaporation          = mean(summary_table$evaporation         )
avg_runoff               = mean(summary_table$runoff              )
avg_baseflow             = mean(summary_table$baseflow            )        
avg_groundwater_recharge = mean(summary_table$groundwater_recharge)

average_values = rbind(average_values, 
                       cbind(code, 
                             avg_evaporation,         
                             avg_runoff,              
                             avg_baseflow,            
                             avg_groundwater_recharge))
}

# names of all columns
names(average_values)[1] <- "code"
names(average_values)[2] <- "avg_evaporation"        
names(average_values)[3] <- "avg_runoff"             
names(average_values)[4] <- "avg_baseflow"           
names(average_values)[5] <- "avg_groundwater_recharge"

# make sure formats are correct
average_values[,1] <- as.character(average_values[,1])
average_values[,2:ncol(average_values)] <- lapply(average_values[,2:ncol(average_values)], as.character)
average_values[,2:ncol(average_values)] <- lapply(average_values[,2:ncol(average_values)], as.numeric)
########################################################################################################################

# merge two data frame
parameters_ori = parameters
parameters = merge(parameters, average_values, by = "code")

# main path for the summary folder
main_path = "/scratch-shared/edwin/sensitivity_analysis/2015_10_XX/"

# get the list of all rivers/stations used
file_for_list_of_rivers = paste(main_path, "code__a__", as.character(0), "/analysis/monthly_discharge/summary.txt", sep = "")
river = read.table(file_for_list_of_rivers, sep=";", header = T)

# select rivers with number of months > 12
river = river[which(river$num_of_month_pairs > 12), ]

# sort river based on grdc catchment area and use only the river name
river = as.character(river$river_name[order(-river$grdc_catchment_area_in_km2)])

pdf("0Rtest_selected.pdf", width = 17.5, height = 0.75 * length(river), bg = "white")
par(mfrow=c(length(river), 5*4), mar=c(1,1,1,1))

# loop through all rivers to get model performances from all runs and their corresponding model parameters
for (i_river in seq(1, length(river), 1)) {
#~ for (i_river in seq(1, 5, 1)) {


print("")
print(i_river)
print("")

# initiate model performance indicators (all NA)
ns_eff   = array(NA, length(parameters$code))
ns_log   = array(NA, length(parameters$code))
kge_2009 = array(NA, length(parameters$code))
kge_2012 = array(NA, length(parameters$code))
R2       = array(NA, length(parameters$code))

# loop through all model runs
for (i_code in seq(1, length(parameters$code), 1)) {

# open/read file 
file_name = paste(main_path, "code__a__", as.character(i_code-1), "/analysis/monthly_discharge/summary.txt", sep = "")
print(file_name)
performance_table = read.table(file_name, sep=";", header = T)

# model performance indicators
ns_eff[i_code]   = performance_table$ns_efficiency[which(performance_table$river_name == river[i_river])]
ns_log[i_code]   = performance_table$ns_efficiency_log[which(performance_table$river_name == river[i_river])]
kge_2009[i_code] = performance_table$kge_2009[which(performance_table$river_name == river[i_river])]
kge_2012[i_code] = performance_table$kge_2012[which(performance_table$river_name == river[i_river])]
R2[i_code]       = performance_table$R2[which(performance_table$river_name == river[i_river])]

#~ # set minimum value of model performance indicator
#~ ns_eff[i_code][which(ns_eff[i_code] < 0.0)] = 0.0
#~ ns_log[i_code][which(ns_log[i_code] < 0.0)] = 0.0
#~ kge_2009[i_code][which(kge_2009[i_code] < 0.0)] = 0.0
#~ kge_2012[i_code][which(kge_2012[i_code] < 0.0)] = 0.0
#~ R2[i_code][which(R2[i_code] < 0.0)] = 0.0      

in_criteria = TRUE

if (!(parameters$log_ksat[i_code] %in% c(-0.5, -0.25))) {in_criteria = FALSE}

if (as.numeric(parameters$avg_runoff[i_code]) < 35000) {in_criteria = FALSE}
if (as.numeric(parameters$avg_runoff[i_code]) > 50000) {in_criteria = FALSE}

if (parameters$avg_baseflow[i_code] < 15000) {in_criteria = FALSE}
if (parameters$avg_baseflow[i_code] > 25000) {in_criteria = FALSE}

if (in_criteria == FALSE) {

ns_eff[i_code] = -9999
ns_log[i_code] = -9999
kge_2009[i_code] = -9999
kge_2012[i_code] = -9999
R2[i_code] = -9999      

}



}

#~ plot(parameters$min_soil_depth_frac, array(i_river, length(parameters$code)), cex = ns_eff * 7., yaxt = 'n', ylab = substr(as.character(river[i_river]), 1, 5), ylim = c(i_river - 0.5, i_river + 0.5))
#~ text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 2.5)
#~ plot(parameters$log_ksat           , array(i_river, length(parameters$code)), cex = ns_eff * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$log_recession_coef , array(i_river, length(parameters$code)), cex = ns_eff * 7., yaxt = 'n', ylab = "")
#~ plot(parameters$stor_cap           , array(i_river, length(parameters$code)), cex = ns_eff * 7., yaxt = 'n', ylab = "")

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


plot(parameters$min_soil_depth_frac, ns_eff, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
plot(parameters$log_ksat           , ns_eff, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$log_recession_coef , ns_eff, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$stor_cap           , ns_eff, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")

plot(parameters$min_soil_depth_frac, ns_log, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
plot(parameters$log_ksat           , ns_log, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$log_recession_coef , ns_log, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$stor_cap           , ns_log, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")

plot(parameters$min_soil_depth_frac, kge_2009, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
plot(parameters$log_ksat           , kge_2009, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$log_recession_coef , kge_2009, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$stor_cap           , kge_2009, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")

plot(parameters$min_soil_depth_frac, kge_2012, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
plot(parameters$log_ksat           , kge_2012, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$log_recession_coef , kge_2012, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$stor_cap           , kge_2012, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")

plot(parameters$min_soil_depth_frac, R2, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
text(mean(parameters$min_soil_depth_frac), 0.85, labels = as.character(river[i_river]), cex = 1)
plot(parameters$log_ksat           , R2, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$log_recession_coef , R2, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")
plot(parameters$stor_cap           , R2, ylab = "", ylim = c(0, 1.1), breaks = seq(0, 1, 0.1), bg=NULL, fg="black")



}

dev.off()
