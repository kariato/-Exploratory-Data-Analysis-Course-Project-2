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
SourceClassificationCode <- readRDS("./Source_Classification_Code.rds")
#
#use sql to group and sum data

SCCMotorVehicle <- sqldf("select SCC from SourceClassificationCode where [SCC.Level.One]='Mobile Sources' and [SCC.Level.Two] like '%vehicle%'")
emissions.by.year.BaltimoreCity <-  sqldf("select year,sum(Emissions)/1.0 as emissions from [SCC.PM25] PM25 INNER JOIN [SCCMotorVehicle] SC on PM25.SCC=SC.SCC where fips=24510 group by year order by year")
emissions.by.year.BaltimoreCity$year <- as.character(emissions.by.year.BaltimoreCity$year)
#
#plot data
#plot data
png(filename = "plot5.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
plot5 <- ggplot(data=emissions.by.year.BaltimoreCity,aes(year,emissions))+geom_bar(stat="identity") + labs(x="Year of Emission",y="Emission (PM2.5) (in Tons)",title="Emission(PM2.5) from Motor Vehicle Related Sources in Baltimore City")
plot5
dev.off()
plot5