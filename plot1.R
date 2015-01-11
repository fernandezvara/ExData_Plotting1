# Download data?
fileName <- 'dataset.zip'
if (!file.exists(fileName)) {
  print("Downloading data...")
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(url, fileName, method = 'curl')
  unzip(fileName)
}

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

png(filename='plot1.png',
    width=480,
    height=480,
    units='px')

hist(power_data_subset$GlobalActivePower,
     main='Global Active Power',
     xlab='Global Active Power (kilowatts)',
     col='red')

# dev.off
x<-dev.off()
