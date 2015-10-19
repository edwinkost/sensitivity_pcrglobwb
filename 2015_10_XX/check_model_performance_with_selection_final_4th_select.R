
# packages needed and clear all available existing objects:
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
parameters = rbind(parameters, read.table("../table_15_october_2015_cartesius.txt", header=T)[1:5])

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
average_values = data.frame()
# main path
main_path = "~/github/edwinkost/sensitivity_pcrglobwb/2015_10_XX/summary_0to1124/summary_"

for( i_run in seq(0, length(parameters$code) - 1,1)) {

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
parameters = parameters_ori
parameters = merge(parameters, average_values, by = "code")

# make sure formats are correct
parameters[,1] <- as.character(parameters[,1])
parameters[,2:ncol(parameters)] <- lapply(parameters[,2:ncol(parameters)], as.character)
parameters[,2:ncol(parameters)] <- lapply(parameters[,2:ncol(parameters)], as.numeric)
########################################################################################################################


# value for the reference run
evaporation_ref = parameters$avg_evaporation[which(parameters$code == "code__a__0")]
runoff_ref      = parameters$avg_runoff[which(parameters$code == "code__a__0")]
baseflow_ref    = parameters$avg_baseflow[which(parameters$code == "code__a__0")]
recharge_ref    = parameters$avg_groundwater_recharge[which(parameters$code == "code__a__0")]


########################################################################################################################
with_selection = TRUE 
file_name_selection = "no_selection"
#
if (with_selection == TRUE) {
# make selection 

# file name for this selection
file_name_selection = "fourth_selection"

# average runoff should be between 35000 and 50000 km3/year
parameters = parameters[which(parameters$avg_runoff >= 35000), ]
parameters = parameters[which(parameters$avg_runoff <= 50000), ]

# average recharge should be between 15000 and 25000 km3/year
parameters = parameters[which(parameters$avg_groundwater_recharge >= 15000), ]
parameters = parameters[which(parameters$avg_groundwater_recharge <= 25000), ]

# average evaporation should be above 55000 km3/year
parameters = parameters[which(parameters$avg_evaporation >= 55000), ]

# log_ksat should be -0.50
parameters = parameters[which(parameters$log_ksat == -0.50), ]

# stor_cap should be at least 1.00
parameters = parameters[which(parameters$stor_cap >= 1.00), ]

# stor_cap should be 1.25
parameters = parameters[which(parameters$stor_cap >= 1.25), ]

#~ # min_soil_depth_frac should be 0.75
#~ parameters = parameters[which(parameters$min_soil_depth_frac == 0.75), ]

#~ # log_recession_coef should be -0.50
#~ parameters = parameters[which(parameters$log_recession_coef == -0.50), ]


}
########################################################################################################################


########################################################################################################################
# make scatter plots
file_name = paste("scatter_plot_parameters_", file_name_selection, ".pdf", sep = "")

pdf(file_name, width=10, height=12, bg = "white")
par(mfrow=c(4,4), mar=c(4,4,2,4))

plot(parameters$min_soil_depth_frac, parameters$avg_evaporation, xlim = c(0.5, 1.5), ylim = c(30000, 80000))
abline(h = evaporation_ref)
plot(parameters$log_ksat           , parameters$avg_evaporation, xlim = c(-1, 1), ylim = c(30000, 80000))
abline(h = evaporation_ref)
plot(parameters$log_recession_coef , parameters$avg_evaporation, xlim = c(-1, 1), ylim = c(30000, 80000))
abline(h = evaporation_ref)
plot(parameters$stor_cap           , parameters$avg_evaporation, xlim = c(0.5, 1.5), ylim = c(30000, 80000))
abline(h = evaporation_ref)

plot(parameters$min_soil_depth_frac, parameters$avg_runoff, xlim = c(0.5, 1.5), ylim = c(25000, 75000))
abline(h = runoff_ref)                                    
plot(parameters$log_ksat           , parameters$avg_runoff, xlim = c(-1, 1), ylim = c(25000, 75000))
abline(h = runoff_ref)                                    
plot(parameters$log_recession_coef , parameters$avg_runoff, xlim = c(-1, 1), ylim = c(25000, 75000))
abline(h = runoff_ref)                                    
plot(parameters$stor_cap           , parameters$avg_runoff, xlim = c(0.5, 1.5), ylim = c(25000, 75000))
abline(h = runoff_ref)

plot(parameters$min_soil_depth_frac, parameters$avg_baseflow, xlim = c(0.5, 1.5), ylim = c(5000, 55000))
abline(h = baseflow_ref)                                    
plot(parameters$log_ksat           , parameters$avg_baseflow, xlim = c(-1, 1), ylim = c(5000, 55000))
abline(h = baseflow_ref)                                    
plot(parameters$log_recession_coef , parameters$avg_baseflow, xlim = c(-1, 1), ylim = c(5000, 55000))
abline(h = baseflow_ref)                                    
plot(parameters$stor_cap           , parameters$avg_baseflow, xlim = c(0.5, 1.5), ylim = c(5000, 55000))
abline(h = baseflow_ref)

plot(parameters$min_soil_depth_frac, parameters$avg_groundwater_recharge, xlim = c(0.5, 1.5), ylim = c(5000, 55000))
abline(h = recharge_ref)                                                
plot(parameters$log_ksat           , parameters$avg_groundwater_recharge, xlim = c(-1, 1), ylim = c(5000, 55000))
abline(h = recharge_ref)                                                
plot(parameters$log_recession_coef , parameters$avg_groundwater_recharge, xlim = c(-1, 1), ylim = c(5000, 55000))
abline(h = recharge_ref)                                                
plot(parameters$stor_cap           , parameters$avg_groundwater_recharge, xlim = c(0.5, 1.5), ylim = c(5000, 55000))
abline(h = recharge_ref)

dev.off()
########################################################################################################################



#############################################################################################################################
# get the list of all rivers/stations used
output_path = "/scratch-shared/edwin/sensitivity_analysis/2015_10_XX/"
file_for_list_of_rivers = paste(output_path, "code__a__", as.character(0), "/analysis/monthly_discharge/summary.txt", sep = "")
performance_table = read.table(file_for_list_of_rivers, sep=";", header = T)

# select rivers with number of months >= 12
river = performance_table[which(performance_table$num_of_month_pairs >= 12), ]

# sort river based on grdc catchment area and use only the river name
river = as.character(river$river_name[order(-river$grdc_catchment_area_in_km2)])
#############################################################################################################################


# loop through all model performances:
performance_indi = c("ns_efficiency", "ns_efficiency_log", "kge_2009", "kge_2012", "R2")

for (i_indi in seq(1, length(performance_indi), 1)) {

performance_used = performance_indi[i_indi]
performance_colm = which(names(performance_table) == performance_used)

file_name_indi = paste(performance_used, "_", file_name_selection, ".pdf", sep = "")

pdf(file_name_indi, width = 16, height = 1.2 * length(river), bg = "white")
par(mfrow=c(length(river), 4), mar=c(1,1,1,1))

# loop through all rivers to get model performances from all runs and their corresponding model parameters
for (i_river in seq(1, length(river), 1)) {
#~ for (i_river in seq(1, 5, 1)) {

# initiate model performance indicator (all NA)
indicator_value = array(NA, length(parameters$code))

# loop through all model runs
for (i_code in seq(1, length(parameters$code), 1)) {

# open/read file 
file_name = paste(output_path, "code__a__", as.character(i_code-1), "/analysis/monthly_discharge/summary.txt", sep = "")
print(file_name)
performance_table = read.table(file_name, sep=";", header = T)

# model performance indicators
indicator_value[i_code] = performance_table[which(performance_table$river_name == as.character(river[i_river])), performance_colm]

# set minimum value of model performance indicator
indicator_value[i_code][which(indicator_value[i_code] < 0.0)] = 0.0

# print to indicate progress
print("")
print("Processing ...")
print(file_name)
print(river[i_river])
print(performance_used)
print("")

}

plot(c(parameters$min_soil_depth_frac, 10), array(i_river, length(parameters$code) + 1), cex = c(indicator_value, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c( 0.5, 1.5))
text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 1.5)
plot(c(parameters$log_ksat           , 10), array(i_river, length(parameters$code) + 1), cex = c(indicator_value, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(-1.0, 1.0))
plot(c(parameters$log_recession_coef , 10), array(i_river, length(parameters$code) + 1), cex = c(indicator_value, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c(-1.0, 1.0))
plot(c(parameters$stor_cap           , 10), array(i_river, length(parameters$code) + 1), cex = c(indicator_value, 1) * 7., yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), xlim = c( 0.5, 1.5))

}

dev.off()

}
