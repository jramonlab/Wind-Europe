# getting data sources for MEAN WIND SPEED
url <- "https://www.ecad.eu//download/ECA_blend_source_fg.txt"
dest_file <- "data/wind-speed/sources_fg.csv"
download.file(url, dest_file)

# getting data for stations for MEAN WIND SPEED
url <- "https://www.ecad.eu//download/ECA_blend_station_fg.txt"
dest_file <- "data/wind-speed/stations_fg.csv"
download.file(url, dest_file)

#####################################################
# getting table for wind scale
url <- "https://en.wikipedia.org/wiki/Beaufort_scale"
dest_file <- "data/wind-beaufort-scale.html"
download.file(url, dest_file)
#####################################################

# getting data sources for WIND DIRECTION
url <- "https://www.ecad.eu//download/ECA_blend_source_dd.txt"
dest_file <- "data/wind-direction/sources_dd.csv"
download.file(url, dest_file)
# getting data for stations for WIND DIRECTION
url <- "https://www.ecad.eu//download/ECA_blend_station_dd.txt"
dest_file <- "data/wind-direction/stations_dd.csv"
download.file(url, dest_file)

# getting data sources for MAX WIND GUST SPEED
url <- "https://www.ecad.eu//download/ECA_blend_source_fx.txt"
dest_file <- "data/wind-gust/sources_fx.csv"
download.file(url, dest_file)
# getting data for stations for MAX WIND GUST SPEED
url <- "https://www.ecad.eu//download/ECA_blend_station_fx.txt"
dest_file <- "data/wind-gust/stations_fx.csv"
download.file(url, dest_file)

