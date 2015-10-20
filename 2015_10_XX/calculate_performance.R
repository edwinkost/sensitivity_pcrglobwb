# function to calculate performance values

ns_discharge = discharge_table$ns_efficiency
min_ns_discharge = 0.00
ns_discharge[which(ns_discharge < min_ns_discharge)] = min_ns_discharge
#~ ns_discharge = ceiling(ns_discharge*100)/100
average_ns_discharge = mean(ns_discharge, na.rm = TRUE)
#
baseflow_deviation_relative = abs(baseflow_table$avg_baseflow_deviation/baseflow_table$average_iwmi_opt_baseflow)
names(baseflow_table)
max_baseflow_deviation_relative = 1.50
baseflow_deviation_relative[which(baseflow_deviation_relative > max_baseflow_deviation_relative)] = max_baseflow_deviation_relative
baseflow_deviation_relative[which(is.na(baseflow_deviation_relative) )]  = max_baseflow_deviation_relative
baseflow_deviation_relative[which(is.nan(baseflow_deviation_relative) )] = max_baseflow_deviation_relative
#~ baseflow_deviation_relative = floor(baseflow_deviation_relative*100)/100
baseflow_deviation = mean(baseflow_deviation_relative, na.rm = FALSE)
#
#~ general_performance = average_ns_discharge / (1.0 + baseflow_deviation)
general_performance = mean(ns_discharge/(1.0 + baseflow_deviation))
