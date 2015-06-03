##plot3.R

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
plot(data$Time, data$Sub_metering_1, type="l", 
     ylab = "Energy sub metering", xlab ="")
lines(data$Time, data$Sub_metering_2, type="l", col="red")
lines(data$Time, data$Sub_metering_3, type="l", col="blue")

##Store the plot to a PNG file of size 480 by 480 pixels
dev.copy(png, width=480, height=480, file = "plot3.png")
legend("topright", lty = 1, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()

legend("topright", lty = 1, col = c("black", "blue", "red"), 
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))