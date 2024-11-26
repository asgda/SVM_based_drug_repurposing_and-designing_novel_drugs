#!/usr/bin/Rscript
#install.packages('ggpubr')
library(ggplot2)
#install.packages('gridExtra')
library(ggpubr)
require(gridExtra)
#cell_line <- read.table("final_selected_cell_lines.txt", header=F)
#cl<- cell_line$V1
#cl<- c("APC2D9_O_I","APC2D9_O_I","APC2D9_O_I","APC2D9_O_I","APC2D9_O_I","APC2D9_O_I","APC2D9_O_I","APC2D9_O_I","APC2D9_O_I","SK-CO-1","APC2D9_O_I","APC2D9_O_I")
#for (i in 1:length(cl)) {
	#cl<- cl[i]
	a<- read.table(paste0("desc_calc_SK-CO-1.csv"), header=T, sep=',')
	#fp<- tail(head(names(a), -1), -1)
	#fp<- c("APC2D9_O_I")
	a$APC2D9_O_I <- ifelse(a$APC2D9_O_I %in% c(1, 2), "1/2", "0")
	#a$APC2D9_O_I <- ifelse(a$APC2D9_O_I == 0, "Absent", "Present")
	#for (j in 1:length(fp)) {
		#fp <- fp[j]
		p <- ggboxplot(a, x = "APC2D9_O_I", y = "IC50",
                	color = "APC2D9_O_I", palette =c("#888888","black"),
                	add = c("jitter"), add.params=list(size=4, alpha=1), 
                	size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-7, 5))+
                	labs(x="Descriptor", y= expression(bold(logIC[50])))+
                	theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
			axis.title.x = element_text(face="bold", colour="Black", size=20),
			axis.title.y = element_text(face="bold", colour="Black", size=20),
			axis.text.x=element_text(size=16, face="bold"),
			panel.border = element_rect(color = "black",fill = NA,size = 1),
			panel.background = element_blank(),
			axis.text.y=element_text(angle=90, size=16),
			legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
			)
		y_range <- range(a$IC50)
		y_range[2] <- y_range[2] + 1  # Get minimum and maximum values
		p <- p + coord_cartesian(ylim = y_range)

		p<- p+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                	  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range[2], size=4.5)
                
## save as jpeg ##
		jpeg(paste0('descriptors_scatterplot/APC2D9_O_I/desc_calc_APC2D9_O_I_SK-CO-1.jpeg'), res=300, units="in", width=6, height=6)
		annotate_figure(p, top = text_grob(paste0("Descriptor: APC2D9_O_I, Cell Line: SK-CO-1"),
               color = "black", face = "bold", size = 20))
		dev.off()
#	}
#}
