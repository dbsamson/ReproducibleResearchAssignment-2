library(data.table)
eventTypes <-data.table(unique(raw$eventType))
eventTypes <- arrange(eventTypes,V1)

# simplify the sorting.  
#remove numbers and case issues
eventTypes$forSorting <-tolower(str_replace_all(eventTypes$V1,"[0-9]",""))
eventTypes$forSorting <-str_replace_all(eventTypes$forSorting,"(|)","")

# Now create columns with 2 words and 1 words 

