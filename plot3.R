rm( list=ls() )
dn <- "C:/Users/Alex/Documents/Coursera/Johns Hopkins - Certification/Data Science/04 - Exploratory Data Analysis/data"
# dn <- "~/Code/R/ExData_Plotting1"
setwd( dn )
#
get.and.clean.household.power.consumption <- function() {
   fn <- "household_power_consumption.txt"
   hpc <- read.csv2( fn , dec=".", na.strings=c("","?","NA") , stringsAsFactors=FALSE ) 
   hpc$Date <- as.Date( hpc$Date , "%e/%m/%Y" )
   hpc <- hpc[ hpc$Date >= as.Date( "2007-02-01" ) & hpc$Date <= as.Date( "2007-02-02" ) , ]
   hpc$TimeStamp <- as.POSIXct( strptime( paste( hpc$Date , hpc$Time ) , "%Y-%m-%e %H:%M:%S" ) )
   hpc
}
#
write.png3.file <- function( hpc ) {
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
   # Saving to file
   dev.copy(png, file="plot3.png", height=480, width=480)
   dev.off()
}
#
hpc <- get.and.clean.household.power.consumption()
write.png3.file( hpc )
