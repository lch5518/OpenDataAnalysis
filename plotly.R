install.packages("ggmap")
install.packages("plotly")
install.packages("dplyr")

library(ggmap)
library(plotly)
library(dplyr)


##violin
ggp <- ggplot(mpg, aes(class, cty)) + geom_violin(fill="plum")
ggp %>% ggplotly()


p <- plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length)
p # 그냥은출력이 안됨

getwd()
setwd(choose.dir())

htmlwidgets::saveWidget(as.widget(p), "graph.html", selfcontained=F)

pal <- c("red","blue","green")
plot_ly(data=iris, x = ~Sepal.Length, y = ~Petal.Length,
        color = ~Species, colors = pal, marker = list(size=10))

d <- diamonds[sample(nrow(diamonds), 1000),]
d %>% dim()
plot_ly(d, x= ~carat, y= ~price, color = ~carat, size = ~carat)


## Styled Scatter Plot
plot_ly(data = iris, x = ~Sepal.Length, y = ~Petal.Length,
        marker = list(
          size = 10,
          color = 'rgba(255, 182, 193, .9)',
          line = list(color = 'rgba(152, 0, 0, .8)',
                      width = 2)))



### Line Plots
x <- c(1:100)
random_y <- rnorm(100, mean = 0)
data <- data.frame(x, random_y)
p <- plot_ly(data, x = ~x, y = ~random_y, mode = 'lines')
p



### Line Plots Mode
trace_0 <- rnorm(100, mean=5);trace_1 <- rnorm(100, mean=0);trace_2 <- rnorm(100, mean=-5)
x <- c(1:100)
data <- data.frame(x, trace_0, trace_1, trace_2)
p <- plot_ly(data, x = ~x, y = ~trace_0, name = 'trace 0', type = 'scatter', mode =
               'lines') %>%
  add_trace(y = ~trace_1, name = 'trace 1', mode = 'lines+markers') %>%
  add_trace(y = ~trace_2, name = 'trace 2', mode = 'markers')
p



### Basic Bar Chart
# Prepare data
cty_mpg <- aggregate(mpg$cty, by=list(mpg$manufacturer), FUN=mean) # aggregate
colnames(cty_mpg) <- c("make", "mileage") # change column names
p <- plot_ly(cty_mpg, x = ~make, y = ~mileage, type="bar")
p



### Stacked Bar Chart
data <- mpg %>% count(manufacturer, class)
plot_ly(data, x = ~manufacturer, y = ~n, color = ~class) %>%
  layout(yaxis = list(title = 'Count'), barmode = 'stack')



### Horizontal Bar Chart
data <- mpg %>% count(manufacturer, class)
plot_ly(data, x = ~n, y = ~manufacturer, color = ~class, orientation = 'h', type="bar") %>%
  layout(barmode = 'stack')



### Donut Chart
data <- mpg %>% count(manufacturer)
plot_ly(data, labels = ~manufacturer, values = ~n) %>%
  add_pie(hole = 0.6)




### Simple Bubble Chart
plot_ly(mtcars, x = ~disp, y = ~hp, text = rownames(mtcars), type = 'scatter', mode =
          'markers', marker = list(size = ~cyl*8, opacity = 0.5))


### Basic box plot
plot_ly(mpg, y = ~cty, type = "box")
### Adding Jittered Points
plot_ly(mpg, y = ~cty, type = "box", boxpoints = "all", jitter = 0.3, pointpos = -1.8)


### Several Box Plots
plot_ly(mpg, y = ~cty, color = ~manufacturer, type = "box")


### Basic Histogram
plot_ly(mpg, x = ~cty, type = "histogram")


### Basic Violin Plot
plot_ly(mpg, y = ~cty, type = 'violin')
plot_ly(mpg, y = ~cty, type = 'violin', box=list(visible=T), meanline=list(visible=T))


### Multiple Trace
plot_ly(mpg, x = ~class, y = ~cty, split = ~class, type = 'violin', box=list(visible=T),
        meanline=list(visible=T))

