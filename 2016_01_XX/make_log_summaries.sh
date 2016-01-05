
run_output_folder = "/scratch-shared/edwin/sensitivity_analysis_non_natural/2016_01_XX/code__a__"

for i in {0..224}
do
   echo "Processing the run $i."
   echo "python make_log.summary.py $run_output_folder$i/log/*.log /scratch-shared/edwin/sensitivity_analysis_non_natural/2016_01_XX/code__a__$i/log/summary_$i.sum"
   #~ python make_log.summary.py $run_output_folder$i/log/*.log /scratch-shared/edwin/sensitivity_analysis_non_natural/2016_01_XX/code__a__$i/log/summary_$i.sum
done
