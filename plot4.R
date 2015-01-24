library(dplyr)
library(ggplot2)

unzip('data/exdata-data-NEI_data.zip', exdir = 'data')
NEI <- tbl_df(readRDS('data/summarySCC_PM25.rds'))
SCC <- tbl_df(readRDS('data/Source_Classification_Code.rds'))

coal_combustion_SCC <- filter(SCC, (grepl('[cC]omb', paste(SCC$Short.Name, SCC$EI.Sector)) & grepl('[cC]oal', paste(SCC$Short.Name, SCC$EI.Sector))))$SCC
coal_combustion_NEI <- filter(NEI, SCC %in% coal_combustion_SCC)

coal_combustion_NEI_by_year <- group_by(coal_combustion_NEI, year)
coal_combustion_per_year <- summarise(coal_combustion_NEI_by_year, year_emissions = sum(Emissions))

ggplot(coal_combustion_per_year, aes(year, year_emissions)) +
    geom_line() +
    labs(x = 'Year') +
    labs(y = 'Amount of PM2.5 emitted, in tons') +
    labs(title = 'Total PM2.5 emission from coal combustion-related sources')

dev.copy(png, file = "plot4.png") 
dev.off()