---
title: Randomized Min-Cut Analysis
type: multi_part
course: Advanced Algorithms
topic: Randomized Algorithms
tags: [min-cut, randomization, probability, counting]
difficulty: medium
bloom: analyze
points: 5
course-slug: advalgo
---

**Karger's Min-Cut Algorithm** finds a minimum cut in an undirected multigraph $G = (V, E)$ with $n$ vertices:

```
while |V| > 2:
    Pick an edge (u, v) uniformly at random
    Contract (u, v): merge u and v into a single vertex
    Remove all self-loops
return the edges between the two remaining vertices
```

Recall from the analysis that the probability of finding a *specific* minimum cut $C$ in a single run is at least $\frac{2}{n(n-1)} = \frac{1}{\binom{n}{2}}$.

---

## Part A

A graph may have several different minimum cut sets. Using the analysis of the randomized min-cut algorithm, what is the maximum number of distinct min-cut sets that a graph with $n$ vertices can have?

## Options
- [ ] At most $n$ >>> This bound is too small. Consider the cycle graph $C_n$, which has more min-cuts than this.
- [ ] At most $2^n$ >>> This is way too large. The randomized analysis gives a much tighter bound.
- [x] At most $\binom{n}{2} = \frac{n(n-1)}{2}$ >>> Correct! The probability argument implies this upper bound, and the cycle graph achieves it.
- [ ] At most $n!$ >>> The bound is polynomial, not factorial.

> [!hint]
> If there were more than $\binom{n}{2}$ distinct min-cuts, what would that imply about the sum of their individual success probabilities?

> [!solution]
> Let $C_1, C_2, \ldots, C_m$ be all distinct minimum cut sets in $G$.
>
> **Key observation:** The events "algorithm outputs $C_i$" are mutually exclusive (only one cut can be output per run).
>
> From the analysis, $\Pr[\text{output } C_i] \geq \frac{2}{n(n-1)}$ for each $i$.
>
> Since probabilities of disjoint events sum to at most 1:
> $$\sum_{i=1}^{m} \Pr[\text{output } C_i] \leq 1$$
> $$m \cdot \frac{2}{n(n-1)} \leq 1$$
> $$m \leq \frac{n(n-1)}{2} = \binom{n}{2}$$
>
> **Tight example:** The cycle graph $C_n$ achieves this bound. Every pair of edges forms a min-cut (of size 2), and there are exactly $\binom{n}{2}$ such pairs.

---

## Part B

An **$r$-way cut-set** is a set of edges whose removal breaks the graph into $r$ or more connected components. The randomized min-cut algorithm can be adapted to find minimum $r$-way cut-sets by contracting until $r$ vertices remain (instead of 2).

What is the probability that this adapted algorithm finds a specific minimum $r$-way cut in one iteration?

## Options
- [ ] At least $\frac{1}{n^r}$ >>> The bound involves binomial coefficients, not powers.
- [x] At least $\frac{1}{\binom{n}{r}}$ >>> Correct! The analysis generalizes: we need to avoid contracting cut edges for $n - r$ steps.
- [ ] At least $\frac{r}{n(n-1)}$ >>> This doesn't correctly generalize the 2-way cut analysis.
- [ ] At least $\frac{2}{n^2}$ regardless of $r$ >>> The bound depends on $r$; larger $r$ gives higher success probability.

> [!hint]
> Generalize the original analysis: at step $i$, the probability of not contracting a cut edge is $\frac{n-i-r}{n-i}$ (instead of $\frac{n-i-2}{n-i}$).

> [!solution]
> **Adapted algorithm:** Contract until $r$ vertices remain. The edges between the $r$ remaining super-vertices form an $r$-way cut.
>
> **Analysis:** Let $C$ be a minimum $r$-way cut of size $k$. Every vertex has degree $\geq k$ (otherwise removing fewer edges could separate it).
>
> At step $i$ (with $n - i$ vertices remaining), we need $n - i > r$:
> $$\Pr[\text{don't cut } C] \geq \frac{n - i - r}{n - i}$$
>
> The algorithm runs for $n - r$ contraction steps (reducing from $n$ to $r$ vertices).
>
> **Success probability:**
> $$\prod_{i=0}^{n-r-1} \frac{n-i-r}{n-i} = \frac{(n-r)(n-r-1)\cdots 2 \cdot 1}{n(n-1)\cdots(r+1)}$$
> $$= \frac{(n-r)!}{n!/(r!)} \cdot \frac{1}{r!} \cdot r! = \frac{(n-r)! \cdot r!}{n!} = \frac{1}{\binom{n}{r}}$$
>
> **Note:** For $r = 2$, this gives $\frac{1}{\binom{n}{2}} = \frac{2}{n(n-1)}$, matching the original analysis.
>
> **Implication:** Larger $r$ means higher success probability (since $\binom{n}{r}$ is largest around $r = n/2$). Finding 3-way cuts is easier than 2-way cuts!
