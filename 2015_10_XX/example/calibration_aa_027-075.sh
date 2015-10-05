#!/bin/bash
#SBATCH -N 1
#SBATCH -t 119:00:00
#SBATCH --constraint=haswell
#SBATCH -p normal

python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__27 1 -1 -0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__28 1 -1 0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__29 1 -0.5 -1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__30 1 -0.5 -0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__31 1 -0.5 0 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__32 1 -0.5 0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__33 1 -0.5 1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__34 1 0 -0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__35 1 0 0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__36 1 0.5 -1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__37 1 0.5 -0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__38 1 0.5 0 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__39 1 0.5 0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__40 1 0.5 1 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__41 1 1 -0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__42 1 1 0.5 0.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__43 1 -1 -0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__44 1 -1 0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__45 1 -0.5 -1 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__46 1 -0.5 -0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__47 1 -0.5 0 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__48 1 -0.5 0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__49 1 -0.5 1 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__50 1 0 -0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__51 1 0 0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__52 1 0.5 -1 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__53 1 0.5 -0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__54 1 0.5 0 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__55 1 0.5 0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__56 1 0.5 1 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__57 1 1 -0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__58 1 1 0.5 1 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__59 1 -1 -0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__60 1 -1 0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__61 1 -0.5 -1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__62 1 -0.5 -0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__63 1 -0.5 0 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__64 1 -0.5 0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__65 1 -0.5 1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__66 1 0 -0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__67 1 0 0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__68 1 0.5 -1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__69 1 0.5 -0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__70 1 0.5 0 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__71 1 0.5 0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__72 1 0.5 1 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__73 1 1 -0.5 1.5 &  
python /home/edwin/github/edwinkost/PCR-GLOBWB/model/deterministic_runner_glue_IWMI.py setup_calib_with_fossil_limit_with_pump_limit_26_june_2015_cartesius.ini no_debug code__a__74 1 1 0.5 1.5 &  

wait
