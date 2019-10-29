# K-means
install.packages("dplyr")
library(dplyr)

iris %>% head()
newiris <- iris %>% select(-Species)
newiris %>% head()

kc <- kmeans(newiris, 3)
kc
pred <- kc$cluster
target <- iris$Species
table(target, pred)

plot(newiris)

plot.col <- target %>% as.integer()  # 실제 데이터! 
plot(newiris[3:4], pch=pred, col=plot.col)

# 군집수 결정
install.packages("NbClust")
library(NbClust)

#최소 2개에서 최대 10개까지의 군집수 구간설정
nc <- NbClust(newiris, min.nc=2, max.nc=10, method="kmeans") # 경사가 가장 가파른 값이 최적의 군집수가 된다.
