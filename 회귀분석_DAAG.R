install.packages("DAAG")
install.packages("car")
install.packages("dplyr")
library(DAAG)
library(car)
library(dplyr)

# 선형회귀분석(linear Regression)
# 자료 : Booik Weight(Maindonald, 2007)
# 종속변수 : 책의 무게
# 독립변수 : 책의 부피, 표지의 면적, 표지의 종류

data(allbacks)
dim(allbacks);
allbacks

## 행렬 산점도
plot(allbacks)

## 단순회귀분석
allbacks.lm <- lm(weight~volume, data = allbacks)
allbacks.lm
allbacks.lm %>% summary()

x <- allbacks$volume
y <- allbacks$weight
plot(x,y)
abline(allbacks.lm, col='red')

## 다중회귀분석
allbacks.lm <- lm(weight~volume+area, data = allbacks)
allbacks.lm %>% summary() 
# p-value가 둘 다 0.05보다 작으므로 두 독립변수 모두 책의 무게에 영향을 준다고 할 수 있다. 

## <회귀진단>
# 독립성, 선형성, 정규성, 등분산성
# 이상점 및 영향력 관측치
# 진단도구 : 
# - 잔차/독립변수 그래프(선형성 검토) 
# - 잔차/적합값 그래프(등분산성 검토)
# - 잔차의 QQ plot(정규성검토)
# - 표준화잔차 지렛값(이상점의 검토) / cook의 거리(영향성검토)

par(mfrow=c(2,2))
plot(allbacks.lm)




