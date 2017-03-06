
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
libraries_davis <- read_csv("~/GitHub/nationallibraries/Data/libraries_davis.csv")
