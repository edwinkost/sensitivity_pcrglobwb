
# clear the memory
rm(list=ls()); # ls()

# packages needed and clear all available existing objects:
require('ggplot2');require('RColorBrewer');require(scales);require(grid)


########################################################################################################################
# list of parameters
parameters = data.frame()
parameters = rbind(parameters, read.table("table_13_february_2016_cartesius_edwin.txt"    , header=T)[1:6])            
parameters = rbind(parameters, read.table("table_13_february_2016_cartesius_edwin_2nd.txt", header=T)[1:6])                   

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
main_path = "/scratch-shared/edwin/30min_sensitivity_analysis_non_natural/2016_02_XX/"

# station type: folder from the analysis results:
type_folder = "analysis_iwmi/calibration/"

# get the list of all rivers/stations used (from the monthly discharge analysis folder)
file_for_list_of_rivers = paste(main_path, "code__a__", as.character(0), "/", type_folder, "/monthly_discharge/summary.txt", sep = "")
river = read.table(file_for_list_of_rivers, sep=";", header = T)

#~ # select rivers with number of months > 12
#~ river = river[which(river$num_of_month_pairs > 12), ]

# sort river based on grdc catchment area and use only the river name
river = as.character(river$river_name[order(-river$grdc_catchment_area_in_km2)])

