setwd("/home/nishant/coursera/R/dataexploration/Assignment")
require(sqldf)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
subset_data <- subset(NEI, fips=="24510" | fips=="06037")
nei_scc <- merge(subset_data, SCC, by="SCC")
names(nei_scc) <- gsub("\\.","_",names(nei_scc))

vehicle_emission <- sqldf("select Emissions, year, fips, type from nei_scc where type='ON-ROAD'")
onroad_em_yearly <- aggregate(vehicle_emission$Emissions, by=list(vehicle_emission$year, vehicle_emission$fips), FUN=sum)
names(onroad_em_yearly) <- c("Year", "County", "Emission")

myPlot <- ggplot(onroad_em_yearly, aes(Year, Emission, group=County))+ 
  geom_point(aes(color = County), size=10)+ geom_line()+ 
  theme_grey(base_size = 38)+ 
  xlab("Year")+
  ylab("Total PM'[2.5]*' Emissions")+
  ggtitle('Total Emissions from motor vehicle (type=ON-ROAD) in Baltimore City, MD (fips = "24510") vs Los Angeles, CA (fips = "06037")  1999-2008')
ggsave(filename="plot6.png", plot=myPlot, width = 49, height = 20)