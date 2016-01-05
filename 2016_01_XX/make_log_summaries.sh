#!/bin/bash

for i in {0..224}
do
   OUT=/scratch-shared/edwin/sensitivity_analysis_non_natural/2016_01_XX/code__a__
   echo "Processing the run $i."
   echo "python make_log.summary.py $OUT$i/log/*.log $OUT$i/log/summary_$i.sum"
   #~ python make_log.summary.py $OUT$i/log/*.log $OUT$i/log/summary_$i.sum
done
