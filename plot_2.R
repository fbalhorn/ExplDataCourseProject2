#dataimport and subset
codebook<-readRDS('Source_Classification_Code.rds')
data<-readRDS('summarySCC_PM25.rds')

dataSubset<-subset(data,data$fips=="24510")
Emissions<-tapply(dataSubset$Emissions,dataSubset$year,sum)
Years<-unique(dataSubset$year)
df=data.frame(Emissions,Years)

#do plotting
png("plot_2.png")
plot1<-plot(names(Emissions),Emissions,xlab="Year",ylab="Total Emissions",pch=16,col="red",main="Baltimore City: Total Emissions from all Sources 1999-2008")
model<-lm(Emissions~Years,df)
abline(model,lwd=2)
dev.off()
