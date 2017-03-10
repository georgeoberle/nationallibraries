#Building the Libraries in the Nation
####This project focuses on using the data from https://daviesproject.princeton.edu/databases/
####Load Libraries
{r
library(dplyr)
library(ggplot2)
library (magrittr)
library (knitr)
library (stringr)
library (tidyr)
library (ggmap)
library (USAboundaries)
library(tidyverse)
}
#The data in my work on libraries in the United States came from the _Davies Project_ at Princeton University. Their website identifies the purpose of their project as one that focuses on the history of collections. >Research into the History of Libraries in the United States, especially those at Universities and the History of their Collections The Davies Project is an on-going project at Princeton aimed at increasing knowledge of the history of the collections in university libraries in general and their rare book collections in particular.  
davies <- read_csv("~/Github/nationallibraries/Data/libraries_davies.csv")
  davies <- davies %>%
    filter(!is.na(plus)) %>%
    mutate(locality = str_trim(locality),
           state = str_trim(state),
           type = str_trim(type))
  
  types <- unique(davies$type)
  
  library_types <- data_frame(davies_types = types)
  write_csv(library_types, "library-types.csv")
  
  
  davies %>%
    left_join(library_types, by = c("type" = "davies_types"))
  
  places <- davies %>%
    select(locality, state) %>%
    distinct() %>%
    arrange(state, locality)
  
  
location_geocoded <- geocode(as.character(davies$location))

###GMU University Libraries Research Leave Day one geocoding data.

libraries_davies<- read.csv("~/GitHub/nationallibraries/Data/libraries_davies.csv")
#These are the processes to use to add columns for geocoded.
#First we need to add a location column combines the state and locality and it will be called location.
libraries_davies<-libraries_davies%>%
  mutate(location=paste (locality, state, sep=', '))
write_csv(libraries_davies, "~/GitHub/nationallibraries/Data/libraries_davies.csv")
          
#geocode function only allows 2500 "non business" instances per day. Since this dataset has 8528 observations I need to split apart my processes.
#One method is to divide the data into groups of 2500 and run them through the processes every day. An important nuance to the 2500 limit is that it counts the time from the last completed action from the day before.

libraries_davies<- read.csv("~/GitHub/nationallibraries/Data/libraries_davies.csv")



location_geocoded <- geocode(as.character(libraries_davies$location))

libraries_davies_location<- read.csv("/GitHub/nationallibraries/Data/libraries_davies_location.csv")

libraries_davies_location_a<-libraries_davies_location_a[1:2499,]




libraries_davis_a_<- geocode(as.character(libraries_davies_location_a$location))
libraries_davis_a<- bind_cols(libraries_davis_a, libraries_davis_a_)
libraries_davis_a_geocoded<- (libraries_davis_a_)
View(libraries_davis_a_)

#A more elegant method suggested by Lincoln Mullen includes the following.









libraries_davis_b<-libraries_davis[2500:4999,]
View(libraries_davis_b)
libraries_davis_b<- geocode(as.character(libraries_davis_b$location))
View(libray)
libraries_davis_b<- bind_cols(libraries_davis_b, libraries_davis_b)


#libraries_davis_c<-libraries_davis[5000:7400,]
#libraries_davis_d<-libraries_davis[7401:8528,]

#libraries_davis_geocoded<-bind_rows()






