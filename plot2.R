##plot2.R

##Read house_hold_power_consumption.txt between 2/1/2007 and 2/2/2007
##Specify File Name
fl <-"household_power_consumption.txt"

##Read Headers
headers <- unlist(read.table(fl, nrows=1, sep=";"))

## Read Data in range of interest
data <- read.table(fl,sep =";", skip=grep("31/1/2007;23:59:00", readLines(fl)),
                   nrows=2880)

##Add Header Names
names(data) <- headers

##Convert Date to date class and time into time class
dates <- data$Date
times <- data$Time
combined <- paste(dates,times)
data$Date <-as.Date(data$Date, "%d/%m/%Y")
data$Time <-strptime(combined, format = "%d/%m/%Y %H:%M:%S")

#Plot the data
plot(data$Time, data$Global_active_power, type = "l",
     ylab = "Global Active Power (kilowatts)", xlab="")

     ##Store the plot to a PNG file of size 480 by 480 pixels
dev.copy(png, width=480, height=480, file = "plot2.png")
dev.off()



