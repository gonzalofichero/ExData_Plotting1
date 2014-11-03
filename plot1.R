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


#PLOT 1
png(filename="plot1.png", width=480, height=480)
hist(data$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", ylim=c(0,1200), main="Global Active Power")
dev.off()  #esto "cierra" la sesión del plot y permite crear una nueva luego
