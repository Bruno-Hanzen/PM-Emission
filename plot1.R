# some initialisations
indirectory <-"Z:/Professionnel/Cours/R Code/Assignment 6"
dataurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
outdirectory <-"Z:/Professionnel/Cours/repos/PM-Emission"
zipfile <- "exdata_data_NEI_data.zip"
datafile <- "summarySCC_PM25.RDS"
codefile <- "Source_Classification_Code.RDS"
fullzip <-paste(indirectory,"/", zipfile, sep="")
fulldata <- paste(indirectory,"/", datafile, sep="")
plot1 <-paste(outdirectory,"/", "plot1.png", sep="")

# get zip from Internet
download.file(dataurl, fullzip)
# unzip
unzip(fullzip, exdir=indirectory)
# read unzipped file
NEI <- readRDS(fulldata)
# sum by year
summed<-aggregate(Emissions~year, data=NEI, FUN=sum)
# output to png
png(file=plot1)
plot(summed$year, 
     summed$Emissions,
	 main="United States PM 2.5 Emissions Evolution",
     xlab="Year", 
     ylab="Total Emissions", 
     type="l", 
     col="green", 
     lwd=2)
dev.off()