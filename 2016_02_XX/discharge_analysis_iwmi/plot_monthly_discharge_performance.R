
# input directory
table_file_name = "/scratch/edwin/30min_22_jun_2015/rerun_for_iwmi/calibration_27_june_2015/code__a__0/analysis/calibration/monthly_discharge/summary.txt"

# output directory
output_directory = "/scratch/edwin/30min_22_jun_2015/rerun_for_iwmi/calibration_27_june_2015/code__a__0/analysis/calibration/monthly_discharge/"

# reading the performance table
table = read.table(table_file_name,header=T,sep=";")

# only using the related performance
table = data.frame(table$id_from_grdc, table$ns_efficiency)
# sort the table
table = table[order(table[,1]),]

# write to a pcraster table
table = rbind(c(-9,1),table)
write.table(table,file=paste(output_directory,"/discharge_performance.txt",sep=""),sep="\t",row.names = FALSE,col.names=FALSE)

# plot in the pcraster format
pcrcalc discharge_performance.map = lookupscalaer
