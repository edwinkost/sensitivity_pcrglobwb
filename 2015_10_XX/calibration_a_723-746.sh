#!/bin/bash
#SBATCH -N 1
#SBATCH -t 48:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__723 0.5 -1 0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__724 0.5 -1 1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__725 0.5 -0.75 -1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__726 0.5 -0.75 -0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__727 0.5 -0.75 0 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__728 0.5 -0.75 0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__729 0.5 -0.75 1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__730 0.5 -0.5 -1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__731 0.5 -0.5 -0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__732 0.5 -0.5 0 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__733 0.5 -0.5 0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__734 0.5 -0.5 1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__735 0.5 -0.25 -1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__736 0.5 -0.25 -0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__737 0.5 -0.25 0 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__738 0.5 -0.25 0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__739 0.5 -0.25 1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__740 0.5 0 -1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__741 0.5 0 -0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__742 0.5 0 0 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__743 0.5 0 0.5 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__744 0.5 0 1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__745 0.5 0.25 -1 0.875 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__746 0.5 0.25 -0.5 0.875 &  
wait
