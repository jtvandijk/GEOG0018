# set seed
set.seed(123)

# random height data
# first-year students: mean = 168 cm, sd = 8, sample size = 50
# second-year students: mean = 172 cm, sd = 8, sample size = 50
first_year_heights <- rnorm(50, mean = 168, sd = 8)
second_year_heights <- rnorm(50, mean = 172, sd = 8)

# to dataframe
student_heights <- data.frame(
  height = c(first_year_heights, second_year_heights),
  year = factor(rep(c('First Year', 'Second Year'), each = 50))
)

# boxplot
boxplot(height ~ year, data = student_heights,
        main = 'Boxplot of Heights by Year',
        xlab = 'Student Year', ylab = 'Height (cm)')

# t-test
t.test(height ~ year, data = student_heights)

# random height data
# third-year students: mean = 170, sd = 8, sample size = 50
third_year_heights <- rnorm(50, mean = 170, sd = 8)

# to dataframe
student_heights <- data.frame(
  height = c(first_year_heights, second_year_heights, third_year_heights),
  year = factor(rep(c('First Year', 'Second Year', 'Third Year'), each = 50))
)

# boxplot
boxplot(height ~ year, data = student_heights,
        main = 'Boxplot of Heights by Year',
        xlab = 'Student Year', ylab = 'Height (cm)')

# anova
summary(aov(height ~ year, data = student_heights))

# tukey
TukeyHSD(aov(height ~ year, data = student_heights))
