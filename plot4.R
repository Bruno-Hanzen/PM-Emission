# some initialisations
indirectory <-"Z:/Professionnel/Cours/R Code/Assignment 6"
outdirectory <-"Z:/Professionnel/Cours/repos/PM-Emission"
zipfile <- "exdata_data_NEI_data.zip"
datafile <- "summarySCC_PM25.RDS"
codefile <- "Source_Classification_Code.RDS"
fullzip <-paste(indirectory,"/", zipfile, sep="")
fulldata <- paste(indirectory,"/", datafile, sep="")
fullcode <- paste(indirectory,"/", codefile, sep="")
plot4 <-paste(outdirectory,"/", "plot4.png", sep="")

# get zip from Internet
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip", fullzip)
# unzip
unzip(fullzip, exdir=indirectory)
# read unzipped file
NEI <- readRDS(fulldata)
SCC <- readRDS(fullcode)
# create new dataframe with coal combustion observations
Coal<-SCC[ grepl("Coal", SCC$EI.Sector)&grepl("Comb", SCC$EI.Sector),]
CoalEm<-NEI[NEI$SCC %in% Coal$SCC,]

# sum by year
summed<-aggregate(Emissions~year, data=CoalEm, FUN=sum)
png(file=plot4)
plot(summed$year, 
     summed$Emissions,
     main="United States Coal Combustion PM 2.5 Emissions Evolution",
     xlab="Year", 
     ylab="Total Emissions", 
     type="l", 
     col="green", 
     lwd=2)
dev.off()