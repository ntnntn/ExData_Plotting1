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
        png(filename='Plots/plot1.png')

        # Make plot
        hist(data$Global_active_power, main='Global Active Power', xlab='Global Active Power (kilowatts)', col='red')

        # Turn off device
        dev.off()