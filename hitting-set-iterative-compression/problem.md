---
title: Hitting Set Iterative Compression
type: multi_part
course: Advanced Algorithms
topic: Parameterized Algorithms
tags: [hitting-set, iterative-compression, parameterized]
difficulty: medium
bloom: analyze
points: 5
course-slug: advalgo
---
In **$d$-Hitting Set**, we are given a universe $S$, a family $C$ of subsets of size at most $d$, and a budget $k$. The task is to decide whether there is a hitting set $H \subseteq S$ with $|H| \le k$. These questions explore iterative compression assuming a solver for $(d-1)$-Hitting Set.

## Part A

Let $S = \{1,2,3,4,5,6,7,8,9\}$ be a set of elements, and let $C$ be the collection of subsets: $$C = \{ \{1,2,3\}, \{2,3,4\}, \{3,4,5\}, \{1,4,5\}, \{2,6,7\}, \{1,7,8\}, \{3,8,9\}, \{2,5,9\}, \{1,6,9\}, \{3,6,8\}, \{2,4,8\}, \{1,5,7\} \}$$ Now, suppose we are given $X = \{1,2,3,7\}$ as a Hitting Set of size $4$ and we want to know if there is a hitting set $Y$ of size $3$. Let us assume that $Y \cap X = \{1,2\}$. Then we can throw away the sets that contain $1$ or $2$ from $C$. What is the collection that remains?

## Options
- [ ] $\{\{3,4,5\}, \{2,6,7\}, \{3,4,8\}, \{3,5,7\}\}$
- [ ] $\{\{3,4,5\}, \{3,6,7\}, \{3,7,8\}\}$
- [x] $\{\{3,4,5\}, \{3,8,9\}, \{3,6,8\}\}$
- [ ] $\{\{3,4,5\}, \{3,8,9\}\}$

## Part B

Continuing from the example in the previous question, recall that we have $Y \cap X = \{1,2\}$. Now, we want to know if there is a hitting set $Y$ of size $3$ overall. This will be the case if and only if:

## Options
- [ ] The family that remains after throwing away sets that contain either $1$ or $2$ must have a hitting set of size $1$.
- [x] The family that remains after throwing away sets that contain either $1$ or $2$ must have a hitting set of size $1$ that does not contain either $3$ or $7$.
- [ ] The family that remains after throwing away sets that contain either $1$ or $2$ must have a hitting set of size $1$ that contains at most one of $3$ or $7$.

## Part C

Based on your answer to the previous question, simplify the leftover family from the first question to observe that solving the remaining problem is now equivalent to:

## Options
- [ ] Vertex Cover
- [ ] $d$-Hitting Set on a smaller family
- [x] $(d-1)$-Hitting Set on a smaller family
- [ ] $(d+1)$-Hitting Set on a smaller family

## Part D

For the example in the first question, we can extend the solution $\{1,2\}$ to a complete solution of size at most three if and only if:

## Options
- [x] The sets $\{4,5\}$, $\{8,9\}$ and $\{6,8\}$ have a single common element.
- [ ] The sets $\{4,5\}$, $\{8,9\}$ and $\{6,8\}$ have a hitting set of size at most two

## Part E

If we know how to solve $(d-1)$-Hitting Set in time $O(c^k \cdot \text{poly}(n))$, then we can solve $d$-Hitting Set in time:

## Options
- [ ] $O(c^k \cdot \text{poly}(n))$
- [ ] $O((c-1)^k \cdot \text{poly}(n))$
- [x] $O((c+1)^k \cdot \text{poly}(n))$

> [!solution]
> **Part A:** $\{\{3,4,5\}, \{3,8,9\}, \{3,6,8\}\}$
> **Part B:** The family that remains after throwing away sets that contain either $1$ or $2$ must have a hitting set of size $1$ that does not contain either $3$ or $7$.
> **Part C:** $(d-1)$-Hitting Set on a smaller family
> **Part D:** The sets $\{4,5\}$, $\{8,9\}$ and $\{6,8\}$ have a single common element.
> **Part E:** $O((c+1)^k \cdot \text{poly}(n))$
