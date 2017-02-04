setwd("/home/nishant/coursera/R/dataexploration/Assignment")

NEI <- readRDS("summarySCC_PM25.rds")
pm0 <- as.data.frame(NEI)
baltimore_data <- subset(pm0, fips=="24510")
baltimore_total <- aggregate(baltimore_data$Emissions, by=list(baltimore_data$year), FUN=sum)
# Create the data for the chart.
xval <- baltimore_total[,1]
yval <- baltimore_total[,2]
# Give the chart file a name.
png(file = "plot2.png")
# Plot the  chart. 
plot(xval, yval ,type = "o",xlab = "Year", ylab = "Total PM'[2.5]*' Emissions")
title(main="Total Emission in Baltimore City,MD per year")
# Save the file.
dev.off()
