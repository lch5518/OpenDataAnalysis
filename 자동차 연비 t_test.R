install.packages("dplyr")
install.packages("data.table")
install.packages("ggplot2")
install.packages("plotly")



library("dplyr")
library(data.table)
library(ggplot2)
library(plotly)


# T-test

data(mtcars)
mtcars %>% dim()
mtcars %>% head()
mtcars %>% summary()

# mpg:연비, am:1(수동),0(자동)

am.mpg <- mtcars %>% filter(am==1) %>% select(mpg)

t.test(am.mpg, mu=20) #mu에 비교할 값을 넣는다.
# 대립가설 채택, 연비평균은 20이 아니다. 
# mear of x가 24.39이므로 20보다 큼을 알 수 있다