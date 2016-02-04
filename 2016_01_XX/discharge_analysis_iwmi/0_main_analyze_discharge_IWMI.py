#!/usr/bin/env python
# -*- coding: utf-8 -*-

# Edwin Husni Sutanudjaja (EHS, 06 Jun 2014): This is script for evaluating monthly simulated discharge to GRDC discharge data.
# Edwin Husni Sutanudjaja (EHS, 10 Jun 2014): I modify this script such that it can also be used for evaluating 30 arc-min results. 
# Edwin Husni Sutanudjaja (EHS, 26 Jun 2014): I modify this script such that it can also be used for evaluating a certain period of time series. 
# Edwin Husni Sutanudjaja (EHS, 04 Feb 2015): I use this script for re-analyzing the runs for IWMI. 

import os
import sys
import glob

import dischargeGRDC
import baseflowIWMI

import logging
from logger import Logger
# get name for the logger
logger = logging.getLogger("main_script")

# PCR-GLOBWB results: model output directory, 
pcrglobwb_output = {}
pcrglobwb_output["folder"]               = None # "/scratch/edwin/IWMI_run_20_nov/without_fossil_limit_with_pumping_limit_CRU/netcdf/"
pcrglobwb_output["netcdf_file_name"]     = None # "netcdf/discharge_monthAvg_output.nc" # "discharge_monthAvg_output.nc" 
pcrglobwb_output["netcdf_variable_name"] = None # "discharge" 

# output directory storing analysis results (results from this script)
globalAnalysisOutputDir = None  # "/scratch/edwin/IWMI_run_20_nov/without_fossil_limit_with_pumping_limit_CRU/analysis/monthly_discharge/"
cleanOutputDir          = True # option to clean analysisOutputDir 		

# optional: PCR-GLOBWB output and analysis output folders are given in the system argument
if len(sys.argv) > 1:
    pcrglobwb_output["folder"] = str(sys.argv[1])
    globalAnalysisOutputDir    = str(sys.argv[1])+"/analysis/"
    if len(sys.argv) > 2 and sys.argv[2] == "iwmi_calibration": globalAnalysisOutputDir = str(sys.argv[1])+"/analysis_iwmi/calibration/"
    if len(sys.argv) > 2 and sys.argv[2] == "iwmi_validation" : globalAnalysisOutputDir = str(sys.argv[1])+"/analysis_iwmi/validation/"
try:
    os.makedirs(globalAnalysisOutputDir) 
except:
    pass 

# time range for analyses
startDate = None # "1960-01-31" #YYYY-MM-DD # None 
endDate   = None # "2010-12-31" #YYYY-MM-DD # None 

# directory for GRDC monthly discharge files (and IWMI annual baseflow files) 
globalDirectoryGRDC = "/projects/0/dfguu/users/edwin/data/observation_data/pcrglobwb_sensitivity_analysis/grdc_monthly_discharge/"
# - for IWMI runs: There are 39 calibration stations and 65 validation stations used for validating monthly discharge. 
#                  However, for validating annual baseflow, due to the data quality and length, we use only 33 calibration stations and 54 for validation stations.
if len(sys.argv) > 2 and sys.argv[2] == "iwmi_calibration":
    globalDirectoryGRDC = "/projects/0/dfguu/users/edwin/data/observation_data/IWMI_calibration/monthly_discharge/for_calibration/"
    baseflowFolderIWMI  = "/projects/0/dfguu/users/edwin/data/observation_data/IWMI_calibration/annual_baseflow/for_calibration/"
if len(sys.argv) > 2 and sys.argv[2] == "iwmi_validation":
    globalDirectoryGRDC = "/projects/0/dfguu/users/edwin/data/observation_data/IWMI_calibration/monthly_discharge/for_validation/"
    baseflowFolderIWMI  = "/projects/0/dfguu/users/edwin/data/observation_data/IWMI_calibration/annual_baseflow/for_validation/"

