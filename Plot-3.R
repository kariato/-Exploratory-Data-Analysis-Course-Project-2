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
library(ggplot2)
#
#read data from 
SCC.PM25 <- readRDS("./summarySCC_PM25.rds")
#
#use sql to group and sum data
emissions.by.type.year.BaltimoreCity <- 
  sqldf("select year,type as Type,sum(Emissions)/1.0 as emissions from [SCC.PM25] where fips=24510 group by year,type order by year,type")
emissions.by.type.year.BaltimoreCity$year <- as.character(emissions.by.type.year.BaltimoreCity$year)

#
#plot data
png(filename = "plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
plot3 <- ggplot(data=emissions.by.type.year.BaltimoreCity,aes(year,emissions,group=Type,color=Type))+geom_line()+geom_point()+
  labs(x="Year of Emission",y="Emission (PM2.5) (in Tons)",title="Emission(PM2.5) by Type in Baltimore City, Maryland")
plot3
dev.off()
plot3