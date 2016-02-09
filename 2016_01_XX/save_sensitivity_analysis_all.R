
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

avg_runoff               = mean(summary_table$total_runoff        )
avg_evaporation          = mean(summary_table$total_evaporation   )
avg_groundwater_recharge = mean(summary_table$gw_recharge         )
avg_baseflow             = mean(summary_table$gw_baseflow         )        

avg_total_withdrawal               = mean(summary_table$total_withdrawal     )
avg_surface_water_abstraction      = mean(summary_table$surface_water_withdrawal )
avg_renewable_gw_abstraction       = mean(summary_table$non_fossil_gw_abstraction)
avg_fossil_groundwater_abstraction = mean(summary_table$fossil_gw_abstraction    ) 

# average abstraction values for the period 2000
sta_year = which(summary_table$year == 2000)
end_year = which(summary_table$year == 2000)
avg_total_withdrawal_2000               = mean(summary_table$total_withdrawal     [sta_year:end_year])
avg_surface_water_abstraction_2000      = mean(summary_table$surface_water_withdrawal [sta_year:end_year])
avg_renewable_gw_abstraction_2000       = mean(summary_table$non_fossil_gw_abstraction[sta_year:end_year])
avg_fossil_groundwater_abstraction_2000 = mean(summary_table$fossil_gw_abstraction    [sta_year:end_year]) 

# average abstraction values for the period 2000-2009
sta_year = which(summary_table$year == 2000)
end_year = which(summary_table$year == 2009)
avg_total_withdrawal_2000_to_2009               = mean(summary_table$total_withdrawal     [sta_year:end_year])
avg_surface_water_abstraction_2000_to_2009      = mean(summary_table$surface_water_withdrawal [sta_year:end_year])
avg_renewable_gw_abstraction_2000_to_2009       = mean(summary_table$non_fossil_gw_abstraction[sta_year:end_year])
avg_fossil_groundwater_abstraction_2000_to_2009 = mean(summary_table$fossil_gw_abstraction    [sta_year:end_year]) 

# average abstraction values for the period 2001-2008
sta_year = which(summary_table$year == 2001)
end_year = which(summary_table$year == 2008)
avg_total_withdrawal_2001_to_2008               = mean(summary_table$total_withdrawal     [sta_year:end_year])
avg_surface_water_abstraction_2001_to_2008      = mean(summary_table$surface_water_withdrawal [sta_year:end_year])
avg_renewable_gw_abstraction_2001_to_2008       = mean(summary_table$non_fossil_gw_abstraction[sta_year:end_year])
avg_fossil_groundwater_abstraction_2001_to_2008 = mean(summary_table$fossil_gw_abstraction    [sta_year:end_year]) 

# average abstraction values for the period 2010
sta_year = which(summary_table$year == 2010)
end_year = which(summary_table$year == 2010)
avg_total_withdrawal_2010               = mean(summary_table$total_withdrawal     [sta_year:end_year])
avg_surface_water_abstraction_2010      = mean(summary_table$surface_water_withdrawal [sta_year:end_year])
avg_renewable_gw_abstraction_2010       = mean(summary_table$non_fossil_gw_abstraction[sta_year:end_year])
avg_fossil_groundwater_abstraction_2010 = mean(summary_table$fossil_gw_abstraction    [sta_year:end_year]) 

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
# set NA to the limit
discharge$correlation      [ is.na(discharge$correlation      )] <- limit 
discharge$R2               [ is.na(discharge$R2               )] <- limit 
discharge$R2_adjusted      [ is.na(discharge$R2_adjusted      )] <- limit 
discharge$ns_efficiency    [ is.na(discharge$ns_efficiency    )] <- limit 
discharge$ns_efficiency_log[ is.na(discharge$ns_efficiency_log)] <- limit 
discharge$kge_2009         [ is.na(discharge$kge_2009         )] <- limit 
discharge$kge_2012         [ is.na(discharge$kge_2012         )] <- limit 
# set NaN to the limit                                               
discharge$correlation      [is.nan(discharge$correlation      )] <- limit 
discharge$R2               [is.nan(discharge$R2               )] <- limit 
discharge$R2_adjusted      [is.nan(discharge$R2_adjusted      )] <- limit 
discharge$ns_efficiency    [is.nan(discharge$ns_efficiency    )] <- limit 
discharge$ns_efficiency_log[is.nan(discharge$ns_efficiency_log)] <- limit 
discharge$kge_2009         [is.nan(discharge$kge_2009         )] <- limit 
discharge$kge_2012         [is.nan(discharge$kge_2012         )] <- limit 

