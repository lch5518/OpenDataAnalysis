library(MASS)
library(dplyr)
library(data.table)
library(ggplot2)
library(plotly)


choose.files()
data.file <- "C:\\Users\\PC39043\\Downloads\\titanic\\train.csv"
data.raw <- fread(data.file)

data.raw %>% dim()
data.raw %>% head()
data.raw %>% summary()

lab <- c("no","yes")
data.raw$Survived <- factor(lab[data.raw$Survived+1])


#[성별-생존시
data.use <- data.raw %>% select(Sex, Survived)
data.use %>% dim()
data.use %>% head()
tb <- table(data.use$Sex, data.use$Survived)
barplot(tb, beside = T)
ggp.bar <- ggplot(data.use, aes(x=Survived, fill=Sex)) + geom_bar(position="dodge")
ggp.bar
ggplotly(ggp.bar)

chisq.test(tb)
# p-value가 유의수준 0.05보다 작으므로 대립가설을 채택, 성별의 차이는 있다. 


#[생존-객실]

data.use <- data.raw %>% select(Survived, Pclass)
data.use %>% dim()
data.use %>% head()
tb <- table(data.use$Pclass, data.use$Survived)
barplot(tb, beside = T)
ggp.bar <- ggplot(data.use, aes(x=Survived, fill=Pclass)) + geom_bar(position="dodge")
ggp.bar
ggplotly(ggp.bar)

chisq.test(tb)


