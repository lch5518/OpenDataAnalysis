install.packages("dplyr")
install.packages("car")
library(dplyr)
library("car")

### 1
boxplot(weight~feed, data=chickwts)

### 2
data.1 <- rbind(chickwts %>% filter(feed=='sunflower'),chickwts %>% filter(feed=='casein'))
head(data.1)
tail(data.1)

### 3
x <- data.1 %>% filter(feed=='sunflower')
y <- data.1 %>% filter(feed=='casein')


leveneTest(x,y)



