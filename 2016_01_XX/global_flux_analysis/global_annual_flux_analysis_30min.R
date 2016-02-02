
# clear the memory
rm(list=ls());ls()

# packages needed:
require(ncdf4)
require(ggplot2)
require(grid)

# read the system arguments
args <- commandArgs()

#
pcrglobwb_output_folder <- args[4]

# 
analysis_output_file    <- 
modelFile  =  args[5]


"desalinationAbstractionVolume_annuaTot_output.nc",
"domesticWaterWithdrawalVolume_annuaTot_output.nc",
"industryWaterWithdrawalVolume_annuaTot_output.nc",
"irrGrossDemandVolume_annuaTot_output.nc",
"irrigationWaterWithdrawalVolume_annuaTot_output.nc",
"livestockWaterWithdrawalVolume_annuaTot_output.nc",
"nonIrrGrossDemandVolume_annuaTot_output.nc",
"surfaceWaterAbstractionVolume_annuaTot_output.nc",
"totalGrossDemandVolume_annuaTot_output.nc",
"totalGroundwaterAbstractionVolume_annuaTot_output.nc"

"actualET_annuaTot_output.nc",
"baseflow_annuaTot_output.nc",
"desalinationAbstractionVolume_annuaTot_output.nc",
"desalinationAbstraction_annuaTot_output.nc",

"domesticWaterWithdrawalVolume_annuaTot_output.nc",

"domesticWaterWithdrawal_annuaTot_output.nc",

"fossilGroundwaterAbstraction_annuaTot_output.nc",

"gwRecharge_annuaTot_output.nc",

"industryWaterWithdrawalVolume_annuaTot_output.nc"

"industryWaterWithdrawal_annuaTot_output.nc
"irrGrossDemandVolume_annuaTot_output.nc
"irrGrossDemand_annuaTot_output.nc
"irrNonPaddyWaterWithdrawal_annuaTot_output.nc
"irrPaddyWaterWithdrawal_annuaTot_output.nc
"irrigationWaterWithdrawalVolume_annuaTot_output.nc
"irrigationWaterWithdrawal_annuaTot_output.nc
"livestockWaterWithdrawalVolume_annuaTot_output.nc
"livestockWaterWithdrawal_annuaTot_output.nc
"nonFossilGroundwaterAbstraction_annuaTot_output.nc
"nonIrrGrossDemandVolume_annuaTot_output.nc
"nonIrrGrossDemand_annuaTot_output.nc
"nonIrrReturnFlow_annuaTot_output.nc
"nonIrrWaterConsumption_annuaTot_output.nc
"precipitation_annuaTot_output.nc
"runoff_annuaTot_output.nc
"storGroundwaterFossil_annuaAvg_output.nc
"storGroundwaterFossil_annuaEnd_output.nc
"storGroundwaterTotal_annuaAvg_output.nc
"storGroundwaterTotal_annuaEnd_output.nc
"storGroundwater_annuaAvg_output.nc
"storGroundwater_annuaEnd_output.nc
"surfaceWaterAbstractionVolume_annuaTot_output.nc
"surfaceWaterAbstraction_annuaTot_output.nc
"temperature_annuaAvg_output.nc
"totalAbstraction_annuaTot_output.nc
"totalActiveStorageThickness_annuaAvg_output.nc
"totalActiveStorageThickness_annuaEnd_output.nc
"totalEvaporation_annuaTot_output.nc
"totalGrossDemandVolume_annuaTot_output.nc
"totalGrossDemand_annuaTot_output.nc
"totalGroundwaterAbstractionVolume_annuaTot_output.nc
"totalGroundwaterAbstraction_annuaTot_output.nc
"totalRunoff_annuaTot_output.nc
"totalWaterStorageThickness_annuaAvg_output.nc
"totalWaterStorageThickness_annuaEnd_output.nc


# You have to define the following variables
# - output_folder
# - starting_year


pre_file = nc_open( paste( output_folder, "precipitation_annuaTot_output.nc"               , sep = "") )
eva_file = nc_open( paste( output_folder, "totalEvaporation_annuaTot_output.nc"            , sep = "") )
run_file = nc_open( paste( output_folder, "totalRunoff_annuaTot_output.nc"                 , sep = "") )

snw_file = nc_open( paste( output_folder, "snowCoverSWE_annuaAvg_output.nc"                , sep = "") )
snf_file = nc_open( paste( output_folder, "snowFreeWater_annuaAvg_output.nc"               , sep = "") )

swt_file = nc_open( paste( output_folder, "surfaceWaterStorage_annuaAvg_output.nc"         , sep = "") )
top_file = nc_open( paste( output_folder, "topWaterLayer_annuaAvg_output.nc"               , sep = "") )

int_file = nc_open( paste( output_folder, "interceptStor_annuaAvg_output.nc"               , sep = "") )

