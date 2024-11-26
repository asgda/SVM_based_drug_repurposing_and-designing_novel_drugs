#!/usr/bin/Rscript
#install.packages('ggpubr')
library(ggplot2)
#install.packages('gridExtra')
library(ggpubr)
require(gridExtra)
b<- read.table('actualvspredicted_fsip2.csv', header=T, sep=',')
a<- read.table('actualvspredicted_abca13.csv', header=T, sep=',')
d<- read.table('actualvspredicted_dnah6.csv', header=T, sep=',')
e<- read.table('actualvspredicted_dnah9.csv', header=T, sep=',')
f<- read.table('actualvspredicted_flg.csv', header=T, sep=',')


y_range_1 <- range(a$ActualLog_IC50_24866313)
y_range_1[2] <- y_range_1[2] + 1
y_range_2 <- range(a$PredictedLog_IC50_24866313)
y_range_2[2] <- y_range_2[2] + 1
y_range_3 <- range(a$ActualLog_IC50_46926350)
y_range_3[2] <- y_range_3[2] + 1
y_range_4 <- range(a$PredictedLog_IC50_46926350)
y_range_4[2] <- y_range_4[2] + 1
y_range_5 <- range(e$ActualLog_IC50_46236925)
y_range_5[2] <- y_range_5[2] + 1
y_range_6 <- range(e$PredictedLog_IC50_46236925)
y_range_6[2] <- y_range_6[2] + 1
y_range_7 <- range(e$ActualLog_IC50_5978)
y_range_7[2] <- y_range_7[2] + 1
y_range_8 <- range(e$PredictedLog_IC50_5978)
y_range_8[2] <- y_range_8[2] + 1
y_range_9 <- range(d$ActualLog_IC50_56962337)
y_range_9[2] <- y_range_9[2] + 1
y_range_10 <- range(d$PredictedLog_IC50_56962337)
y_range_10[2] <- y_range_10[2] + 1
y_range_11 <- range(f$ActualLog_IC50_234820)
y_range_11[2] <- y_range_11[2] + 1
y_range_12 <- range(f$PredictedLog_IC50_234820)
y_range_12[2] <- y_range_12[2] + 1

p <- ggboxplot(a, x = "Type", y = "ActualLog_IC50_24866313",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Actual~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
p <- p + coord_cartesian(ylim = y_range_1)	
p<- p+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_1[2]-0.35)
                
q <- ggboxplot(a, x = "Type", y = "PredictedLog_IC50_24866313",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Predicted~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
q <- q + coord_cartesian(ylim = y_range_2)			
q<- q + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_2[2]-0.35)

r <- ggboxplot(a, x = "Type", y = "ActualLog_IC50_46926350",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Actual~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
r <- r + coord_cartesian(ylim = y_range_3)					
r<- r+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_3[2]-0.35)
                
s <- ggboxplot(a, x = "Type", y = "PredictedLog_IC50_46926350",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Predicted~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
s<- s + coord_cartesian(ylim = y_range_4)		
s<- s + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_4[2]-0.35)

t <- ggboxplot(e, x = "Type", y = "ActualLog_IC50_46236925",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Actual~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
t <- t + coord_cartesian(ylim = y_range_5)					
t<- t+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_5[2]-0.35)
                
u <- ggboxplot(e, x = "Type", y = "PredictedLog_IC50_46236925",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Predicted~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
u<- u + coord_cartesian(ylim = y_range_6)		
u<- u + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_6[2]-0.35)
                  
v <- ggboxplot(e, x = "Type", y = "ActualLog_IC50_5978",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Actual~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
v <- v + coord_cartesian(ylim = y_range_7)					
v<- v+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_7[2]-0.35)
                
w <- ggboxplot(e, x = "Type", y = "PredictedLog_IC50_5978",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Predicted~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
w<- w + coord_cartesian(ylim = y_range_8)		
w<- w + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_8[2]-0.35)
                  
                                    
x <- ggboxplot(d, x = "Type", y = "ActualLog_IC50_56962337",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Actual~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
x <- x + coord_cartesian(ylim = y_range_9)					
x<- x+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_9[2]-0.35)
                
y <- ggboxplot(d, x = "Type", y = "PredictedLog_IC50_56962337",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Predicted~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
y<- y + coord_cartesian(ylim = y_range_10)		
y<- y + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_10[2]-0.35)
                  
ab <- ggboxplot(f, x = "Type", y = "ActualLog_IC50_234820",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Actual~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
ab <- ab + coord_cartesian(ylim = y_range_11)					
ab<- ab+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_11[2]-0.35)
                
bc <- ggboxplot(f, x = "Type", y = "PredictedLog_IC50_234820",
                color = "Type", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(0, 5))+
                labs(x="", y= expression(bold(Predicted~logIC[50])))+
                theme(#plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=16),
		axis.title.y = element_text(face="bold", colour="Black", size=16),
		axis.text.x=element_text(size=12, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=12),
		legend.position= "none"
		#legend.title= element_text(size=16, face='bold'), 
		#legend.text= element_text(size=14), 
		#legend.key.size = unit(1, 'cm')
		)
bc<- bc + coord_cartesian(ylim = y_range_12)		
bc<- bc + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "WT", hide.ns=TRUE, size=3, label.y=y_range_12[2]-0.35)                  
                  
## save as jpeg ##
#jpeg('FSIP2/actual_vs_pred_56962337_FSIP2.jpeg', units="in",width=5,height=5, res=300)
g1<- ggarrange(p,q, ncol=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"))
g2<- ggarrange(r,s, ncol=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"))
g3<- ggarrange(t,u, ncol=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"))
g4<- ggarrange(v,w, ncol=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"))
g5<- ggarrange(x,y, ncol=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"))
g6<- ggarrange(ab,bc, ncol=2, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"))

#library(grid)
a1<- annotate_figure(g1, 
	top = text_grob(expression(paste(bold("Drug: SCH772984, Gene: "), italic(ABCA13))), color = "black", size = 17)
	)
a2<- annotate_figure(g2, 
	top = text_grob(expression(paste(bold("Drug: Dinaciclib, Gene: "), italic(ABCA13))), color = "black", size = 17)
	)
a3<- annotate_figure(g3, 
	top = text_grob(expression(paste(bold("Drug: Sabutoclax, Gene: "), italic(DNAH9))), color = "black", size = 17)
	)
a4<- annotate_figure(g4, 
	top = text_grob(expression(paste(bold("Drug: Vincristine, Gene: "), italic(DNAH9))), color = "black", size = 17)
	)
a5<- annotate_figure(g5, 
	top = text_grob(expression(paste(bold("Drug: SGC0946, Gene: "), italic(DNAH6))), color = "black", size = 17)
	)
a6<- annotate_figure(g6, 
	top = text_grob(expression(paste(bold("Drug: Podophyllotoxin Bromide, Gene: "), italic(FLG))), color = "black", size = 17)
	)				
jpeg('merged_suppl_figs_act_vs_pred.jpeg', units="in",width=13.333333,height=8, res=300)
g<- ggarrange(a1,a2,a3,a4,a5,a6, ncol=2, nrow=3, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"),
labels = c("A.","B.","C.","D.","E.","F.")
)

#library(grid)
annotate_figure(g)
dev.off()
