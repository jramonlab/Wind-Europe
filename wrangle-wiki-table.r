
# getting table for wind scale
library(rvest)
url <- "data/wind-beaufort-scale.html"
ht <- read_html(url)
tab <- ht %>% html_nodes("table") # extract html tables from XML
tab <- tab[[2]]

tab <- tab %>% html_table  # converts table to data.frame
tab_names <- c("DESCRIPTION", "WIND_CATEGORY","WIND_SPEED")
tab <- t(tab)
df <- as.data.frame(tab)
df <- df %>% setNames(tab_names)

library(dplyr)
library(stringr)
df <- df  %>% mutate(SPEED_MPS=WIND_SPEED)  
df$SPEED_MPS <- df$SPEED_MPS %>% str_replace_all( " m/s|m/s", "")
df$SPEED_MPS <- df$SPEED_MPS %>% str_replace_all( "<| <|< ", " 0\\.0-")
df$SPEED_MPS <- df$SPEED_MPS %>% str_replace_all( "=|= | =", "")
df$SPEED_MPS <- df$SPEED_MPS %>% str_trim()

# Extracts wind speed in m/s
df$SPEED_MPS <- str_split(df$SPEED_MPS, " ", simplify=TRUE)[,6]

# Extracts max and min wind speed in m/s
df <- df %>% mutate(MIN_SPEED_MPS = SPEED_MPS)
df$MIN_SPEED_MPS <- str_extract(df$MIN_SPEED_MPS, "\\d{1,2}.\\d")

df <- df %>% mutate(MAX_SPEED_MPS = SPEED_MPS)
df$MAX_SPEED_MPS <- str_extract(df$MAX_SPEED_MPS, "\\d{1,2}.\\d$")

# converts to numbrer
df <- df %>% mutate_at(c("MIN_SPEED_MPS", "MAX_SPEED_MPS"), as.numeric)
# custom set format value of hurracanes
df$MAX_SPEED_MPS[13] <- 1000

#
# Select interesting columns
windscale <- df %>% select(c(-3,-4))

save(windscale, file = "rda/windscale.rda")
