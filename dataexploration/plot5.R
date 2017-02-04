setwd("/home/nishant/coursera/R/dataexploration/Assignment")
require(sqldf)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
baltimore_data <- subset(NEI, fips=="24510")
nei_scc <- merge(baltimore_data, SCC, by="SCC")
names(nei_scc) <- gsub("\\.","_",names(nei_scc))
vehicle_emission <- sqldf("select Emissions, year, type from nei_scc where type='ON-ROAD'")
onroad_em_yearly <- aggregate(vehicle_emission$Emissions, by=list(vehicle_emission$year), FUN=sum)
# Create the data for the chart.
xval <- onroad_em_yearly[,1]
yval <- onroad_em_yearly[,2]
# Give the chart file a name.
png(file = "plot5.png", width = 850, height = 480, units = "px")
# Plot the  chart. 
plot(xval, yval ,type = "o",xlab = "Year", ylab = "Total PM'[2.5]*' Emissions")
title(main="Total Emissions from motor vehicle (type = ON-ROAD) in Baltimore City, Maryland (fips = '24510') from 1999 to 2008")
# Save the file.
dev.off()