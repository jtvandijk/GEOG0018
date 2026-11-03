# set seed
set.seed(123)

# random data
# study hours, attendance (%), final grade
study_hours <- rnorm(150, mean = 15, sd = 5)
attendance_rate <- rnorm(150, mean = 70, sd = 8)
final_grade <- 5 + 1.2 * study_hours + 0.6 * attendance_rate + rnorm(150, mean = 0, sd = 6)

# to dataframe
student_data <- data.frame(
  final_grade = final_grade,
  study_hours = study_hours,
  attendance_rate = attendance_rate
)

# scatterplot
plot(student_data$study_hours, student_data$final_grade,
     main = 'Final Grade vs Study Hours',
     xlab = 'Study Hours', ylab = 'Final Grade')

# linear regression
lm1 <- lm(final_grade ~ study_hours, data = student_data)
summary(lm1)

# multiple regression
lm2 <- lm(final_grade ~ study_hours + attendance_rate, data = student_data)
summary(lm2)

# check the assumptions
performance::check_model(lm2)
