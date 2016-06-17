## reset the plot space

dev.off()

## source dplyr

library(dplyr)

## read the data into a table using “;” as the separator.  The file does have headers.

datap <- read.table("./data/household_power_consumption.txt", sep=";", header=TRUE, na.strings = "?")

## trim the data to be the two days we are interested in

datap2 <- filter(datap,Date=="1/2/2007" | Date=="2/2/2007")

## change the Global_active_power to a numeric (after converting it to 
## character since it is a factor!

datap2$Global_active_power <- as.numeric(as.character(datap2$Global_active_power))

## convert the Date factor to character

datap2$Date <- as.character(datap2$Date)

## convert the Time factor to character

datap2$Time <- as.character(datap2$Time)

## create a temporary variable with the date and time

date_array <- paste(datap2$Date, datap2$Time)

## create a new column in the dataset with a real date/time

datap2$Full_Date <- strptime(date_array, "%d/%m/%Y %H:%M:%S")

## generate the plot using the new (real) date/time and global active power

plot(datap2$Full_Date, datap2$Global_active_power, type="l", xlab="", ylab="Global Active Power (in Kilowatts)")

## create the png output file

dev.copy(png, file="plot2.png")

## close the file

dev.off()
