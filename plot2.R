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
write.png2.file <- function( hpc ) {
   plot( hpc$TimeStamp, hpc$Global_active_power , main = "", xlab="", ylab="Global Active Power (kilowatts)", pch="." ,type = "o")
   # Saving to file
   dev.copy(png, file="plot2.png", height=480, width=480)
   dev.off()
}
#
hpc <- get.and.clean.household.power.consumption()
write.png2.file( hpc )
