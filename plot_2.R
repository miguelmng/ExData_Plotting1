
### PLOT 2


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

# combine date and time columns to get formated time

Sys.setlocale("LC_TIME", "English") # this line sets date variables in English

b<-strptime(paste(a$Date, a$Time), "%d/%m/%Y %H:%M:%S") # store formated time in b

# create plot 2 in png format in 480 x 480 pixels

png("plot_2.png", width = 480, height = 480)

        
        par(bg = "transparent") # transparent background
        
        # plot with type line
        
        plot(b, a$Global_active_power, xlab = "", 
             ylab = "Global Active Power (kilowatts)", col="black",type="l")

dev.off()