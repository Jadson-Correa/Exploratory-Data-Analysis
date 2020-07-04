#install.packages("datatable")
library("data.table")

setwd("C:/Users/Home/Desktop/coursera")

#READ THE DATA
energia <- data.table::fread(input = "household_power_consumption.txt"
                             , na.strings="?"
)

#FILTER AND ORGANIZE
energia[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

energia[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

energia <- energia[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width=480, height=480)

## Plot 2
plot(x = energia[, dateTime]
     , y = energia[, Global_active_power]
     , type="l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()