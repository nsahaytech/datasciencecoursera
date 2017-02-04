setwd("/home/nishant/coursera/R/dataexploration/Assignment")
require(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
pm0 <- as.data.frame(NEI)
baltimore_data <- subset(pm0, fips=="24510")
baltimore_total_types<- 
  aggregate(baltimore_data$Emissions, by=list(baltimore_data$type, baltimore_data$year), FUN=sum)
names(baltimore_total_types) <- c("Type", "Year", "Emission")

myPlot <- ggplot(baltimore_total_types, aes(Year, Emission))+ 
        geom_point(size=10)+geom_smooth(method="lm")+ 
        facet_grid(. ~ Type)+
        theme_grey(base_size = 38)+ 
        xlab("Year")+
        ylab("Total PM'[2.5]*' Emissions")+
ggtitle("Total Emissions by Types between Year 1999 to 2008")
ggsave(filename="plot3.png", plot=myPlot, width = 40, height = 40)
