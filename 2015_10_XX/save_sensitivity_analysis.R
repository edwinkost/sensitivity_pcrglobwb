
# main path
main_path = "/home/sutan101/github/edwinkost/sensitivity_pcrglobwb/2015_10_XX/summary_0to224/summary_"

########################################################################################################################
# list of parameters
parameters = data.frame()
parameters = rbind(parameters, read.table("table_05_october_2015_speedy_and_rapid.txt", header=T)[1:5])            
parameters = rbind(parameters, read.table("table_05_october_2015_cartesius.txt", header=T)[1:5])                   
parameters = rbind(parameters, read.table("table_06_october_2015_cartesius_and_speedy_rapid.txt", header=T)[1:5])
parameters = rbind(parameters, read.table("table_08_october_2015_cartesius.txt", header=T)[1:5])
parameters = rbind(parameters, read.table("table_12_october_2015_cartesius.txt", header=T)[1:5])

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

for( i_run in seq(0,224,1)) {

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

########################################################################################################################
# make scatter plots to the reference

# value for the reference run
evaporation_ref = table$avg_evaporation[which(table$code == "code__a__0")]
runoff_ref      = table$avg_runoff[which(table$code == "code__a__0")]
baseflow_ref    = table$avg_baseflow[which(table$code == "code__a__0")]
recharge_ref    = table$avg_groundwater_recharge[which(table$code == "code__a__0")]

pdf("scatter_plot_reference.pdf", width=10, height=12, bg = "white")
par(mfrow=c(4,4), mar=c(4,4,2,4))

abline(h = evaporation_ref)
abline(h = evaporation_ref)
abline(h = evaporation_ref)
abline(h = evaporation_ref)

plot(table$min_soil_depth_frac, table$avg_runoff - runoff_ref)
plot(table$log_ksat           , table$avg_runoff - runoff_ref)
plot(table$log_recession_coef , table$avg_runoff - runoff_ref)
plot(table$stor_cap           , table$avg_runoff - runoff_ref)

plot(table$min_soil_depth_frac, table$avg_baseflow - baseflow_ref)
plot(table$log_ksat           , table$avg_baseflow - baseflow_ref)
plot(table$log_recession_coef , table$avg_baseflow - baseflow_ref)
plot(table$stor_cap           , table$avg_baseflow - baseflow_ref)

plot(table$min_soil_depth_frac, table$avg_groundwater_recharge - recharge_ref)
plot(table$log_ksat           , table$avg_groundwater_recharge - recharge_ref)
plot(table$log_recession_coef , table$avg_groundwater_recharge - recharge_ref)
plot(table$stor_cap           , table$avg_groundwater_recharge - recharge_ref)

dev.off()
########################################################################################################################


# barData = matrix(NA, 3, 5)
# barData[1,] = evap[wminSel]/evap[1]-1
# barData[2,] = evap[wmaxSel]/evap[1]-1
# barData[3,] = evap[ksatSel]/evap[1]-1
# sensBarPlot(barData, orgData = evap/1000/1000/1000/1000, title="Evaporation (*1000 km3/year)", leg=TRUE)
# 
# 
# sensBarPlot <- function(barData, orgData, title_given = "", leg = FALSE){
#   barcols = c("Red", "Blue", "Black","Green")
#   barplot(barData, col = barcols, beside = T, ylim = c(min(barData)-0.005, max(barData)+0.005), main = title_given, ylab="Relative change", xlab="Parameter change")
#   axis(1, at=c(2.5,6.5, 10.5, 14.5, 18.5), c("80%", "90%", "100%", "110%", "120%"))
#   axis(4, at=c(min(barData), 0, max(barData)), round(c(min(orgData), orgData[ref], max(orgData)), digits=2))
#   mtext("Absolute numbers", side=4, line=2.5, cex=0.7)
#   if(leg == TRUE){
#     legend("topright", c("min_soil_depth_frac", "log_ksat", "log_recession_coef", "stor_cap"), col = barcols, pch = 15)
#   }
#   box()
# }
# 
# min_soil_depth_frac_sel = 1.0
#  log_recession_coef_sel = 0.0
#            log_ksat_sel = 0.0
#            stor_cap_sel = 1.0
# 
# evaporation_reference = table$avg_evaporation[which(table$code == "code__a__0")] 
# 
# barData = matrix(NA, 4, 45)
# barData[1,] = table$avg_evaporation[which(table$min_soil_depth_frac == min_soil_depth_frac_sel)]
# barData[2,] = table$avg_evaporation[which(table$log_recession_coef  == log_recession_coef_sel )]
# barData[3,] = table$avg_evaporation[which(table$log_ksat == log_ksat_sel )]
# barData[4,] = table$avg_evaporation[which(table$stor_cap == stor_cap_sel )]
# 
# 
# barData[1,] = evap[wminSel]/evap[1]-1
# barData[2,] = evap[wmaxSel]/evap[1]-1
# barData[3,] = evap[ksatSel]/evap[1]-1
# barData[4,] = evap[ksatSel]/evap[1]-1
# 
# sensBarPlot(barData, orgData = evap/1000/1000/1000/1000, title="Evaporation (*1000 km3/year)", leg=TRUE)
# 
# 
# 
# pdf("SensAnalysis.pdf", width=10, height=14)
# par(mfrow=c(3,2), mar=c(4,4,2,4))
# barData = matrix(NA, 3, 5)
# barData[1,] = evap[wminSel]/evap[1]-1
# barData[2,] = evap[wmaxSel]/evap[1]-1
# barData[3,] = evap[ksatSel]/evap[1]-1
# sensBarPlot(barData, orgData = evap/1000/1000/1000/1000, title="Evaporation (*1000 km3/year)", leg=TRUE)
# 
# barData = matrix(NA, 3, 5)
# barData[1,] = satDeg[wminSel]/satDeg[1]-1
# barData[2,] = satDeg[wmaxSel]/satDeg[1]-1
# barData[3,] = satDeg[ksatSel]/satDeg[1]-1
# sensBarPlot(barData, orgData = satDeg, title="Saturation Degree (-)")
# 
# barData = matrix(NA, 3, 5)
# barData[1,] = runoff[wminSel]/runoff[1]-1
# barData[2,] = runoff[wmaxSel]/runoff[1]-1
# barData[3,] = runoff[ksatSel]/runoff[1]-1
# sensBarPlot(barData, orgData=runoff/1000/1000/1000/1000, title="Runoff (*1000 km3/year)")
# 
# barData = matrix(NA, 3, 5)
# barData[1,] = baseflow[wminSel]/baseflow[1]-1
# barData[2,] = baseflow[wmaxSel]/baseflow[1]-1
# barData[3,] = baseflow[ksatSel]/baseflow[1]-1
# sensBarPlot(barData, orgData=baseflow/86400, title="Baseflow (m3 s-1)")
# 
# barData = matrix(NA, 3, 5)
# barData[1,] = recharge[wminSel]/recharge[1]-1
# barData[2,] = recharge[wmaxSel]/recharge[1]-1
# barData[3,] = recharge[ksatSel]/recharge[1]-1
# sensBarPlot(barData, orgData=recharge/1000/1000/1000/1000, title="Recharge (*1000 km3/year)")
# 
# barData = matrix(NA, 3, 5)
# barData[1,] = discharge[wminSel]/discharge[1]-1
# barData[2,] = discharge[wmaxSel]/discharge[1]-1
# barData[3,] = discharge[ksatSel]/discharge[1]-1
# sensBarPlot(barData, orgData=discharge, title="Discharge  (m3 s-1)")
# dev.off()
# 
