# some initialisations
indirectory <-"Z:/Professionnel/Cours/R Code/Assignment 6"
outdirectory <-"Z:/Professionnel/Cours/repos/PM-Emission"
zipfile <- "exdata_data_NEI_data.zip"
datafile <- "summarySCC_PM25.RDS"
codefile <- "Source_Classification_Code.RDS"
fullzip <-paste(indirectory,"/", zipfile, sep="")
fulldata <- paste(indirectory,"/", datafile, sep="")
fullcode <- paste(indirectory,"/", codefile, sep="")
plot5 <-paste(outdirectory,"/", "plot5.png", sep="")

library(ggplot2)

# get zip from Internet
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", fullzip)
# unzip
unzip(fullzip, exdir=indirectory)
# read unzipped file
NEI <- readRDS(fulldata)
SCC <- readRDS(fullcode)

# Find the Vehicles-related SCC codes
Veh<-SCC[grepl("Vehicles", SCC$EI.Sector),]
# Select Baltimore Vehicles observations
VehBaltEm<-NEI[NEI$SCC %in% Veh$SCC & NEI$fips == "24510",]
# sum by year
summed<-aggregate(Emissions~year, data=VehBaltEm, FUN=sum)
png(file=plot5)
plot(summed$year, 
     summed$Emissions,
     main="Baltimore Vehicules PM 2.5 Emissions Evolution",
     xlab="Year", 
     ylab="Total Emissions", 
     type="l", 
     col="green", 
     lwd=2)
dev.off()