#import "template.typ": *

#show: project.with(
  title: "Error Propagation",
  authors: (
    "Lumi",
  ),
  col_num: 2,
  date: "April 16, 2023"
)

#set math.equation(numbering: "(1)")
#set text(10pt)

= Introduction
Error and uncertainties are common in experiments. While we can control the error, uncertainties are just beyond our control.

= Classification of Errors

+ (accidental, stupid or intended) mistakes
+ systematic deviations
+ randome errors or _uncertainties_
Three types of errors are generally encountered during experiments. The first type of error caused by humans should definitely be avoided. The second type can be solved by careful thinking, so careful corroboration should be conducted before and during experiments.

The final type of error is inevitable. The uncertainties are caused by limited precision of instruments, or due to thermal noise.

We should be fully aware of these errors and and also learn to use them efficiently. (e.g. you don't have to use a complex instrument to measure your height).

= Error Propagation
As we pass multiple quantities through a function, the error will intuitively stack upon each other. But how do we express them? How will these errors contribute to the error of the output of the function?

The general rule for a single input function is:
$ sigma_f = |(dif f) / (dif x)| sigma_x $
The error of the output is simply the error of the input times it's derivative's absolute value.

If we happen to have multiple independent uncertainties, they follow the general equation:
$ sigma_f^2 = ((diff f)/(diff x))^2 sigma_x^2 + ((diff f)/(diff y))^2 sigma_y^2 + dots $
Beware of the circumstances when you can use this equation. The variables must be independent.This function simply don't work on dependent variables.

When working on dependent variables, we need to consider the covariance between the two variables.
#set text(8pt)
$ sigma_f^2 = ((diff f)/(diff x))^2 sigma_x^2 + ((diff f)/(diff y))^2 sigma_y^2 + 2 (diff f)/(diff x)(diff f)/(diff y) "cov"(x,y) dots $
#set text(10pt)

In a linear relationship, the equation $E[f(x)] = f(E[x])$ holds. If $f(x)$ is a nonlinear function, the equation does not hold. But because of the Taylor expansion, we can use it as an approximation.

= Monte Carlo Methods
The methods above are all centered around equation (1). But in certain cases, it's hard to find the derivative of a relationship. That's where the _Monte Carlo Method_ comes to the rescue. By computer simulations, we can take large number of variables in the given range following a specific distribution, and obtaining an interval for our final output of the function

You can also see the distortions due to the non-linear relationship between the input and the output from the Monte Carlo Method.