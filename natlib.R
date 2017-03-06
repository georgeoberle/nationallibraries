
####This project focuses on using the data from 
####https://daviesproject.princeton.edu/databases/

  ##Load Libraries
  
```{r
library(dplyr)
library(ggplot2)
library (magrittr)
library (knitr)
library (stringr)
library (tidyr)
library (ggmap)
library (USAboundaries)

````
libraries_davis<- read.csv("~/GitHub/nationallibraries/Data/libraries_davis.csv")
#These are the processes to use to add columns for geocoded.

libraries_davis%>%
  mutate(location=paste (locality, state))%>%
  location_geocoded <- geocode(libraries_davis$location)



