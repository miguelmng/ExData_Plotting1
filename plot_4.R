### PLOT 4


# file path

file_path <- "./household_power_consumption.txt"

# read table, 01 Feb 2007 starts on row 66638. As data is sampled
# each minute: 2 dais x 24 h x 60m = 2880 rows to read.

a <- read.table(file_path, sep = ";", nrow = 2880, 
                head = F, skip = 66637, colClasses = "character")

# now read first row to get table names and set them to our table "a"

names(a) <- names(read.table(file_path, sep = ";", head = T, nrow = 1))

# convert global active power column to numeric values

a$Global_active_power <- as.numeric(a$Global_active_power)

# convert global reactive power column to numeric values

a$Global_reactive_power <- as.numeric(a$Global_reactive_power)

# convert voltage column to numeric values

a$Voltage <- as.numeric(a$Voltage)

# convert sub metering columns to numeric values

a$Sub_metering_1 <- as.numeric(a$Sub_metering_1)

a$Sub_metering_2 <- as.numeric(a$Sub_metering_2)

a$Sub_metering_3 <- as.numeric(a$Sub_metering_3)

# combine date and time columns to get formated time

Sys.setlocale("LC_TIME", "English") # this line sets date variables in English

b<-strptime(paste(a$Date, a$Time), "%d/%m/%Y %H:%M:%S") # store formated time in b

# create plot 4 in png format in 480 x 480 pixels

png("plot_4.png", width = 480, height = 480)

        par(mfrow = c(2,2)) # 2 x 2 subplots in figure
        
        par(bg = "transparent") # transparent background

        # 1 plot top-left global active power
        
        plot(b, a$Global_active_power, xlab = "", ylab = "Global Active Power",
             col = "black", type = "l")

        # 2 plot top-right Voltage
        
        plot(b, a$Voltage, xlab = "datetime", ylab = "Voltage",
             col = "black",type = "l")

        # 3 plot bottom-left sub meterings
                
        plot(b, a$Sub_metering_1, xlab = "", ylab = "Energy sub metering",
              col = "black", type = "l")
        
        lines(b, a$Sub_metering_2, col = "red")
        
        lines(b, a$Sub_metering_3, col = "blue")
        
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"), lty = 1, bty = "n") # legend with no border
        
        # 4 plot bottom-right global reactive power        

        plot(b, a$Global_reactive_power, xlab = "datetime",
             ylab = "Global_reactive_power", col = "black", type = "l")

dev.off()