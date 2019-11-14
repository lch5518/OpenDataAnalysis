install.packages("dplyr")
install.packages("ggplot2")
install.packages("plotly")

library(dplyr)
library(ggplot2)
library(plotly)

data(diamonds)
diamonds %>% dim()
diamonds %>% head()
diamonds %>% summary()
?diamonds


# boxplot
ggplot(diamonds, aes(y=price)) + geom_boxplot()

ggplot(diamonds, aes(y=carat)) + geom_boxplot()

ggplot(diamonds, aes(x=clarity, y=price)) + geom_boxplot()


# scater plot
ggplot(diamonds, aes(x=carat, y=price)) + 
  geom_point(color="skyblue", alpha=0.1) #alpha : 투명도

ggplot(diamonds, aes(x=clarity)) + geom_bar(fill="skyblue")

ggplot(diamonds, aes(x=carat, y=price, colour=clarity)) + 
  geom_point(alpha=0.1)



