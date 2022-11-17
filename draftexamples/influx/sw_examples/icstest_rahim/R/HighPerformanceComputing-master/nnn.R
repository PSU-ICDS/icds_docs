
library(neuralnet)
library(ggplot2)
library(nnet)
library(dplyr)
library(reshape2)
#a=Sys.time()
data("iris")

set.seed(123)

a=Sys.time()

labels <- class.ind(as.factor(iris$Species))
View(labels)

standardiser <- function(x){(x-min(x))/(max(x)-min(x))}


iris[, 1:4] <- lapply(iris[, 1:4], standardiser)
c=Sys.time()-a
c

pre_process_iris <- cbind(iris[,1:4], labels)

f <- as.formula("setosa + versicolor + virginica ~ Sepal.Length + Sepal.Width + Petal.Length + Petal.Width")

iris_net <- neuralnet(f, data = pre_process_iris, hidden = c(16,12), act.fct = "tanh", linear.output = FALSE)

plot(iris_net)
print(iris_net)

iris_preds <- compute(iris_net, pre_process_iris[, 1:4])
origi_vals <- max.col(pre_process_iris[, 5:7])
pr.nn_2 <- max.col(iris_preds$net.result)
print(paste("Model Accuracy: ", round(mean(pr.nn_2==origi_vals)*100, 2), "%.", sep = ""))

b=Sys.time()-a

