##### Script for working on the Culex Data for mapping purposes
# requires lubridate package
###################################################
# Load lubridate package
library(lubridate)
###################################################
# Set working directory
setwd("C:/Users/R&Dcoordinator/Desktop/R data 2016")
###################################################
#Import data
CD1 <- read.csv("culexdata1.csv", header = TRUE)
CD2 <- read.csv("culexdata2.csv", header = TRUE)
###################################################
# Combine Data Sets
CD <- rbind(CD1, CD2)
###################################################
# Factors in the Dataset
str(CD)
###################################################
# Omitting N/a columns for moquitoes caught
CDM <- CD[complete.cases(CD$NumberMosq),]
###################################################
#Removing "Junk" Levels from species list
levels(CDM$Species)
CDdrop <- which(CDM$Species =="Non_Mosquito_Larvae")
CDM <- CDM[-CDdrop,]
CDdrop2 <- which(CDM$Species =="Manual.Total.Mosquitoes")
CDM <- CDM[-CDdrop2,]
CDdrop3 <- which(CDM$Species =="Total.Larvae.Collected.y")
CDM <- CDM[-CDdrop3,]
CDdrop4 <- which(CDM$Species =="Unknown.Mosquito")
CDM <- CDM[-CDdrop4,]
CDdrop5 <- which(CDM$Species =="XX")
CDM <- CDM[-CDdrop5,]

###################################################
#change date column to be recognized as date type
CDM$Date = as.Date(CDM$Date, "%Y-%m-%d")
###################################################
# Double check it changed to date
str(CDM)
###################################################
# Subset for Years 2012,2013,2014,2015 *requires Lubridate package

CDallyear <- subset(CDM, Date > "2012-01-01")
CD2012 <- subset(CDM, Date > "2012-01-01" & Date < "2013-01-01")
CD2013 <- subset(CDM, Date > "2013-01-01" & Date < "2014-01-01")
CD2014 <- subset(CDM, Date > "2014-01-01" & Date < "2015-01-01")
CD2015  <- subset(CDM, Date > "2015-01-01"& Date < "2016-01-01")
###################################################
# Requires plyr for next step
library(plyr)
###################################################
# Aggregating all similar sites together
CDallyearsum <- ddply(CDallyear,"CulexSiteID",numcolwise(sum))
CD2012sum <- ddply(CD2012,"CulexSiteID",numcolwise(sum))
CD2013sum <- ddply(CD2013,"CulexSiteID",numcolwise(sum))
CD2014sum <- ddply(CD2014,"CulexSiteID",numcolwise(sum))
CD2015sum<- ddply(CD2015,"CulexSiteID",numcolwise(sum))
###################################################
#Clean up aggregated tables
CDallyearsum$WaterTemp <- NULL
CDallyearsum$WaterDepth <- NULL
CDallyearsum$AirTemp <- NULL
CDallyearsum$PondArea <- NULL
CDallyearsum$ChannelWidth <- NULL
CDallyearsum$BankfullWidth <- NULL
CDallyearsum$X <- NULL

CD2012sum$WaterTemp <- NULL
CD2012sum$WaterDepth <- NULL
CD2012sum$AirTemp <- NULL
CD2012sum$PondArea <- NULL
CD2012sum$ChannelWidth <- NULL
CD2012sum$BankfullWidth <- NULL
CD2012sum$X <- NULL

CD2013sum$WaterTemp <- NULL
CD2013sum$WaterDepth <- NULL
CD2013sum$AirTemp <- NULL
CD2013sum$PondArea <- NULL
CD2013sum$ChannelWidth <- NULL
CD2013sum$BankfullWidth <- NULL
CD2013sum$X <- NULL


CD2014sum$WaterTemp <- NULL
CD2014sum$WaterDepth <- NULL
CD2014sum$AirTemp <- NULL
CD2014sum$PondArea <- NULL
CD2014sum$ChannelWidth <- NULL
CD2014sum$BankfullWidth <- NULL
CD2014sum$X <- NULL

CD2015sum$WaterTemp <- NULL
CD2015sum$WaterDepth <- NULL
CD2015sum$AirTemp <- NULL
CD2015sum$PondArea <- NULL
CD2015sum$ChannelWidth <- NULL
CD2015sum$BankfullWidth <- NULL
CD2015sum$X <- NULL
###################################################
#Aggregate the abundace of species to the site id for each year
CD2012Species <- ddply(CD2012, .(CulexSiteID, Species), summarize, NumberMosq = sum(NumberMosq))
CD2013Species <- ddply(CD2013, .(CulexSiteID, Species), summarize, NumberMosq = sum(NumberMosq))
CD2014Species <- ddply(CD2014, .(CulexSiteID, Species), summarize, NumberMosq = sum(NumberMosq))
CD2015Species <- ddply(CD2015, .(CulexSiteID, Species), summarize, NumberMosq = sum(NumberMosq))
###################################################
# Immporting the Site Coordinate data *Requires Stringr package
library(stringr)
Sites <- read.csv("CSites_2015.csv", header = TRUE)

