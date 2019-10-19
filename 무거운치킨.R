#20140736 이창현
rm(list = ls())
install.packages("dplyr")
install.packages("car")
library(dplyr)
library(car)

# 1
## (1)
boxplot(weight~feed, data=chickwts)

## (2)
data.1 <- rbind(chickwts %>% filter(feed=='sunflower'),chickwts %>% filter(feed=='casein'))
head(data.1)
tail(data.1)

## (3) 등분산검정
leveneTest(weight~feed, data=data.1)

## (4) t-test
t.test(weight~feed, data=data.1, var.equal=T)



# 2
## anova
a <- c(36,41,42,49)
b <- c(40,48,39,45,44)
c <- c(35,37,42,34,32)

data <- c(a,b,c)
data

n <- c(4,5,5)
machine <- rep(1:3, n)
machine

group_df <- data.frame(data,machine)
group_df

sapply(group_df, class)
group_df <- transform(group_df, machine = factor(machine))
sapply(group_df, class)

tapply(data, machine, summary)

fit <- aov(data~machine,data=group_df)
fit %>% summary()


## 사후분석 / 그래서 어느놈이 다른건지
### Tukey HSD
TukeyHSD(fit)
TukeyHSD(fit) %>% plot()

### Duncan LSD
install.packages("agricolae")
library(agricolae)

duncan.test(fit, "machine", alpha = 0.05, console = T)


# 3
fit <- aov(weight~ feed, data=chickwts)
fit %>% summary()
duncan.test(fit, "feed", alpha = 0.05, console = T) %>% plot()


# 4
getwd()
choose.dir()
setwd("C:/Users/dydeh/Downloads")
### (1)
data <- read.csv('nuclear.csv', head=T)

pairs(data)

### (2)
nuclear.use <- select(data,-X,-date)

### (3) 로지스틱회귀모형
model <- lm(cost ~ ., data = nuclear.use)
model %>% summary()

### (4) AIC
model.step <- step(model)
model.step %>% summary()

### (5) 회귀진단
par(mfrow=c(2,2))
plot(model.step)

### Q-Q_plot 잔차들의 정규성 판단
par(mfrow=c(1,1))
qqPlot(model.step,id.method="identify",simulate=TRUE,main="Q-Q_ plot")


### 등분산성 검정
# 모형 적합 값에 따라 오차의 분산이 변하는지 검정
# 유의한 결과 가 나온다면 오차의 등분산성 가정이 위배
ncvTest(model.step) 
spreadLevelPlot(model.step) # 등분산성을 만족할 경우 수평선을 보여준다


### 이상치
car::outlierTest(model.step)

### 이상치, 큰지레점, 영향관측치를 한번에 확인하는 그래프
car::influencePlot(model.step, main="Influence Plot",
                   sub="Circle size is proportional to Cook’s distance")
