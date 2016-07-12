#Author: Mark C. Davey
#Date: 7/11/2016
#Decription: R code to plot air quality data 
#
#clean up
setwd("C:/Users/mdavey/Google Drive/Data Science/Exploratory Data Analysis/Graphical R/Week 4")
rm(list=ls())
#
#read in packages to be used
library(sqldf)
#
#read data from 
SCC.PM25 <- readRDS("./summarySCC_PM25.rds")
#
#use sql to group and sum data
emissions.by.year.BaltimoreCity <- 
  sqldf("select year,sum(Emissions)/1.0 as emissions from [SCC.PM25] where fips=24510 group by year order by year")
#
#plot data
png(filename = "plot2.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
barplot(emissions.by.year.BaltimoreCity$emissions,emissions.by.year.BaltimoreCity$year,
        names.arg=emissions.by.year.BaltimoreCity$year,
        main="Gross PM2.5 Emissions in Baltimore City (Maryland) by Year",
        ylab="Emissions(in Tons) ",xlab="Year of Emission")
dev.off()