upp_file = nc_open( paste( output_folder, "storUppTotal_annuaAvg_output.nc"                , sep = "") )
low_file = nc_open( paste( output_folder, "storLowTotal_annuaAvg_output.nc"                , sep = "") )

gwt_file = nc_open( paste( output_folder, "groundwaterThicknessEstimate_annuaAvg_output.nc", sep = "") )

# time values 
time = ncvar_get(swt_file, "time")

# years used in the model
year = seq(starting_year, 2010, 1)





PRE = rep(NA, length(time))
EVA = rep(NA, length(time))
RUN = rep(NA, length(time))

SNW = rep(NA, length(time))
SNF = rep(NA, length(time))

SWT = rep(NA, length(time))
TOP = rep(NA, length(time))

INT = rep(NA, length(time))

UPP = rep(NA, length(time))
LOW = rep(NA, length(time))

GWT = rep(NA, length(time))

# cell area 
cell_area_file = nc_open("/home/edwin/data/cell_area_nc/cellsize05min.correct.used.nc")
cell_area = ncvar_get(cell_area_file, "Band1")[,]
nc_close(cell_area_file)

for (i in 1:length(time)){

PRE_field = ncvar_get(pre_file, "precipitation"                   , c(1, 1, i), c(-1, -1, 1))
EVA_field = ncvar_get(eva_file, "total_evaporation"               , c(1, 1, i), c(-1, -1, 1))
RUN_field = ncvar_get(run_file, "total_runoff"                    , c(1, 1, i), c(-1, -1, 1))

SNW_field = ncvar_get(snw_file, "snow_water_equivalent"           , c(1, 1, i), c(-1, -1, 1))
SNF_field = ncvar_get(snf_file, "snow_free_water"                 , c(1, 1, i), c(-1, -1, 1))

SWT_field = ncvar_get(swt_file, "surface_water_storage"           , c(1, 1, i), c(-1, -1, 1))
TOP_field = ncvar_get(top_file, "top_water_layer"                 , c(1, 1, i), c(-1, -1, 1))

INT_field = ncvar_get(int_file, "interception_storage"            , c(1, 1, i), c(-1, -1, 1))

UPP_field = ncvar_get(upp_file, "upper_soil_storage"              , c(1, 1, i), c(-1, -1, 1))
LOW_field = ncvar_get(low_file, "lower_soil_storage"              , c(1, 1, i), c(-1, -1, 1))

GWT_field = ncvar_get(gwt_file, "groundwater_thickness_estimate"  , c(1, 1, i), c(-1, -1, 1))

# ignore zero values for some stores 
SWT_field[which(SWT_field < 0.0)] = 0.0

# calculate the global volumes (unit: km3)
PRE[i] = sum( PRE_field  * cell_area, na.rm = T)/10^9
EVA[i] = sum( EVA_field  * cell_area, na.rm = T)/10^9
RUN[i] = sum( RUN_field  * cell_area, na.rm = T)/10^9

SNW[i] = sum( SNW_field  * cell_area, na.rm = T)/10^9
SNF[i] = sum( SNF_field  * cell_area, na.rm = T)/10^9

SWT[i] = sum( SWT_field  * cell_area, na.rm = T)/10^9
TOP[i] = sum( TOP_field  * cell_area, na.rm = T)/10^9

INT[i] = sum( INT_field  * cell_area, na.rm = T)/10^9

UPP[i] = sum( UPP_field  * cell_area, na.rm = T)/10^9
LOW[i] = sum( LOW_field  * cell_area, na.rm = T)/10^9

GWT[i] = sum( GWT_field  * cell_area, na.rm = T)/10^9

print(i)
print(year[i])
print(paste("PRE : ",PRE[i]))
print(paste("EVA : ",EVA[i]))
print(paste("RUN : ",RUN[i]))

print(paste("SNW : ",SNW[i]))
print(paste("SNF : ",SNF[i]))

print(paste("SWT : ",SWT[i]))
print(paste("TOP : ",TOP[i]))

print(paste("INT : ",INT[i]))

print(paste("UPP : ",UPP[i]))
print(paste("LOW : ",LOW[i]))

print(paste("GWT : ",GWT[i]))

print("")

}

# index of the starting year
analysis_starting_year = starting_year + 10
sta = which(year == analysis_starting_year)
# index of the last year
las = length(year)

# correcting snow and snow free water (due to the accumulation in glacier and ice sheet regions)
snw_lm_model  = lm(SNW ~ year)
snf_lm_model  = lm(SNF ~ year)
SNW_corrected = SNW - (snw_lm_model$coefficients[1] + snw_lm_model$coefficients[2]*year)
SNF_corrected = SNF - (snf_lm_model$coefficients[1] + snf_lm_model$coefficients[2]*year)

