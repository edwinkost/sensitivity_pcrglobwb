#!/bin/bash
#SBATCH -N 1
#SBATCH -t 12:00:00
#SBATCH -p normal

# runs 24 to 26
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__24 1 0.25 0.5 0.75 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__25 1 0.25 0.5 1 1 1 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__26 1 0.25 0.5 1.25 1 1 &  

# reference run
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__0 1 0.0 0.0 1.0 1 1 &  

# runs 73 to 80
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__73 1 0.25 0 1.25 1 0.75 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__74 1 0.25 0 1.25 1 1.25 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__75 1 0.25 0.5 0.75 1 0.75 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__76 1 0.25 0.5 0.75 1 1.25 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__77 1 0.25 0.5 1 1 0.75 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__78 1 0.25 0.5 1 1 1.25 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__79 1 0.25 0.5 1.25 1 0.75 &  
python /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/model/deterministic_runner_glue_february_2016.py /home/patrill/Morocco/PCR-GLOBWB-for_patricia_morroco_3layers/config/setup_05min_Morocco_1979_2012_E2O_3layers_AccuTravel.ini no_debug code__a__80 1 0.25 0.5 1.25 1 1.25 &  

wait
