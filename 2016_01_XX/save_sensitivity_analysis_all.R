
# clear the memory
rm(list=ls());ls()

# packages needed:
require(ggplot2)
require(grid)

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

########################################################################################################################
# make table of average values 
average_values = data.frame()

for( i_run in 1:length(parameters$code) ) {

# scenario_code
code = as.character(parameters$code[i_run])

# open the file for global fluxes
global_flux_file_name = paste(main_path , "/", code, "/analysis_iwmi/global_annual_fluxes/table_global_annual_fluxes_km3.txt", sep = "")
print(global_flux_file_name)

# open the log_summary file
summary_table = read.table(global_flux_file_name, sep = ";", header = T)

avg_precipitation        = mean(summary_table$precipitation       )
avg_runoff               = mean(summary_table$total_runoff        )
avg_evaporation          = mean(summary_table$total_evaporation   )
avg_groundwater_recharge = mean(summary_table$gw_recharge         )
avg_baseflow             = mean(summary_table$gw_baseflow         )        

avg_total_withdrawal                            = mean(summary_table$total_withdrawal         )
avg_total_gw_abstraction                        = mean(summary_table$total_gw_abstraction     )
avg_surface_water_abstraction                   = mean(summary_table$surface_water_withdrawal )
avg_renewable_gw_abstraction                    = mean(summary_table$non_fossil_gw_abstraction)
avg_fossil_groundwater_abstraction              = mean(summary_table$fossil_gw_abstraction    ) 

# average abstraction values for the period 2000
sta_year = which(summary_table$year == 2000)
end_year = which(summary_table$year == 2000)
avg_total_withdrawal_2000                       = mean(summary_table$total_withdrawal         [sta_year:end_year])
avg_surface_water_abstraction_2000              = mean(summary_table$surface_water_withdrawal [sta_year:end_year])
avg_total_gw_abstraction_2000                   = mean(summary_table$total_gw_abstraction     [sta_year:end_year])
avg_renewable_gw_abstraction_2000               = mean(summary_table$non_fossil_gw_abstraction[sta_year:end_year])
avg_fossil_groundwater_abstraction_2000         = mean(summary_table$fossil_gw_abstraction    [sta_year:end_year]) 

# average abstraction values for the period 2000-2009
sta_year = which(summary_table$year == 2000)
end_year = which(summary_table$year == 2009)
avg_total_withdrawal_2000_to_2009               = mean(summary_table$total_withdrawal         [sta_year:end_year])
avg_surface_water_abstraction_2000_to_2009      = mean(summary_table$surface_water_withdrawal [sta_year:end_year])
avg_total_gw_abstraction_2000_to_2009           = mean(summary_table$total_gw_abstraction     [sta_year:end_year])
avg_renewable_gw_abstraction_2000_to_2009       = mean(summary_table$non_fossil_gw_abstraction[sta_year:end_year])
avg_fossil_groundwater_abstraction_2000_to_2009 = mean(summary_table$fossil_gw_abstraction    [sta_year:end_year]) 

# average abstraction values for the period 2001-2008
sta_year = which(summary_table$year == 2001)
end_year = which(summary_table$year == 2008)
avg_total_withdrawal_2001_to_2008               = mean(summary_table$total_withdrawal         [sta_year:end_year])
avg_surface_water_abstraction_2001_to_2008      = mean(summary_table$surface_water_withdrawal [sta_year:end_year])
avg_total_gw_abstraction_2001_to_2008           = mean(summary_table$total_gw_abstraction     [sta_year:end_year])
avg_renewable_gw_abstraction_2001_to_2008       = mean(summary_table$non_fossil_gw_abstraction[sta_year:end_year])
avg_fossil_groundwater_abstraction_2001_to_2008 = mean(summary_table$fossil_gw_abstraction    [sta_year:end_year]) 

# average abstraction values for the period 2010
sta_year = which(summary_table$year == 2010)
end_year = which(summary_table$year == 2010)
avg_total_withdrawal_2010                       = mean(summary_table$total_withdrawal         [sta_year:end_year])
avg_surface_water_abstraction_2010              = mean(summary_table$surface_water_withdrawal [sta_year:end_year])
avg_total_gw_abstraction_2010                   = mean(summary_table$total_gw_abstraction     [sta_year:end_year])
avg_renewable_gw_abstraction_2010               = mean(summary_table$non_fossil_gw_abstraction[sta_year:end_year])
avg_fossil_groundwater_abstraction_2010         = mean(summary_table$fossil_gw_abstraction    [sta_year:end_year]) 

station_types = c("calibration", "validation")

for (i_type in 1:length(station_types)){

station_type = as.character(station_types[i_type])
print(station_type)

# open the file for discharge performance
discharge_file_name = paste(main_path , "/", code, "/analysis_iwmi/", station_type, "/monthly_discharge/summary.txt", sep = "")
print(discharge_file_name)
discharge = read.table(discharge_file_name, sep = ";", header = T)

# set limit, ignoring bad performances  
limit = 0.0
discharge$correlation      [ which(discharge$correlation       < limit)] <- limit 
discharge$R2               [ which(discharge$R2                < limit)] <- limit 
discharge$R2_adjusted      [ which(discharge$R2_adjusted       < limit)] <- limit 
discharge$ns_efficiency    [ which(discharge$ns_efficiency     < limit)] <- limit 
discharge$ns_efficiency_log[ which(discharge$ns_efficiency_log < limit)] <- limit 
discharge$kge_2009         [ which(discharge$kge_2009          < limit)] <- limit 
discharge$kge_2012         [ which(discharge$kge_2012          < limit)] <- limit 
#~ # set NA to the limit
#~ discharge$correlation      [ is.na(discharge$correlation      )] <- limit 
#~ discharge$R2               [ is.na(discharge$R2               )] <- limit 
#~ discharge$R2_adjusted      [ is.na(discharge$R2_adjusted      )] <- limit 
#~ discharge$ns_efficiency    [ is.na(discharge$ns_efficiency    )] <- limit 
#~ discharge$ns_efficiency_log[ is.na(discharge$ns_efficiency_log)] <- limit 
#~ discharge$kge_2009         [ is.na(discharge$kge_2009         )] <- limit 
#~ discharge$kge_2012         [ is.na(discharge$kge_2012         )] <- limit 
#~ # set NaN to the limit                                               
#~ discharge$correlation      [is.nan(discharge$correlation      )] <- limit 
#~ discharge$R2               [is.nan(discharge$R2               )] <- limit 
#~ discharge$R2_adjusted      [is.nan(discharge$R2_adjusted      )] <- limit 
#~ discharge$ns_efficiency    [is.nan(discharge$ns_efficiency    )] <- limit 
#~ discharge$ns_efficiency_log[is.nan(discharge$ns_efficiency_log)] <- limit 
#~ discharge$kge_2009         [is.nan(discharge$kge_2009         )] <- limit 
#~ discharge$kge_2012         [is.nan(discharge$kge_2012         )] <- limit 

# open the file for baseflow performance
baseflow_file_name = paste(main_path , "/", code, "/analysis_iwmi/", station_type, "/annual_baseflow/baseflow_summary.txt", sep = "")
print(baseflow_file_name)
baseflow = read.table(baseflow_file_name, sep = ";", header = T)

# calculating relative baseflow deviation
baseflow_deviation_relative = abs(baseflow$avg_baseflow_deviation/baseflow$average_iwmi_opt_baseflow)
# set limit - ignoring bad performances:
limit = 2.0  
baseflow_deviation_relative[ which(baseflow_deviation_relative > limit)] <- limit
#~ # set NA and NaN to the limit
#~ baseflow_deviation_relative[ is.na(baseflow_deviation_relative)        ] <- limit
#~ baseflow_deviation_relative[is.nan(baseflow_deviation_relative)        ] <- limit

# calculate the average values of performance
avg_correlation                           =     mean(discharge$correlation      , na.rm = TRUE)
avg_R2                                    =     mean(discharge$R2               , na.rm = TRUE)
avg_R2_adjusted                           =     mean(discharge$R2_adjusted      , na.rm = TRUE)
avg_ns_efficiency                         =     mean(discharge$ns_efficiency    , na.rm = TRUE)
avg_ns_efficiency_log                     =     mean(discharge$ns_efficiency_log, na.rm = TRUE)
avg_kge_2009                              =     mean(discharge$kge_2009         , na.rm = TRUE)
avg_kge_2012                              =     mean(discharge$kge_2012         , na.rm = TRUE)
one_minus_avg_baseflow_deviation_relative = 1 - mean(baseflow_deviation_relative, na.rm = TRUE)

# calculate the average values of composite performance values
# - alternative one:
avg_correlation_per_baseflow_deviation_relative       = avg_correlation        / (1 + (mean(baseflow_deviation_relative, na.rm = TRUE))^2)
avg_R2_per_baseflow_deviation_relative                = avg_R2                 / (1 + (mean(baseflow_deviation_relative, na.rm = TRUE))^2)
avg_R2_adjusted_per_baseflow_deviation_relative       = avg_R2_adjusted        / (1 + (mean(baseflow_deviation_relative, na.rm = TRUE))^2)
avg_ns_efficiency_per_baseflow_deviation_relative     = avg_ns_efficiency      / (1 + (mean(baseflow_deviation_relative, na.rm = TRUE))^2)
avg_ns_efficiency_log_per_baseflow_deviation_relative = avg_ns_efficiency_log  / (1 + (mean(baseflow_deviation_relative, na.rm = TRUE))^2)
avg_kge_2009_per_baseflow_deviation_relative          = avg_kge_2009           / (1 + (mean(baseflow_deviation_relative, na.rm = TRUE))^2)
avg_kge_2012_per_baseflow_deviation_relative          = avg_kge_2012           / (1 + (mean(baseflow_deviation_relative, na.rm = TRUE))^2)
#~ # - alternative two
#~ # -- calculating the composite performance values for all stations:
#~ correlation_per_baseflow_deviation_relative       = discharge$correlation       / (1 + baseflow_deviation_relative)
#~ R2_per_baseflow_deviation_relative                = discharge$R2                / (1 + baseflow_deviation_relative)
#~ R2_adjusted_per_baseflow_deviation_relative       = discharge$R2_adjusted       / (1 + baseflow_deviation_relative)
#~ ns_efficiency_per_baseflow_deviation_relative     = discharge$ns_efficiency     / (1 + baseflow_deviation_relative)
#~ ns_efficiency_log_per_baseflow_deviation_relative = discharge$ns_efficiency_log / (1 + baseflow_deviation_relative)
#~ kge_2009_per_baseflow_deviation_relative          = discharge$kge_2009          / (1 + baseflow_deviation_relative)
#~ kge_2012_per_baseflow_deviation_relative          = discharge$kge_2012          / (1 + baseflow_deviation_relative)
#~ # -- then calculate their averages
#~ avg_correlation_per_baseflow_deviation_relative       = mean(correlation_per_baseflow_deviation_relative      , na.rm = TRUE) 
#~ avg_R2_per_baseflow_deviation_relative                = mean(R2_per_baseflow_deviation_relative               , na.rm = TRUE) 
#~ avg_R2_adjusted_per_baseflow_deviation_relative       = mean(R2_adjusted_per_baseflow_deviation_relative      , na.rm = TRUE) 
#~ avg_ns_efficiency_per_baseflow_deviation_relative     = mean(ns_efficiency_per_baseflow_deviation_relative    , na.rm = TRUE) 
#~ avg_ns_efficiency_log_per_baseflow_deviation_relative = mean(ns_efficiency_log_per_baseflow_deviation_relative, na.rm = TRUE) 
#~ avg_kge_2009_per_baseflow_deviation_relative          = mean(kge_2009_per_baseflow_deviation_relative         , na.rm = TRUE) 
#~ avg_kge_2012_per_baseflow_deviation_relative          = mean(kge_2012_per_baseflow_deviation_relative         , na.rm = TRUE)

# an extra composite performance
lm_slope_obs_to_model = lm(discharge$average_observation ~ 0 + discharge$average_model, na.action = na.omit)$coefficients
lm_slope_obs_to_model_per_baseflow_deviation_relative = lm_slope_obs_to_model / (1 + mean(baseflow_deviation_relative)) 

if (station_type == "calibration") {

calibration_avg_correlation                                       = avg_correlation                                      
calibration_avg_R2                                                = avg_R2                                               
calibration_avg_R2_adjusted                                       = avg_R2_adjusted                                      
calibration_avg_ns_efficiency                                     = avg_ns_efficiency                                    
calibration_avg_ns_efficiency_log                                 = avg_ns_efficiency_log                                
calibration_avg_kge_2009                                          = avg_kge_2009                                         
calibration_avg_kge_2012                                          = avg_kge_2012                                         
calibration_one_minus_avg_baseflow_deviation_relative             = one_minus_avg_baseflow_deviation_relative                                
calibration_avg_correlation_per_baseflow_deviation_relative       = avg_correlation_per_baseflow_deviation_relative      
calibration_avg_R2_per_baseflow_deviation_relative                = avg_R2_per_baseflow_deviation_relative               
calibration_avg_R2_adjusted_per_baseflow_deviation_relative       = avg_R2_adjusted_per_baseflow_deviation_relative      
calibration_avg_ns_efficiency_per_baseflow_deviation_relative     = avg_ns_efficiency_per_baseflow_deviation_relative    
calibration_avg_ns_efficiency_log_per_baseflow_deviation_relative = avg_ns_efficiency_log_per_baseflow_deviation_relative
calibration_avg_kge_2009_per_baseflow_deviation_relative          = avg_kge_2009_per_baseflow_deviation_relative         
calibration_avg_kge_2012_per_baseflow_deviation_relative          = avg_kge_2012_per_baseflow_deviation_relative         
calibration_lm_slope_obs_to_model_per_baseflow_deviation_relative = lm_slope_obs_to_model_per_baseflow_deviation_relative

} # end if (station_type == "calibration")

if (station_type == "validation") {

validation_avg_correlation                                       = avg_correlation                                      
validation_avg_R2                                                = avg_R2                                               
validation_avg_R2_adjusted                                       = avg_R2_adjusted                                      
validation_avg_ns_efficiency                                     = avg_ns_efficiency                                    
validation_avg_ns_efficiency_log                                 = avg_ns_efficiency_log                                
validation_avg_kge_2009                                          = avg_kge_2009                                         
validation_avg_kge_2012                                          = avg_kge_2012                                         
validation_one_minus_avg_baseflow_deviation_relative             = one_minus_avg_baseflow_deviation_relative                                
validation_avg_correlation_per_baseflow_deviation_relative       = avg_correlation_per_baseflow_deviation_relative      
validation_avg_R2_per_baseflow_deviation_relative                = avg_R2_per_baseflow_deviation_relative               
validation_avg_R2_adjusted_per_baseflow_deviation_relative       = avg_R2_adjusted_per_baseflow_deviation_relative      
validation_avg_ns_efficiency_per_baseflow_deviation_relative     = avg_ns_efficiency_per_baseflow_deviation_relative    
validation_avg_ns_efficiency_log_per_baseflow_deviation_relative = avg_ns_efficiency_log_per_baseflow_deviation_relative
validation_avg_kge_2009_per_baseflow_deviation_relative          = avg_kge_2009_per_baseflow_deviation_relative         
validation_avg_kge_2012_per_baseflow_deviation_relative          = avg_kge_2012_per_baseflow_deviation_relative         
validation_lm_slope_obs_to_model_per_baseflow_deviation_relative = lm_slope_obs_to_model_per_baseflow_deviation_relative

} # end if (station_type == "validation")

} # end for (i_type in 1:length(station_types))

# all average values
average_values = rbind(average_values, 
                       cbind(
                             code, 
                             avg_precipitation,
                             avg_evaporation,         
                             avg_runoff,              
                             avg_groundwater_recharge,
                             avg_baseflow,            
                             avg_total_withdrawal, 
                             avg_surface_water_abstraction,     
                             avg_total_gw_abstraction,
                             avg_renewable_gw_abstraction,      
                             avg_fossil_groundwater_abstraction,
                             avg_total_withdrawal_2000, 
                             avg_surface_water_abstraction_2000,     
                             avg_total_gw_abstraction_2000,
                             avg_renewable_gw_abstraction_2000,      
                             avg_fossil_groundwater_abstraction_2000,
                             avg_total_withdrawal_2000_to_2009, 
                             avg_surface_water_abstraction_2000_to_2009,     
                             avg_total_gw_abstraction_2000_to_2009,
                             avg_renewable_gw_abstraction_2000_to_2009,      
                             avg_fossil_groundwater_abstraction_2000_to_2009,
                             avg_total_withdrawal_2001_to_2008, 
                             avg_surface_water_abstraction_2001_to_2008,     
                             avg_total_gw_abstraction_2001_to_2008,
                             avg_renewable_gw_abstraction_2001_to_2008,      
                             avg_fossil_groundwater_abstraction_2001_to_2008,
                             avg_total_withdrawal_2010, 
                             avg_surface_water_abstraction_2010,     
                             avg_total_gw_abstraction_2010,
                             avg_renewable_gw_abstraction_2010,      
                             avg_fossil_groundwater_abstraction_2010,
                             calibration_avg_correlation,                                      
                             calibration_avg_R2,                                               
                             calibration_avg_R2_adjusted,                                      
                             calibration_one_minus_avg_baseflow_deviation_relative,                                
                             calibration_avg_ns_efficiency,                                    
                             calibration_avg_ns_efficiency_log,                                
                             calibration_avg_kge_2009,                                         
                             calibration_avg_kge_2012,                                         
                             calibration_avg_correlation_per_baseflow_deviation_relative,      
                             calibration_avg_R2_per_baseflow_deviation_relative,               
                             calibration_avg_R2_adjusted_per_baseflow_deviation_relative,      
                             calibration_lm_slope_obs_to_model_per_baseflow_deviation_relative,
                             calibration_avg_ns_efficiency_per_baseflow_deviation_relative,    
                             calibration_avg_ns_efficiency_log_per_baseflow_deviation_relative,
                             calibration_avg_kge_2009_per_baseflow_deviation_relative,         
                             calibration_avg_kge_2012_per_baseflow_deviation_relative,         
                             validation_avg_correlation,                                      
                             validation_avg_R2,                                               
                             validation_avg_R2_adjusted,                                      
                             validation_one_minus_avg_baseflow_deviation_relative,                                
                             validation_avg_ns_efficiency,                                    
                             validation_avg_ns_efficiency_log,                                
                             validation_avg_kge_2009,                                         
                             validation_avg_kge_2012,                                         
                             validation_avg_correlation_per_baseflow_deviation_relative,      
                             validation_avg_R2_per_baseflow_deviation_relative,               
                             validation_avg_R2_adjusted_per_baseflow_deviation_relative,      
                             validation_lm_slope_obs_to_model_per_baseflow_deviation_relative,
                             validation_avg_ns_efficiency_per_baseflow_deviation_relative,    
                             validation_avg_ns_efficiency_log_per_baseflow_deviation_relative,
                             validation_avg_kge_2009_per_baseflow_deviation_relative,         
                             validation_avg_kge_2012_per_baseflow_deviation_relative
                             ))

} # end for( i_run in 1:length(parameters$code) )

