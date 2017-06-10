## plot2.R
## Assumes data.table & dplyr packages are installed
library(dplyr)
library(data.table)

## Reading Files & Subsetting to 1/2/2007 & 2/2/2007
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("EPC.zip")) download.file(fileURL, "./EPC.zip")
suppressWarnings(unzip("EPC.zip",overwrite = FALSE))
initial <- fread(input = "household_power_consumption.txt", nrows = 10)
names <- colnames(initial)
x <- fread(input = "household_power_consumption.txt", skip="1/2/2007",nrows = 2880, 
           col.names = names)

#Combine Date-Time
x <- mutate(x, DateTime = paste(Date, Time, sep=" "))
x$DateTime <- strptime(x$DateTime, "%d/%m/%Y %H:%M:%S")


## PNG Graphics Device
png("plot4.png")

## Setting up parameters & creating the plots
par(mfrow=c(2,2))

#Plot 1
with(x, plot(DateTime, Global_active_power,type = "l", 
     xlab=NA, ylab="Global Active Power (kilowatts)"))

#Plot 2
with(x, plot(DateTime, Voltage, type="l", xlab="datetime"))

#Plot 3
with(x, plot(DateTime,Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering"))
with(x, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(x, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2",
                                                         "Sub_metering_3"),lty=c(1,1))

#Plot 4
with(x, plot(DateTime, Global_reactive_power, 
             type="l", xlab="datetime"))

## closing graphics device
dev.off()

