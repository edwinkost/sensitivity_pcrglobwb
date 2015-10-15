
# main path
main_path = "~/github/edwinkost/sensitivity_pcrglobwb/2015_10_XX/summary_0to674/summary_"


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
table = merge(parameters, average_values, by = "code")

# value for the reference run
evaporation_ref = table$avg_evaporation[which(table$code == "code__a__0")]
runoff_ref      = table$avg_runoff[which(table$code == "code__a__0")]
baseflow_ref    = table$avg_baseflow[which(table$code == "code__a__0")]
recharge_ref    = table$avg_groundwater_recharge[which(table$code == "code__a__0")]

########################################################################################################################
# make scatter plots
pdf("scatter_plot.pdf", width=10, height=12, bg = "white")
par(mfrow=c(4,4), mar=c(4,4,2,4))

plot(table$min_soil_depth_frac, table$avg_evaporation)
abline(h = evaporation_ref)
plot(table$log_ksat           , table$avg_evaporation)
abline(h = evaporation_ref)
plot(table$log_recession_coef , table$avg_evaporation)
abline(h = evaporation_ref)
plot(table$stor_cap           , table$avg_evaporation)
abline(h = evaporation_ref)

plot(table$min_soil_depth_frac, table$avg_runoff)
abline(h = runoff_ref)
plot(table$log_ksat           , table$avg_runoff)
abline(h = runoff_ref)
plot(table$log_recession_coef , table$avg_runoff)
abline(h = runoff_ref)
plot(table$stor_cap           , table$avg_runoff)
abline(h = runoff_ref)

plot(table$min_soil_depth_frac, table$avg_baseflow)
abline(h = baseflow_ref)
plot(table$log_ksat           , table$avg_baseflow)
abline(h = baseflow_ref)
plot(table$log_recession_coef , table$avg_baseflow)
abline(h = baseflow_ref)
plot(table$stor_cap           , table$avg_baseflow)
abline(h = baseflow_ref)

plot(table$min_soil_depth_frac, table$avg_groundwater_recharge)
abline(h = recharge_ref)
plot(table$log_ksat           , table$avg_groundwater_recharge)
abline(h = recharge_ref)
plot(table$log_recession_coef , table$avg_groundwater_recharge)
abline(h = recharge_ref)
plot(table$stor_cap           , table$avg_groundwater_recharge)
abline(h = recharge_ref)

dev.off()
########################################################################################################################

