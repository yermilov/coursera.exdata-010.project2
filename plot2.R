library(dplyr)

unzip('data/exdata-data-NEI_data.zip', exdir = 'data')
NEI <- tbl_df(readRDS('data/summarySCC_PM25.rds'))

Baltimore_NEI <- filter(NEI, fips == '24510')
Baltimore_NEI_by_year <- group_by(Baltimore_NEI, year)
Baltimore_emissions_per_year <- summarise(Baltimore_NEI_by_year, year_emissions = sum(Emissions))

plot(Baltimore_emissions_per_year$year, Baltimore_emissions_per_year$year_emissions, type='l', main = 'Total PM2.5 emission in the Baltimore City, Maryland', xlab = 'Year', ylab = 'Amount of PM2.5 emitted, in tons')

dev.copy(png, file = "plot2.png", width = 640)
dev.off()