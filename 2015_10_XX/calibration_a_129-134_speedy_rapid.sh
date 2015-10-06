#!/bin/bash
#SBATCH -N 1
#SBATCH -t 119:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__129 1.5 -0.5 -1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__130 1.5 -0.5 0 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__131 1.5 -0.5 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__132 1.5 0.5 -1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__133 1.5 0.5 0 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__134 1.5 0.5 1 1.5 &  
wait
