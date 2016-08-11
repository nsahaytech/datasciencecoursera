setwd("~/Study/coursera/DataScienceToolBox/datasciencecoursera/r-programming/")
corr <- function(directory, threshold=0){
        complete_df<-complete(directory,id=1:332)
        filelist<-list.files(path=directory,pattern="*.csv")
        cor_vector<-vector(mode = "numeric",length = 0)
        nobs <- complete_df$complete_cases
        ids <- complete_df$file_id[nobs > threshold]
        for(i in ids) {
                
                filepath<-paste(directory,"/",filelist[i],sep="")
                filedata<-read.csv(file = filepath,header = T)
                cor_val<-cor(filedata["sulfate"],filedata["nitrate"],use="complete.obs")
                cor_vector<-c(cor_vector,cor_val)
        }
       cor_vector 
}