# names of all columns
names(average_values)[ 1] <- "code" 
names(average_values)[ 2] <- "avg_precipitation"
names(average_values)[ 3] <- "avg_evaporation"         
names(average_values)[ 4] <- "avg_runoff"              
names(average_values)[ 5] <- "avg_groundwater_recharge"
names(average_values)[ 6] <- "avg_baseflow"            
names(average_values)[ 7] <- "avg_total_withdrawal" 
names(average_values)[ 8] <- "avg_surface_water_abstraction"     
names(average_values)[ 9] <- "avg_total_gw_abstraction"
names(average_values)[10] <- "avg_renewable_gw_abstraction"      
names(average_values)[11] <- "avg_fossil_groundwater_abstraction"
names(average_values)[12] <- "avg_total_withdrawal_2000" 
names(average_values)[13] <- "avg_surface_water_abstraction_2000"     
names(average_values)[14] <- "avg_total_gw_abstraction_2000"
names(average_values)[15] <- "avg_renewable_gw_abstraction_2000"      
names(average_values)[16] <- "avg_fossil_groundwater_abstraction_2000"
names(average_values)[17] <- "avg_total_withdrawal_2000_to_2009" 
names(average_values)[18] <- "avg_surface_water_abstraction_2000_to_2009"     
names(average_values)[19] <- "avg_total_gw_abstraction_2000_to_2009"
names(average_values)[20] <- "avg_renewable_gw_abstraction_2000_to_2009"      
names(average_values)[21] <- "avg_fossil_groundwater_abstraction_2000_to_2009"
names(average_values)[22] <- "avg_total_withdrawal_2001_to_2008" 
names(average_values)[23] <- "avg_surface_water_abstraction_2001_to_2008"     
names(average_values)[24] <- "avg_total_gw_abstraction_2001_to_2008"
names(average_values)[25] <- "avg_renewable_gw_abstraction_2001_to_2008"      
names(average_values)[26] <- "avg_fossil_groundwater_abstraction_2001_to_2008"
names(average_values)[27] <- "avg_total_withdrawal_2010" 
names(average_values)[28] <- "avg_surface_water_abstraction_2010"     
names(average_values)[29] <- "avg_total_gw_abstraction_2010"        
names(average_values)[30] <- "avg_renewable_gw_abstraction_2010"      
names(average_values)[31] <- "avg_fossil_groundwater_abstraction_2010"
names(average_values)[32] <- "calibration_avg_correlation"                                      
names(average_values)[33] <- "calibration_avg_R2"                                               
names(average_values)[34] <- "calibration_avg_R2_adjusted"                                      
names(average_values)[35] <- "calibration_one_minus_avg_baseflow_deviation_relative"             
names(average_values)[36] <- "calibration_avg_ns_efficiency"                                    
names(average_values)[37] <- "calibration_avg_ns_efficiency_log"                                
names(average_values)[38] <- "calibration_avg_kge_2009"                                         
names(average_values)[39] <- "calibration_avg_kge_2012"                                         
names(average_values)[40] <- "calibration_avg_correlation_per_baseflow_deviation_relative"      
names(average_values)[41] <- "calibration_avg_R2_per_baseflow_deviation_relative"               
names(average_values)[42] <- "calibration_avg_R2_adjusted_per_baseflow_deviation_relative"      
names(average_values)[43] <- "calibration_lm_slope_obs_to_model_per_baseflow_deviation_relative"
names(average_values)[44] <- "calibration_avg_ns_efficiency_per_baseflow_deviation_relative"    
names(average_values)[45] <- "calibration_avg_ns_efficiency_log_per_baseflow_deviation_relative"       
names(average_values)[46] <- "calibration_avg_kge_2009_per_baseflow_deviation_relative"         
names(average_values)[47] <- "calibration_avg_kge_2012_per_baseflow_deviation_relative"         
names(average_values)[48] <- "validation_avg_correlation"                                      
names(average_values)[49] <- "validation_avg_R2"                                               
names(average_values)[50] <- "validation_avg_R2_adjusted"                                      
names(average_values)[51] <- "validation_one_minus_avg_baseflow_deviation_relative"              
names(average_values)[52] <- "validation_avg_ns_efficiency"                                    
names(average_values)[53] <- "validation_avg_ns_efficiency_log"                                
names(average_values)[54] <- "validation_avg_kge_2009"                                         
names(average_values)[55] <- "validation_avg_kge_2012"                                         
names(average_values)[56] <- "validation_avg_correlation_per_baseflow_deviation_relative"      
names(average_values)[57] <- "validation_avg_R2_per_baseflow_deviation_relative"               
names(average_values)[58] <- "validation_avg_R2_adjusted_per_baseflow_deviation_relative"      
names(average_values)[59] <- "validation_lm_slope_obs_to_model_per_baseflow_deviation_relative"
names(average_values)[60] <- "validation_avg_ns_efficiency_per_baseflow_deviation_relative"    
names(average_values)[61] <- "validation_avg_ns_efficiency_log_per_baseflow_deviation_relative"
names(average_values)[62] <- "validation_avg_kge_2009_per_baseflow_deviation_relative"         
names(average_values)[63] <- "validation_avg_kge_2012_per_baseflow_deviation_relative"


