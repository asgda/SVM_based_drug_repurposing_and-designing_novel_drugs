#!/usr/bin/Rscript

a<- read.table('all_common_drugs_cl_ic50.csv', header=T, check.names=F, sep=',')
#a<- t(a)
d<- read.table('common_drug_names.txt', header=F)
v<- d$V1
#colnames(a)<- v
#a<- as.data.frame(a)
a$drugs<- v
#class(a$pubchem)<- 'character'
#write.table(a,"drugs_ic50_common_020323.csv", sep=',', row.names=T, col.names=NA)
library(ggplot2)

#Create a scatterplot using mtcars data with ggplot object p1 as the base layer
#p1 <- ggplot(a, aes(reorder(x = rownames(a), + `COLO-678`), y = `COLO-678`))
p1 <- ggplot(a, aes(reorder(x = drugs, + `COLO-678`), y = `COLO-678`))
#Specify the color of points in the next layer
p1 <- p1 + geom_point(size = 3)

#connect points with line
p2 <- p1 + geom_line(group=1)                           

#Adding a regression line
#p3 <- p2 + geom_smooth(method = "lm", se = TRUE)  

#Formatting
p3 <- p2 + labs(x="Drugs", y = "log(IC)50") +
		ggtitle("COLO-678") +
		theme(plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=20),
		axis.title.y = element_text(face="bold", colour="Black", size=20),
		axis.text.x=element_text(angle=90, size=16),
		axis.text.y=element_text(angle=90, size=16),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank())+
		geom_text(aes(label=sprintf("%0.2f",round(a$`COLO-678`, digits=2)), vjust=-1, hjust=0.75), size=3.5)+ #, position = position_dodge(.5))+
		geom_hline(yintercept=-2, linetype="dashed", color = "black", face="bold")

jpeg('drugs_COLO-678.jpeg', height=1200, width=1200)
print(p3)

dev.off()
