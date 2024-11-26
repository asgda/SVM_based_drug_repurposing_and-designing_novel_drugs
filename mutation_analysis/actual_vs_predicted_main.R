#!/usr/bin/Rscript
#install.packages('ggpubr')
library(ggplot2)
#install.packages('gridExtra')
library(ggpubr)
require(gridExtra)
b<- read.table('actualvspredicted_fsip2.csv', header=T, sep=',')
a<- read.table('actualvspredicted_abca13.csv', header=T, sep=',')
y_range_1 <- range(a$ActualLog_IC50_11707110)
y_range_1[2] <- y_range_1[2] + 1
y_range_2 <- range(a$PredictedLog_IC50_11707110)
y_range_2[2] <- y_range_2[2] + 1
y_range_3 <- range(b$ActualLog_IC50_56962337)
y_range_3[2] <- y_range_3[2] + 1
y_range_4 <- range(b$PredictedLog_IC50_56962337)
y_range_4[2] <- y_range_4[2] + 1

p <- ggboxplot(a, x = "Type", y = "ActualLog_IC50_11707110",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=3, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Actual~logIC[50])))+
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
p <- p + coord_cartesian(ylim = y_range_1)	
p<- p+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=4.5, label.y=y_range_1[2]-0.1)
                
q <- ggboxplot(a, x = "Type", y = "PredictedLog_IC50_11707110",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=3, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Predicted~logIC[50])))+
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
q <- q + coord_cartesian(ylim = y_range_2)			
q<- q + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=4.5, label.y=y_range_2[2]-0.1)

r <- ggboxplot(b, x = "Type", y = "ActualLog_IC50_56962337",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=3, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Actual~logIC[50])))+
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
r <- r + coord_cartesian(ylim = y_range_3)					
r<- r+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=4.5, label.y=y_range_3[2]-0.1)
                
s <- ggboxplot(b, x = "Type", y = "PredictedLog_IC50_56962337",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=3, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Predicted~logIC[50])))+
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
s<- s + coord_cartesian(ylim = y_range_4)		
s<- s + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=4.5, label.y=y_range_4[2]-0.1)

## save as jpeg ##
#jpeg('FSIP2/actual_vs_pred_56962337_FSIP2.jpeg', units="in",width=5,height=5, res=300)
g1<- ggarrange(p,q, ncol=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"))
g2<- ggarrange(r,s, ncol=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"))

#library(grid)
a1<- annotate_figure(g1, 
	top = text_grob(expression(paste(bold("Drug: Trametinib, Gene: "), italic(ABCA13))), color = "black", size = 20)
	)
a2<- annotate_figure(g2, 
	top = text_grob(expression(paste(bold("Drug: SGC0946, Gene: "), italic(FSIP2))), color = "black", size = 20)
	)
tiff('merged_main_figs_act_vs_pred.tif', units="in",width=7,height=8, res=600, compression="lzw")
g<- ggarrange(a1,a2, ncol=1, nrow=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"),
labels = c("A.","B.")
)

#library(grid)
annotate_figure(g)
dev.off()
