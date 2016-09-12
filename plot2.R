# some initialisations
indirectory <-"Z:/Professionnel/Cours/R Code/Assignment 6"
outdirectory <-"Z:/Professionnel/Cours/repos/PM-Emission"
zipfile <- "exdata_data_NEI_data.zip"
datafile <- "summarySCC_PM25.RDS"
fullzip <-paste(indirectory,"/", zipfile, sep="")
fulldata <- paste(indirectory,"/", datafile, sep="")
plot2 <-paste(outdirectory,"/", "plot2.png", sep="")

# get zip from Internet
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", fullzip)
# unzip
unzip(fullzip, exdir=indirectory)
# read unzipped file
NEI <- readRDS(fulldata)
# select Baltimore records
Baltimore<-NEI[NEI$fips=="24510",]
# sum by year
summed<-aggregate(Emissions~year, data=Baltimore, FUN=sum)
#plot to png
png(plot2)
plot(summed$year, 
           summed$Emissions,
           main= "Baltimore PM 2.5 Emissions Evolution",
           xlab="Year", 
           ylab="Total Emissions", 
           type="l", 
           col="green", 
           lwd=2)
dev.off()