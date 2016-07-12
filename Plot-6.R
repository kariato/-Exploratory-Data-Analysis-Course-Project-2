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
locations <- data.frame(fips=c("24510","06037"),location=c("Baltimore City","Los Angeles County"))
SCCMotorVehicle <- sqldf("select SCC from SourceClassificationCode where [SCC.Level.One]='Mobile Sources' and [SCC.Level.Two] like '%vehicle%'")
emissions.by.year.location <-  sqldf("select year,location,sum(Emissions)/1.0 as emissions from [SCC.PM25] PM25 INNER JOIN [SCCMotorVehicle] SC on PM25.SCC=SC.SCC INNER JOIN locations loc on PM25.fips=loc.fips group by year,location order by year,location")
emissions.by.year.location$year <- as.character(emissions.by.year.location$year)
#
#plot data
#plot data
png(filename = "plot6.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
plot6 <- ggplot(data= emissions.by.year.location,aes(x=year,y=emissions,group=location,color=location))+geom_line()+geom_point()+labs(x="Year of Emission",y="Emission (PM2.5) (in Tons)",title="Emission(PM2.5) for Motor Vehicles by Location")
plot6
dev.off()
plot6