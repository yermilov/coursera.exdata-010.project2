library(dplyr)
library(ggplot2)

unzip('data/exdata-data-NEI_data.zip', exdir = 'data')
NEI <- tbl_df(readRDS('data/summarySCC_PM25.rds'))
SCC <- tbl_df(readRDS('data/Source_Classification_Code.rds'))

motor_vehicle_SCC <- filter(SCC, (grepl('[mM]otor', paste(SCC$Short.Name, SCC$EI.Sector)) & grepl('[vV]ehicle', paste(SCC$Short.Name, SCC$EI.Sector))))$SCC
Baltimore_motor_vehicle_NEI <- filter(NEI, SCC %in% motor_vehicle_SCC & fips == '24510')

Baltimore_motor_vehicle_NEI_by_year <- group_by(Baltimore_motor_vehicle_NEI, year)
Baltimore_motor_vehicle_per_year <- summarise(Baltimore_motor_vehicle_NEI_by_year, year_emissions = sum(Emissions))

ggplot(Baltimore_motor_vehicle_per_year, aes(year, year_emissions)) +
    geom_line() +
    labs(x = 'Year') +
    labs(y = 'Amount of PM2.5 emitted, in tons') +
    labs(title = 'Total PM2.5 emission from motor vehicle sources in Baltimore City')

dev.copy(png, file = "plot5.png") 
dev.off()