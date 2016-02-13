#!/bin/bash
#SBATCH -N 1
#SBATCH -t 110:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__662 1.5 0.5 0 1.25 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__663 1.5 0.5 0.5 0.75 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__664 1.5 0.5 0.5 0.75 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__665 1.5 0.5 0.5 0.75 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__666 1.5 0.5 0.5 1.25 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__667 1.5 0.5 0.5 1.25 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__668 1.5 0.5 0.5 1.25 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__669 1.5 0.5 1 0.75 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__670 1.5 0.5 1 0.75 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__671 1.5 0.5 1 0.75 1.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__672 1.5 0.5 1 1.25 0.5 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__673 1.5 0.5 1 1.25 1 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_january_2016.py ~/github/edwinkost/sensitivity_pcrglobwb/2016_02_XX/setup_sensitivity_analysis_cartesius_non_natural_version_february_2016.ini no_debug code__a__674 1.5 0.5 1 1.25 1.5 &  
wait
