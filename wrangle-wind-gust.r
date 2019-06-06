library(tidyverse)
library(lubridate)

# Sources from csv
sources <- read_csv("data/sources.csv", skip = 24)
save(sources, file = "rda/sources.rda")

# Spain Sources 
sources %>% filter(CN == "ES")
sources %>% filter(match())

## get station ID
target_name <- "CORDOBA"
#target_name <- "MALAGA"

target_id <- sources$STAID[contains(target_name,sources$SOUNAME, ignore.case = TRUE)][1]
target_id
target_station_name <-  sources$SOUNAME[contains(target_name,sources$SOUNAME, ignore.case = TRUE)][1]


# retrieving data file for specific station ( defined in target_name)
file_path <- "~/projects/repos/ECA_blend_fx/"                   # data for wind speed GUST
sta_id_str <-str_c("0000000000", target_id)
dest_file <- str_c("FX_STAID",str_sub(sta_id_str, -6), ".txt")  # files for mean wind speed
cmd <- str_c("cp ", file_path, dest_file, " ./data/wind-gust/") 
system(cmd)                                                     # copy to project folder the target data station file

# Adapting data
raw_target_wind <- read_csv(str_c("data/wind-gust/",dest_file), skip = 20)
target_wind <- raw_target_wind %>% mutate(SOUID = as.factor(SOUID))
target_wind <- target_wind %>% mutate(FX = FX*0.1)            # Converts to m/s
target_wind <- target_wind %>% mutate(DATE_ISO = ymd(DATE))   # Adds data type column
target_wind <- target_wind %>% filter(Q_FX == 0)              # Only valid values

cordoba_wind_gust <- target_wind
#save(cordoba_wind_gust, file = "rda/malaga_wind_gust.rda")

