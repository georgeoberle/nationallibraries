#Building the Libraries in the Nation
####This project focuses on using the data from https://daviesproject.princeton.edu/databases/
####Load Libraries

library(dplyr)
library(ggplot2)
library (magrittr)
library (knitr)
library (stringr)
library (tidyr)
library (ggmap)
library (USAboundaries)
library(tidyverse)
library(leaflet)
library(historydata)

#The data in my work on libraries in the United States came from the _Davies Project_ at Princeton University. Their website identifies the purpose of their project as one that focuses on the history of collections. >Research into the History of Libraries in the United States, especially those at Universities and the History of their Collections The Davies Project is an on-going project at Princeton aimed at increasing knowledge of the history of the collections in university libraries in general and their rare book collections in particular.  
###GMU University Libraries Research Leave Day one geocoding data.

# Load and prepare data ---------------------------------------------------


davies <- read_csv("~/Github/nationallibraries/Data/libraries_davies.csv")
#tidy the data a bit.
  davies <- davies %>%
    filter(!is.na(plus)) %>%
    mutate(locality = str_trim(locality),
           state = str_trim(state),
           type = str_trim(type))
 # Create a unique types of libraries sets.  
  types <- unique(davies$type)
  
  library_types <- data_frame(davies_types = types)
  write_csv(library_types, "library-types.csv")
  
  
  davies %>%
    left_join(library_types, by = c("type" = "davies_types"))
  

  places <- davies %>%
    select(locality, state) %>%
    distinct() %>%
    arrange(state, locality)
  
  
  places_combined<-places%>%
    mutate(location=paste (locality, state, sep=', '))
  #write_csv(places, "~/GitHub/nationallibraries/Data/places_combined.csv")
 # write_csv(places_combined, "~/GitHub/nationallibraries/Data/places_combined.csv")
  
#location_geocoded <- geocode(as.character(davies$location))


#split the data so I can use the non-business geocode from Google. Their limit is 2500 per day.
places_combined_a<-places_combined[1:2499,]
places_combined_b<-places_combined[2500:3653,]

#Geocode the locations.

places_combined_a<-geocode(as.character(places_combined_a$location))
places_combined_b<-geocode(as.character(places_combined_b$location))

#Bring them back together
placeslatlon<-bind_rows (places_combined_a, places_combined_b)

#Bind locations with the geocoded data
libraries_geocoded<-bind_cols (places_combined, placeslatlon)
write_csv(libraries_geocoded, "~/GitHub/nationallibraries/Data/libraries_geocoded.csv")

libraries_geocoded<-read.csv("~/GitHub/nationallibraries/Data/libraries_geocoded.csv")

#Need to join the table and have the location geocoded data added to the master libraries data.
libupdate<-davies%>%
  left_join(libraries_geocoded, by = c("location" = "location"))

write_csv(libupdate, "~/GitHub/nationallibraries/Data/libraries_geocoded.csv")
write_csv(libupdate, "~/GitHub/nationallibraries/Data/libupdate.csv")




###Research Day Two



Practice
# load package and data
library(ggplot2)
libupdate <-read_csv ("~/Github/nationallibraries/Data/libupdate.csv")
data("libupdate", package="ggplot2")

# Scatterplot
theme_set(theme_bw())  # pre-set the bw theme.
g <- ggplot(libupdate, aes(state.x, type))
g + geom_count(col="navy", show.legend=F) +
  labs(subtitle="Libraries Type and State", 
       y="Type", 
       x="State", 
       title="Counts Plot")

# Histogram on a Categorical variable
gg <- ggplot(libupdate, aes(state.x))
gg + geom_bar(aes(fill=type), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) + 
  labs(title="Histogram on Categorical Variable", 
       subtitle="Manufacturer across Vehicle Classes") 

freqtable <- table(libupdate$state.x)
df <- as.data.frame.table(freqtable)
head(df)

library(ggplot2)
theme_set(theme_classic())

# Plot
g <- ggplot(df, aes(Var1, Freq))
g + geom_bar(stat="identity", width = 0.5, fill="tomato2") + 
  labs(title="Bar Chart", 
       subtitle="Number of Libraries by State", 
       x= "state",
       caption="Source: Davies Libraries") +
  theme(axis.text.x = element_text(angle=65, vjust=0.6))


g <- ggplot(libupdate, aes(state.x))
g + geom_bar(aes(fill=type), width = 0.5) + 
  theme(axis.text.x = element_text(angle=65, vjust=0.6)) +
  labs(title="Categorywise Bar Chart", 
       subtitle="Types of Libraries by State", 
       caption="Source: Libraries Davies")
