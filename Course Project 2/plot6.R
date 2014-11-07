# Levanto los datos en forma de data.frame

# Los datos están en archivo "rds", asi que hay que usar el "readRDS" function.
nei <- data.frame(readRDS("summarySCC_PM25.rds"))

#También tengo que levantar el código de clasificación!
scc <- data.frame(readRDS("Source_Classification_Code.rds"))


##Checking which are coming from motor vehicle sources

#   table(scc$EI.Sector)

##from where one can find:

#   Mobile - On-Road Diesel Heavy Duty Vehicles  
#   Mobile - On-Road Diesel Light Duty Vehicles 
#   Mobile - On-Road Gasoline Heavy Duty Vehicles 
#   Mobile - On-Road Gasoline Light Duty Vehicles 

##Not a neat solution, but works.


#Selecting SCC's only from Motor Vehicle

mobilescc <- scc[scc$EI.Sector == "Mobile - On-Road Diesel Heavy Duty Vehicles " | scc$EI.Sector == "Mobile - On-Road Diesel Light Duty Vehicles " | scc$EI.Sector == "Mobile - On-Road Gasoline Heavy Duty Vehicles" | scc$EI.Sector == "Mobile - On-Road Gasoline Light Duty Vehicles",]

# Selecting the SCC's to make a match between databases
names.of.mobilesccs <- unique(mobilescc$SCC)

# Selecting from Baltimore, only those rows that correspond to Mobile, by matching
cities <- subset(nei, fips == "24510" | fips == "06037")

mobile <- cities[cities$SCC %in% names.of.mobilesccs, ]


#Changing the "fips" for "City"
mobile["City"] <- NA

for (i in 1:length(mobile$fips)){
    if (mobile$fips[i] == "24510") {
        mobile$City[i] <- "Baltimore"
    } else {
        mobile$City[i] <- "Los Angeles"
    }    
}


#Aggregating the Emission from
mobileplus <- aggregate(mobile$Emissions, by = list(mobile$year, mobile$City), FUN = sum)
colnames(mobileplus) <- c("Year","City", "Total_Emissions")


#Compare emissions from motor vehicle sources in Baltimore City with emissions
#from motor vehicle sources in Los Angeles County, California.
#Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)
png("plot6.png")
qplot(Year, Total_Emissions, data=mobileplus, geom="line", color=factor(City)) + labs(title="Baltimore vs. LA", x = "Year", y = expression("PM" [2.5] ~ "Emitted (tons) from Motor Vehicles Sources"))

dev.off()