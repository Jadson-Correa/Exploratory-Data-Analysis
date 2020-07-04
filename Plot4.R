#install.packages("datatable")
library("data.table")

setwd("C:/Users/Home/Desktop/coursera")

#READ THE DATA
energia <- data.table::fread(input = "household_power_consumption.txt", na.strings="?")

# FILTER AND ORGANIZE
energia[, Global_active_power := lapply(.SD, as.numeric), .SDcols = c("Global_active_power")]

energia[, dateTime := as.POSIXct(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S")]

energia <- energia[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot4.png", width=480, height=480)

par(mfrow=c(2,2))

# Plot 1
plot(energia[, dateTime], energia[, Global_active_power], type="l", xlab="", ylab="Global Active Power")

# Plot 2
plot(energia[, dateTime],energia[, Voltage], type="l", xlab="datetime", ylab="Voltage")

# Plot 3
plot(energia[, dateTime], energia[, Sub_metering_1], type="l", xlab="", ylab="Energy sub metering")
lines(energia[, dateTime], energia[, Sub_metering_2], col="red")
lines(energia[, dateTime], energia[, Sub_metering_3],col="blue")
legend("topright", col=c("black","red","blue")
       , c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  ")
       , lty=c(1,1)
       , bty="n"
       , cex=.5) 

# Plot 4
plot(energia[, dateTime], energia[,Global_reactive_power], type="l", xlab="datetime", ylab="Global_reactive_power")

dev.off()