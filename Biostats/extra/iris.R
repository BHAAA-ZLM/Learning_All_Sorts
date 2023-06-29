setwd('/Users/lumizhang/Documents/sustech/biology/classes/Biostatistics/extra')

# In R, you can check the annotations for a function using ?function()

# Read data with read.csv() function
iris <- read.csv('iris.csv', header = T)

# Draw boxplots to get a general view for the data
boxplot(SepalWidthCm ~ Species, data = iris)

# Perform ANOVA to check are the mean of Sepal Width between species
res <- aov(SepalWidthCm ~ Species, data = iris)
summary(res)

# Perform pairwise T-tests
pairwise.t.test(iris$SepalWidthCm, iris$Species, p.adjust.method = "bonferroni")
#t.test(SepalWidthCm ~ Species, data = iris)
# Error in t.test.formula(SepalWidthCm ~ Species, data = iris) : 
#   grouping factor must have exactly 2 levels

# Perform T-test in the sepcies versicolor and virginica
t.test(SepalWidthCm ~ Species, data = iris[51:150,])
t.test(SepalWidthCm ~ Species, data = iris[iris$Species %in% c("Iris-versicolor", "Iris-virginica"),])

# Adjust T-test with the mean square within
mean_versi <- mean(iris[iris$Species %in% "Iris-versicolor",]$SepalWidthCm)
mean_virgini <- mean(iris[iris$Species %in% "Iris-virginica",]$SepalWidthCm)
msw <- 0.116
pt((mean_versi - mean_virgini)/sqrt(msw * (1/25)), 98)

lm(iris$SepalLengthCm~iris$SepalWidthCm)
a <- plot(iris$SepalLengthCm, iris$SepalWidthCm, pch = 20)
b <- curve(-0.2089 * x + 6.4812, xlim = c(4,6), ylim = c(4,6) )
a + b
