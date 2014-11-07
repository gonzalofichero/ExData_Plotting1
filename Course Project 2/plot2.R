# Levanto los datos en forma de data.frame
# Los datos están en archivo "rds", asi que hay que usar el "readRDS" function.
nei <- data.frame(readRDS("summarySCC_PM25.rds"))

#Leaving Baltimore City alone
baltimore <- subset(nei, fips == "24510")


#Agregación de las emisiones, por año
baltimoreplus <- aggregate(baltimore$Emissions, by = list(baltimore$year), FUN = sum)
colnames(baltimoreplus) <- c("Year","Total_Emissions")


# Have total emissions from PM2.5 decreased in Balmitore City from 1999 to 2008? 
png("plot2.png")
#Mirar q no me pone bien los años: se arregla con el "at" de la función "axis"
plot(baltimoreplus$Year, baltimoreplus$Total_Emissions,  type = "p", main = "Total Emissions in Baltimore City", xlab = "Year", ylab = expression("PM" [2.5]~~ "emitted(tons)"), xaxt="n")
axis(1, at=baltimoreplus$Year, las=2)
dev.off()

