## reset the plot space

dev.off()

## source dplyr

library(dplyr)

## read the data into a table using “;” as the separator.  The file does have headers.

datap <- read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?", colClasses = c(rep("character",9)))

## trim the data to be the two days we are interested in

datap2 <- filter(datap,Date=="1/2/2007" | Date=="2/2/2007")

## change the Global_active_power to a numeric (after converting it to 
## character since it is a factor!

datap2$Global_active_power <- as.numeric(as.character(datap2$Global_active_power))

## create the histogram with the correct variable, adding color, x-label, title, and y limits

hist(datap2$Global_active_power, col="red", xlab="Global Active Power (in Kilowatts)", main="Global Active Power",ylim=c(0,1200))

## create the png output file

dev.copy(png, file="plot1.png")

## close the file

dev.off()
