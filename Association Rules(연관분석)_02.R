install.packages("dplyr")
install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz) # 연관성 분석 시각화
library(dplyr)

choose.dir()
setwd("C:/Users/PC39043/Downloads")
getwd()


data <- read.csv("order_products_aisles_group.csv")
data %>% head()
data %>% str()

op.list <- split(data$aisle, data$order_id) # id별 구매제품목록으로 데이터변환 
op.trans <- as(op.list, "transactions")
summary(op.trans)
image(op.trans)

op.rules <- apriori(op.trans, para=list(support=0.1,confidence=0.8))
summary(op.rules)
inspect(op.rules)

plot(op.rules, method="graph", int = T)
class(op.rules)