# make sure formats are correct
average_values[,1] <- as.character(average_values[,1])
average_values[,2:ncol(average_values)] <- lapply(average_values[,2:ncol(average_values)], as.character)
average_values[,2:ncol(average_values)] <- lapply(average_values[,2:ncol(average_values)], as.numeric)
########################################################################################################################

# merge two data frames
complete_table = merge(parameters, average_values, by = "code")

# function to make scatter plots
sensitivity_scatter_plot_per_row <- function(data_frame, selected_column_name, selected_objective_function, y_axis_title = NA) {

# options for the scatter plots
axis_text_size   =  6
axis_title_size  =  6.5
axis_title_vjust =  0 
axis_title_face  = "bold"

# list of variables/parameters that will be plotted
x_axis_variable_list = list("min_soil_depth_frac", "log_ksat"      , "log_recession_coef", "degree_day_factor")
x_axis_label_list    = list("pre-factor f_W"     , "pre-factor f_K", "pre-factor f_J"    , "pre-factor f_D"   )

# column index 
col_index = which(names(data_frame) == selected_column_name)

# reference value
assign("reference", data_frame[which(data_frame$code == "code__a__0"), col_index], envir = .GlobalEnv)

# sorting the data based
col_index_for_objective_function = which(names(data_frame) == selected_objective_function) 
data_frame = data_frame[order(-data_frame[,col_index_for_objective_function]),]

# selecting the data (only using the best 20% runs)
index_for_the_last_chosen_run = as.integer(round(0.20 * length(complete_table$code)))
data_frame_select = data_frame[1:index_for_the_last_chosen_run,]
assign("data_frame_select", data_frame_select, envir = .GlobalEnv)

# average and standard deviation values from the selected runs:
assign("average", mean(data_frame_select[, col_index]), envir = .GlobalEnv)
assign("std_dev",   sd(data_frame_select[, col_index]), envir = .GlobalEnv)

for (i_x_axis in 1:4) {

print(i_x_axis)
x_axis_variable = x_axis_variable_list[i_x_axis]
x_axis_label    = as.character(x_axis_label_list[i_x_axis])
print(x_axis_label)

chart <- ggplot()
chart <- chart + annotate("rect", xmin = -Inf, xmax = Inf, ymin = average - 1.96*std_dev, ymax = average + 1.96*std_dev, fill = "yellow", alpha = 0.30)  # z_score for 95% confidence interval = 1.96
chart <- chart + geom_point(data = data_frame,        aes_string(x = x_axis_variable, y = selected_column_name), solid = FALSE )
chart <- chart + geom_hline(aes(yintercept = reference), colour = "black", linetype = 2)
chart <- chart + geom_hline(aes(yintercept = average  ), colour = "black")
chart <- chart + geom_hline(aes(yintercept = average - std_dev), colour = "blue")
chart <- chart + geom_hline(aes(yintercept = average + std_dev), colour = "blue")
chart <- chart + theme(axis.text = element_text(size = axis_text_size), axis.title = element_text(size = axis_title_size, vjust = axis_title_vjust, face = axis_title_face))
chart <- chart + geom_point(data = data_frame_select, aes_string(x = x_axis_variable, y = selected_column_name), colour = "red")
chart <- chart + xlab(x_axis_label)
if (!is.na(y_axis_title)) {
chart <- chart + ylab(y_axis_title)
}

assign(paste("chart", as.character(i_x_axis), sep = "_"), chart)

if (i_x_axis == 1) {charts_in_ggplotGrob = cbind(ggplotGrob(chart), size = "last")} else {charts_in_ggplotGrob = cbind(charts_in_ggplotGrob, ggplotGrob(chart), size = "last")}

}

return(charts_in_ggplotGrob)

}

