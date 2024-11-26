#!/usr/bin/Rscript

a<- read.table('all_common_drugs_cl_ic50.csv', header=T, check.names=F, sep=',')
a = setNames(data.frame(t(a[,-1])), a[,1])

#class(a$pubchem)<- 'character'

library(ggplot2)

#Create a scatterplot using drugs data with ggplot object p1 as the base layer
p1 <- ggplot(a, aes(reorder(x = rownames(a), + `24978538`), y = `24978538`))

#Specify the color of points in the next layer
p1 <- p1 + geom_point(size = 3)

#connect points with line
p2 <- p1 + geom_line(group=1)                           

#Adding a regression line
#p3 <- p2 + geom_smooth(method = "lm", se = TRUE)  

#Formatting
p3 <- p2 + labs(x="Cell Lines", y = expression(bold(log~IC[50]))) +
		ggtitle("Navitoclax") +
		theme(plot.title = element_text(face="bold", colour="Black", size=25, hjust=0.5),
		axis.title.x = element_text(face="bold", colour="Black", size=20),
		axis.title.y = element_text(face="bold", colour="Black", size=20),
		axis.text.x=element_text(angle=90, size=10, face="bold"),
		panel.border = element_rect(color = "black",fill = NA,size = 1),
		panel.background = element_blank(),
		axis.text.y=element_text(angle=90, size=16))+
		geom_text(size=2.5,aes(label=sprintf("%0.2f",round(a$`24978538`, digits=2)), vjust=-1, hjust=0.75))+
		geom_hline(yintercept=-2,linetype=2)

jpeg('cl_Navitoclax.jpeg')
print(p3)

dev.off()
