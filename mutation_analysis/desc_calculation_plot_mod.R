#!/usr/bin/Rscript
#install.packages('ggpubr')
library(ggplot2)
#install.packages('gridExtra')
library(ggpubr)
require(gridExtra)
a<- read.table('desc_calc_MDST8.csv', header=T, sep=',')
b<- read.table('desc_calc_KM12.csv', header=T, sep=',')
d<- read.table('desc_calc_CCK-81.csv', header=T, sep=',')
e<- read.table('desc_calc_COLO-205.csv', header=T, sep=',')
f<- read.table('desc_calc_GP5d.csv', header=T, sep=',')
g<- read.table('desc_calc_SK-CO-1.csv', header=T, sep=',')
h<- read.table('desc_calc_SW1417.csv', header=T, sep=',')
i<- read.table('desc_calc_HT-115.csv', header=T, sep=',')
j<- read.table('desc_calc_SW620.csv', header=T, sep=',')

a$APC2D9_O_I <- ifelse(a$APC2D9_O_I %in% c(1, 2), "1/2", "0")
#b$APC2D9_O_I <- ifelse(b$APC2D9_O_I %in% c(1, 2), "1/2", "0")
#g$APC2D9_O_I <- ifelse(d$APC2D9_O_I %in% c(1, 2), "1/2", "0")
e$APC2D9_O_I <- ifelse(e$APC2D9_O_I %in% c(1, 2), "1/2", "0")
#f$APC2D9_O_I <- ifelse(f$APC2D9_O_I %in% c(1, 2), "1/2", "0")
i$KRFPC314 <- ifelse(i$KRFPC314 %in% c(1, 2), "1/2", "0")

y_range_mdst8 <- range(a$IC50)
y_range_mdst8[2] <- y_range_mdst8[2] + 1
y_range_km12 <- range(b$IC50)
y_range_km12[2] <- y_range_km12[2] + 1
y_range_cck81 <- range(d$IC50)
y_range_cck81[2] <- y_range_cck81[2] + 1
y_range_colo205 <- range(e$IC50)
y_range_colo205[2] <- y_range_colo205[2] + 1
y_range_gp5d <- range(e$IC50)
y_range_gp5d[2] <- y_range_gp5d[2] + 1
y_range_skco1 <- range(e$IC50)
y_range_skco1[2] <- y_range_skco1[2] + 1
y_range_sw1417 <- range(e$IC50)
y_range_sw1417[2] <- y_range_sw1417[2] + 1
y_range_ht115 <- range(e$IC50)
y_range_ht115[2] <- y_range_ht115[2] + 1
y_range_sw620 <- range(e$IC50)
y_range_sw620[2] <- y_range_sw620[2] + 1

p <- ggboxplot(f, x = "KRFP314", y = "IC50",
                color = "KRFP314", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-6, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: KRFP314\nCL: GP5d")
#p <- p + stat_summary(fun = mean, geom = "line", aes(group = KRFP314), size = 1.2, color = "blue")
p <- p + coord_cartesian(ylim = y_range_gp5d)
p <- p+ stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_gp5d[2]-0.75, size=3)
                
q <- ggboxplot(i, x = "KRFPC314", y = "IC50",
                color = "KRFPC314", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-7, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: KRFPC314\nCL: HT-115")
#q <- q + stat_summary(fun = mean, geom = "line", aes(group = KRFPC314), size = 1.2, color = "blue")
q <- q + coord_cartesian(ylim = y_range_ht115)
q<- q + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_ht115[2]-0.75, size=3)

r <- ggboxplot(d, x = "nC", y = "IC50",
                color = "nC", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-5.5, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: nC\nCL: CCK-81")
#r <- r + stat_summary(fun = mean, geom = "line", aes(group = nC), size = 1.2, color = "blue")
r <- r + coord_cartesian(ylim = y_range_cck81)
r<- r + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_cck81[2]-0.75, size=3)

s <- ggboxplot(b, x = "KRFP803", y = "IC50",
                color = "KRFP803", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-6.5, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: KRFP803\nCL: KM12")
#s <- s + stat_summary(fun = mean, geom = "line", aes(group = KRFP803), size = 1.2, color = "blue")
s <- s + coord_cartesian(ylim = y_range_km12)
s<- s + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_km12[2]-0.75, size=3)

