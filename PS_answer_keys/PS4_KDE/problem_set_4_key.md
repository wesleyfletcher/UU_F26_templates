# PROBLEM SET 4: Kernel Density Estimation

Answer key for `UU_F26_templates/Week05/problem_set_4.md`. Figures: `problem_set_4_KEY_p1.png`, `problem_set_4_KEY_p3.png`, `problem_set_4_KEY_p4.png`.

Conventions follow `kernel_densities.ipynb`: uniform kernel with a **strict** window, $\hat f_h(x)=\dfrac{\#\{i:|x_i-x|<h\}}{2nh}$; Gaussian kernel $\hat f_h(x)=\dfrac{1}{nh}\sum_i\varphi\!\left(\frac{x-x_i}{h}\right)$; `np.std` (ddof = 0) in Silverman's rule.

---

## Problem 1 (20 pt)

 — $X=[1,\ 1.75,\ 2,\ 3,\ 3.25,\ 4]$, $n=6$

**a. (5pt)** ECDF: staircase from 0 to 1 with a jump of $1/6$ at each of the six distinct values. Left panel of the p1 figure.

$$
F_6(x)=\begin{cases}
0,&x<1\\ 1/6,&1\le x<1.75\\ 2/6,&1.75\le x<2\\ 3/6,&2\le x<3\\
4/6,&3\le x<3.25\\ 5/6,&3.25\le x<4\\ 1,&x\ge 4
\end{cases}
$$

**b. (5pt)** $h=0.2$, so each point contributes height $\dfrac{1}{2nh}=\dfrac{1}{2(6)(0.2)}=0.4167$ over its window $(x_i-0.2,\ x_i+0.2)$. Middle panel.

| window                                          | height |
| ----------------------------------------------- | ------ |
| $(0.8,1.2)$                                   | 0.4167 |
| $(1.55,1.8)$                                  | 0.4167 |
| $(1.8,1.95)$ — windows of 1.75 and 2 overlap | 0.8333 |
| $(1.95,2.2)$                                  | 0.4167 |
| $(2.8,3.05)$                                  | 0.4167 |
| $(3.05,3.2)$ — windows of 3 and 3.25 overlap | 0.8333 |
| $(3.2,3.45)$                                  | 0.4167 |
| $(3.8,4.2)$                                   | 0.4167 |
| everywhere else                                 | 0      |

Six disjoint-ish blocks, two of which overlap to double height. Total area $= 6\times 2(0.2)\times0.4167=1$. ✓

**c. (2 pt)** $\bar X=2.5$, $\mathrm{sd}(X)=1.010363$ (ddof = 0), $n^{-0.2}=6^{-0.2}=0.69882$.

$$
h=1.84\times1.010363\times6^{-0.2}=\boxed{1.2992}
$$

*(With `pandas`' default ddof = 1, $\mathrm{sd}=1.106797$ and $h=1.4232$. The notebook's `np.std` gives ddof = 0; either is defensible if stated.)*

**d. (5pt)** $h=1.2992$, so each point contributes $\dfrac{1}{2nh}=0.06414$ over a window of width $2h=2.598$. The windows overlap heavily, giving one connected blocky mound. Right panel.

| region             | count | $\hat f_h$ |
| ------------------ | ----- | ------------ |
| $[-0.299,0.451)$ | 1     | 0.0641       |
| $[0.451,0.701)$  | 2     | 0.1283       |
| $[0.701,1.701)$  | 3     | 0.1924       |
| $[1.701,1.951)$  | 4     | 0.2566       |
| $[1.951,2.299)$  | 5     | 0.3207       |
| $[2.299,2.701)$  | 4     | 0.2566       |
| $[2.701,3.049)$  | 5     | 0.3207       |
| $[3.049,3.299)$  | 4     | 0.2566       |
| $[3.299,4.299)$  | 3     | 0.1924       |
| $[4.299,4.549)$  | 2     | 0.1283       |
| $[4.549,5.299)$  | 1     | 0.0641       |

**e. (3pt)** $h=0.2$ is far too small: the windows barely overlap, so the estimate is six spikes of height 0.417 separated by regions of exactly zero density. It reproduces the sample rather than estimating the population — high variance, low bias, and it claims zero probability between the observed points.

$h=1.299$ (Silverman) is about $6.5\times$ wider. The windows overlap, the spikes merge into one connected mound peaking around $x\in[2,3]$, and the maximum height drops from 0.833 to 0.321. It smooths — low variance, higher bias — and gives a plausible unimodal shape, though at this $n$ it is wide enough to spread mass out to $x\approx-0.3$ and $5.3$, past the data range.

Both integrate to 1; the difference is entirely how that area is distributed.

---

## Problem 2 (25 pt)

— $X=[-1,-0.5,0,0.5,1]$ drawn from $N(0,1)$

**a. (3 pt)** $h=0.6$, $n=5$. Points within 0.6 of 0: $-0.5,\ 0,\ 0.5$ (the $\pm1$ are 1.0 away, outside). So

$$
\hat f_{0.6}(0)=\frac{3}{2(5)(0.6)}=\frac{3}{6}=\boxed{0.5}
$$

**b. (3 pt)** *(This first answer was not taught in class but is a fair way to do it.)* Each $X_i\sim N(0,1)$ independently, so the terms are identically distributed and the $n$ cancels.

$$
\mathbb{E}\!\left[\hat f_h(0)\right]
=\frac{1}{2h}\,\mathbb{P}\!\left(|X|<h\right)
=\frac{2\Phi(h)-1}{2h}.
$$

At $h=0.6$: $\Phi(0.6)=0.725747$, so $\mathbb{P}(|X|<0.6)=0.451494$ and

$$
\mathbb{E}\!\left[\hat f_{0.6}(0)\right]=\frac{0.451494}{1.2}=\boxed{0.376245}
$$

*Alternative without $\Phi$ (numerical area).* $\mathbb{P}(|X|<h)$ is the area under $\varphi(x)=e^{-x^2/2}/\sqrt{2\pi}$ on $(-h,h)$.  $\varphi(0)=0.398942$, $\varphi(0.3)=0.381388$, $\varphi(0.6)=0.333225$:

$$
\int_0^{0.6}\varphi(x)\,dx\approx\frac{0.3}{3}\big[0.398942+4(0.381388)+0.333225\big]=0.225772
$$

$$
\mathbb{P}(|X|<0.6)\approx2(0.225772)=0.451544,\qquad
\mathbb{E}\!\left[\hat f_{0.6}(0)\right]\approx\frac{0.451544}{1.2}=0.3763
$$

A fine-grid sum in code (e.g. `np.mean(phi(np.linspace(-0.6, 0.6, 100001)))`) gives $0.376245$. Accept either.

*Alternative using the ECDF.* Some students will replace the true CDF with the ECDF of the five data points:

$$
\mathbb{P}(|X|<0.6)\approx\hat F_5(0.6)-\hat F_5(-0.6)=\frac45-\frac15=\frac35,\qquad
\mathbb{E}\!\left[\hat f_{0.6}(0)\right]\approx\frac{3/5}{1.2}=0.5
$$

**Note:** this isn't quite correct. The expectation is over the true $N(0,1)$ distribution, and plugging in the ECDF of the same sample just returns the realized value from (a), so it can't reveal bias in (d). Don't take off points for it; give full credit if the student carries it through consistently.

**c. (3pt)** $f(0)=\dfrac{1}{\sqrt{2\pi}}=\boxed{0.398942}$

**d.**  (5 pt) Not equal: $0.376245$ vs. $0.398942$, a bias of $-0.022698$. The estimator is **biased**, and biased *downward* at this point. The uniform kernel replaces $f(0)$ with the average of $f$ over the window $(-0.6,0.6)$; since $x=0$ is the peak of the normal density, every other point in the window has lower density, so the average must fall below the peak. Smoothing flattens peaks (and fills in valleys).

**e. (5 pt)** At $h=0.1$: $\Phi(0.1)=0.539828$, $\mathbb{P}(|X|<0.1)=0.079656$,

$$
\mathbb{E}\!\left[\hat f_{0.1}(0)\right]=\frac{0.079656}{0.2}=0.398278,
\qquad \text{bias}=-0.000664 .
$$

The gap shrinks by a factor of about 34 when $h$ drops from 0.6 to 0.1. As $h\to0$ the window average converges to the value at the center, so bias $\to 0$. (The bias is $O(h^2)$ here, consistent with $0.0227/0.000664\approx34\approx(0.6/0.1)^2$.)

**f. (3 pt)** Yes, **consistent — but only if $h$ shrinks as $n$ grows.** Two things must go to zero together:

- Bias $\to0$ requires $h_n\to0$ (part e).
- Variance $\to0$ requires $nh_n\to\infty$, so the expanding sample keeps putting more points inside the shrinking window.

Silverman's $h_n\propto n^{-1/5}$ satisfies both: $h_n\to0$, and $nh_n\propto n^{4/5}\to\infty$. Then $\hat f_{h_n}(x)\to f(x)$ in probability. Held at a *fixed* $h$, the estimator is not consistent — the bias in part d never goes away no matter how large $n$ is. This is the course's first estimator that is biased at every sample size yet still consistent.

**g.** (3pt)The bias–variance trade-off, which is exactly the contrast in Problem 1e:

- **$h$ too small** → low bias, high variance: the estimate chases individual observations and is spiky and unreproducible (see Problem 4b's resampled curves).
- **$h$ too large** → low variance, high bias: peaks flatten, valleys fill, real structure (like a second mode) gets smoothed away.

Practical considerations: start from a plug-in rule (Silverman, $1.84\,\mathrm{sd}\,n^{-1/5}$ for the uniform kernel), then check sensitivity by re-plotting at $h/3$ and $3h$; use cross-validation when the choice matters; and remember $h$ has the units of the data, so it must be rescaled if the variable is.

---

## Problem 3 (25 pt)

— $X=[5,7,7,8,10]$, $h=1.5$, $n=5$

**a.** $\hat f_h(x)=\dfrac{\text{count within }1.5}{2(5)(1.5)}=\dfrac{\text{count}}{15}$.

| $x$ | distances to 5, 7, 7, 8, 10                          | count | $\hat f_h(x)$ |
| ----- | ---------------------------------------------------- | ----- | --------------- |
| 6.0   | 1.0, 1.0, 1.0, 2.0, 4.0                              | 3     | $3/15=0.2000$ |
| 6.5   | **1.5**, 0.5, 0.5, **1.5**, 3.5          | 2     | $2/15=0.1333$ |
| 7.0   | 2.0, 0, 0, 1.0, 3.0                                  | 3     | $3/15=0.2000$ |
| 8.0   | 3.0, 1.0, 1.0, 0, 2.0                                | 3     | $3/15=0.2000$ |
| 8.5   | 3.5,**1.5**, **1.5**, 0.5, **1.5** | 1     | $1/15=0.0667$ |

**b.** $\hat f_h(x)=\dfrac{1}{5(1.5)}\sum_i\varphi\!\left(\dfrac{x-x_i}{1.5}\right)=\dfrac{1}{7.5}\sum_i\varphi(z_i)$.

| $x$ | $\varphi(z)$ for 5, 7, 7, 8, 10      | sum     | $\hat f_h(x)$   |
| ----- | -------------------------------------- | ------- | ----------------- |
| 6.0   | .31945, .31945, .31945, .16401, .01140 | 1.13376 | **0.15117** |
| 6.5   | .24197, .37738, .37738, .24197, .02622 | 1.26492 | **0.16866** |
| 7.0   | .16401, .39894, .39894, .31945, .05399 | 1.33533 | **0.17804** |
| 8.0   | .05399, .31945, .31945, .39894, .16401 | 1.25584 | **0.16745** |
| 8.5   | .02622, .24197, .24197, .37738, .24197 | 1.12951 | **0.15060** |

**c.** Among the five tabulated values the biggest change is **8.0 → 8.5**: $0.2000$ down to $0.0667$, a drop of $2/15$. The Gaussian moves from $0.16745$ to $0.15060$ over the same half-step, a change of about $0.017$ — an eighth as large.

Two clarifications about *where* the discontinuity really is, since $x=8.5$ is one of the tied points:

- The value at exactly $8.5$ is a single-point dip. Three observations (7, 7, and 10) sit at distance exactly $1.5$ and are all excluded by the strict `<`, leaving only the 8.
- The curve's genuine step at $x=8.5$ is $0.2000\to0.1333$, a net $-1/15$: the **pair at 7 exits** ($-2/15$) at the same instant the **10 enters** ($+1/15$).

The largest genuine jump anywhere in this curve is $+2/15$ at $x=5.5$, where the same duplicated pair at 7 *enters* the window together. Every breakpoint sits at some $x_i\pm h$:

| breakpoint    | what crosses                  | net change         |
| ------------- | ----------------------------- | ------------------ |
| 3.5           | 5 enters                      | $+1/15$          |
| **5.5** | **7, 7 enter together** | $\mathbf{+2/15}$ |
| 6.5           | 5 exits, 8 enters             | $0$              |
| 8.5           | 7, 7 exit; 10 enters          | $-1/15$          |
| 9.5           | 8 exits                       | $-1/15$          |
| 11.5          | 10 exits                      | $-1/15$          |

The cause is the **shape of the two kernels at the edge of the window, not their overall smoothness.**

The uniform kernel is an indicator: it gives weight $\tfrac{1}{2h}$ to every point strictly within $h$ and weight $0$ beyond, with a vertical cliff at distance exactly $h$. An observation's contribution does not decay as $x$ moves away from it — full strength right up to distance 1.5, then instantly nothing. So $\hat f$ can only change by whole multiples of $1/(2nh)$, and it changes by *two* at once wherever a repeated value crosses the edge. That is why the 7, 7 pair produces the biggest steps in both directions.

The Gaussian kernel $\varphi(z)$ has no edge. Its weight decays continuously and stays positive at every distance, so an observation never enters or leaves — it just contributes less. Moving from $x=8.0$ to $8.5$, the weight on each 7 falls smoothly from $0.31945$ to $0.24197$ while the weight on 10 rises from $0.16401$ to $0.24197$, and the losses partly cancel the gains. A finite sum of continuous functions is continuous, and since $\varphi$ is differentiable everywhere, so is the estimate.

**d.** Prefer the **Gaussian** when the underlying density is believed smooth, when you need a continuous or differentiable estimate (finding a mode, taking a derivative, plotting for presentation), or when the sample is small enough that a few points entering and leaving windows would dominate the picture. It is the default in plotting libraries for this reason.

Prefer the **uniform** when you want a transparent, hand-checkable estimate — it is literally "count the neighbors and divide," so every value can be verified by hand, as in part a — or when you want a strictly local estimate with compact support, so that distant observations contribute exactly zero rather than a small amount. It is also cheaper to compute, since only points inside the window enter the sum.

The choice matters much less than the choice of $h$: both kernels with a reasonable bandwidth give similar answers, while the same kernel at a bad bandwidth does not.

---

## Problem 4 (30 pt)

— `heart_failure_clinical_records_dataset.csv`, `ejection_fraction` ($n=299$)

$\mathrm{sd}=11.815$, so Silverman's uniform bandwidth is $h=1.84(11.815)(299^{-0.2})=6.95$.

**a.** Left panel of the p4 figure. The estimate is a single broad mound centered near 35%, rising from near zero below 15%, peaking at $\hat f\approx0.0385$ around $x=33$–36, and falling off through a shoulder near 55–60% to near zero above 70%. Area under the curve is 1.00. ✓

```python
import numpy as np, pandas as pd, matplotlib.pyplot as plt
df = pd.read_csv("./data/heart_failure_clinical_records_dataset.csv")
X = df["ejection_fraction"].to_numpy(float); n = len(X)
h = 1.84 * X.std() * n ** -0.2                       # 6.95
grid = np.linspace(X.min() - 2 * h, X.max() + 2 * h, 600)
ukde = lambda Xs, g, h: (np.abs(g[:, None] - Xs[None, :]) < h).sum(1) / (2 * len(Xs) * h)
plt.step(grid, ukde(X, grid, h), where="mid")
```

**b.** Right panel: 15 resamples via `df.sample(frac=1.0, replace=True)`, each estimated at the same $h$, plotted over the original.

```python
for _ in range(15):
    Xb = df.sample(frac=1.0, replace=True)["ejection_fraction"].to_numpy(float)
    plt.step(grid, ukde(Xb, grid, h), where="mid", alpha=0.5)
```

**c.** Reliable in the **core, roughly 25% to 45%**, where the 15 curves stay in a tight band around the original: the spread across resamples is about 6–9% of the height there, and every resample agrees on the location and rough height of the peak near 35.

| $x$               | 20    | 25    | 30    | 35    | 40    | 45    | 50    | 60    | 70    | 80    |
| ------------------- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- | ----- |
| $\hat f$          | .0142 | .0212 | .0286 | .0385 | .0351 | .0188 | .0106 | .0089 | .0005 | .0002 |
| sd across resamples | .0018 | .0019 | .0018 | .0025 | .0025 | .0015 | .0013 | .0011 | .0004 | .0002 |
| spread ÷ height    | 13%   | 9%    | 6%    | 6%    | 7%    | 8%    | 12%   | 13%   | 91%   | 79%   |

Noticeable variation in the **tails — below about 20% and above about 65%** — where the relative spread averages over 50% and individual resamples drop to exactly zero while others do not. Also unstable is the **upper shoulder around 50–60%**, where the relative spread roughly doubles compared to the core and the small bumps move between resamples.

The reason is the count in the numerator. $\hat f_h(x)$ is (points within $h$ of $x$) / $2nh$, so its variance is driven by how many observations are in the window. Near 35 each window holds dozens of patients, and resampling changes that count by a few percent. Above 65 the window holds a handful — 70, 80, and a few 60s — so resampling can easily include two of them or none, and the estimate swings by 100% of its own height. **Absolute** variability is actually largest at the peak (sd .0025 vs .0004); it is the variability *relative to the height being estimated* that explodes in the tails, and that is what makes the tail shape untrustworthy.

Practical reading: report the mode and the central shape, do not interpret the small bumps near 55–60, and do not claim anything about the density above 65% from this sample.
