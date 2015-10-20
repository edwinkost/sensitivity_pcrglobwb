#!/bin/bash
#SBATCH -N 1
#SBATCH -t 119:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__317 1 0.25 0 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__318 1 0.25 0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__319 1 0.25 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__320 1 0.75 -1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__321 1 0.75 -0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__322 1 0.75 0 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__323 1 0.75 0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__324 1 0.75 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__325 1 -0.75 -1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__326 1 -0.75 -0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__327 1 -0.75 0 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__328 1 -0.75 0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__329 1 -0.75 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__330 1 -0.25 -1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__331 1 -0.25 -0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__332 1 -0.25 0 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__333 1 -0.25 0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__334 1 -0.25 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__335 1 0.25 -1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__336 1 0.25 -0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__337 1 0.25 0 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__338 1 0.25 0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__339 1 0.25 1 1.5 &  
wait
