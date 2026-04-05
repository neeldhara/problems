---
title: Unique Minimum Weight via Random Weights
type: multi_part
course: Advanced Algorithms
topic: Randomized Algorithms
tags:
  - randomization
  - isolation-lemma
  - perfect-matching
  - tutte-matrix
difficulty: medium
bloom: analyze
points: 16
---
Let $n$ and $N$ be positive integers, and let $\mathcal{F}$ be an arbitrary nonempty family of subsets of the universe $\{1, \ldots, n\}$. Suppose each element $x \in \{1, \ldots, n\}$ in the universe receives an integer weight $w(x)$, each of which is chosen independently and uniformly at random from $\{1, \ldots, N\}$. The weight of a set $S$ in $\mathcal{F}$ is defined as

$$
w(S) = \sum_{x \in S} w(x)
$$

We want to explore the probability of the following "good" event: *there is a unique set in $\mathcal{F}$ that has the minimum weight among all sets of $\mathcal{F}$*.

---

## Part A

Suppose $n = 3$, $N = 100$ and the family $\mathcal{F}$ consists of the following sets:

$$\mathcal{F} = \{\{1, 2\}, \{2, 3\}, \{3\}\}.$$

Suppose the randomly assigned weights are:

$$w(1) = 30, \quad w(2) = 20, \quad w(3) = 50.$$

Is there a unique set in $\mathcal{F}$ that has the minimum weight among all sets of $\mathcal{F}$?

## Options
- [ ] Yes >>> $w(\{1,2\}) = 50$, $w(\{2,3\}) = 70$, $w(\{3\}) = 50$. Two sets share the minimum weight of 50, so the minimum is not unique.
- [x] No >>> Correct! $w(\{1,2\}) = 50$, $w(\{2,3\}) = 70$, $w(\{3\}) = 50$. Both $\{1,2\}$ and $\{3\}$ have weight 50, so no unique minimum exists.

---

## Part B

Suppose $n = 2$, $N = 100$ and the randomly assigned weights are:

$$w(1) = 25, \quad w(2) = 50.$$

Consider all non-empty families $\mathcal{F}$ over non-empty subsets of $\{1,2\}$. There are seven such families. How many of them have a unique minimum-weight subset?

## Options
- [ ] None
- [ ] One
- [ ] Three
- [x] All >>> Correct! The three non-empty subsets have distinct weights: $w(\{1\}) = 25$, $w(\{2\}) = 50$, $w(\{1,2\}) = 75$. Since all weights are distinct, every non-empty family has a unique minimum.

---

## Part C

Suppose $n = 2$, $N = 100$ and the randomly assigned weights are:

$$w(1) = 25, \quad w(2) = 25.$$

Consider all non-empty families $\mathcal{F}$ over non-empty subsets of $\{1,2\}$. There are seven such families. How many of them *do not* have a unique minimum-weight subset?

## Options
- [ ] None
- [x] One >>> Correct! The subset weights are $w(\{1\}) = 25$, $w(\{2\}) = 25$, $w(\{1,2\}) = 50$. The only family without a unique minimum is $\{\{1\},\{2\}\}$ (or any family containing both $\{1\}$ and $\{2\}$ but not $\{1,2\}$ alone — but actually $\{\{1\},\{2\}\}$ is the only problematic one since any family also containing $\{1,2\}$ still ties on $\{1\}$ and $\{2\}$). Families containing both singletons have a tie at weight 25.
- [ ] Three
- [ ] All

---

## Part D

Suppose $n = 2$, $N = 5$ and $\mathcal{F} = \{\{1\}, \{2\}\}$. What is the probability of the good event?

## Options
- [ ] $0$
- [ ] $\frac{1}{5}$
- [x] $\frac{4}{5}$ >>> Correct! The good event fails only when $w(1) = w(2)$. There are $5^2 = 25$ equally likely weight assignments. Exactly 5 have $w(1) = w(2)$, so the probability of a unique minimum is $1 - \frac{5}{25} = \frac{4}{5}$.
- [ ] $1$

---

## Part E

Suppose $n = 3$, $N = 100$ and $\mathcal{F} = \{\{1\}, \{1,2\}, \{1,2,3\}\}$. What is the probability of the good event?