# clone, ldd and cell area maps, for 30min results (of PCR-GLOBWB 2.0)
globalCloneMapFileName = "/projects/0/dfguu/data/hydroworld/PCRGLOBWB20/input30min/global/Global_CloneMap_30min.map"
lddMapFileName         = "/projects/0/dfguu/data/hydroworld/PCRGLOBWB20/input30min/routing/lddsound_30min.map"
cellAreaMapFileName    = "/projects/0/dfguu/data/hydroworld/PCRGLOBWB20/input30min/routing/cellarea30min.map"

# the following is needed for evaluating model results with 5 arcmin resolution
catchmentClassFileName = None 

def main():

    # discharge analysis
    ####################################################################################################
    #
    # make analysisOutputDir
    analysisOutputDir = globalAnalysisOutputDir+"/monthly_discharge/"
    try:
        os.makedirs(analysisOutputDir) 
    except:
        if cleanOutputDir == True: os.system('rm -r '+analysisOutputDir+"/*") 
    #
    # temporary directory (note that it is NOT a good idea to store temporary files in the memory (/dev/shm))
    temporary_directory = analysisOutputDir+"/tmp/"
    try:
        os.makedirs(temporary_directory) 
    except:
        os.system('rm -r '+temporary_directory+"/*") # make sure that temporary directory is clean 
    #
    # logger object for discharge analysis
    logger = Logger(analysisOutputDir)
    #
    # monthly discharge evaluation (based on GRDC data)
    dischargeEvaluation = dischargeGRDC.DischargeEvaluation(pcrglobwb_output["folder"],\
                                                            startDate,endDate,temporary_directory)
    # - get GRDC attributes of all stations:
    dischargeEvaluation.get_grdc_attributes(directoryGRDC = globalDirectoryGRDC)
    #
    # - evaluate monthly discharge results
    pcrglobwb_output["netcdf_file_name"]     = "netcdf/discharge_monthAvg_output.nc"
    pcrglobwb_output["netcdf_variable_name"] = "discharge"
    dischargeEvaluation.evaluateAllModelResults(globalCloneMapFileName,\
                                                catchmentClassFileName,\
                                                lddMapFileName,\
                                                cellAreaMapFileName,\
                                                pcrglobwb_output,\
                                                analysisOutputDir)  
    ####################################################################################################


    # baseflow analysis
    ####################################################################################################
    #
    if len(sys.argv) > 2 and (sys.argv[2] == "iwmi_calibration" or\
                              sys.argv[2] == "iwmi_validation"):
        # make analysisOutputDir
        analysisOutputDir = globalAnalysisOutputDir+"/annual_baseflow/"
        try:
            os.makedirs(analysisOutputDir) 
        except:
            if cleanOutputDir == True: os.system('rm -r '+analysisOutputDir+"/*") 
        #
        # logger object for baseflow analysis
        logger = Logger(analysisOutputDir)
        #
        # annual baseflow evaluation (based on baseflow data)
        baseflowEvaluation = baseflowIWMI.BaseflowEvaluation(pcrglobwb_output["folder"],\
                                                             startDate,endDate,temporary_directory)
        # - get GRDC attributes of all stations 
        #   (based on the previous analysis on monthly discharge)
        baseflowEvaluation.get_grdc_attributes(dischargeEvaluation.attributeGRDC, baseflowFolderIWMI)
        #
        # - evaluate annual baseflow time series
        pcrglobwb_output["netcdf_file_name"]     = "netcdf/accuBaseflow_annuaAvg_output.nc"
        pcrglobwb_output["netcdf_variable_name"] = "accumulated_land_surface_baseflow"
        baseflowEvaluation.evaluateAllBaseflowResults(globalCloneMapFileName,\
                                                      catchmentClassFileName,\
                                                      lddMapFileName,\
                                                      cellAreaMapFileName,\
                                                      pcrglobwb_output,\
                                                      analysisOutputDir)  
    ####################################################################################################


if __name__ == '__main__':
    sys.exit(main())
