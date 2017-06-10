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
png("plot2.png")

## Creating the Plot and closing graphics device
plot(x$DateTime, x$Global_active_power,type = "l", 
     xlab=NA, ylab="Global Active Power (kilowatts)")
dev.off()

