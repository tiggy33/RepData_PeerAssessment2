

head(mydata)

mydata$year <- as.numeric(format(as.Date(mydata$BGN_DATE, format = "%m/%d/%Y %H:%M:%S"), "%Y"))

mydata <- storm[c("EVTYPE", "FATALITIES", "INJURIES", "PROPDMG", "PROPDMGEXP", "CROPDMG", "CROPDMGEXP",  "year")]

#Find unique Property Damage exponential 
unique(mydata$PROPDMGEXP)

# Sorting the property exponent data
mydata$PROPEXP[mydata$PROPDMGEXP == "K"] <- 1000
mydata$PROPEXP[mydata$PROPDMGEXP == "M"] <- 1e+06
mydata$PROPEXP[mydata$PROPDMGEXP == ""] <- 1
mydata$PROPEXP[mydata$PROPDMGEXP == "B"] <- 1e+09
mydata$PROPEXP[mydata$PROPDMGEXP == "m"] <- 1e+06
mydata$PROPEXP[mydata$PROPDMGEXP == "0"] <- 1
mydata$PROPEXP[mydata$PROPDMGEXP == "5"] <- 1e+05
mydata$PROPEXP[mydata$PROPDMGEXP == "6"] <- 1e+06
mydata$PROPEXP[mydata$PROPDMGEXP == "4"] <- 10000
mydata$PROPEXP[mydata$PROPDMGEXP == "2"] <- 100
mydata$PROPEXP[mydata$PROPDMGEXP == "3"] <- 1000
mydata$PROPEXP[mydata$PROPDMGEXP == "h"] <- 100
mydata$PROPEXP[mydata$PROPDMGEXP == "7"] <- 1e+07
mydata$PROPEXP[mydata$PROPDMGEXP == "H"] <- 100
mydata$PROPEXP[mydata$PROPDMGEXP == "1"] <- 10
mydata$PROPEXP[mydata$PROPDMGEXP == "8"] <- 1e+08
mydata$PROPEXP[mydata$PROPDMGEXP == "+"] <- 0
mydata$PROPEXP[mydata$PROPDMGEXP == "-"] <- 0
mydata$PROPEXP[mydata$PROPDMGEXP == "?"] <- 0

mydata$PROPDMG <- mydata$PROPDMG * mydata$PROPEXP

mydata$DMG <- (mydata$PROPDMG + mydata$CROPDMG) / 1000000000
finaldata <- mydata[,c("EVTYPE","FATALITIES","INJURIES","DMG", "year")]  

head(finaldata)
#Summarise of Fatalities events and get the top 10 result 
FATALITIES <- aggregate(FATALITIES ~ EVTYPE, finaldata, sum)
FATALITIES <- FATALITIES[order(-FATALITIES$FATALITIES), ][1:10, ]
#Print the table
print(FATALITIES)
