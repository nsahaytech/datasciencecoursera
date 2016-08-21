setwd("/home/nishant/Study/coursera/R")
best<-function(state, outcome){
        care_outcome<-read.csv("outcome-of-care-measures.csv", colClasses = "character")
        unique_state<-unique(care_outcome[,7])
        best_outcome<-care_outcome[, c("Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack", "Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure", "Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia","Hospital.Name","State")]
        unique_outcome <- c("heart attack", "heart failure", "pneumonia")
        if(!state %in% unique_state)
                stop("invalid state")
        if(!outcome %in% unique_outcome)
                stop("invalid outcome")
        state_hospital_outcome=subset(best_outcome, State==state)
        if(outcome == "heart attack"){
                outcome_list <- as.vector(na.omit(as.numeric(state_hospital_outcome[,1])))
                minRate <- min(outcome_list)
                minHospital <- state_hospital_outcome[which(state_hospital_outcome[,1] == minRate), "Hospital.Name"]
        }else if(outcome == "heart failure"){
                outcome_list <- as.vector(na.omit(as.numeric(state_hospital_outcome[,2])))
                minRate <- min(outcome_list)
                minHospital <- state_hospital_outcome[which(state_hospital_outcome[,2] == minRate), "Hospital.Name"]
        }else if(outcome == "pneumonia"){
                outcome_list <- as.vector(na.omit(as.numeric(state_hospital_outcome[,3])))
                minRate <- min(outcome_list)
                minHospital <- state_hospital_outcome[which(state_hospital_outcome[,3] == minRate), "Hospital.Name"]
        }
        return(minHospital)
}
