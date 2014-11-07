# Levanto los datos en forma de data.frame

# Los datos están en archivo "rds", asi que hay que usar el "readRDS" function.
nei <- data.frame(readRDS("summarySCC_PM25.rds"))

#También tengo que levantar el código de clasificación!
scc <- data.frame(readRDS("Source_Classification_Code.rds"))


##Checking which are coming from coal

#   table(scc$EI.Sector)

##from where one can find:

#   Fuel Comb - Comm/Institutional - Coal
#   Fuel Comb - Industrial Boilers, ICEs - Coal
#   Fuel Comb - Electric Generation - Coal

##Not a neat solution, but works.


#Selecting SCC's only from Coal

coalscc <- scc[scc$EI.Sector == "Fuel Comb - Comm/Institutional - Coal" | scc$EI.Sector == "Fuel Comb - Industrial Boilers, ICEs - Coal" | scc$EI.Sector == "Fuel Comb - Electric Generation - Coal",]

# Selecting the SCC's to make a match between databases
names.of.coalsccs <- unique(coalscc$SCC)

# Selecting from NEI, only those rows that correspond to Coal, by matching
coal <- nei[nei$SCC %in% names.of.coalsccs, ]
#Aggregating the Emssion from 
coalplus <- aggregate(coal$Emissions, by = list(coal$year), FUN = sum)
colnames(coalplus) <- c("Year","Total_Emissions")


#Across the United States, how have emissions from coal combustion-related sources
#changed from 1999-2008? 

#Loading the ggplot package
library(ggplot2)

png("plot4.png")
qplot(Year, Total_Emissions, data=coalplus, geom="point") + labs(x = "Year", y = expression("PM" [2.5] ~ "Emitted (tons) from Coal Sources"))

dev.off()