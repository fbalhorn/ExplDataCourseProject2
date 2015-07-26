#dataimport and subset
codebook<-readRDS('Source_Classification_Code.rds')
data<-readRDS('summarySCC_PM25.rds')

Emissions<-tapply(data$Emissions,data$year,sum)

#do plotting
png("plot_1.png")
plot1<-plot(names(Emissions),Emissions,xlab="Year",ylab="Total Emissions",pch=16,col="red",main="Total Emissions from all Sources 1999-2008")
dev.off()
