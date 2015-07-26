library(ggplot2)

#dataimport and subset
codebook<-readRDS('Source_Classification_Code.rds')
data<-readRDS('summarySCC_PM25.rds')


#Subset for Baltimore City
dataSubset<-subset(data,data$fips=="24510")

#Concatenate list to look for in SCC.Level.Three
l = c("Vehicle","vehicle")
#get only the data based on SCC.Level.Three
CodebookMotor<-subset(codebook, grepl(paste(l, collapse="|"),codebook$SCC.Level.Three))
#subset the dataset according to the identified data entries
dataMotor <- subset(dataSubset, (SCC %in% CodebookMotor$SCC))

dataUse<-aggregate(dataMotor$Emissions, list(dataMotor$year), sum)
names(dataUse)<-c('year','Emissions')

#do plotting
png("plot_5.png")
p<-qplot(year,Emissions, data=dataUse,geom=c("point","smooth"),method="lm")
p<-p+labs(title="Emissions fom Motor Vehicle-Related Sources in Baltimore City")
p
dev.off()