# open the file for baseflow performance
baseflow_file_name = paste(main_path , "/", code, "/analysis_iwmi/", station_type, "/annual_baseflow/baseflow_summary.txt", sep = "")
print(baseflow_file_name)
baseflow = read.table(baseflow_file_name, sep = ";", header = T)

# calculating relative baseflow deviation
baseflow_deviation_relative = abs(baseflow$avg_baseflow_deviation/baseflow$average_iwmi_opt_baseflow)
# set limit - ignoring bad performances:
limit = 1.0  
baseflow_deviation_relative[ which(baseflow_deviation_relative > limit)] <- limit
# set NA and NaN to the limit
baseflow_deviation_relative[ is.na(baseflow_deviation_relative)        ] <- limit
baseflow_deviation_relative[is.nan(baseflow_deviation_relative)        ] <- limit

# calculating the composite performance values for all stations:
correlation_per_baseflow_deviation_relative       = discharge$correlation       / (1 + baseflow_deviation_relative)
R2_per_baseflow_deviation_relative                = discharge$R2                / (1 + baseflow_deviation_relative)
R2_adjusted_per_baseflow_deviation_relative       = discharge$R2_adjusted       / (1 + baseflow_deviation_relative)
ns_efficiency_per_baseflow_deviation_relative     = discharge$ns_efficiency     / (1 + baseflow_deviation_relative)
ns_efficiency_log_per_baseflow_deviation_relative = discharge$ns_efficiency_log / (1 + baseflow_deviation_relative)
kge_2009_per_baseflow_deviation_relative          = discharge$kge_2009          / (1 + baseflow_deviation_relative)
kge_2012_per_baseflow_deviation_relative          = discharge$kge_2012          / (1 + baseflow_deviation_relative)

# calculate the average values of performance
avg_correlation                           = mean(discharge$correlation      )
avg_R2                                    = mean(discharge$R2               )
avg_R2_adjusted                           = mean(discharge$R2_adjusted      )
avg_ns_efficiency                         = mean(discharge$ns_efficiency    )
avg_ns_efficiency_log                     = mean(discharge$ns_efficiency_log)
avg_kge_2009                              = mean(discharge$kge_2009         )
avg_kge_2012                              = mean(discharge$kge_2012         )
one_minus_avg_baseflow_deviation_relative = 1 - mean(baseflow_deviation_relative)

# calculate the average values of composite performance values
avg_correlation_per_baseflow_deviation_relative       = mean(correlation_per_baseflow_deviation_relative      ) 
avg_R2_per_baseflow_deviation_relative                = mean(R2_per_baseflow_deviation_relative               ) 
avg_R2_adjusted_per_baseflow_deviation_relative       = mean(R2_adjusted_per_baseflow_deviation_relative      ) 
avg_ns_efficiency_per_baseflow_deviation_relative     = mean(ns_efficiency_per_baseflow_deviation_relative    ) 
avg_ns_efficiency_log_per_baseflow_deviation_relative = mean(ns_efficiency_log_per_baseflow_deviation_relative) 
avg_kge_2009_per_baseflow_deviation_relative          = mean(kge_2009_per_baseflow_deviation_relative         ) 
avg_kge_2012_per_baseflow_deviation_relative          = mean(kge_2012_per_baseflow_deviation_relative         )

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
                       cbind(code, 

                             avg_evaporation,         
                             avg_runoff,              
                             avg_baseflow,            
                             avg_groundwater_recharge,

                             avg_total_withdrawal, 
                             avg_surface_water_abstraction,     
                             avg_renewable_gw_abstraction,      
                             avg_fossil_groundwater_abstraction,

                             avg_total_withdrawal_2000, 
                             avg_surface_water_abstraction_2000,     
                             avg_renewable_gw_abstraction_2000,      
                             avg_fossil_groundwater_abstraction_2000,

                             avg_total_withdrawal_2000_to_2009, 
                             avg_surface_water_abstraction_2000_to_2009,     
                             avg_renewable_gw_abstraction_2000_to_2009,      
                             avg_fossil_groundwater_abstraction_2000_to_2009,

                             avg_total_withdrawal_2001_to_2008, 
                             avg_surface_water_abstraction_2001_to_2008,     
                             avg_renewable_gw_abstraction_2001_to_2008,      
                             avg_fossil_groundwater_abstraction_2001_to_2008,

                             avg_total_withdrawal_2010, 
                             avg_surface_water_abstraction_2010,     
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
}




