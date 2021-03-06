# Levanto los datos en forma de data.frame
# Los datos est�n en archivo "rds", asi que hay que usar el "readRDS" function.
nei <- data.frame(readRDS("summarySCC_PM25.rds"))

#Agregaci�n de las emisiones, por a�o
neiplus <- aggregate(nei$Emissions, by = list(nei$year), FUN = sum)
colnames(neiplus) <- c("Year","Total_Emissions")

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
png("plot1.png")
#Mirar q no me pone bien los a�os: se arregla con el "at" de la funci�n "axis"
plot(neiplus$Year, neiplus$Total_Emissions,  type = "p", main = "Total Emissions in the US", xlab = "Year", ylab = expression("PM" [2.5]~~ "emitted(tons)"), xaxt="n")
axis(1, at=neiplus$Year, las=2)
dev.off()


