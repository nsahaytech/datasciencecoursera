setwd("~/Study/coursera/DataScienceToolBox/datasciencecoursera/r-programming/")
pollutantmean<-function(directory, pollutant,id=1:332){
        filelist<-list.files(path=directory,pattern="*.csv")
        pollutant_df<-data.frame(pollutant=integer())
        for(i in id){
                filepath<-paste(directory,"/",filelist[i],sep="")
                specdata<-read.csv(file = filepath,header = T)
                pollutant_data<-subset(specdata[pollutant])
                pollutant_df<-rbind(pollutant_df, pollutant_data)
        }
        pollutant_mean=colMeans(pollutant_df, na.rm = T)
        pollutant_mean
}