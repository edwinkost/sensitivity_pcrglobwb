#!/bin/bash
#SBATCH -N 1
#SBATCH -t 48:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1131 1.5 -0.75 -0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1132 1.5 -0.75 0 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1133 1.5 -0.75 0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1134 1.5 -0.75 1 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1135 1.5 -0.5 -1 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1136 1.5 -0.5 -0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1137 1.5 -0.5 0 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1138 1.5 -0.5 0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1139 1.5 -0.5 1 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1140 1.5 -0.25 -1 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1141 1.5 -0.25 -0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1142 1.5 -0.25 0 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1143 1.5 -0.25 0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1144 1.5 -0.25 1 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1145 1.5 0 -1 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1146 1.5 0 -0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1147 1.5 0 0 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1148 1.5 0 0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1149 1.5 0 1 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1150 1.5 0.25 -1 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1151 1.5 0.25 -0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1152 1.5 0.25 0 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1153 1.5 0.25 0.5 1.125 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_675.ini no_debug code__a__1154 1.5 0.25 1 1.125 &  
wait
