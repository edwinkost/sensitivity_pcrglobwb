# This scripts 

# clear the memory
rm(list=ls());ls()

# packages needed:
require('ggplot2'); require('RColorBrewer')

# set minimum number of pairs that will be analyzed:
minPairs = 2

# functions:
#
nPairs_function <- function(obs, pred) length(pred[which(!is.na(obs) & !is.na(pred))])
#
avg_baseflow_deviation_function <- function (Qopt_obs, Qmax_obs, Qmin_obs, Qsim) {
    # original data
    Qopt_obs_ori <- Qopt_obs
    Qmax_obs_ori <- Qmax_obs
    Qmin_obs_ori <- Qmin_obs
    Qsim_ori     <- Qsim
    # throw away missing values (both obs and sim must have values)
    Qopt_obs <- Qopt_obs_ori[!is.na(Qopt_obs_ori) & !is.na(Qmax_obs_ori) & !is.na(Qmin_obs_ori) & !is.na(Qsim_ori)]
    Qmax_obs <- Qmax_obs_ori[!is.na(Qopt_obs_ori) & !is.na(Qmax_obs_ori) & !is.na(Qmin_obs_ori) & !is.na(Qsim_ori)]
    Qmin_obs <- Qmin_obs_ori[!is.na(Qopt_obs_ori) & !is.na(Qmax_obs_ori) & !is.na(Qmin_obs_ori) & !is.na(Qsim_ori)]
    Qsim     <- Qsim_ori    [!is.na(Qopt_obs_ori) & !is.na(Qmax_obs_ori) & !is.na(Qmin_obs_ori) & !is.na(Qsim_ori)]
    if (length(Qsim) == 0) 
        return(NA)
    baseflow_deviation     = apply(cbind(0, Qsim -Qmax_obs), 1, max) + apply(cbind(0, Qmin_obs - Qsim), 1, max) 
    avg_baseflow_deviation = mean(baseflow_deviation)
    return(avg_baseflow_deviation)
}
#
NSeff_function <- function (Qobs, Qsim) {
    # original data:
    Qobs_ori <-Qobs 
    Qsim_ori <-Qsim 
    # throw away missing values (both obs and sim must have values)
    Qsim <- Qsim_ori[!is.na(Qobs_ori) & !is.na(Qsim_ori)]
    Qobs <- Qobs_ori[!is.na(Qobs_ori) & !is.na(Qsim_ori)]
    if (length(Qobs) == 0 || length(Qsim) == 0) 
        return(NA)
    NS <- 1 - (sum((Qobs - Qsim)^2)/sum((Qobs - mean(Qobs))^2))
    return(NS)
}
#
NSeff_log_function <- function (Qobs, Qsim) {
    # avoid zero and negative discharge values
    Qobs[which(Qobs<=1)] = 1
    Qsim[which(Qsim<=1)] = 1
    # convert to become log values
    Qobs = log(Qobs)
    Qsim = log(Qsim)
    # original data:
    Qobs_ori <-Qobs 
    Qsim_ori <-Qsim 
    # throw away missing values (both obs and sim must have values)
    Qsim <- Qsim_ori[!is.na(Qobs_ori) & !is.na(Qsim_ori)]
    Qobs <- Qobs_ori[!is.na(Qobs_ori) & !is.na(Qsim_ori)]
    if (length(Qobs) == 0 || length(Qsim) == 0) 
        return(NA)
    NS <- 1 - (sum((Qobs - Qsim)^2)/sum((Qobs - mean(Qobs))^2))
    return(NS)
}
#
avg_obs_function <- function(obs, sim) mean(obs[which(!is.na(obs) & !is.na(sim))]) # PS: While calculating average we consider only complete pairs.
avg_sim_function <- function(obs, sim) mean(sim[which(!is.na(obs) & !is.na(sim))]) # PS: While calculating average we consider only complete pairs.    
#
rmse_function    <- function(obs, pred) sqrt(mean((obs-pred)^2 ,na.rm=T))
 mae_function    <- function(obs, pred)      mean(abs(obs-pred),na.rm=T)
bias_function    <- function(obs, pred) mean(pred[which(!is.na(obs) & !is.na(pred))]) - mean(obs[which(!is.na(obs) & !is.na(pred))])  # POSITIVE indicates that the average prediction is higher than average observation. 
R2_function      <- function(obs, pred) summary(lm(obs ~ pred))$r.squared
R2ad_function    <- function(obs, pred) summary(lm(obs ~ pred))$adj.r.squared

# read the arguments
args <- commandArgs()
grdcFile   =  args[4]
modelFile  =  args[5]

