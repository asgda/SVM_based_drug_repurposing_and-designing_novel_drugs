#!/usr/bin/Rscript
library(dplyr)
#merge the files into one
s<- read.table('cell_line_names.txt')
w<- read.table('padel_all_desc_mmff94.csv', header=T, sep=",")
l<- as.list(s$V1)
for (i in 1:length(l)) {
	cl<- l[i]
	d<- read.table(paste0('/home2/QSAR_check/drug_data_cell_lines/drug_data_filtered_', cl, '.csv'), header=T, check.names=F, sep=",")
	#d<- d[d$IC_50_value<=100,]
	m<- merge(w,d, by.x='Name', by.y='pubchem')
	n<- subset(m, select=-c(Name, Cell_Line_Name, IC50_val)) 
	n[, 1:ncol(n)][n[, 1:ncol(n)] == "NULL"] <- 0 #null values to 0
	is.na(n)<- sapply(n, is.infinite) #inf values to na
	n[is.na(n)]<-0 #all na values to 0
	n[,c(1:ncol(n))]<- sapply(n[,c(1:ncol(n))], as.numeric) #all columns to numeric
	n[, 1:ncol(n)] <- round(n[, 1:ncol(n)], digits=5) #up to n decimal points in the table
	write.table(n, paste0('padel_final_file_weka_filtered_mmff94_',cl ,'.csv'), sep=",", row.names=F)
}
