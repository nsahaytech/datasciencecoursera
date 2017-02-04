setwd("/home/nishant/coursera/R/dataexploration/Assignment")
require(sqldf)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
nei_scc <- merge(NEI, SCC, by="SCC")
names(nei_scc) <- gsub("\\.","_",names(nei_scc))
coal_emission <- sqldf("select Emissions, year, EI_Sector from nei_scc where EI_Sector LIKE '%coal%'")
coal_em_yearly <- aggregate(coal_emission$Emissions, by=list(coal_emission$year), FUN=sum)
# Create the data for the chart.
xval <- coal_em_yearly[,1]
yval <- coal_em_yearly[,2]
# Give the chart file a name.
png(file = "plot4.png")
# Plot the  chart. 
plot(xval, yval ,type = "o",xlab = "Year", ylab = "Total PM'[2.5]*' Emissions")
title(main="Total Emissions from coal sources from 1999 to 2008 in United States")

# Save the file.
dev.off()