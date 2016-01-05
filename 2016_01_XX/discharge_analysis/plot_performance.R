# in R script
table = read.table("summary.txt",header=T,sep=";")
station_id = data.frame(table$id_from_grdc,table$model_longitude_in_arc_degree,table$model_latitude_in_arc_degree)
write.table(station_id,file="validation_station.txt",sep="\t",row.names = FALSE,col.names=FALSE)

# in command line
col2map --clone lddsound_30min.map --large -N -x 2 -y 3 -v 1 validation_station.txt validation_station.map
pcrcalc validation_station.map = "subcatchment(lddsound_30min.map, validation_station.map)"
