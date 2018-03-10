## Exploratory Data Analysis - Week 1 - Assignment
## seanwoodward33
##
## plot1.R
##
## This script plots a histogram of Global Active Power


## Function assumes the data has already been downloaded and is in the working
## directory in a file called "household_power_consumption.txt

plot1 <- function(){
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
    
    ## Plot histogram to *.png
    png("plot1.png")
    hist(powerData$Global_active_power, col = "red",
         xlab = "Global Active Power (killowatts)", main = "Global Active Power")
    dev.off()
    
    powerData

}