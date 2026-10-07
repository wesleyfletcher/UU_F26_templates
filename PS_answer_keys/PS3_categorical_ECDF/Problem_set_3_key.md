# PROBLEM SET 3: Categorical and Numeric Variables

Answer key for `UU_F26_templates/Week04/problems.md`. Figures: `problem_set_3_KEY_sketches.png` (Q1c, Q3, Q4, Q5), `problem_set_3_KEY_metabric.png` (Q6).

---

## Q1 (10 pt)

**a. (3pt)** $6\times4$ one-hot matrix, columns in alphabetical order (blue, green, grey, red):

$$
Z=
\begin{array}{c}
\text{red}\\ \text{blue}\\ \text{blue}\\ \text{red}\\ \text{green}\\ \text{grey}
\end{array}
\left[\begin{array}{cccc}
0 & 0 & 0 & 1\\
1 & 0 & 0 & 0\\
1 & 0 & 0 & 0\\
0 & 0 & 0 & 1\\
0 & 1 & 0 & 0\\
0 & 0 & 1 & 0
\end{array}\right]
$$

Every row sums to 1; column sums are the label counts $2,1,1,2$.

**b.** (2pt) Column means of $Z$:

| blue        | green   | grey    | red         |
| ----------- | ------- | ------- | ----------- |
| $2/6=1/3$ | $1/6$ | $1/6$ | $2/6=1/3$ |

**c.(5pt)** $F_n(x)=\frac{1}{5}\sum_i \mathbf{1}\{x_i\le x\}$ for $X=[1,3,3,6,11]$:

$$
F_5(x)=
\begin{cases}
0, & x<1\\
0.2, & 1\le x<3\\
0.6, & 3\le x<6\\
0.8, & 6\le x<11\\
1, & x\ge 11
\end{cases}
$$

Staircase with a double jump of $2/5$ at $x=3$; filled dot at the top of each jump, open dot at the bottom. Sketch: top-left panel of the sketches figure.

---

## Q2 (15 pt)

**a. (5pt)** $Y=a+bX$ with $b>0$:

$$
F_Y(y)=\mathbb{P}\!\left(X\le\tfrac{y-a}{b}\right)=F_X\!\left(\frac{y-a}{b}\right),
\qquad
f_Y(y)=\frac{1}{b}\,f_X\!\left(\frac{y-a}{b}\right).
$$

The $1/b$ on the density is the chain-rule factor; it keeps the area at 1 after the horizontal stretch. The CDF has no such factor.

**b. (2pt)** $\bar X=\dfrac{1+3+4}{3}=\dfrac83\approx2.667$.

**c.** (3pt) Squares $[1,9,16]$, so $\overline{X^2}=\dfrac{26}{3}\approx8.667$.

**d. (5pt)** $(\bar X)^2=\dfrac{64}{9}\approx7.111\ne\dfrac{78}{9}=\overline{X^2}$. The gap is

$$
\overline{X^2}-(\bar X)^2=\frac{14}{9}\approx1.556=\mathrm{Var}(X),
$$

the identity $\mathbb{E}[X^2]=(\mathbb{E}[X])^2+\mathrm{Var}(X)$. Since variance is non-negative, the mean of the squares is always at least the square of the mean.

---

## Q3 (20 pt)

**a. (3 pt each sketch)** $f(x)=e^{-x}$ for $x\ge0$, zero below. CDF rises from $F(0)=0$ to the asymptote 1; density decays monotonically from $f(0)=1$, no interior peak. Top-middle panel.

**b. (3 pt each answer)**

$$
\mathbb{P}(X\ge3)=e^{-3}\approx0.0498,
\qquad
\mathbb{P}(X\le35)=1-e^{-35}\approx1 .
$$

**c. (8 pt)** $Y=1+3X$:

$$
F_Y(y)=
\begin{cases}
0, & y<1\\
1-e^{-(y-1)/3}, & y\ge1
\end{cases}
\qquad
f_Y(y)=\tfrac13 e^{-(y-1)/3},\ y\ge1 .
$$

Shifted right by 1 (support starts at $y=1$) and stretched by 3; density peak drops to $1/3$. Top-right panel.

