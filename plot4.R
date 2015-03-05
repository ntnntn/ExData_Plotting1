library(lubridate)

# If the raw data has not been saved, download, unzip, and load it.
if (!file.exists('household_power_consumption.txt')) {
        download.file(paste0('https://d396qusza40orc.cloudfront.net/',
                             'exdata%2Fdata%2Fhousehold_power_consumption.zip'),
                      method='curl', destfile='household_power_consumption.zip') %%
                unzip("household_power_consumption.zip")
} 

# Read data into a table with appropriate classes
data <- read.table('household_power_consumption.txt', header=TRUE,
                   sep=';', na.strings='?',
                   colClasses=c(rep('character', 2), 
                                rep('numeric', 7)))

# Convert dates and time
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)

# Reduce data frame to what we need
data<-data[data$Date >=ymd("2007-02-01") & data$Date <= ymd("2007-02-02"),]

# Combine date and time
data$date.time <- data$Date + data$Time

# Open png device
png(filename='Plots/plot4.png')

# Make plot
par(mfrow=c(2,2))
plot(data$date.time, data$Global_active_power, xlab="", ylab='Global Active Power (kilowatts)', type="l")
plot(data$date.time, data$Voltage, xlab="datetime", ylab="Voltage", type="l")
plot(data$date.time,data$Sub_metering_1, xlab="", ylab='Energy sub metering', type="l")
lines(data$date.time, data$Sub_metering_2, col="red")
lines(data$date.time, data$Sub_metering_3, col="blue")
legend('topright', legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'), col=c('black', 'red', 'blue'), lty='solid', bty="n")
plot(data$date.time, data$Global_reactive_power, xlab='datetime', ylab='Global_reactive_power', type='l')

# Turn off device
dev.off()