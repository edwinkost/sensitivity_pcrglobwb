import os
import re
import glob
import datetime

import netCDF4 as nc
import numpy as np

import pcraster as pcr

import virtualOS as vos

import logging
# logger object
logger = logging.getLogger(__name__)

# the following dictionary is needed to avoid open and closing files
filecache = dict()

class BaseflowEvaluation(object):

    def __init__(self, modelOutputFolder,startDate=None,endDate=None,temporary_directory=None):
        object.__init__(self)
        
        logger.info('Evaluating the model results (annual baseflow) stored in %s.', modelOutputFolder)
        
        self.startDate = startDate
        self.endDate   =   endDate
        if (self.startDate != None) and (self.endDate != None):
            self.startDate = datetime.datetime.strptime(str(startDate),'%Y-%m-%d')
            self.endDate   = datetime.datetime.strptime(str(  endDate),'%Y-%m-%d')
            logger.info("Only results from "+str(self.startDate)+" to "+str(self.endDate)+" are analyzed to available observation data.")
        else:
            logger.info("Entire model results will be analyzed to available observation data.")

        self.tmpDir = "/dev/shm/"
        if temporary_directory != None: self.tmpDir = temporary_directory

        # initiating a dictionary that will contain all GRDC attributes:
        self.attributeGRDC = {}
        #
        # initiating keys in GRDC dictionary 
        self.grdc_dict_keys = \
                ["id_from_grdc",                 
                "iwmi_annual_baseflow_file_name",               
                "river_name",                   
                "station_name",                 
                "country_code",                 
                "grdc_catchment_area_in_km2",   
                "grdc_latitude_in_arc_degree",  
                "grdc_longitude_in_arc_degree", 
                "model_catchment_area_in_km2",  
                "model_latitude_in_arc_degree", 
                "model_longitude_in_arc_degree",
                "model_landmask",               
                "num_of_annual_pairs",           
                "table_file_name",              
                "chart_file_name",              
                "average_iwmi_opt_baseflow",          
                "average_iwmi_max_baseflow",          
                "average_iwmi_min_baseflow",          
                "average_model",                
                "bias",                         
                "correlation",                  
                "R2",                           
                "R2_adjusted",                  
                "rmse",                         
                "mae",                          
                "ns_efficiency",                
                "ns_efficiency_log",
                "avg_baseflow_deviation"]
        #
        for key in self.grdc_dict_keys: self.attributeGRDC[key] = {}                     

        # initiating a list that will contain all grdc ids that will be used
        self.list_of_grdc_ids = []                  

        # initiating a list that will contain random (temporary) directories 
        # (this list should be empty at the end of the calculation):
        self.randomDirList = [] 

    def makeRandomDir(self,tmpDir):

        # make a random (temporary) directory (default: in the memory)
        randomDir = tmpDir + vos.get_random_word()
        directoryExist = True
        while directoryExist:
            try:
                os.makedirs(randomDir)
                directoryExist = False
                self.randomDirList.append(randomDir) 
            except:
                # generate another random directory
                randomDir = tmpDir + vos.get_random_word()
        return randomDir        
        # PS: do not forget to delete this random directory.

    def cleanRandomDir(self,randomDir):

        # clean randomDir
        cmd = 'rm -r '+randomDir+"*"
        print(cmd); os.system(cmd)
        self.randomDirList.remove(randomDir)
        if self.randomDirList != []: print "WARNING!: randomDir(s) found: ", self.randomDirList  

    def get_grdc_attributes(self, attributeDischargeGRDC, baseflowFolderIWMI):
        
        for id_from_grdc in attributeDischargeGRDC["id_from_grdc"].keys():
            
            self.attributeGRDC["id_from_grdc"][id_from_grdc]                   = attributeDischargeGRDC["id_from_grdc"][id_from_grdc]
            self.attributeGRDC["river_name"][id_from_grdc]                     = attributeDischargeGRDC["river_name"][id_from_grdc]                  
            self.attributeGRDC["station_name"][id_from_grdc]                   = attributeDischargeGRDC["station_name"][id_from_grdc]                
            self.attributeGRDC["country_code"][id_from_grdc]                   = attributeDischargeGRDC["country_code"][id_from_grdc]               
            self.attributeGRDC["grdc_latitude_in_arc_degree"][id_from_grdc]    = attributeDischargeGRDC["grdc_latitude_in_arc_degree"][id_from_grdc]
            self.attributeGRDC["grdc_longitude_in_arc_degree"][id_from_grdc]   = attributeDischargeGRDC["grdc_longitude_in_arc_degree"][id_from_grdc]
            self.attributeGRDC["grdc_catchment_area_in_km2"][id_from_grdc]     = attributeDischargeGRDC["grdc_catchment_area_in_km2"][id_from_grdc] 
                
            self.attributeGRDC["model_longitude_in_arc_degree"][id_from_grdc]  = attributeDischargeGRDC["model_longitude_in_arc_degree"][id_from_grdc]
            self.attributeGRDC["model_latitude_in_arc_degree"][id_from_grdc]   = attributeDischargeGRDC["model_latitude_in_arc_degree"][id_from_grdc] 
            self.attributeGRDC["model_catchment_area_in_km2"][id_from_grdc]    = attributeDischargeGRDC["model_catchment_area_in_km2"][id_from_grdc]  
            self.attributeGRDC["model_landmask"][id_from_grdc]                 = attributeDischargeGRDC["model_landmask"][id_from_grdc]               

            iwmi_annual_baseflow_file_name = str(os.path.abspath(baseflowFolderIWMI+"/"+str(id_from_grdc)+".out"))
            self.attributeGRDC["iwmi_annual_baseflow_file_name"][id_from_grdc] = iwmi_annual_baseflow_file_name

            logger.info("IWMI annual baseflow time series "+str(iwmi_annual_baseflow_file_name)+" will be used.")
            # add grdc id to the list (that will be processed later)
            self.list_of_grdc_ids.append(int(id_from_grdc))

    def evaluateAllBaseflowResults(self,globalCloneMapFileName,\
                                   catchmentClassFileName,\
                                   lddMapFileName,\
                                   cellAreaMapFileName,\
                                   pcrglobwb_output,\
                                   analysisOutputDir="",\
                                   tmpDir = None):     

        # temporary directory
        if tmpDir == None: tmpDir = self.tmpDir+"/edwin_iwmi_"

        # output directory for all analyses for all stations
        analysisOutputDir   = str(analysisOutputDir)
        self.chartOutputDir = analysisOutputDir+"/chart/"
        self.tableOutputDir = analysisOutputDir+"/table/"
        #
        if analysisOutputDir == "": self.chartOutputDir = "chart/"
        if analysisOutputDir == "": self.tableOutputDir = "table/"
        #
        # make the chart and table directories:
        os.system('rm -r '+self.chartOutputDir+"*")
        os.system('rm -r '+self.tableOutputDir+"*")
        os.makedirs(self.chartOutputDir)
        os.makedirs(self.tableOutputDir)
        
        # cloneMap for all pcraster operations
        pcr.setclone(globalCloneMapFileName)
        cloneMap = pcr.boolean(1)
        
        lddMap = pcr.lddrepair(pcr.readmap(lddMapFileName))
        cellArea = pcr.scalar(pcr.readmap(cellAreaMapFileName))
        
        # The landMaskClass map contains the nominal classes for all landmask regions. 
        landMaskClass = pcr.nominal(cloneMap)  # default: if catchmentClassFileName is not given
        if catchmentClassFileName != None:
            landMaskClass = pcr.nominal(pcr.readmap(catchmentClassFileName))

        for id in self.list_of_grdc_ids: 

            logger.info("Evaluating simulated annual baseflow time series to IWMI baseflow time series at "+str(self.attributeGRDC["id_from_grdc"][str(id)])+".")
            
            # evaluate model results to GRDC data
            self.evaluateBaseflowResult(str(id),pcrglobwb_output,catchmentClassFileName,tmpDir)
            
        # write the summary to a table 
        summary_file = analysisOutputDir+"baseflow_summary.txt"
        #
        logger.info("Writing the summary for all stations to the file: "+str(summary_file)+".")
        #
        # prepare the file:
        summary_file_handle = open(summary_file,"w")
        #
        # write the header
        summary_file_handle.write( ";".join(self.grdc_dict_keys)+"\n")
        #
        # write the content
        for id in self.list_of_grdc_ids:
            rowLine  = ""
            for key in self.grdc_dict_keys: rowLine += str(self.attributeGRDC[key][str(id)]) + ";"   
            rowLine = rowLine[0:-1] + "\n"
            summary_file_handle.write(rowLine)
        summary_file_handle.close()           

    def evaluateBaseflowResult(self,id,pcrglobwb_output,catchmentClassFileName,tmpDir):
        
        # open and crop the netcdf file that contains the result
        ncFile = pcrglobwb_output['folder']+"/"+pcrglobwb_output["netcdf_file_name"] 

        # for high resolution output, the netcdf files are usually splitted in several files
        if catchmentClassFileName != None:
            
            # identify the landmask
            landmaskCode = str(self.attributeGRDC["model_landmask"][str(id)])
            if int(landmaskCode) < 10: landmaskCode = "0"+landmaskCode 

            # identify the landmask - # TODO: THIS MUST BE FIXED
            ncFile = "/projects/wtrcycle/users/edwinhs/two_layers_with_demand_one_degree_zonation_cruts3.21-era_interim_5arcmin_but_30minArno"+"/M"+landmaskCode+"/netcdf/discharge_monthAvg_output.nc"
        
        logger.info("Reading and evaluating the model result for the grdc station "+str(id)+" from "+ncFile)
        
        if ncFile in filecache.keys():
            f = filecache[ncFile]
            print "Cached: ", ncFile
        else:
            f = nc.Dataset(ncFile)
            filecache[ncFile] = f
            print "New: ", ncFile

        #
        varName = pcrglobwb_output["netcdf_variable_name"]
        try:
            f.variables['lat'] = f.variables['latitude']
            f.variables['lon'] = f.variables['longitude']
        except:
            pass

        # identify row and column indexes:
        #
        lon     = float(self.attributeGRDC["model_longitude_in_arc_degree"][str(id)])
        minX    = min(abs(f.variables['lon'][:] - lon))
        xStationIndex = int(np.where(abs(f.variables['lon'][:] - lon) == minX)[0])  
        #
        lat     = float(self.attributeGRDC["model_latitude_in_arc_degree"][str(id)])
        minY    = min(abs(f.variables['lat'][:] - lat))
        yStationIndex = int(np.where(abs(f.variables['lat'][:] - lat) == minY)[0])  

        # cropping the data:
        cropData = f.variables[varName][:,yStationIndex,xStationIndex]

        # select specific ranges of date/year
        nctime   = f.variables['time']                                # A netCDF time variable object. 
        cropTime = nctime[:]

        if (self.startDate != None) and (self.endDate != None):
            idx_start = nc.date2index(self.startDate, \
                                      nctime, \
                                      calendar = nctime.calendar, \
                                      select = 'exact')
            idx_end   = nc.date2index(self.endDate, \
                                      nctime, \
                                      calendar = nctime.calendar, \
                                      select = 'exact')
            cropData = cropData[int(idx_start):int(idx_end+1)]
            cropTime = cropTime[int(idx_start):int(idx_end+1)]

        cropData = np.column_stack((cropTime,cropData))
        print(cropData)
        
        # make a randomDir containing txt files (attribute and model result):
        randomDir = self.makeRandomDir(tmpDir) 
        txtModelFile = randomDir+"/"+vos.get_random_word()+".txt"
        
        # write important attributes to a .atr file 
        #
        atrModel = open(txtModelFile+".atr","w")
        atrModel.write("# grdc_id: "                    +str(self.attributeGRDC["id_from_grdc"][str(id)])+"\n")
        atrModel.write("# country_code: "               +str(self.attributeGRDC["country_code"][str(id)])+"\n")
        atrModel.write("# river_name: "                 +str(self.attributeGRDC["river_name"][str(id)])+"\n")  
        atrModel.write("# station_name: "               +str(self.attributeGRDC["station_name"][str(id)])+"\n")  
        atrModel.write("# grdc_catchment_area_in_km2: " +str(self.attributeGRDC["grdc_catchment_area_in_km2"][str(id)])+"\n")  
        #
        atrModel.write("# model_landmask: "             +str(self.attributeGRDC["model_landmask"][str(id)])+"\n")  
        atrModel.write("# model_latitude: "             +str(self.attributeGRDC["model_latitude_in_arc_degree"][str(id)])+"\n")  
        atrModel.write("# model_longitude: "            +str(self.attributeGRDC["model_longitude_in_arc_degree"][str(id)])+"\n")  
        atrModel.write("# model_catchment_area_in_km2: "+str(self.attributeGRDC["model_catchment_area_in_km2"][str(id)])+"\n")  
        atrModel.write("####################################################################################\n")  
        atrModel.close()
        
        # save cropData to a .txt file:
        txtModel = open(txtModelFile,"w")
        np.savetxt(txtModelFile,cropData,delimiter=";") # two columns with date and model_result
        txtModel.close()
        
        # run R for evaluation
        cmd = 'R -f evaluateAnnualBaseflow.R '+self.attributeGRDC["iwmi_annual_baseflow_file_name"][str(id)]+' '+txtModelFile
        print(cmd); os.system(cmd)
        
        # get model performance: read the output file (from R)
        try: 
            outputFile = txtModelFile+".out"
            f = open(outputFile) ; allLines = f.read() ; f.close()
            # split the content of the file into several lines
            allLines = allLines.replace("\r",""); allLines = allLines.split("\n")
            
            # performance values
            performance = allLines[2].split(";")

            print performance

            #
            nPairs                 = float(performance[0])
            avg_opt_obs            = float(performance[1])
            avg_max_obs            = float(performance[2])
            avg_min_obs            = float(performance[3])
            avg_sim                = float(performance[4])
            NSeff                  = float(performance[5])
            NSeff_log              = float(performance[6])
            rmse                   = float(performance[7])
            mae                    = float(performance[8])
            bias                   = float(performance[9])
            R2                     = float(performance[10])
            R2ad                   = float(performance[11])
            correlation            = float(performance[12])
            avg_baseflow_deviation = float(performance[13])

            table_file_name = self.tableOutputDir+"/"+\
                                                      str(self.attributeGRDC["country_code"][str(id)])+"_"+\
                                                      str(self.attributeGRDC["river_name"][str(id)])  +"_"+\
                                                      str(self.attributeGRDC["id_from_grdc"][str(id)])+"_"+\
                                                      str(self.attributeGRDC["station_name"][str(id)])+"_"+\
                                                      "table.txt"
            cmd = 'cp '+txtModelFile+".out "+table_file_name
            print(cmd); os.system(cmd)
            logger.info("Copying the model result for the grdc station "+str(id)+" to a column/txt file: "+str(table_file_name)+".")

            chart_file_name = self.chartOutputDir+"/"+\
                                                      str(self.attributeGRDC["country_code"][str(id)])+"_"+\
                                                      str(self.attributeGRDC["river_name"][str(id)])  +"_"+\
                                                      str(self.attributeGRDC["id_from_grdc"][str(id)])+"_"+\
                                                      str(self.attributeGRDC["station_name"][str(id)])+"_"+\
                                                      "chart.pdf"
            cmd = 'cp '+txtModelFile+".out.pdf "+chart_file_name
            print(cmd); os.system(cmd)
            logger.info("Saving the time series plot for the grdc station "+str(id)+" to a pdf file: "+str(chart_file_name)+".")
            
        except: 

            nPairs                 = "NA"
            avg_opt_obs            = "NA"
            avg_max_obs            = "NA"
            avg_min_obs            = "NA"
            avg_sim                = "NA"
            NSeff                  = "NA"
            NSeff_log              = "NA"
            rmse                   = "NA"
            mae                    = "NA"
            bias                   = "NA"
            R2                     = "NA"
            R2ad                   = "NA"
            correlation            = "NA"
            avg_baseflow_deviation = "NA"
            
            chart_file_name = "NA"
            table_file_name = "NA"
        
            logger.info("Evaluation baseflow time series can NOT be performed.")

        # clean (random) temporary directory
        self.cleanRandomDir(randomDir)
        
        self.attributeGRDC["num_of_annual_pairs"][str(id)]       = nPairs               
        self.attributeGRDC["average_iwmi_opt_baseflow"][str(id)] = avg_opt_obs            
        self.attributeGRDC["average_iwmi_max_baseflow"][str(id)] = avg_max_obs            
        self.attributeGRDC["average_iwmi_min_baseflow"][str(id)] = avg_min_obs            
        self.attributeGRDC["average_model"][str(id)]             = avg_sim                   
        self.attributeGRDC["ns_efficiency"][str(id)]             = NSeff                     
        self.attributeGRDC["ns_efficiency_log"][str(id)]         = NSeff_log            
        self.attributeGRDC["rmse"][str(id)]                      = rmse                               
        self.attributeGRDC["mae"][str(id)]                       = mae                                
        self.attributeGRDC["bias"][str(id)]                      = bias                               
        self.attributeGRDC["R2"][str(id)]                        = R2                                   
        self.attributeGRDC["R2_adjusted"][str(id)]               = R2ad                       
        self.attributeGRDC["correlation"][str(id)]               = correlation                
        self.attributeGRDC["chart_file_name"][str(id)]           = chart_file_name 
        self.attributeGRDC["table_file_name"][str(id)]           = table_file_name 
        self.attributeGRDC["avg_baseflow_deviation"][str(id)]    = avg_baseflow_deviation
