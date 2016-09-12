# some initialisations
indirectory <-"Z:/Professionnel/Cours/R Code/Assignment 6"
outdirectory <-"Z:/Professionnel/Cours/repos/PM-Emission"
zipfile <- "exdata_data_NEI_data.zip"
datafile <- "summarySCC_PM25.RDS"
fullzip <-paste(indirectory,"/", zipfile, sep="")
fulldata <- paste(indirectory,"/", datafile, sep="")
plot3 <-paste(outdirectory,"/", "plot3.png", sep="")

# load ggplot2
library(ggplot2)

# get zip from Internet
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", fullzip)
# unzip
unzip(fullzip, exdir=indirectory)
# read unzipped file
NEI <- readRDS(fulldata)
# select Baltimore records
Baltimore<-NEI[NEI$fips=="24510",]
# sum by type and year
summed<-aggregate(Emissions~type+year, data=Baltimore, FUN=sum)
#plot to png
png(plot3)
graph<-qplot(year, 
      Emissions,
      data=summed,
      color=type,
      xlab="Year",
      ylab="Emissions",
      main="Baltimore PM 2.5 Emissions Evolution - by type")+geom_line(size=2)
print(graph)
dev.off()