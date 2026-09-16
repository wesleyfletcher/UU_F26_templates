# Problems: Categorical and Numeric Variables

**Q1.**

Consider the data:
` [ red, blue, blue, red, green, grey] `

- a. Represent these data as a matrix of one hot encoded variables
- b. Compute the sample proportions for each label

Consider the data: 
$$
X = [ 1, 3, 3, 6, 11 ]
$$

- c. Compute and sketch the empirical CDF for this sample.


**Q2.**

We often want to take transformations of random variables, particularly when doing feature engineering.

- a. Suppose we have a random variable $X$ and transform it as $Y = a + b X$, with $b>0$. The distribution of $X$ is given by $F_X(x)$. What is the distribution of $Y$, $F_Y(y)$? What is the density, $f_Y(y)$?

Suppose your sample is:
$$
X = [ 1, 3, 4 ]
$$

- b. What is the mean of the sample?
- c. Square all the values. What the mean of $X^2$?
- d. Compute the square of the mean from part b. Does this equal the mean of the square from part c?

Non-linear transformations change the moments/statistics of the data in a non-linear way. This is important to remember.

**Q3.**

The **exponential distribution** is
$$
F(x) = \begin{cases}
0, & x < 0\\
1-e^{-x}, & x \ge 0
\end{cases}
$$

- a. Sketch a graph of the exponential distribution and density.
- b. What is the probability that $X \ge 3$? What is the probability that $X \le 35$?
- c. Suppose we transform $X$ by $ Y = 1 + 3X$. What is the distribution of $Y$, $F_Y(y) = pr[ Y \le y]$? Provide a formula and sketch a graph in comparison to $F_X$. What is the probability that $Y$ is less than 10?

**Q4.**

The **logistic distribution** is
$$
F(x) = \dfrac{1}{1+e^{-x}}
$$

- a. Sketch a graph of the logistic distribution and density.
- b. What is the probability that $X \ge .8$? What is the probability that $X \le .3$?
- c. Suppose we transform $X$ by $ Y = 2X-1$. What is the distribution of $Y$? Provide a formula and sketch a graph. What is the probability that $Y$ is less than 0?

**Q5.**

The **median** is the value $x$ for which the probability that $X$ is above or below $x$ is $.5$, or $F(\text{median})= \frac{1}{2}.$

- a. What is the median of the exponential distribution?
- b. What is the median of the logistic distribution?

The **quantile function** is the inverse of the distribution function. The CDF answers the question, "What fraction $u$ of the time is $X$ below $x$?" ($F(x)=u$) and the quantile function answers the question, "For what value $x$ is $X$ below $x$ with probability $u$?" ($F^{-1}(u)=x$)

- c. What is the quantile function of the exponential distribution? 
- d. What is the quantile function of the logistic distribution?

**Q6.**

Load `./data/metabric.csv`.

- a. Make an ECDF plot of `Overall Survival (Months)`. 
- b. Make an ECDF plot of `Overall Survival (Months)`, hued by `Chemotherapy`. Conditional on a patient receiving Chemotherapy, should we predict they will live a longer or shorter amount of time? Explain your answer clearly. 
- c. Is chemotherapy an effective treatment? Explain your answer clearly.