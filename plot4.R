##plot4.R

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

#Create the PNG File
png(file = "plot4.png", width=480, height=480)

#Plot the data
par(mfrow = c(2, 2))
with (data,{
  ##First Plot
  plot(Time, Global_active_power, type = "l",
       ylab = "Global Active Power", xlab="")
  ##Second Plot
  plot(Time, Voltage, type = "l",
       ylab = "Voltage", xlab="datetime")
  
  ##Third Plot
  plot(Time, Sub_metering_1, type="l", 
       ylab = "Energy sub metering", xlab ="")
  lines(Time, Sub_metering_2, type="l", col="red")
  lines(Time, Sub_metering_3, type="l", col="blue")
  legend("topright", lty = 1, col = c("black", "blue", "red"), 
         legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
         bty="n")
  
  ##Fourth Plot
  plot(Time, Global_reactive_power, type = "l", xlab="datetime")
    
})

dev.off()
