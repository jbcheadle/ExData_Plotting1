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
png("plot3.png")

## Creating the Plot and closing graphics device
with(x, plot(DateTime,Sub_metering_1, type="l", xlab=NA, ylab="Energy sub metering"))
with(x, lines(DateTime, Sub_metering_2, type="l", col="red"))
with(x, lines(DateTime, Sub_metering_3, type="l", col="blue"))
legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2",
                                                         "Sub_metering_3"),lty=c(1,1))

dev.off()

