#R script to plot Global active power vs days 
fileUrl  <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Download and unzip in "getdata" directory
if(!file.exists("getdata")) dir.create("getdata") 
download.file(fileUrl, destfile = "getdata/electData.zip")
unzip("getdata/electData.zip", exdir="getdata")

#Read and filter feb data
electData    <- read.table("./getdata/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?")
febElectData <- electData[electData$Date == "1/2/2007" | electData$Date == "2/2/2007", ]
febElectData$datetime <- strptime(paste(febElectData$Date, febElectData$Time), "%d/%m/%Y %H:%M:%S")

#Dump plot in  plot3.png file
png("./plot3.png", units = "px", width = 480, height = 480)
plot(febElectData$datetime, febElectData$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(febElectData$datetime, febElectData$Sub_metering_2, type = "l", xlab = "", ylab = "Energy sub metering", col = "red")
points(febElectData$datetime, febElectData$Sub_metering_3, type = "l", xlab = "", ylab = "Energy sub metering", col = "blue")
legend("topright", lty = 1, col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()
