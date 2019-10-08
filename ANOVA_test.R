#ANOVA_test

library(car)
library(dplyr)

setwd("C:/Users/PC39040/Desktop")

titanic_train <- read.csv('train.csv')
titanic_train %>% dim()
titanic_train %>% head()

data.use <- titanic_train %>% select(Pclass, Age) %>% na.omit()
data.use %>% dim()

x <- data.use$Age
y <- data.use$Pclass %>% factor()
data.use$Pclass <- data.use$Pclass %>% factor()

### 등분산 검정
leveneTest(x,y)

### 일원배치 분산분석
# aov에는 여러가지 기능이 있는데 그중 anova검정을 사용
fit <- aov(Age~Pclass, data = data.use)
fit

boxplot(Age~Pclass, data=data.use)

### 분산분석표
summary(fit)

## p-value가 매우 적으므로 대립가설 채택
## 사후검정하자아_3개의 집단중에 어떤것이 다른지!
## 분산분석의 결과 귀무가설을 기각하는 경우 
## 어느 집단간의 차이에서 기인하는지 검토


TukeyHSD(fit)
## 2-1 다르다(0.0000000)
## 3-1 다르다(0.0000000)
## 3-2 다르다(0.0004884)

install.packages("agricolae")
library(agricolae)

duncan.test(fit, "Pclass", console = T)
# 그룹의 문자(a,b,c)가 다 다르므로 3집단 모두 다르다고 할 수 있다. 
# 1그룹 평균 38.23 / a
# 2그룹 평균 29.88 / b
# 3그룹 평균 25.14 / c


### 등분산성, 정규성
#plot(fit$fitted, fit$fitresid)
#qqnorm(fit$resid)
#qqline(fit$resid)

#oneway.test(strength~fmachine, var.equal=True, data=data)





                          