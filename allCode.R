library(lubridate)
library(dplyr)
library(data.table)
library(stringr)

totalDamages <- function (propDamage,propDamageUnits,cropDamage,cropDamageUnits) {
  # combines the property damage and crop damage into one value, multiplied by 
  #  appropriate units so that everything is in millions. 
  
  total<- as.numeric(propDamage) * if(propDamageUnits=="K") { 0.001 } else 
    if(propDamageUnits=="M") { 1 } else 
      if(propDamageUnits=="B") { 1000 } else
      { 0 }
  
  total<- total + as.numeric(cropDamage) * if(cropDamageUnits=="K") { 0.001 } else 
    if(cropDamageUnits=="M") { 1 } else 
      if(cropDamageUnits=="B") { 1000 } else
      { 0 }
  total
}  

colNames<-c("state","eventDate","eventType","fatalities","injuries",
            "propDamage","propDamageUnits","cropDamage","cropDamageUnits","refnum")
raw<-read.csv("data/repdata-data-StormData.csv",
                        colClasses = "character",                         
                           nrows=50000)[c(1,2,8,23:28,37)]
colnames(raw)<-colNames
## Clean up section
# Convert the dates to a date format and create a single 
raw$eventDate<-mdy(str_replace(str_extract(raw$eventDate,"^.* ")," ",""))
raw<-cbind(raw, with(raw,mapply(totalDamages,propDamage,propDamageUnits,cropDamage, cropDamageUnits)))
colnames(raw)<-  c(colNames,"totalDamage")


