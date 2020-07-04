#install.packages("data.table")
library(data.table)
library(dplyr)
setwd("C:/Users/Home/Desktop/coursera")
getwd()

#READ THE DATA
energia <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

#FILTER AND ORGANIZE
energia[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

energia[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

energia <- energia[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width=480, height=480)

## Plot 1
hist(energia[, Global_active_power], main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

dev.off()