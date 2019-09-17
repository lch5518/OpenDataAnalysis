install.packages("dplyr")
install.packages("data.table")
install.packages("ggplot2")

library("dplyr")
library("data.table")
library("ggplot2")

wd <- "C:/Users/PC39043/Downloads"
setwd(wd)
getwd()

list.files()


### read data
# https://www.kaggle.com/residentmario/ramen-ratings
data.file <- "ramen-ratings.csv"
data.raw <- fread(data.file, encoding = "UTF-8")
data.raw

class(data.raw)
data.raw %>% class()
data.raw %>% dim

data.raw %>% head()


### summary
summary(data.raw)

### Country
#### table
tb.data <- data.raw[,Country]
tb <- table(tb.data)
tb
tb.sort <- sort(tb, T)  # T : 내림차순, F: 오름차순
tb.sort

### barplot
barplot(tb.sort)

### barplot - ggplot
tb.sort.dt <- as.data.frame(sort(tb))
tb.sort.dt
names(tb.sort.dt) <- c("Country", "Freq")
tb.sort.dt %>% head()

ggplot(data= tb.sort.dt, aes(x=Country, y=Freq, fill=Country)) + geom_bar(stat="identity") +
  coord_flip()

ggplot(data=data.raw, aes(x=Country, fill=Country)) + geom_bar() + coord_flip()


summary(data.raw)

### Stars
#### table
tb.data <- data.raw[,Stars]
tb.data %>% table()

### filter
data.use <- data.raw %>% filter(Stars!="Unrated")

data.raw %>% dim()
data.use %>% dim()

data.use %>% class()

data.use$Stars %>% as.numeric()
data.use$Stars <- data.use$Stars %>% as.numeric()

data.use %>% head()

### boxplot
plot.value <- data.use$Stars
boxplot(plot.value)
summary(plot.value)

hist(plot.value)


### boxplt - ggplot
ggplot(data = data.use, aes(y=Stars)) + geom_boxplot()


### Country - Top 3
in.country <- c("Japan","USA","South Korea")
data.Country <- data.use %>% filter(Country %in% in.country)
data.Country %>% dim()
data.Country %>% head()


data.Country <- data.use %>% filter(Country %in% in.country) %>% select(Country,Stars)
data.Country %>% head()

### boxplot
boxplot(Stars~Country, data = data.Country)

ggplot(data = data.Country, aes(x=Country, y=Stars, fill = Country)) + geom_boxplot()



## 검정을 해보자
install.packages("car")
library(car)

leveneTest(Stars~Country, data=data.Country)
fit <- aov(Stars~Country, data=data.Country)
summary(fit)
TukeyHSD(fit)  # 세 나라 모두 유의미한 차이를 보인다.


