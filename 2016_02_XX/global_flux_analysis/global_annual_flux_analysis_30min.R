
# clear the memory
rm(list=ls());ls()

# packages needed:
require(ncdf4)
require(ggplot2)
require(grid)

# read the system arguments
args <- commandArgs()
print(args)

# scenario name/code 
scenario_code                  <- args[4]

# folder that contains pcrglobwb model output
pcrglobwb_output_folder        <- paste("/scratch-shared/edwin/30min_sensitivity_analysis_non_natural/2016_02_XX/", scenario_code, "/", sep = "")

# folder for the analysis output
folder_for_the_analysis_output <- paste(pcrglobwb_output_folder, "/analysis_iwmi/global_annual_fluxes/", sep = "")
# - making the folder
dir.create(folder_for_the_analysis_output, recursive = TRUE)

# netcdf output_files 
####################################################################################################################################################################################################################
precipitation_file                   = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "precipitation_annuaTot_output.nc"                   , sep = "") )
land_evaporation_file                = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "actualET_annuaTot_output.nc"                        , sep = "") )
total_evaporation_file               = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "totalEvaporation_annuaTot_output.nc"                , sep = "") )
land_runoff_file                     = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "runoff_annuaTot_output.nc"                          , sep = "") )
total_runoff_file                    = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "totalRunoff_annuaTot_output.nc"                     , sep = "") )
gw_recharge_file                     = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "gwRecharge_annuaTot_output.nc"                      , sep = "") )
gw_baseflow_file                     = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "baseflow_annuaTot_output.nc"                        , sep = "") )
total_withdrawal_file                = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "totalAbstraction_annuaTot_output.nc"                , sep = "") )  # or "totalGrossDemand_annuaTot_output.nc"
desalination_withdrawal_file         = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "desalinationAbstraction_annuaTot_output.nc"         , sep = "") )
surface_water_withdrawal_file        = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "surfaceWaterAbstraction_annuaTot_output.nc"         , sep = "") )
total_gw_abstraction_file            = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "totalGroundwaterAbstraction_annuaTot_output.nc"     , sep = "") )
fossil_gw_abstraction_file           = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "fossilGroundwaterAbstraction_annuaTot_output.nc"    , sep = "") )
non_fossil_gw_abstraction_file       = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "nonFossilGroundwaterAbstraction_annuaTot_output.nc" , sep = "") )
irrigation_withdrawal_file           = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "irrGrossDemand_annuaTot_output.nc"                  , sep = "") )  # or "irrigationWaterWithdrawal_annuaTot_output.nc"
non_irrigation_withdrawal_file       = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "nonIrrGrossDemand_annuaTot_output.nc"               , sep = "") )
paddy_irrigation_withdrawal_file     = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "irrPaddyWaterWithdrawal_annuaTot_output.nc"         , sep = "") )
non_paddy_irrigation_withdrawal_file = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "irrNonPaddyWaterWithdrawal_annuaTot_output.nc"      , sep = "") )
industry_withdrawal_file             = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "industryWaterWithdrawal_annuaTot_output.nc"         , sep = "") )
domestic_withdrawal_file             = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "domesticWaterWithdrawal_annuaTot_output.nc"         , sep = "") )
livestock_withdrawal_file            = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "livestockWaterWithdrawal_annuaTot_output.nc"        , sep = "") )
non_irrigation_consumption_file      = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "nonIrrWaterConsumption_annuaTot_output.nc"          , sep = "") )
non_irrigation_return_flow_file      = nc_open( paste( pcrglobwb_output_folder , "/netcdf/" , "nonIrrReturnFlow_annuaTot_output.nc"                , sep = "") )
####################################################################################################################################################################################################################


# time values 
time = ncvar_get(gw_recharge_file, "time")

# years used in the model
year          = seq(1958, 2010, 1)

