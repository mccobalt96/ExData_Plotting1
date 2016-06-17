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

plot(datap2$Sub_metering_1 ~ as.POSIXct(datap2$Full_Date), type="l", xlab="", ylab="Global Active Power (in Kilowatts)")

## add the second set of data to the plot

lines(datap2$Sub_metering_2 ~ as.POSIXct(datap2$Full_Date), col='red')

## add the third set of data to the plot

lines(datap2$Sub_metering_3 ~ as.POSIXct(datap2$Full_Date), col='blue')

## create the legend

legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, lwd=2)

## create the png output file

dev.copy(png, file="plot3.png")

## close the file

dev.off()
