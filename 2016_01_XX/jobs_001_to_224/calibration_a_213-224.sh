#!/bin/bash
#SBATCH -N 1
#SBATCH -t 72:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__213 1.5 0.5 -0.5 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__214 1.5 0.5 -0.5 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__215 1.5 0.5 -0.5 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__216 1.5 0.5 0 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__217 1.5 0.5 0 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__218 1.5 0.5 0 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__219 1.5 0.5 0.5 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__220 1.5 0.5 0.5 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__221 1.5 0.5 0.5 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__222 1.5 0.5 1 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__223 1.5 0.5 1 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_01_XX/setup_sensitivity_analysis_cartesius_non_natural.ini no_debug code__a__224 1.5 0.5 1 1 1.5 &  
wait