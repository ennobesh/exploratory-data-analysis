### Exploratory Data Analysis Course (Week 1)
### https://github.com/ennobesh/exploratory-data-analysis

setwd("/home/Documents/COURSERA/Exploratory_Analysis")

### Download the dataset if not there
mainDir = getwd()
rawDir = "data"
if(!file.exists(destfile)){
        dir.create(file.path(mainDir, rawDir))
}
setwd(file.path(mainDir, rawDir))

if(!file.exists(destfile)){
        url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
        res <- tryCatch(download.file(url, destfile),
                        error=function(e) 1)
}
unzip("household_power_consumption.zip", exdir = "./")
setwd(file.path(mainDir))
dataDir <- file.path(mainDir,rawDir)


### Seperate the dataset
setwd(dataDir)
                   
commands <- list("head -n1 household_power_consumption.txt  > subset_household_power_consumption.txt ",
             "egrep -i '(^1/2/2007)|(^2/2/2007)' household_power_consumption.txt  >> subset_household_power_consumption.txt")
for (cmd in commands) {
        system(cmd)
}

data <- read.table(paste0(dataDir, "subset_household_power_consumption.txt", collapse = NULL), sep=";")

library(data.table)
library(dplyr) ## (data.table + dplyr code now in dtplyr)
df <- fread(paste0(dataDir, "subset_household_power_consumption.txt", collapse = NULL),
                na.strings="?",stringsAsFactors = FALSE)

#### Converting Date & Date+Time variables to Date and Date/Time classes in R
df$Date <- as.Date(df$Date, format="%d/%m/%Y")
df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")

setwd(file.path(mainDir))

### Plot 1
par(mfrow = c(1,1))
hist(df$Global_active_power, col = "red", main = paste("Global Active Power"),
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()


### Plot 2
par(mfrow = c(1,1))
plot(df$timestamp,df$Global_active_power, type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()


### Plot 3
png(width=480, height=480, file = "plot3.png")
par(mfrow = c(1,1), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(df, {
        plot(Sub_metering_1 ~ timestamp, type = "l", 
             ylab = "Energy sub metering", xlab = "")
        lines(Sub_metering_2 ~ timestamp, col = 'Red')
        lines(Sub_metering_3 ~ timestamp, col = 'Blue')
})
legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()


### Plot 4
png(width=480, height=480, file = "plot4.png")
par(mfrow = c(2,2), mar = c(4,4,2,1), oma = c(0,0,2,0))
with(df, {
        plot(Global_active_power ~ timestamp, type = "l", 
             ylab = "Global Active Power", xlab = "")
        plot(Voltage ~ timestamp, type = "l", ylab = "Voltage", xlab = "datetime")
        plot(Sub_metering_1 ~ timestamp, type = "l", ylab = "Energy sub metering",
             xlab = "")
        lines(Sub_metering_2 ~ timestamp, col = 'Red')
        lines(Sub_metering_3 ~ timestamp, col = 'Blue')
        legend("topright", col = c("black", "red", "blue"), lty = 1, lwd = 2, 
               bty = "n",
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power ~ timestamp, type = "l", 
             ylab = "Global_reactive_power", xlab = "datetime")
})
dev.off()
