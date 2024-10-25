# normal distribution
set.seed(123)
data <- rnorm(1000, mean=0, sd=1)

# histogram 
hist(data, probability=TRUE, main='Histogram with Normal Distribution Curve', 
     xlab='Z-scores', border='white', col='white', xlim=c(-4, 4), ylim=c(0, 0.45))

# add normal distribution curve
x <- seq(-4, 4, length=100)
y <- dnorm(x, mean=0, sd=1)
lines(x, y, col='#A1112A', lwd=2)

# add z-scores
abline(v=c(-1, 1), col='#636363', lwd=2, lty=4) 
abline(v=c(-2, 2), col='#636363', lwd=2, lty=2)

# area under the curve
polygon(c(-3, seq(-3, 3, length=100), 3), c(0, dnorm(seq(-3, 3, length=100)), 0), col='#bdbdbd', border=NA)
polygon(c(-2, seq(-2, 2, length=100), 2), c(0, dnorm(seq(-2, 2, length=100)), 0), col='#969696', border=NA)
polygon(c(-1, seq(-1, 1, length=100), 1), c(0, dnorm(seq(-1, 1, length=100)), 0), col='#737373', border=NA)
lines(x, y, col='#A1112A', lwd=2)