# names of all columns
names(average_values)[ 1] <- "code"         

names(average_values)[ 2] <- "avg_evaporation"         
names(average_values)[ 3] <- "avg_runoff"              
names(average_values)[ 4] <- "avg_baseflow"            
names(average_values)[ 5] <- "avg_groundwater_recharge"

names(average_values)[ 6] <- "avg_total_withdrawal" 
names(average_values)[ 7] <- "avg_surface_water_abstraction"     
names(average_values)[ 8] <- "avg_renewable_gw_abstraction"      
names(average_values)[ 9] <- "avg_fossil_groundwater_abstraction"

names(average_values)[10] <- "avg_total_withdrawal_2000" 
names(average_values)[11] <- "avg_surface_water_abstraction_2000"     
names(average_values)[12] <- "avg_renewable_gw_abstraction_2000"      
names(average_values)[13] <- "avg_fossil_groundwater_abstraction_2000"

names(average_values)[14] <- "avg_total_withdrawal_2000_to_2009" 
names(average_values)[15] <- "avg_surface_water_abstraction_2000_to_2009"     
names(average_values)[16] <- "avg_renewable_gw_abstraction_2000_to_2009"      
names(average_values)[17] <- "avg_fossil_groundwater_abstraction_2000_to_2009"

names(average_values)[18] <- "avg_total_withdrawal_2001_to_2008" 
names(average_values)[19] <- "avg_surface_water_abstraction_2001_to_2008"     
names(average_values)[20] <- "avg_renewable_gw_abstraction_2001_to_2008"      
names(average_values)[21] <- "avg_fossil_groundwater_abstraction_2001_to_2008"

names(average_values)[22] <- "avg_total_withdrawal_2010" 
names(average_values)[23] <- "avg_surface_water_abstraction_2010"     
names(average_values)[24] <- "avg_renewable_gw_abstraction_2010"      
names(average_values)[25] <- "avg_fossil_groundwater_abstraction_2010"

names(average_values)[26] <- "calibration_avg_correlation"                                      
names(average_values)[27] <- "calibration_avg_R2"                                               
names(average_values)[28] <- "calibration_avg_R2_adjusted"                                      
names(average_values)[29] <- "calibration_one_minus_avg_baseflow_deviation_relative"                                

names(average_values)[30] <- "calibration_avg_ns_efficiency"                                    
names(average_values)[31] <- "calibration_avg_ns_efficiency_log"                                
names(average_values)[32] <- "calibration_avg_kge_2009"                                         
names(average_values)[33] <- "calibration_avg_kge_2012"                                         

names(average_values)[34] <- "calibration_avg_correlation_per_baseflow_deviation_relative"      
names(average_values)[35] <- "calibration_avg_R2_per_baseflow_deviation_relative"               
names(average_values)[36] <- "calibration_avg_R2_adjusted_per_baseflow_deviation_relative"      
names(average_values)[37] <- "calibration_lm_slope_obs_to_model_per_baseflow_deviation_relative"

names(average_values)[38] <- "calibration_avg_ns_efficiency_per_baseflow_deviation_relative"    
names(average_values)[39] <- "calibration_avg_ns_efficiency_log_per_baseflow_deviation_relative"
names(average_values)[40] <- "calibration_avg_kge_2009_per_baseflow_deviation_relative"         
names(average_values)[41] <- "calibration_avg_kge_2012_per_baseflow_deviation_relative"         

names(average_values)[42] <- "validation_avg_correlation"                                      
names(average_values)[43] <- "validation_avg_R2"                                               
names(average_values)[44] <- "validation_avg_R2_adjusted"                                      
names(average_values)[45] <- "validation_one_minus_avg_baseflow_deviation_relative"                                

names(average_values)[46] <- "validation_avg_ns_efficiency"                                    
names(average_values)[47] <- "validation_avg_ns_efficiency_log"                                
names(average_values)[48] <- "validation_avg_kge_2009"                                         
names(average_values)[49] <- "validation_avg_kge_2012"                                         

names(average_values)[50] <- "validation_avg_correlation_per_baseflow_deviation_relative"      
names(average_values)[51] <- "validation_avg_R2_per_baseflow_deviation_relative"               
names(average_values)[52] <- "validation_avg_R2_adjusted_per_baseflow_deviation_relative"      
names(average_values)[53] <- "validation_lm_slope_obs_to_model_per_baseflow_deviation_relative"

