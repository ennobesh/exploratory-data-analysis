### Exploratory Data Analysis Course Project (Week 1)
### https://github.com/ennobesh/exploratory-data-analysis


getData <- function() {
        library(data.table)
        library(dplyr) ## (data.table + dplyr code now  in dtplyr)

        originalDir <- getwd()

        ### Download the dataset, if not there already
        mainDir <- getwd()
        rawDir <- "data"
        if(!file.exists(destfile)){
                dir.create(file.path(mainDir, rawDir))
        }
        setwd(file.path(mainDir, rawDir))
        destfile <- file.path(getwd(), "household_power_consumption.zip")
        if(!file.exists(destfile)){
                url <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
                res <- tryCatch(download.file(url, destfile),
                                error=function(e) 1)
        }
        unzip("household_power_consumption.zip", exdir = "./")
        setwd(file.path(mainDir))
        dataDir <- file.path(mainDir,rawDir)
          
        
        ### Seperate large datasetE
        setwd(dataDir)
                                     
        commands <- list("head -n1 household_power_consumption.txt  > subset_household_power_consumption.txt ",
                         "egrep -i '(^1/2/2007)|(^2/2/2007)' household_power_consumption.txt  >> subset_household_power_consumption.txt")
        for (cmd in commands) {
                system(cmd)
        }
        
        data <- read.table(paste0(dataDir, "/", "subset_household_power_consumption.txt", collapse = NULL), sep=";")
        
        ## a faster way to load the whole file than using read-table() 
        ## with fread from "data.table" package (useful for large data files)
        df <- fread(paste0(dataDir, "/", "subset_household_power_consumption.txt", collapse = NULL),
                    na.strings="?",stringsAsFactors = FALSE)
        
        #### Converting Date & Date+Time variables to Date and Date/Time classes in R
        df$Date <- as.Date(df$Date, format="%d/%m/%Y")
        setwd(originalDir)
        df <- transform(df, timestamp=as.POSIXct(paste(Date, Time)), "%d/%m/%Y %H:%M:%S")
}
