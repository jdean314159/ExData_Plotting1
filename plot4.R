library("crayon")
library("lubridate")
library("stringr")

Dir <- "/home/cybernaif/Documents/R/"
File <- Dir %+% "household_power_consumption.txt"

power_data <- read.csv(File, sep = ';')
power_data$Date <- dmy(power_data$Date)
Dates <- power_data$Date
selection <- (Dates == ymd('2007-02-01') | 
              Dates == ymd('2007-02-02') 
              )
power_data <- power_data[selection,]

power_data$date_time <- paste(as.character(power_data$Date), as.character(power_data$Time), sep=" ")
power_data$date_time <- strptime(as.character(power_data$date_time), "%Y-%m-%d %H:%M:%S")

Names <- names(power_data)[-c(1,2,10)]
for (Name in Names) {
      power_data[Name] <- as.numeric(as.character(power_data[[Name]]))
}


# Plot 4
png(filename = Dir %+% "plot4.png")
par(mfrow=c(2,2))
with(power_data, plot(date_time, Global_active_power, type="l", 
                      ylab="Global Active Power (kilowatts)", xlab='',
                      fg="grey"))
axis(1, col="black", labels = FALSE, lwd.ticks = 0)
axis(2, col="black")
with(power_data, plot(date_time, Voltage, type='l', xlab="datetime", fg="grey"))
axis(1, col="black", labels = FALSE, lwd.ticks = 0)
axis(2, col="black")
with(power_data, plot(date_time,Sub_metering_1, type="n", ylab="Energy sub metering",
                      xlab='', fg="grey"))
with(power_data, lines(date_time,Sub_metering_1, type="l"))
with(power_data, lines(date_time,Sub_metering_2, type="l", col='red'))
with(power_data, lines(date_time,Sub_metering_3, type="l", col='blue'))

legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1",
                        "Sub_metering_2","Sub_metering_3"), lty=1, bty = "n"
       )
axis(1, col="black", labels = FALSE, lwd.ticks = 0)
axis(2, col="black")
with(power_data, plot(date_time, Global_reactive_power, type='l', xlab="datetime"))
box(col="grey", col.axis = "black")
axis(1, col="black", labels = FALSE, lwd.ticks = 0)
axis(2, col="black")

dev.off()