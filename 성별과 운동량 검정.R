install.packages("dplyr")
install.packages("data.table")
install.packages("ggplot2")
install.packages("plotly")


library("MASS")
library("dplyr")
library(data.table)
library(ggplot2)
library(plotly)



data(survey)
survey %>% dim()
survey %>% head()
survey %>% summary()

data.use <- survey %>% select(Sex, Exer)

data.use %>% dim()
data.use %>% head()

tb <- table(data.use$Sex, data.use$Exer)
barplot(tb, beside = T)

# 남여간 운동량 차이가 있는지 검정해보자
chisq.test(tb) # p-value가 0.05보다 작으므로 성별과 운동량과 상관이 없다.