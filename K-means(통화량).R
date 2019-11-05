install.packages("dplyr")
install.packages("NbClust")

library(dplyr)
library(NbClust)

choose.dir()
setwd("C:/Users/PC39043/Downloads")
getwd()

  data <- read.csv("Customer2001.csv")

#Peak 주간, OffPeak 야간, Weedend 주말, International 국제통화
data %>% head()
data %>% names()

data.use <- data %>% select("Peak_calls_Sum", "OffPeak_calls_Sum", "Weekend_calls_Sum", "International_mins_Sum", "AvePeak", "AveOffPeak","AveWeekend")
data.use %>% head()
plot(data.use)

nc <- NbClust(data.use, min.nc=2, max.nc=10, method="kmeans")

kc <- kmeans(data.use, 3)
kc

kc$cluster
kc$centers


pred <- kc$cluster
target <- data.use$Peak_calls_Sum
table(target, pred)


