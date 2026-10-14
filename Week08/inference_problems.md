# Homework 11: Bootstrap, CLT, and Normal Approximation

Use two-sided large-sample Normal tests and intervals throughout. Use the following critical values unless a problem says otherwise:

| Confidence Level | Significance Level$\alpha$ | Two-Sided Critical Value |
| :--------------: | :--------------------------: | :----------------------: |
|       90%       |             0.10             |          1.645          |
|       95%       |             0.05             |           1.96           |
|       99%       |             0.01             |          2.576          |

For Problems 4-6, assume independent random samples from the two groups and independent observations within each group.

1. A random sample has

   $$
   \bar{X}=52,\qquad s=10,\qquad n=100.
   $$

   Compute the estimated standard error of $\bar{X}$. Test

   $$
   H_0:\mu=50
   \qquad \text{vs.} \qquad
   H_1:\mu\ne 50
   $$

   at significance levels $\alpha=.10,.05,.01$ using the large-sample $z$-statistic. These correspond to 90%, 95%, and 99% confidence levels. Construct a 95% confidence interval for $\mu$.
2. A health survey compares a biomarker to a benchmark value of 12. The sample has

   $$
   \bar{X}=11.5,\qquad s=3,\qquad n=36.
   $$

   Is 12 a plausible value for the population mean? Construct a 95% confidence interval and compute the two-sided p-value for $H_0:\mu=12$ versus $H_1:\mu\ne12$. Assess plausibility using the interval and the test at $\alpha=.05$.
3. A real estate analyst compares the average price of a house in two neighborhoods.
   Group A:

   $$
   \bar{X}_A=25,\qquad s_A=8,\qquad n_A=100
   $$

   Group B:

   $$
   \bar{X}_B=22,\qquad s_B=7,\qquad n_B=100.
   $$

   Compute the two-sample $Z$-statistic for testing equality of means. Construct an approximate 95% confidence interval for $\mu_A-\mu_B$.

For the following data and scenarios (4-7):

- a. Generate at least $R=2{,}000$ nonparametric bootstrap estimates with a reproducible RNG. Report the seed and $R$. For two groups, resample independently within groups; for correlation, resample paired rows.
- b. Estimate the standard error $\widehat{SE}(\hat\theta)$ with the sample standard deviation of the bootstrap estimates (using denominator $R-1$, or `ddof=1`).
- c. Construct centered-Normal 90%, 95%, and 99% CIs: $\hat\theta \pm z^*\widehat{SE}(\hat\theta)$.
- d. Test the stated null using $z=(\hat\theta-\theta_0)/\widehat{SE}(\hat\theta)$ and $p=2\Phi(-|z|)$. Decide at $\alpha=.10,.05,.01$.
- e. Confirm that every test decision agrees with whether the matching CI contains $\theta_0$.
- f. Interpret the estimate, interval, and test in context. These are observational data: do not turn association into causation.

Use unrounded estimates and standard errors when computing intervals and tests. If a p-value is close to a decision threshold, increase $R$ (for example, to $100{,}000$, using batches if needed) to reduce Monte Carlo error. Small seed-dependent differences in results or borderline test decisions are acceptable when the procedure is correct and reproducible and you discuss the remaining simulation uncertainty. In particular, Problem 10 may be close to the 5% threshold.

4. For `./data/ames_prices.csv`, define an indicator equal to 1 when `Central.Air == 'Y'`. Estimate the proportion of homes with central air and test $H_0:p=.90$. Treat a proportion as the mean of a binary variable and complete the full inference routine.
5. For `./data/ames_prices.csv`, estimate the Pearson correlation between `arcsinh(area)` and `arcsinh(price)`. Bootstrap paired rows, construct all three CIs, and test $H_0:\rho=0$. Explain what would go wrong if area and price were resampled separately.
6. For `./data/metabric.csv`, use `Overall Survival (Months)` to estimate the mean recorded time to death or last follow-up, including both living and deceased patients. Let $\mu$ denote the population mean of this recorded-time variable, and test $H_0:\mu=120$ months. Complete the full inference routine and interpret the CIs in both months and years. Living patients' eventual death times are right-censored, so this exercise does not estimate unrestricted mean lifetime. Explain that distinction in your interpretation.
7. For `./data/nhanes_data_17_18.csv`, use `AgeInYearsAtScreening` to select respondents aged 18 or older with observed `SleepHoursWeekdaysOrWorkdays`. Estimate mean weekday sleep and test $H_0:\mu=8$ hours. Comment on whether statistical and practical significance tell the same story. For this exercise, treat observations as independent and unweighted, ignoring the complex survey design. Do not interpret these results as nationally representative population estimates or survey-adjusted confidence intervals.
