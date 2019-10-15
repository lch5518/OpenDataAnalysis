# SVM(Support Vector Machine)
# 지도학습모델, 주로분류(svm)와 회귀분석(svr)을 위해 사용
# 주어진 데이터 집합을 바탕으로 사상된 공간에서 가장 큰 폭을 가진 경계를 찾는 방법
# 장점: 데이터마이닝 기법 중에서도 예측력이 우수한 알고리즘, 샘플이 적어도 적합도 우수, 계산량이 적은 대용량 데이터분석
# 생물정보학/문자인식/얼굴및문제인식에 우수
# 단점 : 단위비용과 커널선택에 따라 모형이 민감, 다범주 분류의 경우 기하급수적으로 학습속도와 분류속도가 느려짐

install.packages("dplyr")
install.packages("e1071")
library(dplyr)
library(e1071)

data(iris)
iris %>% head()

model.svm <- svm(Species ~ ., data=iris)
model.svm
model.svm %>% summary()

pred <- predict(model.svm, iris)

x <- pred
y <- iris$Species
table(x,y)

# 이제 튜닝을 해볼까나
2^(-1:1)
2^(2:4)
model.svm.tune <- tune.svm(Species ~ . , data=iris, gamma=2^(-1:1), cost = 2^(2:4))
model.svm.tune # 최적의 감마와 코스트를 정해줌줌
model.svm.tune %>% summary()

model.svm <- svm(Species ~ ., data=iris, gamma=0.5, cost = 4)
pred <- predict(model.svm, iris)
x <- pred
y <- iris$Species
table(x,y) #virginica 예측률이 쪼금 좋아짐!

model.svm.tune %>% plot()
