library(tidyverse)
library(lubridate)

# Sources from csv
sources <- read_csv("data/wind-peed/sources_fg.csv", skip = 24)
save(sources, file = "rda/sources_fg.rda")

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
file_path <- "~/projects/repos/ECA_blend_fg/"                   # data for mean wind speed
sta_id_str <-str_c("0000000000", target_id)
dest_file <- str_c("FG_STAID",str_sub(sta_id_str, -6), ".txt")  # files for mean wind speed
cmd <- str_c("cp ", file_path, dest_file, " ./data/wind-speed") 
system(cmd)                                                     # copy to project folder the target data station file

# Adapting data
raw_target_wind <- read_csv(str_c("data/wind-speed",dest_file), skip = 20)
target_wind <- raw_target_wind %>% mutate(SOUID = as.factor(SOUID))
target_wind <- target_wind %>% mutate(FG = FG*0.1)            # Converts to m/s
target_wind <- target_wind %>% mutate(DATE_ISO = ymd(DATE))   # Adds data type column
target_wind <- target_wind %>% filter(Q_FG == 0)              # Only valid values

# Adding wind category to each observation
load(file = "rda/windscale.rda")
f <- cut(x = as.numeric(target_wind$FG), breaks = windscale$MIN_SPEED_MPS, labels = windscale$DESCRIPTION[1:12], include.lowest = TRUE, right=TRUE)
target_wind <- target_wind %>% mutate(WIND_DESC = f)

cordoba_wind <- target_wind
save(cordoba_wind, file = "rda/malaga_wind.rda")

