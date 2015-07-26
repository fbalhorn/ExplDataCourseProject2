library(ggplot2)

#dataimport and subset
codebook<-readRDS('Source_Classification_Code.rds')
data<-readRDS('summarySCC_PM25.rds')

#l = c("coal", "Coal") #using this I will also extract emissions from Charcoal manufacturing and not Coal Combustion
l = c("Coal")

#get only the coal SCCs based on SCC.Level.Three
CodebookCoal<-subset(codebook, grepl(paste(l, collapse="|"),codebook$SCC.Level.Three))
#subset the dataset according to the identified coal emissions across the US
dataCoal <- subset(data, (SCC %in% CodebookCoal$SCC))

dataUse<-aggregate(dataCoal$Emissions, list(dataCoal$year), sum)
names(dataUse)<-c('year','Emissions')

#do plotting
png("plot_4.png")
p<-qplot(year,Emissions, data=dataUse,geom=c("point","smooth"),method="lm")
p<-p+labs(title="Emissions fom Coal Combustion-Related Sources Across the US")
p
dev.off()
