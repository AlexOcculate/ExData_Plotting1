rm( list=ls() )
#
get.and.clean.household.power.consumption <- function() {
   hpc <- read.csv2( "data/household_power_consumption.txt" , dec=".", na.strings=c("","?","NA") , stringsAsFactors=FALSE ) 
   # cast '$Date' to R-Date...
   hpc$Date <- as.Date( hpc$Date , "%e/%m/%Y" )
   # subset the data for specific range... 
   hpc <- hpc[ hpc$Date >= as.Date( "2007-02-01" ) & hpc$Date <= as.Date( "2007-02-02" ) , ]
   # create '$TimeStamp' for posterior calculations...
   hpc$TimeStamp <- as.POSIXct( strptime( paste( hpc$Date , hpc$Time ) , "%Y-%m-%e %H:%M:%S" ) )
   hpc
}
#
write.png1.file <- function( hpc ) {
   hist( hpc$Global_active_power , main = "Global Active Power", xlab="Global Active Power (kilowatts)", col="red" )
   # Saving to file
   dev.copy(png, file="plot1.png", height=480, width=480)
   dev.off()
}
#
hpc <- get.and.clean.household.power.consumption()
write.png1.file( hpc )
