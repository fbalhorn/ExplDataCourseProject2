library(ggplot2)

#dataimport and subset
codebook<-readRDS('Source_Classification_Code.rds')
data<-readRDS('summarySCC_PM25.rds')

#Subset for Baltimore City and for Los Angeles County
dataSubset<-subset(data,(data$fips=="24510")|(data$fips=="06037"))

#Concatenate list to look for in SCC.Level.Three
l = c("Vehicle","vehicle")
#get only the data based on SCC.Level.Three
CodebookMotor<-subset(codebook, grepl(paste(l, collapse="|"),codebook$SCC.Level.Three))

#subset the dataset according to the identified data entries
dataMotor<-subset(dataSubset, (SCC %in% CodebookMotor$SCC))

dataUse<-aggregate(dataSubset$Emissions, c(list(dataSubset$fips),list(dataSubset$year)), sum)
names(dataUse)<-c('fips','year','Emissions')

dataUseBC<-subset(dataUse,(dataUse$fips=="24510"))
dataUseLAC<-subset(dataUse,(dataUse$fips=="06037"))

dataUseBC$Emissions<-dataUseBC$Emissions/dataUseBC$Emissions[1]
dataUseLAC$Emissions<-dataUseLAC$Emissions/dataUseLAC$Emissions[1]

dataPlot<-rbind(dataUseBC,dataUseLAC)

names(dataPlot)<-c('fips','year','Emissions')

#levels(dataPlot$fips) <- c("Los Angeles County", "Baltimore City")

county_labeller <- function(var, value){
  value <- as.character(value)
  if (var=="fips") { 
    value[value=="06037"] <- "Los Angeles County"
    value[value=="24510"]   <- "Baltimore City"
  }
  return(value)
}

#do plotting
png("plot_6.png",width=960)
p<-ggplot(dataPlot, aes(x=year,y=Emissions))+geom_point()+stat_smooth(method="lm")+facet_grid(.~fips, labeller=county_labeller)
p<-p+labs(title="Normalized Emissions fom Motor Vehicle-Related Sources in Los Angeles County and Baltimore City")+ylab("Normalized Emissions to Year 1999")
p
dev.off()
