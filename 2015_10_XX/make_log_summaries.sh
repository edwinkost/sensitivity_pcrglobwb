for i in {675..1124}
do
   echo "Processing the run $i."
   python ../make_log.summary.py /scratch-shared/edwin/sensitivity_analysis/2015_10_XX/code__a__$i/log/*.log summary_$i.sum
done
