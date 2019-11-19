install.packages("dplyr")
install.packages("ggplot2")
install.packages("plotly")
install.packages("ggExtra")
install.packages("ggcorrplot")

library(dplyr)
library(ggplot2)
library(plotly) # 웹브라우저를 통해 시각화
library(ggExtra)
library(ggcorrplot)

#--시각화(Visualization)--


# ***Correlation***


data(diamonds)

## Scatter Plot
# carat & price by clarity
ggp <- ggplot(data=diamonds, aes(x=carat,y=price,colour=clarity)) + 
  geom_point(alpha=0.5)
ggp



data(mtcars)

## Jitter Plot
ggp <- ggplot(data=mtcars, aes(x=disp, y=hp)) + 
  geom_point(aes(size=cyl, col=mpg)) + 
  geom_smooth(method="lm")
ggp
ggp %>% ggplotly()


data(mpg)

## Counts Chart
# disp(Displacement) & hp(Gross horesepower)
ggp <- ggplot(mpg, aes(cty, hwy)) +
  geom_count(col="blue")
ggp



#library(ggExtra)
## Marginal Histogram / Boxplot

data(mpg)

### scatterplot
# disp(Displacement) & hp(Gross horsepower)
ggp <- ggplot(mpg, aes(cty, hwy)) + geom_count() + geom_smooth(method="lm", se=F)

### Marginal Histogram
ggMarginal(ggp, type = "histogram")

### Marginal Boxplot
ggMarginal(ggp, type = "boxplot")



#library(ggcorrplot)
### Correlogram
corr <- round(cor(mtcars), 1)
ggcorrplot(corr, type = "lower", lab = TRUE, lab_size = 3,
           method="circle", colors = c("tomato3", "white", "springgreen3"),
           title="Correlogram of mtcars", ggtheme=theme_bw)





# ***Deviation***

## Diverging Bars

data(mtcars)
### Prepare data
car.name <- rownames(mtcars)
mtcars$mpg_z <- round((mtcars$mpg - mean(mtcars$mpg))/sd(mtcars$mpg), 2)
mtcars$mpg_type <- ifelse(mtcars$mpg_z < 0, "Below", "Above")

### Diverging bars
ggplot(mtcars, aes(x=reorder(car.name, mpg_z), y=mpg_z, label=mpg_z)) +
  geom_bar(stat='identity', aes(fill=mpg_type), width=.5) +
  labs(x="Car name", y="Standardized mpg") + coord_flip()





# ***Ranking***

## Ordered Bar Chart
data("mpg")

### Prepare data
cty_mpg <- aggregate(mpg$cty, by=list(mpg$manufacturer), FUN=mean) # aggregate
colnames(cty_mpg) <- c("make", "mileage") # change column names

### Ordered Bar Chart
ggplot(cty_mpg, aes(x=reorder(make, mileage), y=mileage)) +
  geom_bar(stat="identity", fill="tomato3") + coord_flip()



## Dumbbell Plot
install.packages("ggalt")
library(ggalt)

data("mpg")
mpg %>% head()

### Prepare data
mpg.cty.summ <- mpg %>% group_by(manufacturer) %>% summarize(cty_min=min(cty),
                                                             cty_max=max(cty))
### Dumbbell Plot
ggplot(mpg.cty.summ, aes(x=cty_min, xend=cty_max, y=manufacturer, group=manufacturer)) +
  geom_dumbbell(color="skyblue", size=1.5)






# ***Distribution***

data(mpg)
## Histogram
ggplot(mpg, aes(cty)) + geom_histogram(aes(fill=factor(cyl)))


## Density Plot
ggplot(mpg, aes(cty)) + geom_density(aes(fill=factor(cyl)), alpha=0.8)


## Box Plot
ggplot(mpg, aes(class, cty)) + geom_boxplot(fill="plum")


## Violin Plot
ggplot(mpg, aes(class, cty)) + geom_violin(fill="plum")






# ***Composition***

data(mpg)

## Pie Chart
ggplot(mpg, aes(x= "", fill = factor(class))) + 
  geom_bar(width = 1) + 
  coord_polar(theta = "y", start = 0)


## Bar Chart
ggplot(mpg, aes(manufacturer)) + geom_bar(aes(fill=class)) + coord_flip()





# ***Change***

data(economics)

## Time Series Plots
# psaver t: personal savings rate
ggplot(economics, aes(x=date)) + geom_line(aes(y=psavert))

ggplot(economics, aes(x=date)) + geom_line(aes(y=psavert, col="psavert")) +
  geom_line(aes(y=uempmed, col="uempmed"))





# ***Groups***
install.packages("ggdendro")
library(ggdendro)

data(mtcars)

## Dendrogram
hc <- hclust(dist(mtcars), "ave") # hierarchical clustering
ggdendrogram(hc, rotate = TRUE, size = 2)


## Heatmap
x <- as.matrix(mtcars)
heatmap(x, scale = "column", xlab = "specification variables", ylab = "Car Models", margins = c(5,8))
