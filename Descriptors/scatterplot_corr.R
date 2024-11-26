#!/usr/bin/Rscript

# install.packages('devtools')
#devtools::install_github('r-lib/ragg')
#install.packages('Rmisc')
library(Rmisc)
#library(ragg)

a<- read.table('corr_merged_df.csv', header=T, sep=',', check.names=F)

library(tidyr)
library(dplyr)

a<- a %>% 
	pivot_longer(!Descriptors, names_to='Cell_line',values_to='R')
v<- c('KRFP314','KRFPC314','FP3','APC2D9_O_I','GraphFP252', 'JGI10', 'KRFP3683', 'KRFP803', 'nC')
a<- a[a$Descriptors %in% v,]
a<- na.omit(a)

# calculating SE
gd <- a %>% 
        group_by(Descriptors) %>% 
        summarise(R = mean(R))

library(ggplot2)

jpeg('scatterplot.jpeg', units="in", width = 15, height = 10, res=300)
ggplot(a, aes(reorder(x = Descriptors, -R), y = R)) +
    geom_point(size=5,aes(color = factor(Cell_line)), position= position_dodge(0.4)) +
    geom_point(data=gd, size=15, alpha=0.2, color= 'blue') +
    xlab('Descriptors')+ ylab("Pearson's Correlation (R)")+
    theme(plot.title = element_text(face="bold", colour="black", size=50, hjust=0.5),
    axis.text.x = element_text(angle = 90, face='bold', size=25),
    axis.text.y = element_text(face='bold', size=25), 
    axis.title.x= element_text(size=30, face='bold'), 
    axis.title.y= element_text(size=30, face='bold'), 
    legend.key.size = unit(1, 'cm'), 
    legend.title= element_text(size=25, face="bold"), 
    legend.text= element_text(size=22), 
    panel.border = element_rect(color = "black",fill = NA,size = 1),
    panel.background = element_blank()) +
    labs(col="Cell Lines") + 
    ggtitle('Descriptors Correlation')
dev.off()

