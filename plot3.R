### Exploratory Data Analysis Course (Week 1)
### https://github.com/ennobesh/exploratory-data-analysis

setwd("/home/Documents/COURSERA/Exploratory_Analysis")
mainDir = getwd()
source("getData.R")

df <- getData()

### PLOT 3
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