# including the starting snow and snow free water
SNW_corrected = SNW[1] + SNW_corrected
SNF_corrected = SNF[1] + SNF_corrected

# the corrected TWS
TWS_corrected = SWT + SNW_corrected + SNF_corrected + INT + TOP + UPP + LOW + GWT
plot(year[sta:las], TWS_corrected[sta:las]); lines(year[sta:las], TWS_corrected[sta:las])

# TODO: write a complete and raw data frame
data_frame_raw_complete = data.frame(year,
EVA,
RUN,
SNW,
SNF,
SWT,
TOP,
INT,
UPP,
LOW,
GWT,
SNW_corrected,
SNF_corrected)
file_name = paste(output_folder, "table_raw_complete_", starting_year, "to2010.txt",sep ="")
write.table(data_frame_raw_complete, file_name, sep = ";", row.names = FALSE)

# integrating to several storages
total_water_storage = TWS_corrected
surface_water       = SWT + TOP
snow                = SNW_corrected + SNF_corrected                       ; plot(year[sta:las], snow[sta:las]); lines(year[sta:las], snow[sta:las])
interception        = INT
soil_moisture       = UPP + LOW
groundwater         = GWT

# identify mean values (only using a specific period of interest
mean_total_water_storage = mean(total_water_storage[sta:las])
mean_surface_water       = mean(surface_water      [sta:las])
mean_snow                = mean(snow               [sta:las])
mean_interception        = mean(interception       [sta:las])
mean_soil_moisture       = mean(soil_moisture      [sta:las])
mean_groundwater         = mean(groundwater        [sta:las])

# identiy the maximum amplitude from the mean values (for making charts) 
amplitude = max( 
                    mean_total_water_storage - min(total_water_storage[sta:las]), max(total_water_storage[sta:las]) - mean_total_water_storage,
                    mean_surface_water       - min(surface_water[sta:las])      , max(surface_water[sta:las])       - mean_surface_water,
                    mean_groundwater         - min(groundwater[sta:las])        , max(groundwater[sta:las])         - mean_groundwater,
                0.0)

# making data frame for the absolute value and write it to file
data_frame_absolute = data.frame(year, total_water_storage, surface_water, snow, interception, soil_moisture, groundwater)
file_name = paste(output_folder, "absolute_", starting_year, "to2010.txt",sep ="")
write.table(data_frame_absolute, file_name, sep = ";", row.names = FALSE)

# calculating anomaly values
total_water_storage_anomaly = total_water_storage - mean_total_water_storage
surface_water_anomaly       = surface_water       - mean_surface_water      
snow_anomaly                = snow                - mean_snow               ; plot(year[sta:las], snow_anomaly[sta:las]); lines(year[sta:las], snow_anomaly[sta:las])  
interception_anomaly        = interception        - mean_interception       
soil_moisture_anomaly       = soil_moisture       - mean_soil_moisture      
groundwater_anomaly         = groundwater         - mean_groundwater        

# making data frame for the anomaly value
data_frame_anomaly = data.frame(year, total_water_storage_anomaly, surface_water_anomaly, snow_anomaly, interception_anomaly, soil_moisture_anomaly, groundwater_anomaly)

# making the anomaly charts
tws_anomaly_chart <- ggplot(data = data_frame_anomaly, aes(x = year, y = total_water_storage_anomaly)) + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
swt_anomaly_chart <- ggplot(data = data_frame_anomaly, aes(x = year, y = surface_water_anomaly))       + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
snw_anomaly_chart <- ggplot(data = data_frame_anomaly, aes(x = year, y = snow_anomaly))                + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
int_anomaly_chart <- ggplot(data = data_frame_anomaly, aes(x = year, y = interception_anomaly))        + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
soi_anomaly_chart <- ggplot(data = data_frame_anomaly, aes(x = year, y = soil_moisture_anomaly))       + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
gwt_anomaly_chart <- ggplot(data = data_frame_anomaly, aes(x = year, y = groundwater_anomaly))         + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
# setting y axes
tws_anomaly_chart <- tws_anomaly_chart + scale_y_continuous(limits = c(- amplitude, amplitude))
swt_anomaly_chart <- swt_anomaly_chart + scale_y_continuous(limits = c(- amplitude, amplitude))
snw_anomaly_chart <- snw_anomaly_chart + scale_y_continuous(limits = c(- amplitude, amplitude))
int_anomaly_chart <- int_anomaly_chart + scale_y_continuous(limits = c(- amplitude, amplitude))
soi_anomaly_chart <- soi_anomaly_chart + scale_y_continuous(limits = c(- amplitude, amplitude))
gwt_anomaly_chart <- gwt_anomaly_chart + scale_y_continuous(limits = c(- amplitude, amplitude))