# load the model result
modelTable = read.table(modelFile,header=F,sep=";")	
modelTable[,1] = as.character(as.Date(modelTable[,1],origin="1901-01-01"))
#

simulation = data.frame(modelTable[,1], modelTable[,2])
names(simulation)[1] <- "date"
names(simulation)[2] <- "simulation"
simulation$date      = paste(substr(as.character(modelTable[,1]), 1,4),"-01-01",sep="")            # simulation date -> assume day = 1 January
simulation$date      = as.Date(simulation$date,"%Y-%m-%d")

# load the baseflow data provided by IWMI
iwmiTableOriginal <- read.table(grdcFile,header=F,skip=17)                                         # assume that there are 17 lines to be skipped
#
names(iwmiTableOriginal)[1] <- "date"
names(iwmiTableOriginal)[2] <- "annual_discharge"        # unit: m3/year
names(iwmiTableOriginal)[3] <- "max_baseflow"            # unit: m3/year
names(iwmiTableOriginal)[4] <- "opt_baseflow"            # unit: m3/year
names(iwmiTableOriginal)[5] <- "min_baseflow"            # unit: m3/year
names(iwmiTableOriginal)[6] <- "record_days"             # unit: days
#
# ignore data with record_days <= 200
iwmiTable = iwmiTableOriginal[which(iwmiTableOriginal$record_days > 200),]

# convert unit from m3/year to m3/s
# - number of days in a year
this_year_1_jan = as.Date(paste(as.character(iwmiTable$date  ),"-01-01",sep=""), "%Y-%m-%d")
next_year_1_jan = as.Date(paste(as.character(iwmiTable$date+1),"-01-01",sep=""), "%Y-%m-%d")
days_in_a_year  = as.numeric(next_year_1_jan - this_year_1_jan) ; print(days_in_a_year)
# - convert annual discharge, maximum baseflow and minimum baseflow
iwmiTable$annual_discharge = iwmiTable$annual_discharge / (days_in_a_year * 24 * 3600)
iwmiTable$max_baseflow     = iwmiTable$max_baseflow / (days_in_a_year * 24 * 3600)
iwmiTable$opt_baseflow     = iwmiTable$opt_baseflow / (days_in_a_year * 24 * 3600)
iwmiTable$min_baseflow     = iwmiTable$min_baseflow / (days_in_a_year * 24 * 3600)

# convert year to date
iwmiTable$date = paste(substr(as.character(iwmiTable$date), 1,4),"-01-01",sep="")  # observation date -> assume day = 1 January
iwmiTable$date = as.Date(as.character(iwmiTable$date), "%Y-%m-%d")

# merging model and iwmi tables
mergedTable = merge(simulation,iwmiTable,by="date",all.x=TRUE)

print(mergedTable)

# available observation data
length_observation = length(mergedTable[,1])

