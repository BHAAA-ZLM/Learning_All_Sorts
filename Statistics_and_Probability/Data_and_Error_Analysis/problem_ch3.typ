#import "template.typ": *

// Take a look at the file `template.typ` in the file panel
// to customize this template and discover how it works.
#show: project.with(
  title: "A Problem",
  authors: (
    "Lumi",
  ),
)

#set math.equation(numbering: "(1)")

// We generated the example code below so you can see how
// your document will look. Go ahead and replace it with
// your own content!

Hello, Prof. Chen

#h(20pt) I was reading a book about statics called _A Student's Guide to Data and Error Analysis_, and in the book, I encountered a part about propagating error along functions. It says:

#line(length: 100%)

#h(20pt) _If the stadandard uncertainty in x equals $sigma_x$, then the standard uncertainty $sigma_f$ in $f(x)$ equals:_

$ sigma_f = |(dif f) / (dif x)| sigma_x $


#line(length: 100%)

#h(20pt) And then, the author gives a table of equations (supposing $x "and" y$ are independent):

#line(length: 100%)
#set align(center)
#table(
  columns: (auto, auto),
  align: horizon,
  [$f = x plus.minus y$],[$sigma_f^2 = sigma_x^2 + sigma_y^2$],
  [$f = x y^n "or" f = x\/y^n$], [$(sigma_f \/f)^2 = (sigma_x \/x)^2 + n^2(sigma_y \/y)^2$]
)
#line(length: 100%)
#set align(left)

#h(20pt)Finally, the book gives a general formula:
#line(length: 100%)
#h(20pt)_For a function of independent variables:_
$ sigma_f^2 = ((diff f)/(diff x))^2 sigma_x^2 + ((diff f)/(diff y))^2 sigma_y^2 + dots $

_If the variables are not independent, then another equation involving the covariance should be used:_
$ sigma_f^2 = ((diff f)/(diff x))^2 sigma_x^2 + ((diff f)/(diff y))^2 sigma_y^2 + 2 (diff f)/(diff x)(diff f)/(diff y) "cov"(x,y) dots $
#line(length: 100%)

#h(20pt)The problem was with one of it's examples. Which was calculating the reaction coefficient $K$ for a dimerization reaction $2upright(A) harpoons.rtlb upright(A)_2$, which should be: 
$ K = [upright(A)_2]/[upright(A)]^2 $

#h(20pt)He then says it's sometimes easier to measure the total concentration of $[upright(A)] + 2[upright(A)_2]$ and $[upright(A)_2]$. So he introduced two variables to describe them.
$ x = [upright(A)] + 2[upright(A)_2] ; space space  y = [upright(A)_2] $

#h(20pt)Thus we can re-write $K$ as $ K = y/(x-2y)^2 $
#h(20pt) Then in the book, it directly tells you that $ sigma_K^2 = (x-2y)^(-6)(4y^2 sigma_x^2 + (x + 2y)^2 sigma_y^2) $

#h(20pt)I got a bit interested and decided to calculate this s.d. myself, with equation (2), we can easily get:
$ 
  (diff K)/(diff x) = - 2y/(x-2y)^3 \
  (diff K)/(diff y) = (x + 2y)/(x - 2y)^3 \
  sigma_K^2 &= ( - 2y/(x-2y)^3)^2 sigma_x^2 + ((x + 2y)/(x - 2y)^3)^2 sigma_y^2 \
  &=(x-2y)^(-6)(4y^2 sigma_x^2 + (x + 2y)^2 sigma_y^2)
$

#h(20pt)Hmmm, seems that we can't use the equations in the table can't be used directly because the numerator and denominator are not independent. I will try the equation very soon.