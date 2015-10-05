#!/bin/bash
#SBATCH -N 1
#SBATCH -t 119:00:00
#SBATCH -p normal

python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__1 0.5 -1 -1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__2 0.5 -1 1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__3 0.5 1 -1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__4 0.5 1 1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__5 0.5 -1 -1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__6 0.5 -1 1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__7 0.5 1 -1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__8 0.5 1 1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__9 1.5 -1 -1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__10 1.5 -1 1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__11 1.5 1 -1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__12 1.5 1 1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__13 1.5 -1 -1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__14 1.5 -1 1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__15 1.5 1 -1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug code__a__16 1.5 1 1 1.5 &  
wait
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_october_2015.py setup_sensitivity_analysis.ini no_debug NA NA NA NA NA &  
wait