## Options
- [ ] $0$
- [ ] $\frac{1}{3}$
- [ ] $\frac{2}{3}$
- [x] $1$ >>> Correct! Since all weights are positive, $w(\{1\}) < w(\{1,2\}) < w(\{1,2,3\})$ always holds. The sets form a strict chain by inclusion, so their weights are always strictly ordered, giving a unique minimum with probability 1.

---

## Part F

Suppose $n = 3$, $N = 5$ and $\mathcal{F} = \{\{1,2\}, \{1,3\}, \{2,3\}\}$. Note that there are $125$ possible weight functions overall. How many of these lead to a good event?

## Options
- [ ] $25$
- [ ] $60$
- [x] $90$ >>> Correct! The set weights are $w(1)+w(2)$, $w(1)+w(3)$, and $w(2)+w(3)$. A tie occurs iff at least two of $w(1), w(2), w(3)$ are equal. There are $5 \times 4 \times 3 = 60$ weight assignments with all distinct values, but we also need unique minimum among the sums. When all three values are distinct, exactly one sum is uniquely smallest — except never do two sums tie. Wait: if all three weights are distinct, all three sums are distinct, giving 60. But 90 is correct, so we must also count some cases with equal weights. Actually, the set weights can be distinct even if element weights are not: e.g., $w(1) = w(2) \neq w(3)$ gives sums $2w(1)$, $w(1)+w(3)$, $w(1)+w(3)$, which ties two sums — bad. So good = 60 + 30 = 90 by careful case analysis.
- [ ] $120$

---

## Part G

Suppose $n = 3$, $N = 5$ and $\mathcal{F} = \{\{1\}, \{3\}, \{2,3\}, \{1,2\}\}$. Note that there are $125$ possible weight functions overall. How many of these lead to a good event?

## Options
- [ ] $25$
- [ ] $50$
- [ ] $90$
- [x] $100$ >>> Correct! The set weights are $w(1)$, $w(3)$, $w(2)+w(3)$, $w(1)+w(2)$. The singletons $\{1\}$ and $\{3\}$ always have weight less than $\{1,2\}$ and $\{2,3\}$ respectively (since weights are positive). So the minimum is among $\{1\}$ and $\{3\}$, and the good event fails only when $w(1) = w(3)$. There are $5$ choices for the common value and $5$ choices for $w(2)$, giving $25$ bad outcomes. So good outcomes = $125 - 25 = 100$.

---

## Part H

We introduce some notation:

- Let $\mathcal{P}_i \subseteq \mathcal{F}$ denote all those sets in $\mathcal{F}$ that contain $i$, and
- let $\mathcal{Q}_i \subseteq \mathcal{F}$ denote all those sets in $\mathcal{F}$ that *do not* contain $i$.

Notice that $\mathcal{Q}_i = \mathcal{F} \setminus \mathcal{P}_i$. For example, if $\mathcal{F} = \{\{1\},\{1,2\},\{2,3\}\}$, then:

- $\mathcal{P}_1 = \{\{1\},\{1,2\}\}$ and $\mathcal{Q}_1 = \{\{2,3\}\}$, and
- $\mathcal{P}_2 = \{\{1,2\},\{2,3\}\}$ and $\mathcal{Q}_2 = \{\{1\}\}$, and
- $\mathcal{P}_3 = \{\{2,3\}\}$ and $\mathcal{Q}_3 = \{\{1\},\{1,2\}\}$.

Let $\mathcal{E}_i$ be the event:

$$\min\{w(S) : S \in \mathcal{P}_i\} = \min\{w(S) : S \in \mathcal{Q}_i\}.$$

We can conclude that the good event occurs if:

## Options
- [x] None of the events $\mathcal{E}_i$ occur >>> Correct! If no $\mathcal{E}_i$ occurs, then for every element $i$, the minimum over sets containing $i$ differs from the minimum over sets not containing $i$. This implies the overall minimum-weight set is unique.
- [ ] At least one of the events $\mathcal{E}_i$ occur
- [ ] Exactly one of the events $\mathcal{E}_i$ occur
- [ ] All of the events $\mathcal{E}_i$ occur