# initiate empty arrays 
precipitation                   =  rep( NA, precipitation_file                   , length(time))
land_evaporation                =  rep( NA, land_evaporation_file                , length(time))
total_evaporation               =  rep( NA, total_evaporation_file               , length(time))
land_runoff                     =  rep( NA, land_runoff_file                     , length(time))
total_runoff                    =  rep( NA, total_runoff_file                    , length(time))
gw_recharge                     =  rep( NA, gw_recharge_file                     , length(time))
gw_baseflow                     =  rep( NA, gw_baseflow_file                     , length(time))
total_withdrawal                =  rep( NA, total_withdrawal_file                , length(time))
desalination_withdrawal         =  rep( NA, desalination_withdrawal_file         , length(time))
surface_water_withdrawal        =  rep( NA, surface_water_withdrawal_file        , length(time))
total_gw_abstraction            =  rep( NA, total_gw_abstraction_file            , length(time))
fossil_gw_abstraction           =  rep( NA, fossil_gw_abstraction_file           , length(time))
non_fossil_gw_abstraction       =  rep( NA, non_fossil_gw_abstraction_file       , length(time))
irrigation_withdrawal           =  rep( NA, irrigation_withdrawal_file           , length(time))
non_irrigation_withdrawal       =  rep( NA, non_irrigation_withdrawal_file       , length(time))
paddy_irrigation_withdrawal     =  rep( NA, paddy_irrigation_withdrawal_file     , length(time))
non_paddy_irrigation_withdrawal =  rep( NA, non_paddy_irrigation_withdrawal_file , length(time))
industry_withdrawal             =  rep( NA, industry_withdrawal_file             , length(time))
domestic_withdrawal             =  rep( NA, domestic_withdrawal_file             , length(time))
livestock_withdrawal            =  rep( NA, livestock_withdrawal_file            , length(time))
non_irrigation_consumption      =  rep( NA, non_irrigation_consumption_file      , length(time))   
non_irrigation_return_flow      =  rep( NA, non_irrigation_return_flow_file      , length(time))   

# cell area 
cell_area_file = nc_open("/home/edwin/data/cell_area_nc/cellarea30min.correct.used.nc")
cell_area = ncvar_get(cell_area_file, "Band1")[,]
nc_close(cell_area_file)

# loop for every timestep/year
for (i in 1:length(time)){

print(paste("Processing the data from the year ", year[i]), sep = "")

# load field values from netcdf files
map_precipitation                    = ncvar_get(precipitation_file                   , NA , c(1, 1, i), c(-1, -1, 1))
map_land_evaporation                 = ncvar_get(land_evaporation_file                , NA , c(1, 1, i), c(-1, -1, 1))
map_total_evaporation                = ncvar_get(total_evaporation_file               , NA , c(1, 1, i), c(-1, -1, 1))
map_land_runoff                      = ncvar_get(land_runoff_file                     , NA , c(1, 1, i), c(-1, -1, 1))
map_total_runoff                     = ncvar_get(total_runoff_file                    , NA , c(1, 1, i), c(-1, -1, 1))
map_gw_recharge                      = ncvar_get(gw_recharge_file                     , NA , c(1, 1, i), c(-1, -1, 1))
map_gw_baseflow                      = ncvar_get(gw_baseflow_file                     , NA , c(1, 1, i), c(-1, -1, 1))
map_total_withdrawal                 = ncvar_get(total_withdrawal_file                , NA , c(1, 1, i), c(-1, -1, 1))
map_desalination_withdrawal          = ncvar_get(desalination_withdrawal_file         , NA , c(1, 1, i), c(-1, -1, 1))
map_surface_water_withdrawal         = ncvar_get(surface_water_withdrawal_file        , NA , c(1, 1, i), c(-1, -1, 1))
map_total_gw_abstraction             = ncvar_get(total_gw_abstraction_file            , NA , c(1, 1, i), c(-1, -1, 1))
map_fossil_gw_abstraction            = ncvar_get(fossil_gw_abstraction_file           , NA , c(1, 1, i), c(-1, -1, 1))
map_non_fossil_gw_abstraction        = ncvar_get(non_fossil_gw_abstraction_file       , NA , c(1, 1, i), c(-1, -1, 1))
map_irrigation_withdrawal            = ncvar_get(irrigation_withdrawal_file           , NA , c(1, 1, i), c(-1, -1, 1))
map_non_irrigation_withdrawal        = ncvar_get(non_irrigation_withdrawal_file       , NA , c(1, 1, i), c(-1, -1, 1))
map_paddy_irrigation_withdrawal      = ncvar_get(paddy_irrigation_withdrawal_file     , NA , c(1, 1, i), c(-1, -1, 1))
map_non_paddy_irrigation_withdrawal  = ncvar_get(non_paddy_irrigation_withdrawal_file , NA , c(1, 1, i), c(-1, -1, 1))
map_industry_withdrawal              = ncvar_get(industry_withdrawal_file             , NA , c(1, 1, i), c(-1, -1, 1))
map_domestic_withdrawal              = ncvar_get(domestic_withdrawal_file             , NA , c(1, 1, i), c(-1, -1, 1))
map_livestock_withdrawal             = ncvar_get(livestock_withdrawal_file            , NA , c(1, 1, i), c(-1, -1, 1))
map_non_irrigation_consumption       = ncvar_get(non_irrigation_consumption_file      , NA , c(1, 1, i), c(-1, -1, 1))
map_non_irrigation_return_flow       = ncvar_get(non_irrigation_return_flow_file      , NA , c(1, 1, i), c(-1, -1, 1))

# calculate the global volumes (unit: km3)
precipitation                    [i] = sum(cell_area * map_precipitation                   , na.rm = T) / 10^9
land_evaporation                 [i] = sum(cell_area * map_land_evaporation                , na.rm = T) / 10^9
total_evaporation                [i] = sum(cell_area * map_total_evaporation               , na.rm = T) / 10^9
land_runoff                      [i] = sum(cell_area * map_land_runoff                     , na.rm = T) / 10^9
total_runoff                     [i] = sum(cell_area * map_total_runoff                    , na.rm = T) / 10^9
gw_recharge                      [i] = sum(cell_area * map_gw_recharge                     , na.rm = T) / 10^9
gw_baseflow                      [i] = sum(cell_area * map_gw_baseflow                     , na.rm = T) / 10^9
total_withdrawal                 [i] = sum(cell_area * map_total_withdrawal                , na.rm = T) / 10^9
desalination_withdrawal          [i] = sum(cell_area * map_desalination_withdrawal         , na.rm = T) / 10^9
surface_water_withdrawal         [i] = sum(cell_area * map_surface_water_withdrawal        , na.rm = T) / 10^9
total_gw_abstraction             [i] = sum(cell_area * map_total_gw_abstraction            , na.rm = T) / 10^9
fossil_gw_abstraction            [i] = sum(cell_area * map_fossil_gw_abstraction           , na.rm = T) / 10^9
non_fossil_gw_abstraction        [i] = sum(cell_area * map_non_fossil_gw_abstraction       , na.rm = T) / 10^9
irrigation_withdrawal            [i] = sum(cell_area * map_irrigation_withdrawal           , na.rm = T) / 10^9
non_irrigation_withdrawal        [i] = sum(cell_area * map_non_irrigation_withdrawal       , na.rm = T) / 10^9
paddy_irrigation_withdrawal      [i] = sum(cell_area * map_paddy_irrigation_withdrawal     , na.rm = T) / 10^9
non_paddy_irrigation_withdrawal  [i] = sum(cell_area * map_non_paddy_irrigation_withdrawal , na.rm = T) / 10^9
industry_withdrawal              [i] = sum(cell_area * map_industry_withdrawal             , na.rm = T) / 10^9
domestic_withdrawal              [i] = sum(cell_area * map_domestic_withdrawal             , na.rm = T) / 10^9
livestock_withdrawal             [i] = sum(cell_area * map_livestock_withdrawal            , na.rm = T) / 10^9
non_irrigation_consumption       [i] = sum(cell_area * map_non_irrigation_consumption      , na.rm = T) / 10^9
non_irrigation_return_flow       [i] = sum(cell_area * map_non_irrigation_return_flow      , na.rm = T) / 10^9

}