# plots for global performance at calibration stations
charts_calibration_avg_kge_2009_per_baseflow_deviation_relative  = sensitivity_scatter_plot_per_row(complete_table, "calibration_avg_kge_2009_per_baseflow_deviation_relative"     , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "KGE_BF_avg")
charts_calibration_avg_kge_2009                                  = sensitivity_scatter_plot_per_row(complete_table, "calibration_avg_kge_2009"                                     , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "KGE_avg"   )
charts_calibration_one_minus_avg_baseflow_deviation_relative     = sensitivity_scatter_plot_per_row(complete_table, "calibration_one_minus_avg_baseflow_deviation_relative"        , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "1 - BF_avg")
# - plotting to a table
chart_table = rbind(
                    charts_calibration_avg_kge_2009_per_baseflow_deviation_relative,
                    charts_calibration_avg_kge_2009                                ,
                    charts_calibration_one_minus_avg_baseflow_deviation_relative   ,
                    size = "last")
# - writing to a pdf file
chart_file_name = paste("", "global_calibration_performance.pdf",sep ="")
pdf(file = chart_file_name, width = 6, height = 1.75*3)  # units are in inches
grid.newpage()
grid.draw(chart_table)
dev.off()

# plots for global performance at validation stations
charts_validation_avg_kge_2009_per_baseflow_deviation_relative  = sensitivity_scatter_plot_per_row(complete_table, "validation_avg_kge_2009_per_baseflow_deviation_relative"     , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "KGE_BF_avg")
charts_validation_avg_kge_2009                                  = sensitivity_scatter_plot_per_row(complete_table, "validation_avg_kge_2009"                                     , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "KGE_avg"   )
charts_validation_one_minus_avg_baseflow_deviation_relative     = sensitivity_scatter_plot_per_row(complete_table, "validation_one_minus_avg_baseflow_deviation_relative"        , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "1 - BF_avg")
# - plotting to a table
chart_table = rbind(
                    charts_validation_avg_kge_2009_per_baseflow_deviation_relative,
                    charts_validation_avg_kge_2009                                ,
                    charts_validation_one_minus_avg_baseflow_deviation_relative   ,
                    size = "last")
