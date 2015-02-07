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
write.png3.file <- function( hpc ) {
   png(filename="plot3.png", height=480, width=480, bg="white" ) # Saving to file
   with( hpc 
       , { plot ( Sub_metering_1 ~ TimeStamp 
                , type="l" 
                , ylab="Energy submetring"
                , xlab=""
           )
           lines( Sub_metering_2 ~ TimeStamp , col='Red' )
           lines( Sub_metering_3 ~ TimeStamp , col='Blue')
         }
   )
   legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
          legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
   )
   dev.off()
}
#
hpc <- get.and.clean.household.power.consumption()
write.png3.file( hpc )
