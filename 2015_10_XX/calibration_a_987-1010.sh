#!/bin/bash
#SBATCH -N 1
#SBATCH -t 48:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__987 1.25 1 0 0.75 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__988 1.25 1 0.5 0.75 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__989 1.25 1 1 0.75 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__990 1.25 -1 -1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__991 1.25 -1 -0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__992 1.25 -1 0 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__993 1.25 -1 0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__994 1.25 -1 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__995 1.25 -0.75 -1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__996 1.25 -0.75 -0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__997 1.25 -0.75 0 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__998 1.25 -0.75 0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__999 1.25 -0.75 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1000 1.25 -0.5 -1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1001 1.25 -0.5 -0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1002 1.25 -0.5 0 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1003 1.25 -0.5 0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1004 1.25 -0.5 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1005 1.25 -0.25 -1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1006 1.25 -0.25 -0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1007 1.25 -0.25 0 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1008 1.25 -0.25 0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1009 1.25 -0.25 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1010 1.25 0 -1 1 &  
wait