# data frame contain yearly flux values: 
data_frame_complete = data.frame(
year,
precipitation,                  
land_evaporation,               
total_evaporation,              
land_runoff,                    
total_runoff,                   
gw_recharge,                    
gw_baseflow,                    
total_withdrawal,               
desalination_withdrawal,        
surface_water_withdrawal,       
total_gw_abstraction,           
fossil_gw_abstraction,          
non_fossil_gw_abstraction,      
irrigation_withdrawal,          
non_irrigation_withdrawal,      
paddy_irrigation_withdrawal,    
non_paddy_irrigation_withdrawal,
industry_withdrawal,            
domestic_withdrawal,            
livestock_withdrawal,           
non_irrigation_consumption,     
non_irrigation_return_flow     
)
file_name = paste(folder_for_the_analysis_output, "/table_global_annual_fluxes_km3.txt",sep ="")
write.table(data_frame_complete, file_name, sep = ";", row.names = FALSE)

# making charts
chart_precipitation                   <- ggplot(data = data_frame_complete, aes(x = year, y = precipitation                  )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_land_evaporation                <- ggplot(data = data_frame_complete, aes(x = year, y = land_evaporation               )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_total_evaporation               <- ggplot(data = data_frame_complete, aes(x = year, y = total_evaporation              )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_land_runoff                     <- ggplot(data = data_frame_complete, aes(x = year, y = land_runoff                    )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_total_runoff                    <- ggplot(data = data_frame_complete, aes(x = year, y = total_runoff                   )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_gw_recharge                     <- ggplot(data = data_frame_complete, aes(x = year, y = gw_recharge                    )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_gw_baseflow                     <- ggplot(data = data_frame_complete, aes(x = year, y = gw_baseflow                    )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_total_withdrawal                <- ggplot(data = data_frame_complete, aes(x = year, y = total_withdrawal               )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_desalination_withdrawal         <- ggplot(data = data_frame_complete, aes(x = year, y = desalination_withdrawal        )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_surface_water_withdrawal        <- ggplot(data = data_frame_complete, aes(x = year, y = surface_water_withdrawal       )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_total_gw_abstraction            <- ggplot(data = data_frame_complete, aes(x = year, y = total_gw_abstraction           )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_fossil_gw_abstraction           <- ggplot(data = data_frame_complete, aes(x = year, y = fossil_gw_abstraction          )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_non_fossil_gw_abstraction       <- ggplot(data = data_frame_complete, aes(x = year, y = non_fossil_gw_abstraction      )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_irrigation_withdrawal           <- ggplot(data = data_frame_complete, aes(x = year, y = irrigation_withdrawal          )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_non_irrigation_withdrawal       <- ggplot(data = data_frame_complete, aes(x = year, y = non_irrigation_withdrawal      )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_paddy_irrigation_withdrawal     <- ggplot(data = data_frame_complete, aes(x = year, y = paddy_irrigation_withdrawal    )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_non_paddy_irrigation_withdrawal <- ggplot(data = data_frame_complete, aes(x = year, y = non_paddy_irrigation_withdrawal)) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_industry_withdrawal             <- ggplot(data = data_frame_complete, aes(x = year, y = industry_withdrawal            )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_domestic_withdrawal             <- ggplot(data = data_frame_complete, aes(x = year, y = domestic_withdrawal            )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_livestock_withdrawal            <- ggplot(data = data_frame_complete, aes(x = year, y = livestock_withdrawal           )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_non_irrigation_consumption      <- ggplot(data = data_frame_complete, aes(x = year, y = non_irrigation_consumption     )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))
chart_non_irrigation_return_flow      <- ggplot(data = data_frame_complete, aes(x = year, y = non_irrigation_return_flow     )) + geom_line() + theme(axis.text = element_text(size = 6), axis.title = element_text(size = 6.5, , vjust = -0.005, face = "bold"))

# plot the charts
chart_table = cbind( 
                     rbind(ggplotGrob(chart_precipitation    ),
                           ggplotGrob(chart_land_evaporation ),
                           ggplotGrob(chart_total_evaporation),
                           ggplotGrob(chart_land_runoff      ),
                           ggplotGrob(chart_total_runoff     ), size = "last"), 

                     rbind(ggplotGrob(chart_gw_recharge              ),
                           ggplotGrob(chart_gw_baseflow              ),
                           ggplotGrob(chart_total_gw_abstraction     ),
                           ggplotGrob(chart_fossil_gw_abstraction    ),
                           ggplotGrob(chart_non_fossil_gw_abstraction), size = "last"), 

                     rbind(ggplotGrob(chart_total_withdrawal         ),
                           ggplotGrob(chart_desalination_withdrawal  ),
                           ggplotGrob(chart_surface_water_withdrawal ),
                           ggplotGrob(chart_fossil_gw_abstraction    ),
                           ggplotGrob(chart_non_fossil_gw_abstraction), size = "last"), 
                           
                     rbind(ggplotGrob(chart_total_withdrawal               ),
                           ggplotGrob(chart_irrigation_withdrawal          ),
                           ggplotGrob(chart_livestock_withdrawal           ),
                           ggplotGrob(chart_industry_withdrawal            ),
                           ggplotGrob(chart_domestic_withdrawal            ), size = "last"), 

                     rbind(ggplotGrob(chart_total_withdrawal               ),
                           ggplotGrob(chart_non_irrigation_withdrawal      ),
                           ggplotGrob(chart_irrigation_withdrawal          ),
                           ggplotGrob(chart_paddy_irrigation_withdrawal    ),
                           ggplotGrob(chart_non_paddy_irrigation_withdrawal), size = "last"), 
                           
                     rbind(ggplotGrob(chart_total_withdrawal               ),
                           ggplotGrob(chart_non_irrigation_withdrawal      ),
                           ggplotGrob(chart_livestock_withdrawal           ),
                           ggplotGrob(chart_non_irrigation_consumption     ),
                           ggplotGrob(chart_non_irrigation_return_flow     ), size = "last"), size = "last")

chart_file_name = paste(folder_for_the_analysis_output, "/chart_global_annual_fluxes_km3.pdf",sep ="")
print(chart_file_name)
pdf(file = chart_file_name, width = 11, height = 7)  # units are in inches
grid.newpage()
grid.draw(chart_table)
dev.off()

                           
