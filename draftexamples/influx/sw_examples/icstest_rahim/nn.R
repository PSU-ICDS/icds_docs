library(neuralnet)
library(ggplot2)
library(nnet)
library(dplyr)
library(reshape2)

data("iris")

set.seed(123)


labels <- class.ind(as.factor(iris$Species))

standardiser <- function(x){
  (x-min(x))/(max(x)-min(x))
}


iris[, 1:4] <- lapply(iris[, 1:4], standardiser)

pre_process_iris <- cbind(iris[,1:4], labels)

f <- as.formula("setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width")
f

iris_net <- neuralnet(f, data = pre_process_iris, hidden = c(16, 12), act.fct = "tanh", linear.output = FALSE)

plot(iris_net)


##origi_vals <- max.col(pre_process_iris[, 5:7])
##print(paste("Model Accuracy: ", round(mean(pr.nn_2==origi_vals)*100, 2), "%.", sep = ""))
"Model Accuracy: 100%."
