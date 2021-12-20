library(ggplot2)
library(ggalluvial)
library(scales)
library(plyr)
library(reshape2)
library(scales)
library(ggplot2)
library(artyfarty)




data <- read.table("taxID_count_table+taxa.txt", sep="\t", header=TRUE)

pat <- read.table("patogen_family", sep="\t", header=TRUE)

out <- data.frame()


for (i in seq(1,nrow(pat))) {
	for(j in seq(1,nrow(data))) {
		if (pat$Family[i] == data$family[j]){
		out <- rbind(out, data[j,])
		}
	}
}


write.table(out, file = "patogen_family_out.txt", row.names = FALSE, sep = "\t", quote=FALSE)



library(plyr)
library(reshape2)
library(scales)
library(ggplot2)
library(artyfarty)

summ <- ddply(out,"family",numcolwise(sum))

summ <- summ[-2]

meltdf <- melt(summ, variable_name = "family")

colors120 <- c("#EFDBC5", "#CD9575", "#FDD9B5", "#78DBE2", "#87A96B", "#FFA474", "#FAE7B5", "#9F8170", "#FD7C6E", "#232323", "#1F75FE", "#ADADD6", "#199EBD", "#7366BD", "#DE5D83", "#CB4154", "#B4674D", "#FF7F49", "#EA7E5D", "#B0B7C6", "#FFFF99", "#1CD3A2", "#FFAACC", "#DD4492", "#1DACD6", "#BC5D58", "#DD9475", "#9ACEEB", "#FFBCD9", "#FDDB6D", "#2B6CC4", "#EFCDB8", "#6E5160", "#1DF914", "#71BC78", "#6DAE81", "#C364C5", "#CC6666", "#E7C697", "#FCD975", "#A8E4A0", "#95918C", "#1CAC78", "#F0E891", "#FF1DCE", "#B2EC5D", "#5D76CB", "#CA3767", "#3BB08F", "#FDFC74", "#FCB4D5", "#FFBD88", "#F664AF", "#CD4A4A", "#979AAA", "#FF8243", "#C8385A", "#EF98AA", "#FDBCB4", "#1A4876", "#30BA8F", "#1974D2", "#FFA343", "#BAB86C", "#FF7538", "#E6A8D7", "#414A4C", "#FF6E4A", "#1CA9C9", "#FFCFAB", "#C5D0E6", "#FDD7E4", "#158078", "#FC74FD", "#F780A1", "#8E4585", "#7442C8", "#9D81BA", "#FF1DCE", "#FF496C", "#D68A59", "#FF48D0", "#E3256B", "#EE204D", "#FF5349", "#C0448F", "#1FCECB", "#7851A9", "#FF9BAA", "#FC2847", "#76FF7A", "#9FE2BF", "#A5694F", "#8A795D", "#45CEA2", "#FB7EFD", "#CDC5C2", "#80DAEB", "#ECEABE", "#FFCF48", "#FD5E53", "#FAA76C", "#FC89AC", "#DBD7D2", "#17806D", "#DEAA88", "#77DDE7", "#FDFC74", "#926EAE", "#F75394", "#FFA089", "#8F509D", "#EDEDED", "#A2ADD0", "#FF43A4", "#FC6C85", "#CDA4DE", "#FCE883", "#C5E384", "#FFB653")

spalet <- sample(colors120, 11)

svg("Pathogen viruses family barplot.svg",width=7, height=5, family="Times New Roman")

ggplot(data=meltdf, aes(x=variable, y=value, fill=family)) +
geom_bar(stat="identity", position="fill", color="black", cex=0.2) + 
theme_scientific() + 
scale_y_continuous(labels=percent) +
scale_fill_manual(values=spalet) + 
labs(fill="Taxon", y="Value", x="Sample") + coord_flip() +
theme(axis.text.y = element_text(color = "black", size=12), 
	axis.text.x = element_text(color = "black", size=12), 
	axis.title.x = element_text(color = "black", size=12),	
	axis.title.y = element_text(color = "black", size=12),
	legend.text = element_text(color = "black", size=12),
	legend.title = element_text(color = "black", size=14)) +
ggtitle("Pathogen viruses family")

dev.off()