t <- ggboxplot(j, x = "KRFP3683", y = "IC50",
                color = "KRFP3683", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-7, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: KRFP3683\nCL: SW620")
#t <- t + stat_summary(fun = mean, geom = "line", aes(group = KRFP3683), size = 1.2, color = "blue")
t <- t + coord_cartesian(ylim = y_range_sw620)
t<- t + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_sw620[2]-0.75, size=3)
                  
u <- ggboxplot(e, x = "FP3", y = "IC50",
                color = "FP3", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-4, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: FP3\nCL: COLO-205")
#u <- u + stat_summary(fun = mean, geom = "line", aes(group = FP3), size = 1.2, color = "blue")
u <- u + coord_cartesian(ylim = y_range_colo205)
u<- u + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_colo205[2]-0.75, size=3)
                  
v <- ggboxplot(a, x = "GraphFP252", y = "IC50",
                color = "GraphFP252", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-4, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: GraphFP252\nCL: MDST8")
#v <- v + stat_summary(fun = mean, geom = "line", aes(group = GraphFP252), size = 1.2, color = "blue")
v <- v + coord_cartesian(ylim = y_range_mdst8)
v<- v + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_mdst8[2]-0.75, size=3)


w <- ggboxplot(g, x = "nC", y = "IC50",
                color = "nC", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-4, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: nC\nCL: SK-CO-1")
#w <- w + stat_summary(fun = mean, geom = "line", aes(group = nC), size = 1.2, color = "blue")
w <- w + coord_cartesian(ylim = y_range_skco1)
w<- w + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_skco1[2]-0.75, size=3)


z <- ggboxplot(h, x = "KRFP314", y = "IC50",
                color = "KRFP314", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-4, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: KRFP314\nCL: SW1417")
#z <- z + stat_summary(fun = mean, geom = "line", aes(group = KRFP314), size = 1.2, color = "blue")
z <- z + coord_cartesian(ylim = y_range_sw1417)
z<- z + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_sw1417[2]-0.75, size=3)

ab<- ggboxplot(a, x = "APC2D9_O_I", y = "IC50",
                color = "APC2D9_O_I", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-4, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: APC2D9_O_I\nCL: MDST8")
#z <- z + stat_summary(fun = mean, geom = "line", aes(group = KRFP314), size = 1.2, color = "blue")
ab <- ab + coord_cartesian(ylim = y_range_mdst8)
ab<- ab + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_mdst8[2]-0.75, size=3)


ac<- ggboxplot(e, x = "APC2D9_O_I", y = "IC50",
                color = "APC2D9_O_I", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-4, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: APC2D9_O_I\nCL: COLO-205")
#z <- z + stat_summary(fun = mean, geom = "line", aes(group = KRFP314), size = 1.2, color = "blue")
ac <- ac + coord_cartesian(ylim = y_range_colo205)
ac<- ac + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_colo205[2]-0.75, size=3)
                  
ad<- ggboxplot(i, x = "KRFP314", y = "IC50",
                color = "KRFP314", palette =c("#888888","black"),
                add = c("jitter"), add.params=list(size=1.75, alpha=0.5), 
                size=0.9, bxp.errorbar = FALSE, width=0.2)+
                #coord_cartesian(ylim = c(-4, 5))+
                labs(x="", y= expression(bold(logIC[50])))+
                theme(plot.title = element_text(colour="Black", size=17, hjust=0.5, face="bold"),
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
		) +
		labs(title = "Desc: KRFP314\nCL: HT-115")
#z <- z + stat_summary(fun = mean, geom = "line", aes(group = KRFP314), size = 1.2, color = "blue")
ad <- ad + coord_cartesian(ylim = y_range_ht115)
ad<- ad + stat_compare_means(aes(label = paste0("p = ", after_stat(p.format))),
                  method = "t.test", ref.group = "0", hide.ns=TRUE, label.y=y_range_ht115[2]-0.75, size=3)                  
          
## save as jpeg ##
jpeg('merged_suppl_figs_desc.jpeg', units="in",width=13.3333,height=8, res=300)
g<- ggarrange(p,q,r,s,t,u,v,w,z,ab,ac,ad, nrow=3, ncol=4, common.legend=F,
font.label = list(size = 20, face = "bold", color ="black"),
labels = c("A.","B.","C.","D.","E.","F.","G.","H.","I.","J.","K.","L.")
)

#library(grid)
annotate_figure(g)
dev.off()