# - writing to a pdf file
chart_file_name = paste("", "global_validation_performance.pdf",sep ="")
pdf(file = chart_file_name, width = 6, height = 1.75*3)  # units are in inches
grid.newpage()
grid.draw(chart_table)
dev.off()

# plots for global water fluxes
charts_avg_precipitation        = sensitivity_scatter_plot_per_row(complete_table, "avg_precipitation"       , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "precipitation (km3/yr)")
charts_avg_evaporation          = sensitivity_scatter_plot_per_row(complete_table, "avg_evaporation"         , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "evaporation (km3/yr)"  )
charts_avg_runoff               = sensitivity_scatter_plot_per_row(complete_table, "avg_runoff"              , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "runoff (km3/yr)"       )
charts_avg_groundwater_recharge = sensitivity_scatter_plot_per_row(complete_table, "avg_groundwater_recharge", "calibration_avg_kge_2009_per_baseflow_deviation_relative", "gw recharge (km3/yr)"  )
charts_avg_baseflow             = sensitivity_scatter_plot_per_row(complete_table, "avg_baseflow"            , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "gw baseflow (km3/yr)" )
# - plotting to a table
chart_table = rbind(charts_avg_precipitation,
                    charts_avg_evaporation,         
                    charts_avg_runoff,              
                    charts_avg_groundwater_recharge, 
                    charts_avg_baseflow,            
                    size = "last")
