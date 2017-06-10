## plot1.R
## Assumes data.table package is installed

library(data.table)

## Reading Files & Subsetting to 1/2/2007 & 2/2/2007
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("EPC.zip")) download.file(fileURL, "./EPC.zip")
suppressWarnings(unzip("EPC.zip",overwrite = FALSE))
initial <- fread(input = "household_power_consumption.txt", nrows = 10)
names <- colnames(initial)
x <- fread(input = "household_power_consumption.txt", skip="1/2/2007",nrows = 2880, 
           col.names = names)

## PNG Graphics Device
png("plot1.png")

## Creating the Plot and closing graphics device
hist(x$Global_active_power, col="red", main="Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

