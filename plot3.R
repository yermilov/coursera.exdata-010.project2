library(dplyr)
library(ggplot2)

unzip('data/exdata-data-NEI_data.zip', exdir = 'data')
NEI <- tbl_df(readRDS('data/summarySCC_PM25.rds'))

Baltimore_NEI <- filter(NEI, fips == '24510')
Baltimore_NEI_by_type_year <- group_by(Baltimore_NEI, type, year)
Baltimore_emissions_per_type_year <- summarise(Baltimore_NEI_by_type_year, year_emissions = sum(Emissions))

ggplot(Baltimore_emissions_per_type_year, aes(year, year_emissions)) +
    geom_line(aes(color = type)) +
    labs(x = 'Year') +
    labs(y = 'Amount of PM2.5 emitted, in tons') +
    labs(title = 'Total PM2.5 emission in the Baltimore City, Maryland')

dev.copy(png, file = "plot3.png") 
dev.off()