# Problem Set 2 Key: Probability and Random Variables

Answer key for `UU_F26_templates/Week03/probability_problems.md`.

---

## Problem 1: A Gamble (20 pt)

*Prompt has a double negative ("you lose $\$-7$"); intended payoff is $-7$.*

**a. (5 pt)** Full space: $\Omega=\{1,\dots,6\}$, $\mathcal{F}=2^\Omega$, $\mathbb{P}(\{\omega\})=1/6$. All events = all $2^6=64$ subsets.

The payoff only distinguishes $A=\{1,2,3\}$, $B=\{4,5\}$, $C=\{6\}$, so the simplest space is $\Omega'=\{A,B,C\}$ with $\mathbb{P}(A)=\tfrac12$, $\mathbb{P}(B)=\tfrac13$, $\mathbb{P}(C)=\tfrac16$. Its $2^3=8$ events:

$$
\varnothing,\ \{A\},\ \{B\},\ \{C\},\ \{A,B\},\ \{A,C\},\ \{B,C\},\ \Omega' .
$$

**b. (10 pt)**

| $x$      | $-7$  | $0$   | $3$   |
| ---------- | ------- | ------- | ------- |
| $p_X(x)$ | $1/6$ | $1/2$ | $1/3$ |

$$
\mathbb{E}[X]=(-7)\tfrac16+0\cdot\tfrac12+3\cdot\tfrac13=-\tfrac76+1=-\tfrac16\approx-0.167 .
$$

**c.** **(5 pt)** No. $\mathbb{E}[X]<0$, so the game loses about 17 cents per play.

---

## Problem 2: Weather Forecasting (10 pt)

$R$ = rains, $F$ = forecasts rain. Given $\mathbb{P}(R)=0.3$, $\mathbb{P}(F\mid R)=0.8$, $\mathbb{P}(F\mid R^c)=0.1$.

$$
\mathbb{P}(F)=(0.8)(0.3)+(0.1)(0.7)=0.24+0.07=0.31
$$

$$
\mathbb{P}(R\mid F)=\frac{0.24}{0.31}=\frac{24}{31}\approx 0.774
$$

Not 0.8: that is $\mathbb{P}(F\mid R)$, diluted by false alarms from the larger dry-day pool.

---

## Problem 3: Two Dice (40 pt)

$\Omega=\{1,\dots,6\}^2$, 36 equally likely **ordered** pairs.

**a. (10) Average $A=(D_1+D_2)/2$.**

| $a$          | 1 | 1.5 | 2 | 2.5 | 3 | 3.5 | 4 | 4.5 | 5 | 5.5 | 6 |
| -------------- | - | --- | - | --- | - | --- | - | --- | - | --- | - |
| $36\,p_A(a)$ | 1 | 2   | 3 | 4   | 5 | 6   | 5 | 4   | 3 | 2   | 1 |

$\mathbb{E}[A]=\tfrac12(3.5+3.5)=3.5$ by linearity.

**b. (10) Minimum $M$.** $\mathbb{P}(M\ge k)=\left(\tfrac{7-k}{6}\right)^2$, so $p_M(k)=\dfrac{13-2k}{36}$.

| $k$          | 1  | 2 | 3 | 4 | 5 | 6 |
| -------------- | -- | - | - | - | - | - |
| $36\,p_M(k)$ | 11 | 9 | 7 | 5 | 3 | 1 |

$\mathbb{E}[M]=\dfrac{11+18+21+20+15+6}{36}=\dfrac{91}{36}\approx 2.528$.

**c. (10) Maximum.** $\mathbb{P}(\max\le k)=(k/6)^2$, so $p_{\max}(k)=\dfrac{2k-1}{36}$.

| $k$               | 1 | 2 | 3 | 4 | 5 | 6  |
| ------------------- | - | - | - | - | - | -- |
| $36\,p_{\max}(k)$ | 1 | 3 | 5 | 7 | 9 | 11 |

$\mathbb{E}[\max]=\dfrac{1+6+15+28+45+66}{36}=\dfrac{161}{36}\approx 4.472$.

Check: $\min+\max=D_1+D_2$, and $\tfrac{91}{36}+\tfrac{161}{36}=7$. ✓

**d.** **(10)** The **probability space** $(\Omega,\mathcal{F},\mathbb{P})$ models the experiment: the 36 pairs, the events, and their probabilities. It is the same for a, b, and c.

A **random variable** is a function $X:\Omega\to\mathbb{R}$ — a measurement taken on an outcome. $A$, $M$, $\max$ are three different functions on the one shared $\Omega$: at $\omega=(2,5)$ they return 3.5, 2, and 5.

The **PMF** is $\mathbb{P}$ pushed through that function, $p_X(x)=\mathbb{P}(X=x)$: which values occur and with what probability, summing to 1. It keeps only what $X$ can see, which is why $M$ and $\max$ have different PMFs on identical outcomes.

Short version: the space says what can happen, the random variable says what you measure, the PMF says how often each measurement comes out.

---

## Problem 4: Defective Parts (30 pt)

**1. (10)**

```
                     ┌── defective        P = r·a
        ┌── Factory A┤   (prob a)
        │  (prob r)  └── good             P = r·(1 - a)
 part ──┤
        │            ┌── defective        P = (1 - r)·b
        └── Factory B┤   (prob b)
           (prob 1-r)└── good             P = (1 - r)·(1 - b)
```

Leaves sum to $r+(1-r)=1$.

**2. (10)**

$$
\mathbb{P}(D)=ra+(1-r)b
$$

A weighted average of the two defect rates, so it always lies between $a$ and $b$.

**3. (10)**

$$
\mathbb{P}(A\mid D)=\frac{ra}{ra+(1-r)b}
$$

Checks: if $a=b$ this is $r$ (a defect tells you nothing); if $b=0$ it is 1. With $r=0.7$, $a=0.02$, $b=0.10$: $\mathbb{P}(D)=0.044$ and $\mathbb{P}(A\mid D)=7/22\approx0.318$.
