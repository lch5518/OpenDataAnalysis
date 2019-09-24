install.packages("dplyr")
install.packages("data.table")
install.packages("ggplot2")

library("dplyr")
library("data.table")
library("ggplot2")

# 기본예제.
band_members
band_instruments

cbind(band_members, band_instruments)

# dplyr에서 제공 merge보다 속도가 빠르다.
# "Mutating" joins combine variables from the LHS and RHS
band_members %>% inner_join(band_instruments)
band_members %>% left_join(band_instruments)
band_members %>% right_join(band_instruments)
band_members %>% full_join(band_instruments)

band_members %>% left_join(band_instruments, by="name")

# 경로 쉽게 불러오기 
choose.dir()
setwd("C:\\Users\\PC39043\\Downloads")
getwd()

#file.choose()

#시간별 대기정보 불러오기
choose.files()
data.file.air <- "C:\\Users\\PC39043\\Downloads\\대기정보_20190924.txt"
data.air <- fread(data.file.air, encoding = "UTF-8")
data.air %>% dim()
data.air

#시간별 기온 불러오기
choose.files()
data.file.temp <- "C:\\Users\\PC39043\\Downloads\\기온정보_20190924.txt"
data.tmp <- fread(data.file.temp, encoding = "UTF-8")
data.tmp %>% dim()
data.tmp

data.air %>% inner_join(data.tmp)
data.air %>% left_join(data.tmp, by=c("date","hour"))

data.air.tmp <- data.air %>% left_join(data.tmp, by=c("date","hour"))

x <- data.air.tmp$hour
y <- data.air.tmp$PM_10

#산점도
plot(x,y)
#선그래프
plot(x,y, type="l")
# 선+포인트
plot(x,y, type="o")

ggplot(data.air.tmp, aes(x=hour, y=PM_10, color = 기온)) + 
  geom_line(size=2, lineed="round") + 
  geom_point(size=5) +
  scale_color_gradientn(colours = rainbow(3))








# 브라우저에서 그래프 출력하기
install.packages("plotly")
library(plotly)

ggp.line <- ggplot(data.air.tmp, aes(x=hour, y=PM_10)) + 
  geom_line(size=2, lineed="round") + 
  geom_point(size=5) +
  scale_color_gradientn(colours = rainbow(3))

ggp.line

ggplotly(ggp.line)




# R의 기능을 클릭클릭으로 사용하기 
install.packages("Rcmdr")
library(Rcmdr)
