### Exploratory Data Analysis Course (Week 1)
### https://github.com/ennobesh/exploratory-data-analysis

setwd("/home/Documents/COURSERA/Exploratory_Analysis")
mainDir = getwd()
source("getData.R")

df <- getData()

### Plot 1
par(mfrow = c(1,1))
hist(df$Global_active_power, col = "red", main = paste("Global Active Power"),
     xlab = "Global Active Power (kilowatts)")
dev.copy(png, file="plot1.png", width=480, height=480)
dev.off()
