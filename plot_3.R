### PLOT 3


# file path

file_path <- "./household_power_consumption.txt"

# read table, 01 Feb 2007 starts on row 66638. As data is sampled
# each minute: 2 dais x 24 h x 60m = 2880 rows to read.

a <- read.table(file_path, sep = ";", nrow = 2880, 
                head = F, skip = 66637, colClasses = "character")

# now read first row to get table names and set them to our table "a"

names(a) <- names(read.table(file_path, sep = ";", head = T, nrow = 1))

# convert sub metering columns to numeric values

a$Sub_metering_1 <- as.numeric(a$Sub_metering_1)

a$Sub_metering_2 <- as.numeric(a$Sub_metering_2)

a$Sub_metering_3 <- as.numeric(a$Sub_metering_3)

# combine date and time columns to get formated time

Sys.setlocale("LC_TIME", "English") # this line sets date variables in English

b<-strptime(paste(a$Date, a$Time), "%d/%m/%Y %H:%M:%S") # store formated time in b

# create plot 3 in png format in 480 x 480 pixels

png("plot_3.png", width = 480, height = 480)

        par(bg = "transparent") # transparent background
        
        # plot with type line. 
        
        plot(b, a$Sub_metering_1,xlab = "", ylab = "Energy sub metering",
              col = "black", type = "l") # sub_metering_1
        
        lines(b, a$Sub_metering_2, col = "red") # sub_metering_2
        
        lines(b, a$Sub_metering_3, col = "blue") #sub_metering_3
        
        legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
               col = c("black", "red", "blue"), lty = 1) # add legend in top-right

dev.off()