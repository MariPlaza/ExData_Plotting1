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
#Plot the information
plot(DataMatrix$datetime,DataMatrix$Global_active_power, type="l", xlab="", ylab="Global Active Power (Kilowatts)")
#Copy graph to png file. 
dev.copy(png,file ="plot2.png")
dev.off