# set seed
set.seed(123)

# simulated height data (the heights are made up for this demonstration)
# UCL Year 2 Geography students: mean = 168 cm, sd = 8, sample size = 50
# KCL Year 2 Geography students: mean = 172 cm, sd = 8, sample size = 50
ucl_heights <- rnorm(50, mean = 168, sd = 8)
kcl_heights <- rnorm(50, mean = 172, sd = 8)

# to dataframe
student_heights <- data.frame(
  height = c(ucl_heights, kcl_heights),
  university = factor(rep(c('UCL', 'KCL'), each = 50), levels = c('UCL', 'KCL'))
)

# histogram
hist(student_heights[student_heights$university=='UCL',]$height,
     main = 'UCL', xlab = 'Height (cm)')
hist(student_heights[student_heights$university=='KCL',]$height,
     main = 'KCL', xlab = 'Height (cm)')

# boxplot
boxplot(height ~ university, data = student_heights,
        main = 'Boxplot of Heights by University',
        xlab = 'University', ylab = 'Height (cm)')

# t-test
t.test(height ~ university, data = student_heights)

# simulated height data for a third university
# LSE Year 2 Geography students: mean = 170 cm, sd = 8, sample size = 50
lse_heights <- rnorm(50, mean = 170, sd = 8)

# to dataframe
student_heights <- data.frame(
  height = c(ucl_heights, kcl_heights, lse_heights),
  university = factor(rep(c('UCL', 'KCL', 'LSE'), each = 50), levels = c('UCL', 'KCL', 'LSE'))
)

# boxplot
boxplot(height ~ university, data = student_heights,
        main = 'Boxplot of Heights by University',
        xlab = 'University', ylab = 'Height (cm)')

# anova
summary(aov(height ~ university, data = student_heights))

# tukey
TukeyHSD(aov(height ~ university, data = student_heights))
