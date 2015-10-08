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
#Transform the numeric variables to a number 
DataMatrix$Global_active_power = as.numeric(DataMatrix$Global_active_power)
#Plot the histogram
hist(DataMatrix$Global_active_power, breaks=12, main = "Global Active Power", xlab = "Global Active Power (kilowatts)", col = "red",xlim=c(0,6) , ylim=c(0,1200), xaxt = "n")
axis(side=1, at= seq(0,6, by = 2))
axis(side=2, at=seq(0, 1200, by=200))
#Copy graph to png file. 
dev.copy(png,file ="plot1.png")
dev.off