("C:/Users/david/OneDrive/VU/Statistical Data Analysis/Assignment 7")
source('functions_Ch8.txt')
source('airpollution.txt')
source('geese.txt')
source('steamtable.txt')

# Exercise 7.2
airpol = read.table("airpollution.txt", header = TRUE)
pairs(airpol[,c(6,2,3,4,5)])

  # Part b.
Oxidant=airpol[,6]
Insolation=airpol[,5]
Humidity=airpol[,4]
Temperature=airpol[,3]
Wind=airpol[,2]

summary(lm(Oxidant~Insolation)) #0.2552
summary(lm(Oxidant~Humidity)) #0.124
summary(lm(Oxidant~Temperature)) #0.576
summary(lm(Oxidant~Wind)) #0.5863

summary(lm(Oxidant~Wind + Insolation)) #0.6613
summary(lm(Oxidant~Wind + Humidity)) #0.5913
summary(lm(Oxidant~Wind + Temperature)) #0.7773

summary(lm(Oxidant~Wind + Temperature + Insolation)) #0.7816
summary(lm(Oxidant~Wind + Temperature + Humidity)) #0.7964

  # Part c.
summary(lm(Oxidant~Wind+Temperature+Humidity+Insolation))

  # Part d.
summary(lm(Oxidant~Wind+Temperature+Humidity+Insolation))
summary(lm(Oxidant~Wind+Temperature+Humidity))
summary(lm(Oxidant~Wind+Temperature))

  # Part f.
par(mfrow=c(2,2), pty="s")
ROxi_Hum = lm(Oxidant ~ Wind + Temperature + Insolation)$residuals
RHum_Hum = lm(Humidity ~ Wind + Temperature + Insolation)$residuals
plot(y=ROxi_Hum, x=RHum_Hum, 
     ylab="ROxidant(X-Humidity)", xlab="RHumidity(X-Humidity)")

ROxi_Ins = lm(Oxidant ~ Wind + Temperature + Humidity)$residuals
RIns_Ins = lm(Insolation ~ Wind + Temperature + Humidity)$residuals
plot(y=ROxi_Ins, x=RIns_Ins, 
     ylab="ROxidant(X-Insolation)", xlab="RInsolation(X-Insolation)")

ROxi_Wind = lm(Oxidant ~ Temperature + Humidity + Insolation)$residuals
RWind_Wind = lm(Wind ~ Temperature + Humidity + Insolation)$residuals
plot(y=ROxi_Wind, x=RIns_Ins, 
     ylab="ROxidant(X-Wind)", xlab="RWind(X-Wind)")

ROxi_Tem = lm(Oxidant ~ Wind + Insolation + Humidity)$residuals
RTem_Tem = lm(Temperature ~ Wind + Insolation + Humidity)$residuals
plot(y=ROxi_Ins, x=RIns_Ins, 
     ylab="ROxidant(X-Temperature)", xlab="RTemperature(X-Temperature)")

  # Part g.
u = c(rep(0,3),1,rep(0,26))
msolm = lm(Oxidant ~ Wind + Temperature + u)
summary(msolm)

   