# loop through all rivers to get model performances from all runs and their corresponding model parameters
for (i_river in seq(1, length(river), 1)) {
#~ for (i_river in seq(1, 5, 1)) {

print("")
print(i_river)
print("")

# initiate run codes and model parameter values
code                = array(NA, length(parameters$code))          
min_soil_depth_frac = array(NA, length(parameters$code))
log_ksat            = array(NA, length(parameters$code))
log_recession_coef  = array(NA, length(parameters$code))
stor_cap            = array(NA, length(parameters$code))
degree_day_factor   = array(NA, length(parameters$code))

# initiate model performance indicators (all NA)
ns_eff       = array(NA, length(parameters$code))
ns_log       = array(NA, length(parameters$code))
kge_2009     = array(NA, length(parameters$code))
kge_2012     = array(NA, length(parameters$code))
R2           = array(NA, length(parameters$code))
one_min_bfdv = array(NA, length(parameters$code))

# river numbers (for plotting purpose):
# - in the plot, the upper one will be the river with larger catchments
river_number = length(river) + 1 - i_river
river_number = array(river_number, length(parameters$code))

# river names (only for documentation purpose) 
river_name = array(river[i_river], length(parameters$code))

# loop through all model runs
#~ for (i_code in seq(1, length(parameters$code), 1)) {
for (i_code in seq(1, 5, 1)) {

# code for this run and their parameter/pre-factor values
code               [i_code] = parameters$code               [i_code]
min_soil_depth_frac[i_code] = parameters$min_soil_depth_frac[i_code]
log_ksat           [i_code] = parameters$log_ksat           [i_code]           
log_recession_coef [i_code] = parameters$log_recession_coef [i_code]
stor_cap           [i_code] = parameters$stor_cap           [i_code]  
degree_day_factor  [i_code] = parameters$degree_day_factor  [i_code]

# open/read monthly discharge file 
file_name = paste(main_path, as.character(code[i_code]), "/", type_folder, "/monthly_discharge/summary.txt", sep = "")
print(file_name)
performance_table = read.table(file_name, sep=";", header = T)

# discharge model performance indicators
ns_eff  [i_code] = performance_table$ns_efficiency    [which(performance_table$river_name == river[i_river])]
ns_log  [i_code] = performance_table$ns_efficiency_log[which(performance_table$river_name == river[i_river])]
kge_2009[i_code] = performance_table$kge_2009         [which(performance_table$river_name == river[i_river])]
kge_2012[i_code] = performance_table$kge_2012         [which(performance_table$river_name == river[i_river])]
R2      [i_code] = performance_table$R2               [which(performance_table$river_name == river[i_river])]

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

# data frame for this river
table_for_this_river = data.frame(
river_number       ,
river_name         ,              
min_soil_depth_frac, 
log_ksat           , 
log_recession_coef , 
stor_cap           , 
degree_day_factor  , 
ns_eff             , 
ns_log             , 
kge_2009           , 
kge_2012           , 
R2                 , 
one_min_bfdv       
)


# plot for kge_2009

# initiate the plots 
if (i_river == 1) {
chart_for_degree_day_factor   <- ggplot() 
chart_for_min_soil_depth_frac <- ggplot() 
chart_for_log_ksat            <- ggplot()
chart_for_stor_cap            <- ggplot()
chart_for_log_recession_coef  <- ggplot()
}

chart_for_degree_day_factor   <- chart_for_degree_day_factor   + geom_point(data = table_for_this_river, aes(x = degree_day_factor,   y = river_number, size = kge_2009), shape = 21)
chart_for_min_soil_depth_frac <- chart_for_min_soil_depth_frac + geom_point(data = table_for_this_river, aes(x = min_soil_depth_frac, y = river_number, size = kge_2009), shape = 21)
chart_for_log_ksat            <- chart_for_log_ksat            + geom_point(data = table_for_this_river, aes(x = log_ksat,            y = river_number, size = kge_2009), shape = 21)
chart_for_stor_cap            <- chart_for_stor_cap            + geom_point(data = table_for_this_river, aes(x = stor_cap,            y = river_number, size = kge_2009), shape = 21)
chart_for_log_recession_coef  <- chart_for_log_recession_coef  + geom_point(data = table_for_this_river, aes(x = log_recession_coef,  y = river_number, size = kge_2009), shape = 21)

# to the last column add river name
chart_for_log_recession_coef  <- chart_for_log_recession_coef  + annotate("text", x = 1.25, y = river_number, label = river_name[1], size = 1.50)

# plot for one_min_bfdv

#~ # initiate the plots 
#~ if (i_river == 1) {
#~ chart_for_degree_day_factor   <- ggplot() 
#~ chart_for_min_soil_depth_frac <- ggplot() 
#~ chart_for_log_ksat            <- ggplot()
#~ chart_for_stor_cap            <- ggplot()
#~ chart_for_log_recession_coef  <- ggplot()
#~ }
#~ 
#~ chart_for_degree_day_factor   <- chart_for_degree_day_factor   + geom_point(data = table_for_this_river, aes(x = degree_day_factor,   y = river_number, size = kge_2009), shape = 21)
#~ chart_for_min_soil_depth_frac <- chart_for_min_soil_depth_frac + geom_point(data = table_for_this_river, aes(x = min_soil_depth_frac, y = river_number, size = kge_2009), shape = 21)
#~ chart_for_log_ksat            <- chart_for_log_ksat            + geom_point(data = table_for_this_river, aes(x = log_ksat,            y = river_number, size = kge_2009), shape = 21)
#~ chart_for_stor_cap            <- chart_for_stor_cap            + geom_point(data = table_for_this_river, aes(x = stor_cap,            y = river_number, size = kge_2009), shape = 21)
#~ chart_for_log_recession_coef  <- chart_for_log_recession_coef  + geom_point(data = table_for_this_river, aes(x = log_recession_coef,  y = river_number, size = kge_2009), shape = 21)


}

# hide y labels and set limits
chart_for_degree_day_factor   <- chart_for_degree_day_factor   + theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) + scale_size_continuous(limits = c(0.001, 1.0)) + scale_x_continuous(limits = c( 0.25, 1.75)) + ylab(NA) + scale_y_continuous(breaks = NA)
chart_for_min_soil_depth_frac <- chart_for_min_soil_depth_frac + theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) + scale_size_continuous(limits = c(0.001, 1.0)) + scale_x_continuous(limits = c( 0.25, 1.75)) + ylab(NA) + scale_y_continuous(breaks = NA)
chart_for_log_ksat            <- chart_for_log_ksat            + theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) + scale_size_continuous(limits = c(0.001, 1.0)) + scale_x_continuous(limits = c(-0.75, 0.75)) + ylab(NA) + scale_y_continuous(breaks = NA)
chart_for_stor_cap            <- chart_for_stor_cap            + theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) + scale_size_continuous(limits = c(0.001, 1.0)) + scale_x_continuous(limits = c( 0.25, 1.75)) + ylab(NA) + scale_y_continuous(breaks = NA)
chart_for_log_recession_coef  <- chart_for_log_recession_coef  + theme(axis.ticks.y = element_blank(), axis.text.y = element_blank()) + scale_size_continuous(limits = c(0.001, 1.0)) + scale_x_continuous(limits = c(-1.25, 1.25)) + ylab(NA) + scale_y_continuous(breaks = NA)

plot(chart_for_log_recession_coef)
