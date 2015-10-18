
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

# main path for the summary folder
main_path = "/scratch-shared/edwin/sensitivity_analysis/2015_10_XX/"

# get the list of all rivers/stations used
file_for_list_of_rivers = paste(main_path, "code__a__", as.character(0), "/analysis/monthly_discharge/summary.txt", sep = "")
river = read.table(file_for_list_of_rivers, sep=";", header = T)

# select rivers with number of months > 12
river = river[which(river$num_of_month_pairs > 12), ]

# sort river based on grdc catchment area and use only the river name
river = as.character(river$river_name[order(-river$grdc_catchment_area_in_km2)])


pdf("0Rtest.pdf", width=30, height=1.2*length(river), bg = "white")

#~ pdf("0Rtest.pdf", width=30, height=1.2*5, bg = "white")

par(mfrow=c(length(river), 4), mar=c(1,1,1,1))

# loop through all rivers to get model performances from all runs and their corresponding model parameters
#for (i_river in seq(1, length(river), 1)) {
for (i_river in seq(1, 5, 1)) {


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

# set minimum value of model performance indicator
ns_eff[i_code][which(ns_eff[i_code] < 0.0)] = 0.0
ns_log[i_code][which(ns_log[i_code] < 0.0)] = 0.0
kge_2009[i_code][which(kge_2009[i_code] < 0.0)] = 0.0
kge_2012[i_code][which(kge_2012[i_code] < 0.0)] = 0.0
R2[i_code][which(R2[i_code] < 0.0)] = 0.0      

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


symbols(parameters$min_soil_depth_frac, array(i_river, length(parameters$code)), circles = kge_2009 * 0.05, yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), bg=NULL, fg="black")
text(mean(parameters$min_soil_depth_frac), i_river + 0.25, labels = as.character(river[i_river]), cex = 2.5)
symbols(parameters$log_ksat           , array(i_river, length(parameters$code)), circles = kge_2009 * 0.05, yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), bg=NULL, fg="black")
symbols(parameters$log_recession_coef , array(i_river, length(parameters$code)), circles = kge_2009 * 0.05, yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), bg=NULL, fg="black")
symbols(parameters$stor_cap           , array(i_river, length(parameters$code)), circles = kge_2009 * 0.05, yaxt = 'n', ylab = "", ylim = c(i_river - 0.5, i_river + 0.5), bg=NULL, fg="black")


}

dev.off()