$$
\mathbb{P}(Y<10)=\mathbb{P}(X<3)=1-e^{-3}\approx0.9502 ,
$$

the complement of part b.

---

## Q4 (20 pt)

**a. (3 pt each sketch)** $f(x)=\dfrac{e^{-x}}{(1+e^{-x})^2}=F(x)\bigl(1-F(x)\bigr)$. CDF is the S-curve through $F(0)=\tfrac12$ with $F(-x)=1-F(x)$; density is a symmetric bump peaking at $f(0)=\tfrac14$. Bottom-left panel.

**b. (3 pt each answer)**

$$
\mathbb{P}(X\ge0.8)=\frac{1}{1+e^{0.8}}\approx0.3100,
\qquad
\mathbb{P}(X\le0.3)=\frac{1}{1+e^{-0.3}}\approx0.5744 .
$$

**c. (8 pt)** $Y=2X-1$, so $x=(y+1)/2$:

$$
F_Y(y)=\frac{1}{1+e^{-(y+1)/2}},
\qquad
f_Y(y)=\tfrac12 f_X\!\left(\tfrac{y+1}{2}\right).
$$

Shifted left to center $-1$ and flattened (scale 2, peak $1/8$). Bottom-middle panel.

$$
\mathbb{P}(Y<0)=\mathbb{P}(X<\tfrac12)=\frac{1}{1+e^{-1/2}}\approx0.6225 .
$$

---

## Q5 (20 pt) no plots necessary

**a. (4 pt)** $1-e^{-m}=\tfrac12\Rightarrow m=\ln2\approx0.693$ (below the mean of 1: right-skewed).

**b. (4 pt)** $\dfrac{1}{1+e^{-m}}=\tfrac12\Rightarrow m=0$.

**c. (6 pt)** $u=1-e^{-x}\Rightarrow F^{-1}(u)=-\ln(1-u)$, $0\le u<1$.

**d. (6 pt)** $u=\dfrac{1}{1+e^{-x}}\Rightarrow F^{-1}(u)=\ln\!\left(\dfrac{u}{1-u}\right)$, $0<u<1$ — the logit. Bottom-right panel.


---

## Q6 (15 pt)

**a.** (5 pt) ECDF of `Overall Survival (Months)` — left panel of the metabric figure. Median 118.5 months, range 0.1 to 351. Hand drawn IS FINE.

| $x$ (months) | 24    | 60    | 120   | 180   | 240   |
| -------------- | ----- | ----- | ----- | ----- | ----- |
| $F_n(x)$     | 0.069 | 0.238 | 0.508 | 0.710 | 0.892 |

```python
import pandas as pd, numpy as np, matplotlib.pyplot as plt
df = pd.read_csv("./data/metabric.csv")
x = np.sort(df["Overall Survival (Months)"])
plt.step(x, np.arange(1, len(x) + 1) / len(x), where="post")
# seaborn: sns.ecdfplot(data=df, x="Overall Survival (Months)", hue="Chemotherapy")
```

**b.** (5pt) Right panel, again, hand drawn sketch is fine.

|                  | n    | median   | mean     |
| ---------------- | ---- | -------- | -------- |
| Chemotherapy NO  | 1057 | 125.3 mo | 135.7 mo |
| Chemotherapy YES | 286  | 90.3 mo  | 104.5 mo |

| $x$ (months)  | 24    | 60    | 120   | 180   | 240   |
| --------------- | ----- | ----- | ----- | ----- | ----- |
| $F_n(x)$, NO  | 0.060 | 0.202 | 0.478 | 0.680 | 0.882 |
| $F_n(x)$, YES | 0.105 | 0.371 | 0.619 | 0.818 | 0.930 |

**Predict shorter.** The chemotherapy ECDF is above and to the left at every $x$, and a higher ECDF means a larger fraction of that group has already failed by time $x$. 37% of chemotherapy patients are at or below 60 months versus 20% of the others; the median is about 35 months lower.

**c. (5pt) No — this comparison cannot establish efficacy.** Treatment was not randomly assigned: chemotherapy goes to the patients whose disease is worse, so the groups differ before treatment starts (**confounding by indication**).
