##Assignment1
##Plot1
##December 12, 2015

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileurl, destfile = "powerConsumption.zip", mode="wb")
unzip("powerConsumption.zip")

##Use the following package to make it easier to just get the date range for this data
install.packages("sqldf")
library(sqldf)

csvFile <- "household_power_consumption.txt" ##this is the file from the zip
pwr <- read.csv.sql(csvFile, sql ="select * from file where Date in('1/2/2007','2/2/2007')", header=TRUE, sep=";")
closeAllConnections()

##This column for this range doesn't have any ?.  I used this to check:
pwr$Global_active_power[pwr$Global_active_power == "?"] <- NA
sum(is.na(pwr$Global_active_power))

png("plot1.png", width=480, height=480) ##The default already is 480x480, but I specify anyway because I don't want to lose points if someone doesn't know that
hist(pwr$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power",ylim=c(0,1200))
dev.off()
