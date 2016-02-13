#!/bin/bash
#SBATCH -N 1
#SBATCH -t 110:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__208 1.5 0.25 1 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__209 1.5 0.25 1 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__210 1.5 0.5 -1 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__211 1.5 0.5 -1 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__212 1.5 0.5 -1 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__213 1.5 0.5 -0.5 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__214 1.5 0.5 -0.5 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__215 1.5 0.5 -0.5 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__216 1.5 0.5 0 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__217 1.5 0.5 0 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__218 1.5 0.5 0 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__219 1.5 0.5 0.5 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__220 1.5 0.5 0.5 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__221 1.5 0.5 0.5 1 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__222 1.5 0.5 1 1 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__223 1.5 0.5 1 1 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__224 1.5 0.5 1 1 1.5 &  

# the reference run
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__0 1 0 0 1 1 &  

# and some other reference runs
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_without_fossil_limit_and_without_pumping_limit.ini & 
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_with_fossil_limit_and_without_pumping_limit.ini &
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_with_fossil_limit_and_with_pumping_limit.ini &
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_without_fossil_limit_and_with_pumping_limit.ini &

wait

