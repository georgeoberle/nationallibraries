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


places_combined<-places%>%
  mutate(location=paste (locality, state, sep=', '))
write_csv(places, "~/GitHub/nationallibraries/Data/places_combined.csv")
places_combined_a<-places_combined[1:2499,]
places_combined_a<-geocode(as.character(places_combined_a$location))

places_combined%>%
  left_join(places_combined_a, by = c("location" = "lon"))

View(places_combined_a)









libraries_davis_a_geocoded<- (libraries_davis_a_)
View(libraries_davis_a_)



libraries_davis_a<- bind_cols(libraries_davis_a, libraries_davis_a_)
libraries_davis_a_geocoded<- (libraries_davis_a_)
View(libraries_davis_a_)



###GMU University Libraries Research Leave Day one geocoding data.













