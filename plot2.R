### Exploratory Data Analysis Course (Week 1)
### https://github.com/ennobesh/exploratory-data-analysis

setwd("/home/Documents/COURSERA/Exploratory_Analysis")
mainDir = getwd()
source("getData.R")

df <- getData()

### PLOT 2
par(mfrow = c(1,1))
plot(df$timestamp,df$Global_active_power, type="l",
     xlab="",
     ylab="Global Active Power (kilowatts)")
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
