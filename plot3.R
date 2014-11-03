#Levanto el txt y especifico el tipo de columnas
household_power_consumption <- read.csv("~/household_power_consumption.txt", sep=";", na.strings="?", colClasses=c("factor", "factor", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#Subset de la data para quedarme con los dos días a analizar
data <- subset(household_power_consumption, Date=="1/2/2007"  | Date=="2/2/2007")

#Transformo las fechas y tiempo "caracter" en fechas y tiempo de tipo correcto.
data$DateTime <- paste(data$Date, data$Time)
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
data$DateTime <- strptime(data$DateTime, "%d/%m/%Y %H:%M:%S")


#####
# Hasta aca es igual para los 4 plots!
# Ahora cada uno en particular
#####

#PLOT 3
png(filename = "plot3.png", width = 480, height = 480)
plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", main = "")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"))
dev.off()  #esto "cierra" la sesión del plot y permite crear una nueva luego
