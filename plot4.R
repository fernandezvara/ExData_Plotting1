# Download data?
fileName <- 'dataset.zip'
if (!file.exists(fileName)) {
  print("Downloading data...")
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(url, fileName, method = 'curl')
  unzip(fileName)
}

# library lubridate
library(lubridate)

# Read data
col_classes <- c('character','character','numeric','numeric','numeric','numeric','numeric','numeric')
power_data <- read.table('household_power_consumption.txt',
                         header=TRUE,
                         colClasses=col_classes,
                         sep=';',
                         na.strings='?') 
# Subsetting data
power_data_subset <- power_data[power_data$Date=='1/2/2007' | power_data$Date=='2/2/2007',]

# tidy up data
cols<-c('Date',
        'Time',
        'GlobalActivePower',
        'GlobalReactivePower',
        'Voltage',
        'GlobalIntensity',
        'SubMetering1',
        'SubMetering2',
        'SubMetering3')
colnames(power_data_subset)<-cols

png(filename='plot4.png',
    width=480,
    height=480,
    units='px')

# split 2x2 the plot
par(mfrow=c(2,2))

# coord 1,1 plot
plot(dmy(power_data_subset$Date)+hms(power_data_subset$Time),
     power_data_subset$GlobalActivePower,
     ylab='Global Active Power',
     xlab='',
     type='l')

# coord 1,2 plot
plot(dmy(power_data_subset$Date)+hms(power_data_subset$Time),
     power_data_subset$Voltage,
     ylab='Voltage',
     xlab='datetime',
     type='l')

# coord 2,1 plot
lines_colors <- c('black','red','blue')
lines_labels <- c('Sub_metering_1','Sub_metering_2','Sub_metering_3')

plot(dmy(power_data_subset$Date)+hms(power_data_subset$Time),
     power_data_subset$SubMetering1,
     type='l',
     col=lines_colors[1],
     xlab='',
     ylab='Energy sub metering')
lines(dmy(power_data_subset$Date)+hms(power_data_subset$Time),
      power_data_subset$SubMetering2,
      col=lines_colors[2])
lines(dmy(power_data_subset$Date)+hms(power_data_subset$Time),
      power_data_subset$SubMetering3,
      col=lines_colors[3])
legend('topright',
       legend=lines_labels,
       col=lines_colors,
       lty='solid',
       bty="n")

# coord 2,2 plot
plot(dmy(power_data_subset$Date)+hms(power_data_subset$Time),
     power_data_subset$GlobalReactivePower,
     ylab='Global_reactive_power',
     xlab='datetime',
     type='l')

# dev.off
x<-dev.off()