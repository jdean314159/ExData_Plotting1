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



# Plot 3
png(filename = Dir %+% "plot3.png")
dt <- power_data$date_time
with(power_data, plot(dt,Sub_metering_1, type="n", ylab="Energy sub metering",
                      xlab=''))
with(power_data, lines(dt,Sub_metering_1, type="l"))
with(power_data, lines(dt,Sub_metering_2, type="l", col='red'))
with(power_data, lines(dt,Sub_metering_3, type="l", col='blue'))

legend("topright", col=c("black","red","blue"), legend=c("Sub_metering_1",
                        "Sub_metering_2","Sub_metering_3"), lty=1)
dev.off()

