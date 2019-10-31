install.packages("arules")
install.packages("arulesViz")

library(arules)
library(arulesViz)

choose.files()
chose.files <- "C:/Users/PC39043/Downloads/dvdtrans.csv"
dvd <- read.csv(chose.files, stringsAsFactors=F)
dim(dvd)
head(dvd)

# 자료변환
dvd.list <- split(dvd$Item, dvd$ID)
dvd.trans <- as(dvd.list, "transactions")
summary(dvd.trans)
image(dvd.trans)

# 최소 지지도에 의한 가지치기 알고리즘; 지지도 : 0.2 , 신뢰도 :0.6
dvd.rules <- apriori(dvd.trans, para=list(support=0.2,confidence=0.6))
summary(dvd.rules)
inspect(dvd.rules)

# 연관성 분석 시각화
plot(dvd.rules, method="graph", int = T)
class(dvd.rules)
