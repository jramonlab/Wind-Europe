library(tidyverse)
figures_path <- "figs/"

# PLOTS 
#target_wind <- malaga_wind
target_wind <- cordoba_wind

#PLOTS
hist(target_wind$FG)
title <- str_c("Wind Mean Speed. Daily Observation. [1959-2019] : ", target_station_name)
target_wind %>% ggplot(aes(FG)) + geom_density() + xlab("Wind Speed in m/s") + ggtitle(title)

# Viewing different SOURCE IDs
target_wind %>% ggplot(aes(y=FG,x=DATE_ISO)) + geom_point(aes(color=SOUID),size = 1) + ylab("Wind Speed in m/s") + ggtitle(title) +
                scale_y_continuous(limits = c(0, 50))
# Saving file
out_file_name <- str_c(figures_path, target_station_name, ".png")
ggsave(out_file_name)


# Viewing different wind types
target_wind %>% ggplot(aes(y=FG,x=DATE_ISO)) + geom_point(aes(color=WIND_DESC),size = 1) + ylab("Wind Speed in m/s") + ggtitle(title) +
                scale_y_continuous(limits = c(0, 50))
target_wind %>% ggplot(aes(FG, fill=WIND_DESC)) + geom_histogram() + 
                xlab("Wind Speed in m/s [Log]") + ylab("Days") + ggtitle(title)
title <- str_c("Wind types observed. [1959-2019] : ", target_station_name)
target_wind %>% count(WIND_DESC) %>% ggplot(aes(WIND_DESC,n)) + geom_col() + 
                geom_text(aes(label = round(n/sum(n)*100,3)), vjust = -0.5, size=3.5) +
                theme_minimal() +
                theme(axis.text.x = element_text(face="bold", color="black", angle=90, size=10, hjust=1)) +
                xlab("Wind Types") + ylab("Days, Column top: in % of Days") + ggtitle(title)

out_file_name <- str_c(figures_path, "Wind types observed. [1959-2019]", ".png")
ggsave(out_file_name)



# different sources for the same station
cordoba_wind_S1 <- cordoba_wind %>% filter(SOUID == "20051")
cordoba_wind_S2 <- cordoba_wind %>% filter(SOUID == "908410")

library(scales)
cordoba_wind_S1 %>% ggplot(aes(y=FG,x=DATE_ISO),size = 0.75) + geom_point() + ylab("Wind Speed in m/s") + ggtitle("S1") + 
  scale_x_date(breaks = date_breaks("1 year"), labels = date_format("%Y")) + 
  theme(axis.text.x = element_text(face="bold", color="#993333", angle=90, size=8)) +
  scale_y_continuous(limits = c(0, 30))

cordoba_wind_S2 %>% ggplot(aes(y=FG,x=DATE_ISO),size = 0.75) + geom_point() + ylab("Wind Speed in m/s") + ggtitle("S2") +
  scale_x_date(breaks = date_breaks("1 year"), labels = date_format("%Y")) + 
  theme(axis.text.x = element_text(face="bold", color="#993333", angle=90, size=8)) +
  scale_y_continuous(limits = c(0, 30))