if (length_observation < minPairs) {
print(paste("ONLY FEW OBSERVATION DATA ARE AVAILABLE: ",length_observation,sep=""))} else {

# evaluating model performance:
#
nPairs      =   length_observation
#
avg_opt_obs =   avg_obs_function(mergedTable$opt_baseflow, mergedTable$simulation)
avg_max_obs =   avg_obs_function(mergedTable$max_baseflow, mergedTable$simulation)
avg_min_obs =   avg_obs_function(mergedTable$min_baseflow, mergedTable$simulation)
#
avg_sim     =   avg_sim_function(mergedTable$simulation  , mergedTable$simulation)
#
NSeff       =     NSeff_function(mergedTable$opt_baseflow, mergedTable$simulation)
NSeff_log   = NSeff_log_function(mergedTable$opt_baseflow, mergedTable$simulation)
rmse        =      rmse_function(mergedTable$opt_baseflow, mergedTable$simulation)
mae         =       mae_function(mergedTable$opt_baseflow, mergedTable$simulation)
bias        =      bias_function(mergedTable$opt_baseflow, mergedTable$simulation)
R2          =        R2_function(mergedTable$opt_baseflow, mergedTable$simulation)  
R2ad        =      R2ad_function(mergedTable$opt_baseflow, mergedTable$simulation)
correlation =                cor(mergedTable$opt_baseflow, mergedTable$simulation, use = "na.or.complete")
#
avg_baseflow_deviation = avg_baseflow_deviation_function(Qopt_obs = mergedTable$opt_baseflow, 
                                                         Qmax_obs = mergedTable$max_baseflow, 
                                                         Qmin_obs = mergedTable$min_baseflow, 
                                                         Qsim     = mergedTable$simulation)

print(avg_baseflow_deviation)

performance = c(
nPairs, 
avg_opt_obs, avg_max_obs, avg_min_obs, 
avg_sim,     
NSeff, NSeff_log,   
rmse, mae, bias,       
R2, R2ad, correlation,
avg_baseflow_deviation)
#
performance_character = paste(
nPairs, 
avg_opt_obs, avg_max_obs, avg_min_obs, 
avg_sim,     
NSeff, NSeff_log,   
rmse, mae, bias,       
R2, R2ad, correlation,
avg_baseflow_deviation,
sep=";")

# saving model performance to outputFile (in the memory)
outputFile = paste(modelFile,".out",sep="")
print(outputFile)
cat("observation file: ",grdcFile,"\n",sep="",file=outputFile)
cat(
"nPairs", 
"avg_opt_obs", "avg_max_obs", "avg_min_obs", 
"avg_sim",     
"NSeff", "NSeff_log",   
"rmse", "mae", "bias",       
"R2", "R2ad", "correlation",
"avg_baseflow_deviation",
"\n",sep="",file=outputFile,append=TRUE)
cat(performance_character,"\n",sep="",file=outputFile,append=TRUE)
write.table(mergedTable,file=outputFile,sep=";",quote=FALSE,append=TRUE,row.names=FALSE)

print(performance_character)

# read attribute information of station location
attributeStat = readLines(paste(modelFile,".atr",sep=""))

# Plotting the monthly chart !
####################################################################################################################################
#
# x and y- axis scales:
y_min = 0
y_max_obs = max(mergedTable$max_baseflow,na.rm=T)
y_max_sim = max(mergedTable$simulation  ,na.rm=T)
y_max = max(y_max_obs, y_max_sim)
if (y_max > 50) {y_max = ceiling((y_max+75)/100)*100} else {y_max = 50}
#
x_min = min(mergedTable$date,na.rm=T) - 365*5
x_max = max(mergedTable$date,na.rm=T)
#
x_info_text = x_min - 365*0.5

outplott <- ggplot()
outplott <- outplott +
 layer(data = mergedTable, mapping = aes(x = date, y = opt_baseflow), geom = "line", colour =  "red",  size = 0.90)  +                     # measurement
 layer(data = mergedTable, mapping = aes(x = date, y = max_baseflow), geom = "line", colour = "black", size = 0.45, linetype = "dashed") + # model results
 layer(data = mergedTable, mapping = aes(x = date, y = min_baseflow), geom = "line", colour = "black", size = 0.45, linetype = "dashed") + # model results
 layer(data = mergedTable, mapping = aes(x = date, y = simulation  ), geom = "line", colour = "blue",  size = 0.35   ) +                   # model results
#
 geom_text(aes(x = x_info_text, y = 1.00*y_max, label = attributeStat[1]), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.95*y_max, label = attributeStat[2]), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.90*y_max, label = attributeStat[3]), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.85*y_max, label = attributeStat[4]), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.80*y_max, label = attributeStat[5]), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.75*y_max, label = attributeStat[6]), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.70*y_max, label = attributeStat[7]), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.65*y_max, label = attributeStat[8]), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.60*y_max, label = attributeStat[9]), size = 2.5,hjust = 0) +
#
 geom_text(aes(x = x_info_text, y = 0.55*y_max, label = paste(" nPairs = ",      round(performance[1] ,2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.50*y_max, label = paste(" avg_opt_obs = ", round(performance[2] ,2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.45*y_max, label = paste(" avg_max_obs = ", round(performance[3] ,2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.40*y_max, label = paste(" avg_min_obs = ", round(performance[4] ,2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.35*y_max, label = paste(" avg_sim = "    , round(performance[5] ,2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.30*y_max, label = paste(" avg_bf_dev = " , round(performance[14],2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.25*y_max, label = paste(" rmse = ",        round(performance[8] ,2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.20*y_max, label = paste(" mae = ",         round(performance[9] ,2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.15*y_max, label = paste(" bias = ",        round(performance[10],2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.10*y_max, label = paste(" R2 = ",          round(performance[11],2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.05*y_max, label = paste(" R2ad = ",        round(performance[12],2),sep="")), size = 2.5,hjust = 0) +
 geom_text(aes(x = x_info_text, y = 0.00*y_max, label = paste(" correlation = ", round(performance[13],2),sep="")), size = 2.5,hjust = 0) +
#
 scale_y_continuous("baseflow (m3/s)",limits=c(y_min,y_max)) +
 scale_x_date('',limits=c(x_min,x_max)) +
 theme(legend.position = "none") 
#ggsave("screen.pdf", plot = outplott,width=30,height=8.25,units='cm')
 ggsave(paste(outputFile,".pdf",sep=""), plot = outplott,width=27,height=7,units='cm')
#
rm(outplott)
####################################################################################################################################

}
