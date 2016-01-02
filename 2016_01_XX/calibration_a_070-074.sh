#!/bin/bash
#SBATCH -N 1
#SBATCH -t 72:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__70 1 0.5 0.5 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__71 1 0.5 0.5 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__72 1 0.5 1 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__73 1 0.5 1 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__74 1 0.5 1 1 1.5 &  
wait
