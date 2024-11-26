#!/usr/bin/Rscript

d<- read.table('final_selected_cell_lines.txt', header=F)
l<- as.list(unique(d$V1))
for (i in 1:length(l)){
	cl <- l[i]
	print(cl)
	e<- read.table(paste0('/home2/QSAR_check/weka_processing/final_features/weka_out_padel_filtered_mmff94_',cl,'.csv'), header=T, sep=',')
	v<- as.data.frame(colnames(e))
	colnames(v)<- 'Descriptors'
	v<- head(v, -1)
	write.table(v, paste0('/home2/QSAR_check/descriptors/descriptors_',cl,'.csv'), sep=',', row.names=T, col.names=NA)
}
