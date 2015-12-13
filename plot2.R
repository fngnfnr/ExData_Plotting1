##Assignment1
##Plot2
##December 12, 2015

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "powerConsumption.zip", mode="wb")
unzip("powerConsumption.zip")

##Use the following package to make it easier to just get the date range for this data
##install.packages("sqldf")  ##uncomment the install line to install the package if it isn't there already
library(sqldf)

csvFile <- "household_power_consumption.txt" ##this is the file from the zip
pwr <- read.csv.sql(csvFile, sql ="select * from file where Date in('1/2/2007','2/2/2007')", header=TRUE, sep=";")
closeAllConnections()

##This column for this range doesn't have any ?.  I used this to check:
pwr$Global_active_power[pwr$Global_active_power == "?"] <- NA
sum(is.na(pwr$Global_active_power))
pwr$Date[pwr$Date=="?"] <- NA
sum(is.na(pwr$Date))
pwr$Date[pwr$Time=="?"] <- NA
sum(is.na(pwr$Time))

##Combine the date/time column so we can use it as a date object
newDates <- as.POSIXct(paste(pwr$Date, pwr$Time), format="%d/%m/%Y %H:%M:%S")

png("plot2.png", width=480, height=480) ##The default already is 480x480, but I specify anyway because I don't want to lose points if someone doesn't know that
plot(newDates, pwr$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="") ##type l is for lines
dev.off()

