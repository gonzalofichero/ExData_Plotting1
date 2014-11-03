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

#PLOT 4

#Primero seteo para que los gráficos aparezcan en una matriz de 2x2 (se llena x row)
png(filename = "plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
#Luego se dibuja cada plot que quedará en el lugar especificado por el comando anterior
plot(data$DateTime, data$Global_active_power, type = "l", xlab = "", ylab= "Global Active Power (kilowatts)", main = "")
plot(data$DateTime, data$Voltage, type = "l", xlab = "datetime", ylab= "Voltage", main = "")
plot(data$DateTime, data$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", main = "")
lines(data$DateTime, data$Sub_metering_2, col = "red")
lines(data$DateTime, data$Sub_metering_3, col = "blue")
legend("topright", lty = 1, bty="n", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"))
plot(data$DateTime, data$Global_reactive_power, type = "l", xlab = "datetime", ylab= "Global_reactive_power", main = "")
dev.off()
