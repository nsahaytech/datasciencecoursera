setwd("~/Study/coursera/DataScienceToolBox/datasciencecoursera/r-programming/")
complete<-function(directory, id=1:332){
        filelist<-list.files(path=directory,pattern="*.csv")
        completecases_df<-data.frame(file_id=integer(),nobs=integer())
        for(i in id){
                filepath<-paste(directory,"/",filelist[i],sep="")
                specdata<-read.csv(file = filepath,header = T)
                complete_cases<-nrow(na.omit(specdata))
                #print(complete_cases)
                completecases_df<-rbind(completecases_df, data.frame(file_id=i,complete_cases))
               
        }
        completecases_df
}