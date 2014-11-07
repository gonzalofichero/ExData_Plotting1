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
baltimore <- subset(nei, fips == "24510")

mobile <- baltimore[baltimore$SCC %in% names.of.mobilesccs, ]

#Aggregating the Emission from
mobileplus <- aggregate(mobile$Emissions, by = list(mobile$year), FUN = sum)
colnames(mobileplus) <- c("Year","Total_Emissions")


#How have emissions from motor vehicle sources
#changed from 1999-2008 in Baltimore City?

#Loading the ggplot package
library(ggplot2)

png("plot5.png")
qplot(Year, Total_Emissions, data=mobileplus, geom="line") + labs(title="Baltimore City", x = "Year", y = expression("PM" [2.5] ~ "Emitted (tons) from Motor Vehicles Sources"))

dev.off()