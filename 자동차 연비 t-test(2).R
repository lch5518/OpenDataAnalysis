install.packages("dplyr")
library(dplyr)

# t-검정 _ 수동과 자동에 따라 연비차이가 있는지 검정해보기
data(mtcars)
mtcars %>% head()
mtcars %>% dim()

data.use <- mtcars %>% select(mpg, am)
boxplot(data.use$mpg)

# 0 자동, 1 수동
boxplot(mpg~am, data=data.use)

# 두 집단의 분산이 같은지 검정(등분산검정)
# 1. 모수적방법
# 2. 준모수적방법 
# 3. 비모수적방법

install.packages("car")
library(car)
# 준모수적방법 사용(등분산검정)
x <- data.use$mpg
y <- data.use$am %>% factor()
leveneTest(x,y)
# 귀무가설은 두 집단이 분산이 같다/ 대립가설은 두 집단이 분산이 다르다

# 등분산일경우 var.equal = T
result.test <- t.test(mpg~am, data=data.use, var.equal=F) 

# 대립가설 채택, 두 집단의 평균은 다르다. 
# 결론: 수동과 자동의 연비는 다르다. (수동이 자동보다 연비가 더 높다.)




# 타이타닉데이터로 t-test해보기
choose.dir()
setwd("C:/Users/PC39040/Desktop")
getwd()

titanic_train <- read.csv('train.csv')
titanic_train %>% names()

data.use <- titanic_train %>% select(Survived, Age)
data.use %>% is.na() %>% sum()
data.use <- data.use %>% na.omit()
data.use %>% dim()
data.use %>% head()

boxplot(Age~Survived, data=data.use)

x <- titanic_train$Age
y <- titanic_train$Survived %>% factor()
leveneTest(x,y)
t.test()