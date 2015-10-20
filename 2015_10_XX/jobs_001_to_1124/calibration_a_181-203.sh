#!/bin/bash
#SBATCH -N 1
#SBATCH -t 72:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__181 1 0.5 -0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__182 1 0.5 0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__183 1 1 -0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__184 1 1 0.5 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__185 1 -1 -0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__186 1 -1 0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__187 1 -0.5 -0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__188 1 -0.5 0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__189 1 0 -0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__190 1 0 0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__191 1 0.5 -0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__192 1 0.5 0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__193 1 1 -0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__194 1 1 0.5 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__195 1.5 -1 -0.5 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__196 1.5 -1 0.5 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__197 1.5 -0.5 -0.5 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__198 1.5 -0.5 0.5 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__199 1.5 0 -0.5 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__200 1.5 0 0.5 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__201 1.5 0.5 -0.5 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__202 1.5 0.5 0.5 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius.ini no_debug code__a__203 1.5 1 -0.5 0.5 &  
wait
