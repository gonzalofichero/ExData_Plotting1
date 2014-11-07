# Levanto los datos en forma de data.frame
# Los datos están en archivo "rds", asi que hay que usar el "readRDS" function.
nei <- data.frame(readRDS("summarySCC_PM25.rds"))

#Leaving Baltimore City alone
baltimore <- subset(nei, fips == "24510")

#Aggregating the data by year and type
baltimoreplus <- aggregate(baltimore$Emissions, by = list(baltimore$year, baltimore$type), FUN = sum)
colnames(baltimoreplus) <- c("Year","Type","Total_Emissions")


#Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
#which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City?
#Which have seen increases in emissions from 1999-2008?  

#Loading the ggplot package
library(ggplot2)

png("plot3.png")
qplot(Year, Total_Emissions, data=baltimoreplus, geom="line", facets=.~Type) + labs(x = "Year", y = expression("PM" [2.5] ~ "Emitted (tons)"))

#axis(1, at=baltimoreplus$Year, las=2)
dev.off()