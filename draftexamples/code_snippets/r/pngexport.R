
# Create my_data
my_data <- mtcars

# Print the first 6 rows
head(my_data, 6)

# generate plot
plot(x = my_data$wt, y = my_data$mpg, pch = 16, frame = FALSE, xlab = "wt", ylab = "mpg", col = "#2E9FDF")

# open png file
png("rplot.png", width = 350, height = 350)

# create the plot
plot(x = my_data$wt, y = my_data$mpg, pch = 16, frame = FALSE, xlab = "wt", ylab = "mpg", col = "#2E9FDF")

# close the file
dev.off()
