#!/bin/bash

for i in {0..16}
do
   OUT=code__a__
   echo "Processing the run $i."
   echo "R -f global_annual_flux_analysis_30min.R $OUT$i"
   #~ R -f global_annual_flux_analysis_30min.R $OUT$i
   if ! ((i % 4))
      echo "wait"         
   fi
done

#~ R -f global_annual_flux_analysis_30min.R with_fossil_limit_and_with_pumping_limit 
#~ R -f global_annual_flux_analysis_30min.R with_fossil_limit_and_without_pumping_limit
#~ R -f global_annual_flux_analysis_30min.R without_fossil_limit_and_with_pumping_limit
#~ R -f global_annual_flux_analysis_30min.R without_fossil_limit_and_without_pumping_limit

