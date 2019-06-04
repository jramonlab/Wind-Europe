# getting data sources
url <- "https://www.ecad.eu//download/ECA_blend_source_fg.txt"
dest_file <- "data/sources.csv"
download.file(url, dest_file)

# getting data for stations
url <- "https://www.ecad.eu//download/ECA_blend_station_fg.txt"
dest_file <- "data/stations.csv"
download.file(url, dest_file)

# getting table for wind scale
url <- "https://en.wikipedia.org/wiki/Beaufort_scale"
dest_file <- "data/wind-beaufort-scale.html"
download.file(url, dest_file)
