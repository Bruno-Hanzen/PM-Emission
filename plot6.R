# some initialisations
indirectory <-"Z:/Professionnel/Cours/R Code/Assignment 6"
outdirectory <-"Z:/Professionnel/Cours/repos/PM-Emission"
zipfile <- "exdata_data_NEI_data.zip"
datafile <- "summarySCC_PM25.RDS"
codefile <- "Source_Classification_Code.RDS"
fullzip <-paste(indirectory,"/", zipfile, sep="")
fulldata <- paste(indirectory,"/", datafile, sep="")
fullcode <- paste(indirectory,"/", codefile, sep="")
plot6 <-paste(outdirectory,"/", "plot6.png", sep="")

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
# Select Baltimore and Los Angeles Vehicles data
VehBaltEm<-NEI[NEI$SCC %in% Veh$SCC & (NEI$fips == "24510"|NEI$fips == "06037"),]

summed<-aggregate(Emissions~year+fips, data=VehBaltEm, FUN=sum)
# Replace FIPS codes with city names
summed$fips<-sub("06037", "Los Angeles", summed$fips)
summed$fips<-sub("24510", "Baltimore", summed$fips)

png(file=plot6)
# I used a logarithmic y-axis in order to ease the comparison of the 2 series
graph<-qplot(year, 
      Emissions,
      data=summed,
      color=fips,
      main="Baltimore-Los Angeles PM 2.5 Emissions Evolution Comparison",
      xlab="Year",
      ylab="log(Emissions)")+geom_line(size=2)+coord_trans(y = "log10")
print(graph)
dev.off()