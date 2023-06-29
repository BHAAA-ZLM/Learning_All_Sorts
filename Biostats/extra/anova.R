head(iris)
boxplot(Sepal.Length ~ Species, data = iris)
boxplot(Sepal.Width ~ Species, data = iris)
aov(Sepal.Width ~ Species, data = iris)
res = aov(Sepal.Width ~ Species, data = iris)
summary(res)
iris$Sepal.Width
iris$Species
pairwise.t.test(iris$Sepal.Width, iris$Species, p.adjust.method = 'bonferron')
pairwise.t.test(iris$Sepal.Width, iris$Species, p.adjust.method = 'none')
t.test(Sepal.Width ~ Species, data = iris[51:150,])
t.test(Sepal.Width ~ Species, data = iris[51:150,], var.equal =TRUE)