sample <- rnorm(1000)
head(sample)

hist(sample, prob=T) # prob:상대도수

curve(dnorm, -4, 4, add = T, col="red") # add: 기존 그래프위에 그리기

qqnorm(sample, col="red")

# y=a+bx => a b line
abline(0,1)

