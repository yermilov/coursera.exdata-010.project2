library(dplyr)
library(ggplot2)

unzip('data/exdata-data-NEI_data.zip', exdir = 'data')
NEI <- tbl_df(readRDS('data/summarySCC_PM25.rds'))
SCC <- tbl_df(readRDS('data/Source_Classification_Code.rds'))

motor_vehicle_SCC <- filter(SCC, (grepl('[mM]otor', paste(SCC$Short.Name, SCC$EI.Sector)) & grepl('[vV]ehicle', paste(SCC$Short.Name, SCC$EI.Sector))))$SCC
motor_vehicle_NEI <- filter(NEI, SCC %in% motor_vehicle_SCC & (fips == '24510' | fips == '06037'))
motor_vehicle_NEI <- mutate(motor_vehicle_NEI, location = ifelse(fips == '24510', 'Baltimore City', 'Los Angeles County'))

motor_vehicle_NEI_by_location_year <- group_by(motor_vehicle_NEI, location, year)
motor_vehicle_per_location_year <- summarise(motor_vehicle_NEI_by_location_year, year_emissions = sum(Emissions))

ggplot(motor_vehicle_per_location_year, aes(year, year_emissions)) +
    geom_line(aes(color = location)) +
    labs(x = 'Year') +
    labs(y = 'Amount of PM2.5 emitted, in tons') +
    labs(title = 'Total PM2.5 emission from motor vehicle sources')

dev.copy(png, file = "plot6.png") 
dev.off()