#!/bin/bash
#SBATCH -N 1
#SBATCH -t 12:00:00
#SBATCH -p normal

python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__1 1 -0.25 -0.5 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__2 1 -0.25 -0.5 1 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__3 1 -0.25 -0.5 1.25 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__4 1 -0.25 0 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__5 1 -0.25 0 1 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__6 1 -0.25 0 1.25 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__7 1 -0.25 0.5 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__8 1 -0.25 0.5 1 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__9 1 -0.25 0.5 1.25 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__10 1 0 -0.5 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__11 1 0 -0.5 1 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__12 1 0 -0.5 1.25 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__13 1 0 0 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__14 1 0 0 1.25 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__15 1 0 0.5 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__16 1 0 0.5 1 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__17 1 0 0.5 1.25 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__18 1 0.25 -0.5 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__19 1 0.25 -0.5 1 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__20 1 0.25 -0.5 1.25 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__21 1 0.25 0 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__22 1 0.25 0 1 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__23 1 0.25 0 1.25 1 1 &  
wait