library("lubridate")
setwd("//.../Coursera/Exploratory Data Analysis/Week 1")
getwd()
data <- file("household_power_consumption.txt")

data1 <- read.table(text = grep("^[1,2]/2/2007", readLines(data), value = TRUE),col.names = c("Date", "Time", "Global_active_power",
        "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
         sep = ";", header = TRUE)
names(data1)
#[1] "Date"                  "Time"                  "Global_active_power"   "Global_reactive_power"
#[5] "Voltage"               "Global_intensity"      "Sub_metering_1"        "Sub_metering_2"       
#[9] "Sub_metering_3"       
dim(data1)
#[1] 2879    9
head(data1)
data1$Datetime <- strptime(paste(data1$Date, data1$Time), "%d/%m/%Y %H:%M:%S")
data1$Datetime <- as.POSIXct(data1$Datetime, tz="GMT")

Sys.setlocale("LC_TIME", "English")
#[1] "English_United States.1252"

# Plot 4 #

png(filename='plot4.png', width=480, height=480, units='px')

#Sets graphics parameters # 
par(mfcol = c(2,2))
#1#
plot(data1$Datetime, data1$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power(kilowatts)")
#2#
plot(data1$Datetime, data1$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(data1$Datetime, data1$Sub_metering_2, type = "l", col = "red" )
lines(data1$Datetime, data1$Sub_metering_3, type = "l", col = "blue" )
legend("topright", lty= 1, col = c("Black", "red", "blue"), legend = c( "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
#3#
plot(data1$Datetime, data1$Voltage, type = "l",xlab = "datetime", ylab = "Voltage")
#4#
plot(data1$Datetime, data1$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")

dev.off()

