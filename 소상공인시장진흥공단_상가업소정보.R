library(dplyr)
library(data.table)
library(ggplot2)

wd <- "C:"
setwd(wd)

data.file <- "소상공인시장진흥공단_상가업소정보_201906_02.csv"
data.raw <- fread(data.file, encoding =  "UTF-8")

data.raw %>% dim()
data.raw %>% head()
data.raw %>% names()

### barplot - ggplot
tb <- table(data.raw$시도명)
barplot(sort(tb,T))

tb.df <- as.data.frame(tb)
tb.df
ggplot(data = tb.df, aes(x=Var1, y=Freq) ) + geom_bar(stat = "identity")


## 대전추출
data.Daejeon <-data.raw %>% filter(시도명 == "대전광역시")
data.Daejeon %>% dim()

### barplot - 대전 & 상권업종중분류명
tb <- table(data.Daejeon$상권업종중분류명)
barplot(sort(tb,T))

tb.df <- as.data.frame(tb)
head(tb.df)
ggplot(data = tb.df, aes(x=Var1, y=Freq,fill =  Var1) ) + geom_bar(stat = "identity") + coord_flip() #coord_flip : x y 바꾸기


