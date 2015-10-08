## Set the directory where the repository Electric Power Consumption is. 
## For the purpose of the assignment submission, I remove the directory that I used, 
## if you want to run this code in your own computer, please set your directory first and then run the code. 
directory <- "" ##Replace here (inside the "") the name of your own directory
setwd(directory)
filename <- "household_power_consumption.txt"
## Extract names of the data set. When I use skip for some reason although I use header=TRUE, they are not retreived. I used this work-around to make it work. 
DataNames <- read.table(filename,sep=";",header=TRUE, nrows=1)
Name_Vector <- names(DataNames)
#Establish a grep to identify which lines to skip and how many lines to extract that correspond with the sub-set of the data. 
start <- grep("1/2/2007", readLines(filename))
end <- grep("3/2/2007", readLines(filename))
DataMatrix <- read.table(filename,sep=";",header=TRUE, skip=start,nrows=end-start-1)
DataMatrix <- setNames(DataMatrix, Name_Vector)
## Transfor Date and time variable to work with them. 
DataMatrix$datetime <- paste(DataMatrix$Date, DataMatrix$Time, sep=" ")
DataMatrix$datetime <- strptime(DataMatrix$datetime, format="%d/%m/%Y %H:%M:%S")
#Transform the numeric variables to a number
DataMatrix$Global_active_power = as.numeric(DataMatrix$Global_active_power)
DataMatrix$Sub_metering_1 = as.numeric(DataMatrix$Sub_metering_1)
DataMatrix$Sub_metering_2 = as.numeric(DataMatrix$Sub_metering_2)
DataMatrix$Sub_metering_3 = as.numeric(DataMatrix$Sub_metering_3)
DataMatrix$Voltage = as.numeric(DataMatrix$Voltage)
DataMatrix$Global_reactive_power = as.numeric(Global_reactive_power)
#Plot the information
par(mfrow = c(2, 2))
plot(DataMatrix$datetime,DataMatrix$Global_active_power, type="l", xlab="", ylab="Global Active Power (Kilowatts)")
plot(DataMatrix$datetime,DataMatrix$Voltage, type="l", xlab="datetime", ylab="Voltage")
plot(DataMatrix$datetime, DataMatrix$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", col = "black")
points(DataMatrix$datetime, DataMatrix$Sub_metering_2, type ="l", col = "red")
points(DataMatrix$datetime, DataMatrix$Sub_metering_3, type = "l", col = "blue")
legend("topright", bty="n", lty=c(1,1,1), col = c("black","red", "blue"), legend = c("Sub_metering_1","Sub_metering_2", "Sub_metering_3"))
plot(DataMatrix$datetime,DataMatrix$Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")
#Copy graph to png file. 
dev.copy(png,file ="plot4.png")
dev.off