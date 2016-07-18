# Script for working on the Culex Data for mapping purposes
# requires lubridate package

# Load lubridate package
library(lubridate)

# Set working directory
setwd("C:/Users/JoshE/MetroVan")

#Import data
CD1 <- read.csv("culexdata1.csv", header = TRUE)
CD2 <- read.csv("culexdata2.csv", header = TRUE)

# Combine Data Sets
CD <- rbind(CD1, CD2)

# Factors in the Dataset
str(CD)

# Omitting N/a columns for moquitoes caught
CDM <- CD[complete.cases(CD$NumberMosq),]

#change date column to be recognized as date type
CDM$Date = as.Date(CDM$Date, "%Y-%m-%d")

# Double check it changed to date
str(CDM)

# Subset for Years 2012,2013,2014,2015 *requires Lubridate package
CDsub <- subset(CDM, Date > "2012-01-01")

