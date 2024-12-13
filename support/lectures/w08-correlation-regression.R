# library
library(stargazer)
library(easystats)

# set seed
set.seed(123)

# data points
n <- 200

# positive correlation
x_pos <- seq(0, 50, length.out = n)
y_pos <- x_pos + rnorm(n, mean = 10, sd = 5)  

# negative correlation
x_neg <- seq(50, 0, length.out = n)
y_neg <- x_neg * -1 + 60 + rnorm(n, mean = 0, sd = 5)  

# no correlation
x_none <- rnorm(n, mean = 35, sd = 10)
y_none <- rnorm(n, mean = 35, sd = 10)

# realistic correlation
x_real <- seq(0, 50, length.out = n)
y_real <- x_real + rnorm(n, mean = 10, sd = 15)  

# range
x_range <- range(c(x_pos, x_neg, x_none))
y_range <- range(c(y_pos, y_neg, y_none))

# positive correlation
plot(x_pos, y_pos, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)

# negative correlation
plot(x_neg, y_neg, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)

# no correlation
plot(x_none, y_none, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)

# realistic correlation
plot(x_real, y_real, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)

# covariance, regression parameters
c <- 20
p <- 14
l_pos  <- lm(y_pos ~ x_pos)
l_none <- lm(y_none ~ x_none)
l_real <- lm(y_real ~ x_real)
l_mult <- lm(y_pos ~ x_pos + x_none)
x_real <- seq(0, 50, length.out = c)
y_real <- x_real + rnorm(c, mean = 10, sd = 10)  
x_mean <- mean(x_real)
y_mean <- mean(y_real)
l_pred <- predict(l_real)

# variance X
plot(x_real, y_real, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(v = x_mean, col = '#A1112A', lty = 2)
arrows(x_real[p], y_real[p], x_mean, y_real[p], length = 0.10)
points(x_real[p], y_real[p], pch = 19, col = '#A1112A', cex = 2)

# variance Y
plot(x_real, y_real, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(h = y_mean, col = '#A1112A', lty = 2)
arrows(x_real[p], y_real[p], x_real[p], y_mean, length = 0.10)
points(x_real[p], y_real[p], pch = 19, col = '#A1112A', cex = 2)

# variance both
plot(x_real, y_real, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(v = x_mean, col = '#A1112A', lty = 2)
abline(h = y_mean, col = '#A1112A', lty = 2)
arrows(x_real[p], y_real[p], x_real[p], y_mean, length = 0.10)
arrows(x_real[p], y_real[p], x_mean, y_real[p], length = 0.10)
points(x_real[p], y_real[p], pch = 19, col = '#A1112A', cex = 2)

# regression null
plot(x_real, y_real, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(h = y_mean, col = '#A1112A', lty = 2)

# error
plot(x_real, y_real, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(h = y_mean, col = '#A1112A', lty = 2)
arrows(x_real[p], y_real[p], x_real[p], y_mean, length = 0.10)
points(x_real[p], y_real[p], pch = 19, col = '#A1112A', cex = 2)

# sum squared errors 
p <- c(2,3,4,6,7,8,9,10,11,12,13,14,15,16,17,18,19)
plot(x_real, y_real, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(h = y_mean, col = '#A1112A', lty = 2)
arrows(x_real[p], y_real[p], x_real[p], y_mean, length = 0.10)
points(x_real[p], y_real[p], pch = 19, col = '#A1112A', cex = 2)

# regression line
plot(x_real, y_real, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(l_real, col = '#A1112A', lty = 2)
arrows(x_real[p], y_real[p], x_real[p], l_pred[p], length = 0.10)
points(x_real[p], y_real[p], pch = 19, col = '#A1112A', cex = 2)

# model fit - none
plot(x_none, y_none, xlab = 'X', ylab = 'Y', 
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(l_none, col = '#A1112A', lty = 2)

# model fit - positive
plot(x_pos, y_pos, xlab = 'X', ylab = 'Y',
     xlim = x_range, ylim = y_range, pch = 19, lwd = 5)
abline(l_pos, col = '#A1112A', lty = 2)

# model fit
stargazer(l_none, type = 'latex', out = 'support/w08-lm-none.tex')
stargazer(l_pos, type = 'latex', out = 'support/w08-lm-pos.tex')
stargazer(l_mult, type = 'latex', out = 'support/w08-lm-mult.tex')

# assumptions
y <- y_pos
x <- x_pos
z <- x_none
l_multi <- lm(y ~ x + z)
performance::check_model(l_mult, check = c('linearity','homogeneity'))
