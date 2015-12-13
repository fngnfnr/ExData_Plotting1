##Assignment1
##Plot4
##December 12, 2015

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "powerConsumption.zip", mode="wb")
unzip("powerConsumption.zip")

##Use the following package to make it easier to just get the date range for this data
##install.packages("sqldf")  ##uncomment the install line to install the package if it isn't there already
library(sqldf) ##using this package to make it easier to get data for dates we want

csvFile <- "household_power_consumption.txt" ##this is the file from the zip
pwr <- read.csv.sql(csvFile, sql ="select * from file where Date in('1/2/2007','2/2/2007')", header=TRUE, sep=";")
closeAllConnections()

##This column for this range doesn't have any ?.  I used this to check:
pwr$Date[pwr$Date=="?"] <- NA
sum(is.na(pwr$Date))
pwr$Date[pwr$Time=="?"] <- NA
sum(is.na(pwr$Time))
pwr$Sub_metering_1[pwr$Sub_metering_1=="?"] <- NA
sum(is.na(pwr$Sub_metering_1))
pwr$Sub_metering_2[pwr$Sub_metering_2=="?"] <- NA
sum(is.na(pwr$Sub_metering_2))
pwr$Sub_metering_3[pwr$Sub_metering_3=="?"] <- NA
sum(is.na(pwr$Sub_metering_3))
pwr$Voltage[pwr$Voltage=="?"] <- NA
sum(is.na(pwr$Voltage))
pwr$Global_reactive_power[pwr$Global_reactive_power =="?"] <- NA
sum(is.na(pwr$Global_reactive_power))

##Combine the date/time column so we can use it as a date object
newDates <- as.POSIXct(paste(pwr$Date, pwr$Time), format="%d/%m/%Y %H:%M:%S")

png("plot4.png", width=480, height=480) ##The default already is 480x480, but I specify anyway because I don't want to lose points if someone doesn't know that
par(mfrow=c(2,2))
with(pwr, {
  plot(newDates, pwr$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(newDates, pwr$Voltage, type="l", ylab="Voltage", xlab="datetime")
  plot(newDates, pwr$Sub_metering_1, type="l", ylab="Energy sub meetering", xlab="")
  lines(newDates, pwr$Sub_metering_2, col="red")
  lines(newDates, pwr$Sub_metering_3, col="blue")
  legendNames <- c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
  legend("topright", lty=c(1,1), col=c("black", "red", "blue"), legend=legendNames, bty="n") ##bty makes the border go away
  plot(newDates, pwr$Global_reactive_power, ylab="Global_reactive_power", xlab="datetime", type="l", ylim=c(0.0, 0.5))
})
dev.off()

