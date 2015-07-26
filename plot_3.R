setwd('Y:/Weiterbildung/Coursera/Data_Science/Exploratory Data Analysis/week3')

library(ggplot2)

#dataimport and subset
codebook<-readRDS('Source_Classification_Code.rds')
data<-readRDS('summarySCC_PM25.rds')

dataSubset<-subset(data,data$fips=="24510")
dataUse<-aggregate(dataSubset$Emissions, c(list(dataSubset$type),list(dataSubset$year)), sum)
names(dataUse)<-c('Type','Year','Emission')

#do plotting
png("plot_3.png",width=960)
p<-qplot(Year,Emission, data=dataUse,geom=c("point","smooth"),method="lm",facets=.~Type)
p<-p+labs(title="Baltimore City Emission Type Source Comparison: (point, nonpoint, onroad, nonroad)")
p
dev.off()