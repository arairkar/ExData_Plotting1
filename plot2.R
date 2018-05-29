#########################
####### Course project for Week1 of Coursera/Exploratory Data Analysis
#5/29/2018


# Check and install necessary packages
if("data.table" %in% rownames(installed.packages()) == FALSE) 
{install.packages("data.table")}
if("lubridate" %in% rownames(installed.packages()) == FALSE) 
{install.packages("lubridate")}
library(data.table)
library(lubridate)

#Below statement can be ignored if you want to run code in your own directory

setwd("~/coursera/exploratory-data-analysis")


if(!file.exists("Week1"))
{
        dir.create("Week1")
}
setwd("./Week1")

fileurl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"

#Download and unzip data file
if(!file.exists("./EDA-proj.zip"))
{
        download.file(fileurl,destfile = "./EDA-proj.zip",method = "curl")
}
unzip("./EDA-proj.zip")

#remove zip file to save directory space
file.remove("./EDA-proj.zip")

#Extract data file and subset dates 1/2/2007 and 2/2/2007, 
#remove main data frame after subsetting
dt <- data.table::fread("./household_power_consumption.txt",sep=";",header = TRUE)
dt_sub <- dt[which(dt$Date=="1/2/2007" | dt$Date== "2/2/2007")]
rm(dt)

# set as data frame and make relevant columns numeric
dt_sub <- as.data.frame(dt_sub)
dt_sub$Global_active_power <- as.numeric(dt_sub$Global_active_power)
dt_sub$Global_reactive_power <- as.numeric(dt_sub$Global_reactive_power)
dt_sub$Global_intensity <- as.numeric(dt_sub$Global_intensity)
dt_sub$Voltage <- as.numeric(dt_sub$Voltage)
dt_sub$Sub_metering_1 <- as.numeric(dt_sub$Sub_metering_1)
dt_sub$Sub_metering_2 <- as.numeric(dt_sub$Sub_metering_2)
dt_sub$Sub_metering_3 <- as.numeric(dt_sub$Sub_metering_3)

# create date&time column in POSIXlt format
dt_sub$Tstamp = paste(dt_sub$Date," ", dt_sub$Time)
dt_sub$Tstamp = strptime(dt_sub$Tstamp,"%d/%m/%Y %H:%M:%S")



#plot2
png("plot2.png",width=480,height=480)
plot(dt_sub$Tstamp,dt_sub$Global_active_power,type="l",ylab="Global Active Power (kilowatts)",xlab="")
dev.off()