names(average_values)[54] <- "validation_avg_ns_efficiency_per_baseflow_deviation_relative"    
names(average_values)[55] <- "validation_avg_ns_efficiency_log_per_baseflow_deviation_relative"
names(average_values)[56] <- "validation_avg_kge_2009_per_baseflow_deviation_relative"         
names(average_values)[57] <- "validation_avg_kge_2012_per_baseflow_deviation_relative"

# make sure formats are correct
average_values[,1] <- as.character(average_values[,1])
average_values[,2:ncol(average_values)] <- lapply(average_values[,2:ncol(average_values)], as.character)
average_values[,2:ncol(average_values)] <- lapply(average_values[,2:ncol(average_values)], as.numeric)
########################################################################################################################

# merge two data frames
complete_table = merge(parameters, average_values, by = "code")

# sorting the data
complete_table = complete_table[order(-complete_table$calibration_avg_kge_2009_per_baseflow_deviation_relative), ]

# performance values for the reference run
avg_evaporation_ref                                                     = complete_table$avg_evaporation                                                  [which(complete_table$code == "code__a__0")] 
avg_runoff_ref                                                          = complete_table$avg_runoff                                                       [which(complete_table$code == "code__a__0")]
avg_baseflow_ref                                                        = complete_table$avg_baseflow                                                     [which(complete_table$code == "code__a__0")]
avg_groundwater_recharge_ref                                            = complete_table$avg_groundwater_recharge                                         [which(complete_table$code == "code__a__0")]
avg_total_withdrawal_ref                                                = complete_table$avg_total_withdrawal                                             [which(complete_table$code == "code__a__0")]
avg_surface_water_abstraction_ref                                       = complete_table$avg_surface_water_abstraction                                    [which(complete_table$code == "code__a__0")]
avg_renewable_gw_abstraction_ref                                        = complete_table$avg_renewable_gw_abstraction                                     [which(complete_table$code == "code__a__0")]
avg_fossil_groundwater_abstraction_ref                                  = complete_table$avg_fossil_groundwater_abstraction                               [which(complete_table$code == "code__a__0")]
avg_total_withdrawal_2000_ref                                           = complete_table$avg_total_withdrawal_2000                                        [which(complete_table$code == "code__a__0")]
avg_surface_water_abstraction_2000_ref                                  = complete_table$avg_surface_water_abstraction_2000                               [which(complete_table$code == "code__a__0")]
avg_renewable_gw_abstraction_2000_ref                                   = complete_table$avg_renewable_gw_abstraction_2000                                [which(complete_table$code == "code__a__0")]
avg_fossil_groundwater_abstraction_2000_ref                             = complete_table$avg_fossil_groundwater_abstraction_2000                          [which(complete_table$code == "code__a__0")]
avg_total_withdrawal_2000_to_2009_ref                                   = complete_table$avg_total_withdrawal_2000_to_2009                                [which(complete_table$code == "code__a__0")]
avg_surface_water_abstraction_2000_to_2009_ref                          = complete_table$avg_surface_water_abstraction_2000_to_2009                       [which(complete_table$code == "code__a__0")]
avg_renewable_gw_abstraction_2000_to_2009_ref                           = complete_table$avg_renewable_gw_abstraction_2000_to_2009                        [which(complete_table$code == "code__a__0")]
avg_fossil_groundwater_abstraction_2000_to_2009_ref                     = complete_table$avg_fossil_groundwater_abstraction_2000_to_2009                  [which(complete_table$code == "code__a__0")]
avg_total_withdrawal_2001_to_2008_ref                                   = complete_table$avg_total_withdrawal_2001_to_2008                                [which(complete_table$code == "code__a__0")]
avg_surface_water_abstraction_2001_to_2008_ref                          = complete_table$avg_surface_water_abstraction_2001_to_2008                       [which(complete_table$code == "code__a__0")]
avg_renewable_gw_abstraction_2001_to_2008_ref                           = complete_table$avg_renewable_gw_abstraction_2001_to_2008                        [which(complete_table$code == "code__a__0")]
avg_fossil_groundwater_abstraction_2001_to_2008_ref                     = complete_table$avg_fossil_groundwater_abstraction_2001_to_2008                  [which(complete_table$code == "code__a__0")]
avg_total_withdrawal_2010_ref                                           = complete_table$avg_total_withdrawal_2010                                        [which(complete_table$code == "code__a__0")]
avg_surface_water_abstraction_2010_ref                                  = complete_table$avg_surface_water_abstraction_2010                               [which(complete_table$code == "code__a__0")]
avg_renewable_gw_abstraction_2010_ref                                   = complete_table$avg_renewable_gw_abstraction_2010                                [which(complete_table$code == "code__a__0")]
avg_fossil_groundwater_abstraction_2010_ref                             = complete_table$avg_fossil_groundwater_abstraction_2010                          [which(complete_table$code == "code__a__0")]
calibration_avg_correlation_ref                                         = complete_table$calibration_avg_correlation                                      [which(complete_table$code == "code__a__0")]
calibration_avg_R2_ref                                                  = complete_table$calibration_avg_R2                                               [which(complete_table$code == "code__a__0")]
calibration_avg_R2_adjusted_ref                                         = complete_table$calibration_avg_R2_adjusted                                      [which(complete_table$code == "code__a__0")]
calibration_one_minus_avg_baseflow_deviation_relative_ref               = complete_table$calibration_one_minus_avg_baseflow_deviation_relative            [which(complete_table$code == "code__a__0")]
calibration_avg_ns_efficiency_ref                                       = complete_table$calibration_avg_ns_efficiency                                    [which(complete_table$code == "code__a__0")]
calibration_avg_ns_efficiency_log_ref                                   = complete_table$calibration_avg_ns_efficiency_log                                [which(complete_table$code == "code__a__0")]
calibration_avg_kge_2009_ref                                            = complete_table$calibration_avg_kge_2009                                         [which(complete_table$code == "code__a__0")]
calibration_avg_kge_2012_ref                                            = complete_table$calibration_avg_kge_2012                                         [which(complete_table$code == "code__a__0")]
calibration_avg_correlation_per_baseflow_deviation_relative_ref         = complete_table$calibration_avg_correlation_per_baseflow_deviation_relative      [which(complete_table$code == "code__a__0")]
calibration_avg_R2_per_baseflow_deviation_relative_ref                  = complete_table$calibration_avg_R2_per_baseflow_deviation_relative               [which(complete_table$code == "code__a__0")]  
calibration_avg_R2_adjusted_per_baseflow_deviation_relative_ref         = complete_table$calibration_avg_R2_adjusted_per_baseflow_deviation_relative      [which(complete_table$code == "code__a__0")]
calibration_lm_slope_obs_to_model_per_baseflow_deviation_relative_ref   = complete_table$calibration_lm_slope_obs_to_model_per_baseflow_deviation_relative[which(complete_table$code == "code__a__0")]
calibration_avg_ns_efficiency_per_baseflow_deviation_relative_ref       = complete_table$calibration_avg_ns_efficiency_per_baseflow_deviation_relative    [which(complete_table$code == "code__a__0")]
calibration_avg_ns_efficiency_log_per_baseflow_deviation_relative_ref   = complete_table$calibration_avg_ns_efficiency_log_per_baseflow_deviation_relative[which(complete_table$code == "code__a__0")]
calibration_avg_kge_2009_per_baseflow_deviation_relative_ref            = complete_table$calibration_avg_kge_2009_per_baseflow_deviation_relative         [which(complete_table$code == "code__a__0")]
calibration_avg_kge_2012_per_baseflow_deviation_relative_ref            = complete_table$calibration_avg_kge_2012_per_baseflow_deviation_relative         [which(complete_table$code == "code__a__0")]
validation_avg_correlation_ref                                          = complete_table$validation_avg_correlation                                       [which(complete_table$code == "code__a__0")]
validation_avg_R2_ref                                                   = complete_table$validation_avg_R2                                                [which(complete_table$code == "code__a__0")]
validation_avg_R2_adjusted_ref                                          = complete_table$validation_avg_R2_adjusted                                       [which(complete_table$code == "code__a__0")]
validation_one_minus_avg_baseflow_deviation_relative_ref                = complete_table$validation_one_minus_avg_baseflow_deviation_relative             [which(complete_table$code == "code__a__0")]
validation_avg_ns_efficiency_ref                                        = complete_table$validation_avg_ns_efficiency                                     [which(complete_table$code == "code__a__0")]
validation_avg_ns_efficiency_log_ref                                    = complete_table$validation_avg_ns_efficiency_log                                 [which(complete_table$code == "code__a__0")]
validation_avg_kge_2009_ref                                             = complete_table$validation_avg_kge_2009                                          [which(complete_table$code == "code__a__0")]
validation_avg_kge_2012_ref                                             = complete_table$validation_avg_kge_2012                                          [which(complete_table$code == "code__a__0")]
validation_avg_correlation_per_baseflow_deviation_relative_ref          = complete_table$validation_avg_correlation_per_baseflow_deviation_relative       [which(complete_table$code == "code__a__0")]
validation_avg_R2_per_baseflow_deviation_relative_ref                   = complete_table$validation_avg_R2_per_baseflow_deviation_relative                [which(complete_table$code == "code__a__0")]
validation_avg_R2_adjusted_per_baseflow_deviation_relative_ref          = complete_table$validation_avg_R2_adjusted_per_baseflow_deviation_relative       [which(complete_table$code == "code__a__0")]
validation_lm_slope_obs_to_model_per_baseflow_deviation_relative_ref    = complete_table$validation_lm_slope_obs_to_model_per_baseflow_deviation_relative [which(complete_table$code == "code__a__0")]
validation_avg_ns_efficiency_per_baseflow_deviation_relative_ref        = complete_table$validation_avg_ns_efficiency_per_baseflow_deviation_relative     [which(complete_table$code == "code__a__0")]
validation_avg_ns_efficiency_log_per_baseflow_deviation_relative_ref    = complete_table$validation_avg_ns_efficiency_log_per_baseflow_deviation_relative [which(complete_table$code == "code__a__0")]  
validation_avg_kge_2009_per_baseflow_deviation_relative_ref             = complete_table$validation_avg_kge_2009_per_baseflow_deviation_relative          [which(complete_table$code == "code__a__0")]
validation_avg_kge_2012_per_baseflow_deviation_relative_ref             = complete_table$validation_avg_kge_2012_per_baseflow_deviation_relative          [which(complete_table$code == "code__a__0")]
                                                                                         


