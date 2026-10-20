# Three ways to bootstrap with code

Every bootstrap does the same thing: draw n rows WITH replacement from your n rows, recompute the
statistic, repeat R times, and look at the spread of the R values (its SD is the bootstrap SE).
The three methods below differ only in HOW they draw the rows.

 - Method 1  
   - pandas .sample(frac=1.0, replace=True)      
   - Week 6 Tuesday (bootstrapping), Lab 6, A/B testing bridge
 - Method 2  
   - np.random.randint(0, n, n) -> .iloc[idx]    
   - Week 8 inference notebooks
 - Method 3  
   - rng.integers(0, n, size=(R, n))             
   - Lab 7 extra help (and the Week 4 rng notebook)
 - Other options
   - rng.choice

By the way, Methods 1 and 3 give identical numbers because pandas.sample(replace=True, random_state=rng) calls rng.integers(0, n, size=n) under the hood, so 5,000 calls of size n use the same random stream as one (5,000, n) draw. Method 2 uses numpy's older random generator, so its draws (and computes its SE) differ slightly.

```
import os
import numpy as np
import pandas as pd
R = 5_000
```

## Before the bootstrap: sampling from a distribution you KNOW (Weeks 4–5)
Where `rng` first showed up (`rng.ipynb`, `cdf_and_pdf.ipynb`, `kernel_densities.ipynb`, Lab 5). There was no data yet: we told numpy the distribution, drew samples from it, and watched how a statistic behaves across many samples. That is **simulation** (Monte Carlo), and it is the same move the bootstrap makes later.
- Make one stream with `rng = np.random.default_rng(seed)`, then draw everything from it
- Draw B samples of size K at once with `size=(B, K)`: each **row** is one simulated sample, so `.mean(axis=1)` gives B sample means. This is where Method 3's `(R, n)` matrix comes from
- Or use a loop that appends one sample at a time (the first version in `rng.ipynb`). Same numbers, just slower

```
rng = np.random.default_rng(100)
K, B = 100, 5_000

# Integers: a fair die. integers(low, high) EXCLUDES high, so 1..6 needs (1, 7)
rolls = rng.integers(1, 7, size=(B, K))
rolls.mean(axis=1).std()                 # ≈ 0.171 = sqrt(35/12) / sqrt(100)

# Normal: standard normal draws
z = rng.standard_normal(size=(B, K))     # or rng.normal(loc=mu, scale=sd, size=(B, K))
z.mean(axis=1).std()                     # ≈ 0.100 = 1 / sqrt(100)

# Choice with probabilities: categories with a PMF p
rng.choice(cars, size=1000, p=p)         # the car-brand example

# Bernoulli and binomial: yes/no trials
flips  = rng.binomial(1, 0.1, size=(B, 200))   # B samples of 200 individual 0/1 trials
counts = rng.binomial(200, 0.1, size=B)        # B success counts out of 200, in one step
# flips.sum(axis=1) and counts have the same distribution
```

**From simulation to the bootstrap.** In real life we don't know the distribution, only our n data points. The bootstrap uses the data's own **empirical distribution** in its place: each observed value gets probability 1/n, and we sample n values from it with replacement. We've done 3 different methods to do this resampling.

## Method 1: pandas .sample()
Resample whole ROWS of a DataFrame (or values of a Series)
- frac=1.0 means "draw n rows" (same as .sample(len(df), replace=True), which the A/B bridge used)
- replace=True is what makes it a bootstrap: without it you just get the same rows shuffled
- Seeding: pass random_state=rng to make it reproducible. Our Week 6 notebooks made an rng but never passed it to .sample(), so those results change every run.

```
rng = np.random.default_rng(5030)
reps_1 = []
for r in range(R):
    df_r = df.sample(frac=1.0, replace=True, random_state=rng)
    reps_1.append(df_r['Overall Survival (Months)'].mean())
reps_1 = np.array(reps_1)
```

## Method 2: np.random.randint() indices + .iloc
Draw n random row positions from 0, 1, ..., n-1 (randint excludes the upper bound n),
then pull those rows. Using the SAME idx for every column keeps rows together, which is what
you want for a regression: mlr(X.iloc[idx], y.iloc[idx]).
This is numpy's older "global" random state. np.random.seed() once, ABOVE the loop, makes the
whole run reproducible while every resample is still different.

```
np.random.seed(5030)
reps_2 = []
for r in range(R):
    idx = np.random.randint(0, n, n)
    reps_2.append(x.iloc[idx].mean())
reps_2 = np.array(reps_2)
```

## Method 3: rng.integers() with an (R, n) matrix of indices
Same idea as Method 2, but with the newer Generator (rng) and all R resamples drawn at once: row r of idx is the r-th bootstrap sample's row positions. No loop needed when the statistic can be computed along axis=1 (means, proportions, SDs). This works with a numpy array (x.to_numpy()), since x_np[idx] indexes by position.

```
rng = np.random.default_rng(5030)
x_np = x.to_numpy()
idx = rng.integers(0, n, size=(R, n))
reps_3 = x_np[idx].mean(axis=1)
# For a statistic that isn't vectorized (like a regression), Loop over the rows of idx:
# reps = np.array([mlr(X.iloc[i], y.iloc[i]) for i in idx])
```

## Also fine: rng.choice()
```
rng.choice(x_np, size=n, replace=True) draws values directly instead of indices.
```

This is equivalent for a single column; for several columns, draw indices (Methods 2 and 3) so rows stay together.