# plotting the anomaly charts - this is for one slide
gA <- ggplotGrob(tws_anomaly_chart)
gB <- ggplotGrob(swt_anomaly_chart)
gC <- ggplotGrob(gwt_anomaly_chart)
gD <- ggplotGrob(snw_anomaly_chart)
gE <- ggplotGrob(int_anomaly_chart)
gF <- ggplotGrob(soi_anomaly_chart)
g = cbind(rbind(gA, gB, gC, size = "last"), rbind(gD, gE, gF, size = "last"), size = "first")
grid.newpage()
grid.draw(g)

# making data frame for all fluxes
precipitation = PRE
evaporation   = EVA
runoff        = RUN
data_frame_flux = data.frame(precipitation, evaporation, runoff)
file_name = paste(output_folder, "fluxes_", starting_year, "to2010.txt",sep ="")
write.table(data_frame_flux, file_name, sep = ";", row.names = FALSE)

# calculate mean values of fluxes
mean_precipitation = mean(precipitation[sta:las])
mean_evaporation   = mean(evaporation[sta:las])
mean_runoff        = mean(runoff[sta:las])

# calculate anomaly fluxes and making data frame for anomaly
precipitation_anomaly = precipitation - mean_precipitation
evaporation_anomaly   = evaporation   - mean_evaporation  
runoff_anomaly        = runoff        - mean_runoff       
data_frame_flux_anomaly = data.frame(year, precipitation_anomaly, evaporation_anomaly, runoff_anomaly)
write.table(data_frame_flux_anomaly, file_name, sep = ";", row.names = FALSE)

# amplitude for fluxes (for the bar plots)
amplitude_precipitation = max(mean_precipitation - min(precipitation[sta:las]), max(precipitation[sta:las]) - mean_precipitation) 
amplitude_evaporation   = max(mean_evaporation   - min(evaporation[sta:las])  , max(evaporation[sta:las])   - mean_evaporation) 
amplitude_runoff        = max(mean_runoff        - min(runoff[sta:las])       , max(runoff[sta:las])        - mean_runoff) 

# making barplot for fluxes
pre_anomaly_bar_plot = ggplot(data = data_frame_anomaly, aes(x = year, y = precipitation_anomaly)) + geom_bar(stat = "identity", position = "identity")
eva_anomaly_bar_plot = ggplot(data = data_frame_anomaly, aes(x = year, y = evaporation_anomaly  )) + geom_bar(stat = "identity", position = "identity")
run_anomaly_bar_plot = ggplot(data = data_frame_anomaly, aes(x = year, y = runoff_anomaly       )) + geom_bar(stat = "identity", position = "identity")
# setting x and y axes
pre_anomaly_bar_plot <- pre_anomaly_bar_plot + scale_y_continuous(limits = c(- amplitude_precipitation, amplitude_precipitation)) + scale_x_continuous(limits = c(analysis_starting_year, 2010))
eva_anomaly_bar_plot <- eva_anomaly_bar_plot + scale_y_continuous(limits = c(- amplitude_evaporation  , amplitude_evaporation  )) + scale_x_continuous(limits = c(analysis_starting_year, 2010))
run_anomaly_bar_plot <- run_anomaly_bar_plot + scale_y_continuous(limits = c(- amplitude_runoff       , amplitude_runoff       )) + scale_x_continuous(limits = c(analysis_starting_year, 2010))

# making plot for absolute storages
total_water_storage_chart <- ggplot(data = data_frame_absolute, aes(x = year, y = total_water_storage)) + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
surface_water_chart       <- ggplot(data = data_frame_absolute, aes(x = year, y = surface_water))       + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
groundwater_chart         <- ggplot(data = data_frame_absolute, aes(x = year, y = groundwater))         + geom_line() + scale_x_continuous(limits = c(analysis_starting_year, 2010))
# setting y axes
total_water_storage_chart <- total_water_storage_chart + scale_y_continuous(limits = c(mean_total_water_storage - amplitude, mean_total_water_storage + amplitude)) 
surface_water_chart       <- surface_water_chart       + scale_y_continuous(limits = c(mean_surface_water       - amplitude, mean_surface_water       + amplitude)) 
groundwater_chart         <- groundwater_chart         + scale_y_continuous(limits = c(mean_groundwater         - amplitude, mean_groundwater         + amplitude)) 

# plooting storage and fluxes charts
gA <- ggplotGrob(total_water_storage_chart)
gB <- ggplotGrob(surface_water_chart)
gC <- ggplotGrob(groundwater_chart)
gD <- ggplotGrob(pre_anomaly_bar_plot)
gE <- ggplotGrob(eva_anomaly_bar_plot)
gF <- ggplotGrob(run_anomaly_bar_plot)
g = cbind(rbind(gA, gB, gC, size = "last"), rbind(gD, gE, gF, size = "last"), size = "first")
grid.newpage()
grid.draw(g)
