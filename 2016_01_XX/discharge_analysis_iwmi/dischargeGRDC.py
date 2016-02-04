import os
import re
import glob
import datetime

import numpy as np
import pcraster as pcr
import netCDF4 as nc

import virtualOS as vos

import logging
# logger object
logger = logging.getLogger(__name__)

# the following dictionary is needed to avoid open and closing files
filecache = dict()

class DischargeEvaluation(object):

    def __init__(self, modelOutputFolder,startDate=None,endDate=None,temporary_directory=None):
        object.__init__(self)
        
        logger.info('Evaluating the model results (monthly discharge) stored in %s.', modelOutputFolder)
        
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
                "grdc_file_name",               
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
                "num_of_month_pairs",           
                "table_file_name",              
                "chart_file_name",              
                "average_observation",          
                "average_model",                
                "bias",                         
                "correlation",                  
                "R2",                           
                "R2_adjusted",                  
                "rmse",                         
                "mae",                          
                "ns_efficiency",                
                "ns_efficiency_log",
                "kge_2009",
                "kge_2012"]
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

    def get_grdc_attributes(self, directoryGRDC):
        
        # Currently, we just use monthly observation.
        filesIndirectoryGRDC = directoryGRDC+'/*.mon'
        
        fileList = glob.glob(filesIndirectoryGRDC) 
        
        for fileName in fileList:
            print fileName
            self.getAttributeForEachStation(fileName)

    def getAttributeForEachStation(self,fileName):

        # read the file
        f = open(fileName) ; allLines = f.read() ; f.close()
        
        # split the content of the file into several lines
        allLines = allLines.replace("\r","") 
        allLines = allLines.split("\n")

        # get grdc ids (from files) and check their consistency with their file names  
        id_from_file_name =  int(os.path.basename(fileName).split(".")[0])
        id_from_grdc = None
        if id_from_file_name == int(allLines[ 8].split(":")[1].replace(" ","")):
            id_from_grdc = int(allLines[ 8].split(":")[1].replace(" ",""))
        else:
            logger.info("GRDC station "+str(id_from_file_name)+" ("+str(fileName)+") is NOT used.")
            
        if id_from_grdc != None:
            
            # initiate the dictionary values for each station (put all values to "NA")
            for key in self.attributeGRDC.items(): 
                self.attributeGRDC[key[0]][str(id_from_grdc)] = "NA"
            
            # get the attributes for each station:
            try:

                # make sure the station has coordinate:
                grdc_latitude_in_arc_degree  = float(allLines[12].split(":")[1].replace(" ",""))
                grdc_longitude_in_arc_degree = float(allLines[13].split(":")[1].replace(" ",""))

                # get the catchment area (unit: km2)
                try:
                    grdc_catchment_area_in_km2 = float(allLines[14].split(":")[1].replace(" ",""))
                    if grdc_catchment_area_in_km2 <= 0.0:\
                       grdc_catchment_area_in_km2  = "NA" 
                except:
                    grdc_catchment_area_in_km2 = "NA"

                # get the river name
                try:
                    river_name = str(allLines[ 9].split(":")[1].replace(" ",""))
                    river_name = re.sub("[^A-Za-z]", "_", river_name)
                except:
                    river_name = "NA"
                
                # get the station name
                try:
                    station_name = str(allLines[10].split(":")[1].replace(" ",""))
                    station_name = re.sub("[^A-Za-z]", "_", station_name)
                except:
                    station_name = "NA"
                
                # get the country code
                try:
                    country_code = str(allLines[11].split(":")[1].replace(" ",""))
                    country_code = re.sub("[^A-Za-z]", "_", country_code)
                except:
                    country_code = "NA"

                self.attributeGRDC["id_from_grdc"][str(id_from_grdc)]                 = id_from_grdc
                self.attributeGRDC["grdc_file_name"][str(id_from_grdc)]               = fileName
                self.attributeGRDC["river_name"][str(id_from_grdc)]                   = river_name
                self.attributeGRDC["station_name"][str(id_from_grdc)]                 = station_name
                self.attributeGRDC["country_code"][str(id_from_grdc)]                 = country_code
                self.attributeGRDC["grdc_latitude_in_arc_degree"][str(id_from_grdc)]  = grdc_latitude_in_arc_degree 
                self.attributeGRDC["grdc_longitude_in_arc_degree"][str(id_from_grdc)] = grdc_longitude_in_arc_degree
                self.attributeGRDC["grdc_catchment_area_in_km2"][str(id_from_grdc)]   = grdc_catchment_area_in_km2  
                
                logger.info("GRDC station "+str(id_from_file_name)+" ("+str(fileName)+") is used.")
                # add grdc id to the list (that will be processed later)
                self.list_of_grdc_ids.append(int(id_from_grdc))

            except:
                
                logger.info("GRDC station "+str(id_from_file_name)+" ("+str(fileName)+") is NOT used.")
            
            
    def evaluateAllModelResults(self,globalCloneMapFileName,\
                                catchmentClassFileName,\
                                lddMapFileName,\
                                cellAreaMapFileName,\
                                pcrglobwb_output,\
                                analysisOutputDir="",\
                                tmpDir = None):     

        # temporary directory
        if tmpDir == None: tmpDir = self.tmpDir+"/edwin_grdc_"
        
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
        self.cell_size_in_arc_degree = vos.getMapAttributesALL(globalCloneMapFileName)['cellsize']
        
        lddMap = pcr.lddrepair(pcr.readmap(lddMapFileName))
        cellArea = pcr.scalar(pcr.readmap(cellAreaMapFileName))
        
        # The landMaskClass map contains the nominal classes for all landmask regions. 
        landMaskClass = pcr.nominal(cloneMap)  # default: if catchmentClassFileName is not given
        if catchmentClassFileName != None:
            landMaskClass = pcr.nominal(pcr.readmap(catchmentClassFileName))

        # model catchment areas and cordinates
        catchmentAreaAll = pcr.catchmenttotal(cellArea, lddMap) / (1000*1000)  # unit: km2
        xCoordinate = pcr.xcoordinate(cloneMap)
        yCoordinate = pcr.ycoordinate(cloneMap)
        
        for id in self.list_of_grdc_ids: 

            logger.info("Evaluating simulated discharge to the grdc observation at "+str(self.attributeGRDC["id_from_grdc"][str(id)])+".")
            
            # identify model pixel
            self.identifyModelPixel(tmpDir,catchmentAreaAll,landMaskClass,xCoordinate,yCoordinate,str(id))

            # evaluate model results to GRDC data
            self.evaluateModelResultsToGRDC(str(id),pcrglobwb_output,catchmentClassFileName,tmpDir)
            
        # write the summary to a table 
        summary_file = analysisOutputDir+"summary.txt"
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

    def identifyModelPixel(self,tmpDir,\
                                catchmentAreaAll,\
                                landMaskClass,\
                                xCoordinate,yCoordinate,id):     

        # TODO: Include an option to consider average discharge. 
        
        logger.info("Identify model pixel for the grdc station "+str(id)+".")
        
        # make a temporary directory:
        randomDir = self.makeRandomDir(tmpDir) 

        # coordinate of grdc station
        xCoord  = float(self.attributeGRDC["grdc_longitude_in_arc_degree"][str(id)])
        yCoord  = float(self.attributeGRDC["grdc_latitude_in_arc_degree"][str(id)])
        
        # identify the point at pcraster model
        point = pcr.ifthen((pcr.abs(xCoordinate - xCoord) == pcr.mapminimum(pcr.abs(xCoordinate - xCoord))) &\
                           (pcr.abs(yCoordinate - yCoord) == pcr.mapminimum(pcr.abs(yCoordinate - yCoord))), \
                            pcr.boolean(1))
        
        # expanding the point
        point = pcr.windowmajority(point, self.cell_size_in_arc_degree * 5.0)
        point = pcr.ifthen(catchmentAreaAll > 0, point)
        point = pcr.boolean(point)

        # values based on the model;
        modelCatchmentArea = pcr.ifthen(point, catchmentAreaAll)        # unit: km2
        model_x_ccordinate = pcr.ifthen(point, xCoordinate)             # unit: arc degree
        model_y_ccordinate = pcr.ifthen(point, yCoordinate)             # unit: arc degree
        
        # calculate (absolute) difference with GRDC data
        # - initiating all of them with the values of MV
        diffCatchArea = pcr.abs(pcr.scalar(vos.MV))        # difference between the model and grdc catchment area (unit: km2) 
        diffDistance  = pcr.abs(pcr.scalar(vos.MV))        # distance between the model pixel and grdc catchment station (unit: arc degree)
        diffLongitude = pcr.abs(pcr.scalar(vos.MV))        # longitude difference (unit: arc degree)
        diffLatitude  = pcr.abs(pcr.scalar(vos.MV))        # latitude difference (unit: arc degree)
        #
        # - calculate (absolute) difference with GRDC data
        try:
            diffCatchArea = pcr.abs(modelCatchmentArea-\
                            float(self.attributeGRDC["grdc_catchment_area_in_km2"][str(id)]))
        except:
            logger.info("The difference in the model and grdc catchment area cannot be calculated.")
        try:
            diffLongitude = pcr.abs(model_x_ccordinate - xCoord)
        except:
            logger.info("The difference in longitude cannot be calculated.")
        try:
            diffLatitude  = pcr.abs(model_y_ccordinate - yCoord)
        except:
            logger.info("The difference in latitude cannot be calculated.")
        try:
            diffDistance  = (diffLongitude**(2) + \
                              diffLatitude**(2))**(0.5)                 # TODO: calculate distance in meter
        except:
            logger.info("Distance cannot be calculated.")
        
        # identify  masks
        masks = pcr.ifthen(pcr.boolean(point), landMaskClass)                                          

        # export the difference to temporary files: maps and txt
        catchmentAreaMap = randomDir+"/"+vos.get_random_word()+".area.map"
        diffCatchAreaMap = randomDir+"/"+vos.get_random_word()+".dare.map"
        diffDistanceMap  = randomDir+"/"+vos.get_random_word()+".dist.map"
        diffLatitudeMap  = randomDir+"/"+vos.get_random_word()+".dlat.map"
        diffLongitudeMap = randomDir+"/"+vos.get_random_word()+".dlon.map"
        diffLatitudeMap  = randomDir+"/"+vos.get_random_word()+".dlat.map"
        #
        maskMap          = randomDir+"/"+vos.get_random_word()+".mask.map"
        diffColumnFile   = randomDir+"/"+vos.get_random_word()+".cols.txt" # output
        #
        pcr.report(pcr.ifthen(point,modelCatchmentArea), catchmentAreaMap)
        pcr.report(pcr.ifthen(point,diffCatchArea     ), diffCatchAreaMap)
        pcr.report(pcr.ifthen(point,diffDistance      ), diffDistanceMap )
        pcr.report(pcr.ifthen(point,diffLatitude      ), diffLongitudeMap)
        pcr.report(pcr.ifthen(point,diffLongitude     ), diffLatitudeMap )
        pcr.report(pcr.ifthen(point,masks             ), maskMap)
        #
        cmd = 'map2col '+catchmentAreaMap +' '+\
                         diffCatchAreaMap +' '+\
                         diffDistanceMap  +' '+\
                         diffLongitudeMap +' '+\
                         diffLatitudeMap  +' '+\
                         maskMap+' '+diffColumnFile
        print(cmd); os.system(cmd) 
        
        # use R to sort the file
        cmd = 'R -f saveIdentifiedPixels.R '+diffColumnFile
        print(cmd); os.system(cmd) 
        
        try:
            # read the output file (from R)
            f = open(diffColumnFile+".sel") ; allLines = f.read() ; f.close()
        
            # split the content of the file into several lines
            allLines = allLines.replace("\r",""); allLines = allLines.split("\n")
        
            selectedPixel = allLines[0].split(";")

            model_longitude_in_arc_degree = float(selectedPixel[0])
            model_latitude_in_arc_degree  = float(selectedPixel[1])
            model_catchment_area_in_km2   = float(selectedPixel[2])
            model_landmask                = str(selectedPixel[7])
            
            log_message  = "Model pixel for grdc station "+str(id)+" is identified (lat/lon in arc degree): "
            log_message += str(model_latitude_in_arc_degree) + " ; " +  str(model_longitude_in_arc_degree)
            logger.info(log_message)
            
            self.attributeGRDC["model_longitude_in_arc_degree"][str(id)] = model_longitude_in_arc_degree 
            self.attributeGRDC["model_latitude_in_arc_degree"][str(id)]  = model_latitude_in_arc_degree  
            self.attributeGRDC["model_catchment_area_in_km2"][str(id)]   = model_catchment_area_in_km2   
            self.attributeGRDC["model_landmask"][str(id)]                = model_landmask                

        except:
        
            logger.info("Model pixel for grdc station "+str(id)+" can NOT be identified.")
        
        self.cleanRandomDir(randomDir)

    def swapRows(self,a):
        #-swaps an array upside-down
        b= a.copy()
        for rowCnt in xrange(a.shape[0]):
            revRowCnt= a.shape[0]-(rowCnt+1)
            b[revRowCnt,:]= a[rowCnt,:]
        return b

    def evaluateModelResultsToGRDC(self,id,pcrglobwb_output,catchmentClassFileName,tmpDir):
        
        try:
            
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

            #~ #
            #~ # IN PROGRESS swap rows if needed ?? - It seems that this one is not necessary. 
            #~ if f.variables['lat'][0] < f.variables['lat'][1]: 
                #~ f.variables[varName][:] = self.swapRows(f.variables[varName][:])
                #~ f.variables['lat'][:] = f.variables['lat'][::-1]
            
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
            cmd = 'R -f evaluateMonthlyDischarge.R '+self.attributeGRDC["grdc_file_name"][str(id)]+' '+txtModelFile
            print(cmd); os.system(cmd)
            
            # get model performance: read the output file (from R)
            try: 
                outputFile = txtModelFile+".out"
                f = open(outputFile) ; allLines = f.read() ; f.close()
                # split the content of the file into several lines
                allLines = allLines.replace("\r",""); allLines = allLines.split("\n")
                # performance values
                performance = allLines[2].split(";")
                #
        
                nPairs          = float(performance[0])
                avg_obs         = float(performance[1])
                avg_sim         = float(performance[2])
                KGE_2009        = float(performance[3])
                KGE_2012        = float(performance[4])
                NSeff           = float(performance[5])
                NSeff_log       = float(performance[6])
                rmse            = float(performance[7])
                mae             = float(performance[8])
                bias            = float(performance[9])
                R2              = float(performance[10])
                R2ad            = float(performance[11])
                correlation     = float(performance[12])
                #
                table_file_name = self.tableOutputDir+"/"+\
                                                          str(self.attributeGRDC["country_code"][str(id)])+"_"+\
                                                          str(self.attributeGRDC["river_name"][str(id)])  +"_"+\
                                                          str(self.attributeGRDC["id_from_grdc"][str(id)])+"_"+\
                                                          str(self.attributeGRDC["station_name"][str(id)])+"_"+\
                                                          "table.txt"
                cmd = 'cp '+txtModelFile+".out "+table_file_name
                print(cmd); os.system(cmd)
                logger.info("Copying the model result for the grdc station "+str(id)+" to a column/txt file: "+str(table_file_name)+".")
                #
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

                nPairs          = "NA"
                avg_obs         = "NA"
                avg_sim         = "NA"
                KGE_2009        = "NA"
                KGE_2012        = "NA"
                NSeff           = "NA"
                NSeff_log       = "NA"
                rmse            = "NA"
                mae             = "NA"
                bias            = "NA"
                R2              = "NA"
                R2ad            = "NA"
                correlation     = "NA"
                chart_file_name = "NA"
                table_file_name = "NA"
        
                logger.info("Evaluation model result to the grdc observation can NOT be performed.")

            # clean (random) temporary directory
            self.cleanRandomDir(randomDir)
            
            self.attributeGRDC["num_of_month_pairs"][str(id)]  = nPairs               
            self.attributeGRDC["average_observation"][str(id)] = avg_obs            
            self.attributeGRDC["average_model"][str(id)]       = avg_sim                   
            self.attributeGRDC["kge_2009"][str(id)]            = KGE_2009                     
            self.attributeGRDC["kge_2012"][str(id)]            = KGE_2012                     
            self.attributeGRDC["ns_efficiency"][str(id)]       = NSeff                     
            self.attributeGRDC["ns_efficiency_log"][str(id)]   = NSeff_log            
            self.attributeGRDC["rmse"][str(id)]                = rmse                               
            self.attributeGRDC["mae"][str(id)]                 = mae                                
            self.attributeGRDC["bias"][str(id)]                = bias                               
            self.attributeGRDC["R2"][str(id)]                  = R2                                   
            self.attributeGRDC["R2_adjusted"][str(id)]         = R2ad                       
            self.attributeGRDC["correlation"][str(id)]         = correlation                
            self.attributeGRDC["chart_file_name"][str(id)]     = chart_file_name 
            self.attributeGRDC["table_file_name"][str(id)]     = table_file_name 
            
        except: 

            logger.info("Evaluation model result to the grdc observation can NOT be performed.")
