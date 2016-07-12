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

SCCCoalComb <- sqldf("select SCC from SourceClassificationCode where [SCC.Level.One] like '%combust%' and [SCC.Level.Four] like '%coal%'")
emissions.by.year <-  sqldf("select year,sum(Emissions)/1000000.0 as emissions from [SCC.PM25] PM25 INNER JOIN [SCCCoalComb] SC on PM25.SCC=SC.SCC group by year order by year")
emissions.by.year$year <- as.character(emissions.by.year$year)
#
#plot data
#plot data
png(filename = "plot4.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white" )
plot4 <- ggplot(data=emissions.by.year,aes(year,emissions))+geom_bar(stat="identity") +
  labs(x="Year of Emission",y="Emission (PM2.5) (in Mega Tons)",title="Emission(PM2.5) from Coal Combustion-Related Sources")
plot4
dev.off()
plot4