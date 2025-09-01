# set seed
set.seed(123)

# random height data
# first-year students: mean = 168 cm, sd = 8, sample size = 20
# second-year students: mean = 172 cm, sd = 8, sample size = 20
first_year_heights <- rnorm(20, mean = 168, sd = 8)
second_year_heights <- rnorm(20, mean = 172, sd = 8)

# to dataframe
student_heights <- data.frame(
  height = c(first_year_heights, second_year_heights),
  year = factor(rep(c('First Year', 'Second Year'), each = 20))
)

# boxplot
boxplot(height ~ year, data = student_heights,
        main = 'Boxplot of Heights by Year',
        xlab = 'Student Year', ylab = 'Height (cm)')

# ranks
student_heights$rank <- rank(student_heights$height)

# boxplot
boxplot(rank ~ year, data = student_heights,
        main = 'Boxplot of Heights (Ranked) by Year',
        xlab = 'Student Year', ylab = 'Rank')

# mann-whitney 
wilcox.test(height ~ year, data = student_heights)

# random height data
# third-year students: mean = 170, sd = 8, sample size = 20
third_year_heights <- rnorm(20, mean = 170, sd = 8)

# to dataframe
student_heights <- data.frame(
  height = c(first_year_heights, second_year_heights, third_year_heights),
  year = factor(rep(c('First Year', 'Second Year', 'Third Year'), each = 20))
)

# boxplot
boxplot(height ~ year, data = student_heights,
        main = 'Boxplot of Heights by Year',
        xlab = 'Student Year', ylab = 'Height (cm)')

# ranks
student_heights$rank <- rank(student_heights$height)

# boxplot
boxplot(rank ~ year, data = student_heights,
        main = 'Boxplot of Heights (Ranked) by Year',
        xlab = 'Student Year', ylab = 'Rank')

# kruskal-wallis
kruskal.test(height ~ year, data = student_heights)

# means
mean_rank <- student_heights |> 
  group_by(year) |>
  summarise(mean_rank = mean(rank))
  
