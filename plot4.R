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
write.png4.file <- function( hpc ) {
   par( mfrow=c( 2, 2 ) )
   # top-left
   with( hpc, plot( TimeStamp , Global_active_power , type = "l"
                  , xlab="" , ylab="Global Active Power" ) )
   # top-right
   with( hpc, plot( TimeStamp , Voltage , type = "l" 
                  , xlab="datetime" , main="" ) )
   # bottom-left
   with( hpc,  plot( TimeStamp , Sub_metering_1 , col="black" , type = "l" 
                   , xlab="" , ylab="Energy sub metering" ) )
   with( hpc, lines( TimeStamp , Sub_metering_2 , col="red"  ) )
   with( hpc, lines( TimeStamp , Sub_metering_3 , col="blue" ) )
   legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
          legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
   )
   # bottom-right
   with( hpc,  plot( TimeStamp, Global_reactive_power, type = "l"
                   , xlab="datetime" ) )
   # Saving to file
   dev.copy(png, file="plot4.png", height=480, width=480)
   dev.off()
}
#
hpc <- get.and.clean.household.power.consumption()
write.png4.file( hpc )
