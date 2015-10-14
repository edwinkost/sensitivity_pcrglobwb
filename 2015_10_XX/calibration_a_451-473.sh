#!/bin/bash
#SBATCH -N 1
#SBATCH -t 72:00:00
#SBATCH -p normal

python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__451 0.5 -1 -0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__452 0.5 -1 0 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__453 0.5 -1 0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__454 0.5 -1 1 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__455 0.5 -0.75 -1 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__456 0.5 -0.75 -0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__457 0.5 -0.75 0 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__458 0.5 -0.75 0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__459 0.5 -0.75 1 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__460 0.5 -0.5 -1 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__461 0.5 -0.5 -0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__462 0.5 -0.5 0 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__463 0.5 -0.5 0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__464 0.5 -0.5 1 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__465 0.5 -0.25 -1 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__466 0.5 -0.25 -0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__467 0.5 -0.25 0 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__468 0.5 -0.25 0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__469 0.5 -0.25 1 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__470 0.5 0 -1 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__471 0.5 0 -0.5 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__472 0.5 0 0 1.25 &  
python ~/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis_cartesius_from_405.ini no_debug code__a__473 0.5 0 0.5 1.25 &  
wait