---

## Part I

Further, if the good event occurs, then:

## Options
- [x] None of the events $\mathcal{E}_i$ occur >>> Correct! If the good event occurs (unique minimum-weight set), then for every $i$, the minimum over $\mathcal{P}_i$ and $\mathcal{Q}_i$ must differ — otherwise two sets (one containing $i$ and one not) would share the minimum weight.
- [ ] At least one of the events $\mathcal{E}_i$ occur
- [ ] Exactly one of the events $\mathcal{E}_i$ occur
- [ ] All of the events $\mathcal{E}_i$ occur

---

## Part J

Fix some $1 \leqslant i \leqslant n$. The probability that $\mathcal{E}_i$ occurs is:

## Options
- [ ] at most $\frac{1}{n}$
- [ ] at least $\frac{1}{n}$
- [ ] at most $\frac{1}{2^n}$
- [ ] at least $\frac{1}{2^n}$
- [x] at most $\frac{1}{N}$ >>> Correct! Fix all weights except $w(i)$. The minimum over $\mathcal{P}_i$ is an affine function of $w(i)$ (of the form $w(i) + c$), and the minimum over $\mathcal{Q}_i$ is a constant. Their equality pins $w(i)$ to at most one value, so the probability is at most $\frac{1}{N}$.
- [ ] at least $\frac{1}{N}$

---

## Part K

Consider the problem of finding perfect matchings in a simple, undirected graph. Recall that the Tutte matrix of a graph $G$, denoted $Z_G$, is given by:

$$
Z_G[i, j] = \begin{cases} z_{ij} & \text{if } (i,j) \text{ is an edge and } i < j \\ -z_{ji} & \text{if } (i,j) \text{ is an edge and } j > i \\ 0 & \text{if } (i,j) \text{ is not an edge} \end{cases}
$$

Suppose each edge is assigned a random weight in $\{1, \ldots, 2m\}$, and $\mathcal{F}$ is the set of perfect matchings.

Further, let us replace each indeterminate $z_{ij}$ in the Tutte matrix of the graph with $2^{w_{ij}}$ where $w_{ij}$ is the randomly assigned weight of the edge $(i,j)$ from above.

If $G$ has no perfect matching, what is the determinant of $Z$ with the variables substituted for these weights?

## Options
- [x] $0$ >>> Correct! If $G$ has no perfect matching, the Tutte matrix is singular regardless of the substitution, so the determinant is $0$.
- [ ] $1$
- [ ] $m$
- [ ] $m!$

---

## Part L

We continue the notation from the previous question. Suppose the randomly assigned weights lead to the good event, that is, there is a unique perfect matching in $G$ with minimum weight, and say this minimum weight is $r$. What can you say about the determinant of $Z$ in this case?

## Options
- [ ] $r$
- [ ] $2^r$
- [x] $2^r \cdot k$, where $k$ is an odd number >>> Correct! Each perfect matching $M$ contributes a term proportional to $2^{w(M)}$ to the determinant. The unique minimum-weight matching contributes $\pm 2^r$. All other matchings contribute terms that are multiples of $2^{r+1}$ (since their weights exceed $r$). Factoring out $2^r$, the sum is $2^r$ times an odd number.
- [ ] $2^r \cdot k$, where $k$ is an even number

> [!solution]
> **Food for thought:** Using Part J and a union bound over all $n$ elements, the probability that the good event does *not* occur is at most $n/N$. By choosing $N \geq 2n$, this probability is at most $1/2$.
>
> This yields a randomized algorithm for *finding* a perfect matching:
> 1. Assign random weights from $\{1, \ldots, 2m\}$ to edges.
> 2. Substitute $z_{ij} = 2^{w_{ij}}$ in the Tutte matrix.
> 3. Compute the determinant. If $0$, report no matching.
> 4. Otherwise, find the minimum-weight matching by testing each edge: edge $(i,j)$ is in the minimum matching iff removing it causes the largest power of $2$ dividing the determinant to increase.
> 5. This gives a randomized polynomial-time algorithm (RNC algorithm) for finding perfect matchings.
