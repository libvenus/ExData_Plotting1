#R script to plot a histogram depicting global active power(kw) frequency in png format 
fileUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Download and unzip in "getdata" directory
if(!file.exists("getdata")) dir.create("getdata") 
download.file(fileUrl, destfile = "getdata/electData.zip")
unzip("getdata/electData.zip", exdir="getdata")

#Read and filter feb data
electData    <- read.table("./getdata/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
febElectData <- electData[electData$Date == "1/2/2007" | electData$Date == "2/2/2007", ]

#Dump histogram in a plot1.png file
png("./plot1.png", units = "px", width = 480, height = 480)
hist(febElectData$Global_active_power, col = "red", xlab = "Global Active Power(kilowatts)", main = "Global Active Power");
dev.off()