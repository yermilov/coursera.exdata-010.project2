library(dplyr)

unzip('data/exdata-data-NEI_data.zip', exdir = 'data')
NEI <- tbl_df(readRDS('data/summarySCC_PM25.rds'))

NEI_by_year <- group_by(NEI, year)
emissions_per_year <- summarise(NEI_by_year, year_emissions = sum(Emissions))

plot(emissions_per_year$year, emissions_per_year$year_emissions, type='l', main = 'Total PM2.5 emission from all sources', xlab = 'Year', ylab = 'Amount of PM2.5 emitted, in tons')

dev.copy(png, file = "plot1.png") 
dev.off()