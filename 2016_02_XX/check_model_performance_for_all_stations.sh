
R -f check_model_performance_for_all_stations.R "kge_2009" "validation" &
R -f check_model_performance_for_all_stations.R "kge_2009" "calibration" &

R -f check_model_performance_for_all_stations.R "one_min_bfdv" "validation" &
R -f check_model_performance_for_all_stations.R "one_min_bfdv" "calibration" &

wait