# - writing to a pdf file
chart_file_name = paste("", "global_water_fluxes.pdf",sep ="")
pdf(file = chart_file_name, width = 6, height = 1.75*5)  # units are in inches
grid.newpage()
grid.draw(chart_table)
dev.off()

# plots for water withdrawal
charts_avg_total_withdrawal_2001_to_2008                = sensitivity_scatter_plot_per_row(complete_table, "avg_total_withdrawal_2001_to_2008"              , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "total withdrawal (km3/yr)")
charts_avg_surface_water_abstraction_2001_to_2008       = sensitivity_scatter_plot_per_row(complete_table, "avg_surface_water_abstraction_2001_to_2008"     , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "surface water withdrawal (km3/yr)")
charts_avg_total_gw_abstraction_2001_to_2008            = sensitivity_scatter_plot_per_row(complete_table, "avg_total_gw_abstraction_2001_to_2008"          , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "total gw withdrawal (km3/yr)")
charts_avg_renewable_gw_abstraction_2001_to_2008        = sensitivity_scatter_plot_per_row(complete_table, "avg_renewable_gw_abstraction_2001_to_2008"      , "calibration_avg_kge_2009_per_baseflow_deviation_relative", "non-fossil gw withdrawal (km3/yr)")
charts_avg_fossil_groundwater_abstraction_2001_to_2008  = sensitivity_scatter_plot_per_row(complete_table, "avg_fossil_groundwater_abstraction_2001_to_2008", "calibration_avg_kge_2009_per_baseflow_deviation_relative", "fossil gw withdrawal (km3/yr)")
# - plotting to a table
chart_table = rbind(charts_avg_total_withdrawal_2001_to_2008,               
                    charts_avg_surface_water_abstraction_2001_to_2008,      
                    charts_avg_total_gw_abstraction_2001_to_2008,
                    charts_avg_renewable_gw_abstraction_2001_to_2008,       
                    charts_avg_fossil_groundwater_abstraction_2001_to_2008, 
                    size = "last")
# - writing to a pdf file
chart_file_name = paste("", "global_water_withdrawal.pdf",sep ="")
pdf(file = chart_file_name, width = 6, height = 1.75*5)  # units are in inches
grid.newpage()
grid.draw(chart_table)
dev.off()

