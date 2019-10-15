#로지스틱 회귀분석
# 종속변수가 두 가지 결과만 가지는 경우의 회귀분석!


install.packages("dplyr")


library(dplyr)

data(iris)
iris %>% summary()

iris.use <- iris %>% filter(Species %in% c("versicolor", "virginica"))

iris.use %>% summary()
plot.col <- iris.use$Species %>% as.integer()
plot(iris.use, col = plot.col)

model <- glm(Species ~ ., data=iris.use, family="binomial")

model %>% summary()

pred <-predict(model, iris.use, type = "response") #파라미터 : 모델, 추정치
pred.val <- ifelse(pred>0.5, 1, 0)

#교차표를 통해 얼마나 추정을 잘했는지 알아보자
x <- pred.val
y <- iris.use$Species
table(x,y)

#변수선택 - 모수 절약의 원칙(principle of parsimony)
model.step <- step(model)
model.step %>% summary()

pred.step <-predict(model.step, iris.use, type = "response")
pred.step.val <- ifelse(pred.step>0.5, 1, 0)

x <- pred.step.val
y <- iris.use$Species
table(x,y) # traingset/testset을 나눈게 아니기에 변수가 줄어 예측률이 줄었다.

