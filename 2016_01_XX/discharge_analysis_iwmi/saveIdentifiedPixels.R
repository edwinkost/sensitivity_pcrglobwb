
# read the argument
args <- commandArgs()
inputFile = args[4]

# read the table
table = read.table(inputFile,header=F)

# sort the table
table <- table[order(table$V4,table$V5,table$V6,table$V7),]
#
# Note: Column order:
# table$V1 --> model pixel longitude
# table$V2 --> model pixel latitude
# table$V3 --> model pixel catchment area 
# table$V4 --> difference in catchment area
# table$V5 --> distance 
# table$V6 --> difference in longitude
# table$V7 --> difference in latitude
# table$V8 --> model landmask

# write the table to a file
outputFile = paste(inputFile,".sel",sep="")
write.table(table,outputFile,sep=";",col.names=F,row.names=F)
