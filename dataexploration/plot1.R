setwd("/home/nishant/coursera/R/dataexploration/Assignment")

NEI <- readRDS("summarySCC_PM25.rds")
pm0 <- as.data.frame(NEI)
total <- aggregate(pm0$Emissions, by=list(pm0$year), FUN=sum)
# Create the data for the chart.
xval <- total[,1]
yval <- total[,2]
# Give the chart file a name.
png(file = "plot1.png")
#Exclude scientific notation in lable
options(scipen=999)
# Plot the  chart. 
plot(xval, yval ,type = "o",xlab = "Year", ylab = "Total PM'[2.5]*' Emissions")
title(main="Total Emission per year")
# Save the file.
dev.off()

