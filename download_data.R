# Step 0. Download data.

fileName <- 'dataset.zip'
if (!file.exists(fileName)) {
  print("Downloading data...")
  url <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
  download.file(url, fileName, method = 'curl')
  unzip(fileName)
}
