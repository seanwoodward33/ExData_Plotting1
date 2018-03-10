## Exploratory Data Analysis - Week 1 - Assignment
## seanwoodward33
##
## plot1.R
##
## This script plots a line graph of Global Active Power


## Function assumes the data has already been downloaded and is in the working
## directory in a file called "household_power_consumption.txt

plot4 <- function(){
    ## Import data into R
    powerData <- read.delim("household_power_consumption.txt", sep=";", stringsAsFactors = FALSE)

    ## Create date/time column
    powerData$DateTime <- strptime(paste(powerData$Date,powerData$Time),
                                   format = "%d/%m/%Y %H:%M:%S")
    
    ## Cut down data to relevant data, 1st & 2nd Feb 2002
    powerData <- powerData[powerData$DateTime < as.POSIXlt("2007-02-03")
                           & powerData$DateTime >= as.POSIXlt("2007-02-01"),]
    
    ## Remove NA's from data (need to exclude date columns)
    powerData <- powerData[complete.cases(powerData[,3:9]),]
    
    ## Convert number columns to numbers, not strings
    powerData$Global_active_power <- as.numeric(powerData$Global_active_power)
    powerData$Global_reactive_power <- as.numeric(powerData$Global_reactive_power)
    powerData$Voltage <- as.numeric(powerData$Voltage)
    powerData$Global_intensity <- as.numeric(powerData$Global_intensity)
    powerData$Sub_metering_1 <- as.numeric(powerData$Sub_metering_1)
    powerData$Sub_metering_2 <- as.numeric(powerData$Sub_metering_2)
    powerData$Sub_metering_3 <- as.numeric(powerData$Sub_metering_3)
    
    ## Save plot to *.png
    png("plot4.png")
    par(mfrow = c(2,2))
    plot(powerData$DateTime, powerData$Global_active_power, type = "l",
         xlab = "", ylab = "Global Active Power")
    plot(powerData$DateTime, powerData$Voltage, type = "l",
         xlab = "datetime", ylab = "Voltage")
    plot(powerData$DateTime, powerData$Sub_metering_1, xlab = "", 
         ylab = "Energy sub metering", type = "l")
    lines(powerData$DateTime, powerData$Sub_metering_2, col = "red")
    lines(powerData$DateTime, powerData$Sub_metering_3, col = "blue")
    legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           col = c("black","red","blue"),lty = c(1,1,1), bty = "n")
    plot(powerData$DateTime, powerData$Global_reactive_power, type ="l",
         xlab = "datetime", ylab = "Global_reactive_power")
    dev.off()
    
    ## Return data
    powerData

}