#~ ggplot(data = complete_table, aes(x = log_ksat, y = calibration_avg_kge_2009_per_baseflow_deviation_relative)) + geom_point() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold")) +
#~                         geom_hline(aes(yintercept = calibration_avg_kge_2009_per_baseflow_deviation_relative_ref))
                                                                                         
                                                                                         
#~ 
#~ ########################################################################################################################
#~ # make scatter plots
#~ pdf("scatter_plot.pdf", width=10, height=12, bg = "white")
#~ par(mfrow=c(4,5), mar=c(4,4,2,4))
#~ 
#~ plot(table$min_soil_depth_frac, table$avg_evaporation)
#~ abline(h = evaporation_ref)
#~ plot(table$log_ksat           , table$avg_evaporation)
#~ abline(h = evaporation_ref)
#~ plot(table$log_recession_coef , table$avg_evaporation)
#~ abline(h = evaporation_ref)
#~ plot(table$stor_cap           , table$avg_evaporation)
#~ abline(h = evaporation_ref)
#~ plot(table$degree_day_factor  , table$avg_evaporation)
#~ abline(h = evaporation_ref)
#~ 
#~ plot(table$min_soil_depth_frac, table$avg_runoff)
#~ abline(h = runoff_ref)
#~ plot(table$log_ksat           , table$avg_runoff)
#~ abline(h = runoff_ref)
#~ plot(table$log_recession_coef , table$avg_runoff)
#~ abline(h = runoff_ref)
#~ plot(table$stor_cap           , table$avg_runoff)
#~ abline(h = runoff_ref)
#~ plot(table$degree_day_factor  , table$avg_runoff)
#~ abline(h = runoff_ref)
#~ 
#~ plot(table$min_soil_depth_frac, table$avg_baseflow)
#~ abline(h = baseflow_ref)
#~ plot(table$log_ksat           , table$avg_baseflow)
#~ abline(h = baseflow_ref)
#~ plot(table$log_recession_coef , table$avg_baseflow)
#~ abline(h = baseflow_ref)
#~ plot(table$stor_cap           , table$avg_baseflow)
#~ abline(h = baseflow_ref)
#~ plot(table$degree_day_factor  , table$avg_baseflow)
#~ abline(h = baseflow_ref)
#~ 
#~ plot(table$min_soil_depth_frac, table$avg_groundwater_recharge)
#~ abline(h = recharge_ref)
#~ plot(table$log_ksat           , table$avg_groundwater_recharge)
#~ abline(h = recharge_ref)
#~ plot(table$log_recession_coef , table$avg_groundwater_recharge)
#~ abline(h = recharge_ref)
#~ plot(table$stor_cap           , table$avg_groundwater_recharge)
#~ abline(h = recharge_ref)
#~ plot(table$degree_day_factor  , table$avg_groundwater_recharge)
#~ abline(h = recharge_ref)
#~ 
#~ dev.off()
#~ ########################################################################################################################

