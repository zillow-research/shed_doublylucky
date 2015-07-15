############################################################################################################
##
## Copyright (c) 2015 Zillow.com. All rights reserved. 
##
## shed_doublylucky.R: This program uses Federal Reserve Board, 2014 Survey of Household Economics (SHED)  
## and Decisionmaking data to look at the share of young adults age 23-34 who receive financial support 
## from family for post-secondary education, and home buying
##
## Created: 06/25/15 by Aaron Terrazas
## 
############################################################################################################

## Load packages
rm(list=ls())

packages <- c("dplyr", "foreign", "isotone", "questionr", "data.table")

lapply(packages, require, character.only=TRUE)
rm(packages)

options(scipen=999)
options(stringsAsFactors=FALSE)

## Download and unzip Fed microdata from 
## http://www.federalreserve.gov/communitydev/files/SHED_public_use_data_2014_(CSV).zip
## Read unzipped csv data from local file
shed <- read.csv("U:\\SHED\\data\\SHED_public_use_data_2014.csv", header=TRUE)

## Homeownership rate among millennials whose parents helped finance undergrad 

# Total you adults age 23-34
total <- sum(shed$weight3[shed$ppage >= 23 & shed$ppage <= 34]) 

# Total young adults age 23-34, with post-secondary education
bachelors <- sum(shed$weight3[shed$ppage >= 23 & shed$ppage <= 34 & shed$ED0 >= 5]) 

# Total young adults age 23-34, with post-secondary education, and financial assistance from parents
parentfinaid <- sum(shed$weight3[shed$ppage >= 23 & shed$ppage <= 34 & shed$ED0 >= 5 & shed$ED11A_c == 1 & !is.na(shed$ED11A_c)])

# Total young adults age 23-34, with post-secondary education, and financial assistance from parents, and now owns home
homeowner <- sum(shed$weight3[shed$ppage >= 23 & shed$ppage <= 34 & shed$ED0 >= 5 & shed$ED11A_c == 1 & !is.na(shed$ED11A_c) & shed$S2 == 1])

# Total young adults age 23-34, with post-secondary education, and financial assistance from parents, and now owns home, and received down payment assistance
downpaymenthelp <- sum(shed$weight3[shed$ppage >= 23 & shed$ppage <= 34 & shed$ED0 >= 5 & shed$ED11A_c == 1 & !is.na(shed$ED11A_c) & shed$S2 == 1 & shed$H7_c == 1 & !is.na(shed$H7_c) ])

# Shares
bachelors/total
parentfinaid/total
homeowner/total
downpaymenthelp/total