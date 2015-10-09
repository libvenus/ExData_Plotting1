#R script to plot multiple plots
fileUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Download and unzip in "getdata" directory
if(!file.exists("getdata")) dir.create("getdata") 
download.file(fileUrl, destfile = "getdata/electData.zip")
unzip("getdata/electData.zip", exdir="getdata")

#Read and filter feb data
electData    <- read.table("./getdata/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
febElectData <- electData[electData$Date == "1/2/2007" | electData$Date == "2/2/2007", ]
febElectData$datetime <- strptime(paste(febElectData$Date, febElectData$Time), "%d/%m/%Y %H:%M:%S")

#Dump plots in  plot4.png file
png("./plot4.png", units = "px", width = 480, height = 480)
par(mfrow = c(2,2))
with(febElectData, {
  plot(febElectData$datetime, febElectData$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power (kilowatts)"); 
  plot(febElectData$datetime, febElectData$Voltage, type = "l", xlab = "datetime", ylab = "Voltage"); 
  plot(febElectData$datetime, febElectData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering") 
  points(febElectData$datetime, febElectData$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red") 
  points(febElectData$datetime, febElectData$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue") 
  legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"));
  plot(febElectData$datetime, febElectData$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
})
dev.off()
