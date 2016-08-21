
make.true.NA <- function(x) if(is.character(x)||is.factor(x)){
        is.na(x) <- x=="Not Available"; x} else {
                x}
rankall <- function(outcome, num = "best") {
        care_outcome<-read.csv("outcome-of-care-measures.csv", colClasses = "character")
        unique_state<-unique(care_outcome[,7])
        unique_outcome <- c("heart attack", "heart failure", "pneumonia")
        if(!state %in% unique_state)
                stop("invalid state")
        if(!outcome %in% unique_outcome)
                stop("invalid outcome")
        
        final_df<-data.frame(State="character", Hospital.Name="character")
        if(outcome == "heart attack"){
                best_outcome<-care_outcome[, c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack","State","Hospital.Name")]
                colnames(best_outcome)<-c("outcome","State","Hospital.Name")
                for(i in unique_state){
                        state<-i
                        print(state)
                        best_outcome_state<-subset(best_outcome, State==state)
                        best_outcome_state[] <- lapply(best_outcome_state, make.true.NA)
                        best_outcome_state<-na.omit(best_outcome_state[order(as.numeric(best_outcome_state$outcome), best_outcome_state$Hospital.Name),])
                        if(num=="best"){
                                final_df=rbind(final_df,best_outcome_state[1,c("State","Hospital.Name")])
                                
                        }else if(num=="worst"){
                                last_rank<-length(best_outcome_state[,1])
                                final_df=rbind(final_df,best_outcome_state[last_rank,c("State","Hospital.Name")])
                                
                        }else if(num<=length(best_outcome_state[,1])){
                                final_df=rbind(final_df,best_outcome_state[num,c("State","Hospital.Name")])
                        }else{
                                rankedHospital<-rbind(final_df,data.frame(row.names = ))
                        }
                }
                
                
        }else if(outcome == "heart failure"){
                
                best_outcome<-care_outcome[, c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure","State","Hospital.Name")]
                colnames(best_outcome)<-c("outcome","State","Hospital.Name")
                for(i in unique_state){
                        state<-i
                        print(state)
                        best_outcome_state<-subset(best_outcome, State==state)
                        best_outcome_state[] <- lapply(best_outcome_state, make.true.NA)
                        best_outcome_state<-na.omit(best_outcome_state[order(as.numeric(best_outcome_state$outcome), best_outcome_state$Hospital.Name),])
                        if(num=="best"){
                                final_df=rbind(final_df,best_outcome_state[1,c("State","Hospital.Name")])
                                
                        }else if(num=="worst"){
                                last_rank<-length(best_outcome_state[,1])
                                final_df=rbind(final_df,best_outcome_state[last_rank,c("State","Hospital.Name")])
                                
                        }else if(num<=length(best_outcome_state[,1])){
                                final_df=rbind(final_df,best_outcome_state[num,c("State","Hospital.Name")])
                        }else{
                                rankedHospital<-rbind(final_df,data.frame(row.names = ))
                        }
                }
                
        }else if(outcome == "pneumonia"){
                best_outcome<-care_outcome[, c("Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia","State","Hospital.Name")]
                colnames(best_outcome)<-c("outcome","State","Hospital.Name")
                for(i in unique_state){
                        state<-i
                        print(state)
                        best_outcome_state<-subset(best_outcome, State==state)
                        best_outcome_state[] <- lapply(best_outcome_state, make.true.NA)
                        best_outcome_state<-na.omit(best_outcome_state[order(as.numeric(best_outcome_state$outcome), best_outcome_state$Hospital.Name),])
                        if(num=="best"){
                                final_df=rbind(final_df,best_outcome_state[1,c("State","Hospital.Name")])
                                
                        }else if(num=="worst"){
                                last_rank<-length(best_outcome_state[,1])
                                final_df=rbind(final_df,best_outcome_state[last_rank,c("State","Hospital.Name")])
                                
                        }else if(num<=length(best_outcome_state[,1])){
                                final_df=rbind(final_df,best_outcome_state[num,c("State","Hospital.Name")])
                        }else{
                                rankedHospital<-rbind(final_df,data.frame(row.names = ))
                        }
                }
        }
        
        final_df
        
        
}