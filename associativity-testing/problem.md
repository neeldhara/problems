---
title: Testing Associativity of Finite Binary Operations
type: multi_part
course: Advanced Algorithms
topic: Randomized Algorithms
tags:
  - randomization
  - schwartz-zippel
  - polynomial-identity-testing
  - groupoids
difficulty: medium
bloom: analyze
points: 18
---
A **binary operation** "$\odot$" on a finite set $X$ is an arbitrary mapping $X \times X \to X$. For every two elements $x, y \in X$, the element $x \odot y \in X$ is specified by a table with rows and columns indexed by $X$, where the entry in row $x$ and column $y$ stores $x \odot y$. A set $X$ together with a binary operation is called a **groupoid**.

The operation "$\odot$" is **associative** if $(x \odot y) \odot z = x \odot (y \odot z)$ for all $x, y, z \in X$. A groupoid with an associative operation is called a **semigroup**. We call a triple $(x, y, z) \in X^3$ **associative** if $(x \odot y) \odot z = x \odot (y \odot z)$, and **nonassociative** otherwise.

Here we investigate an algorithmic question: given a binary operation "$\odot$" on a finite set $X$ with $n$ elements, specified by its $n \times n$ table, is "$\odot$" associative?

---

## Part A (1)

Consider the following binary operation on $X = \{1, 2, 3\}$:

| $\odot$ | **1** | **2** | **3** |
|---------|-------|-------|-------|
| **1**   | 1     | 2     | 3     |
| **2**   | 2     | 1     | 3     |
| **3**   | 3     | 3     | 1     |

Is the triple $(3, 3, 2)$ associative?

## Options
- [ ] Yes >>> We have $(3 \odot 3) \odot 2 = 1 \odot 2 = 2$ and $3 \odot (3 \odot 2) = 3 \odot 3 = 1$. Since $2 \neq 1$, the triple is nonassociative.
- [x] No >>> Correct! $(3 \odot 3) \odot 2 = 1 \odot 2 = 2$, but $3 \odot (3 \odot 2) = 3 \odot 3 = 1$. Since $2 \neq 1$, this triple is nonassociative.

---

## Part B (1)

For the operation in Part A, how many of the $27$ triples in $X^3$ are nonassociative?

## Options
- [ ] $0$ >>> We already found one nonassociative triple in Part A!
- [x] $2$ >>> Correct! The only nonassociative triples are $(3, 3, 2)$ and $(2, 3, 3)$.
- [ ] $6$
- [ ] $9$

> [!hint]
> Any nonassociative triple must involve the entry $3 \odot 3 = 1$, since this is the only "surprising" entry in the table. Try triples of the form $(\cdot, 3, 3)$ and $(3, 3, \cdot)$.

> [!solution]
> We can systematically check all 27 triples by noting that the operation agrees with the group $\mathbb{Z}/2\mathbb{Z}$ on $\{1,2\}$ (with $1$ as identity), while $3$ acts as an absorbing element from the left and right *except* that $3 \odot 3 = 1$ instead of $3$.
>
> The two nonassociative triples are:
> - $(3, 3, 2)$: $(3 \odot 3) \odot 2 = 1 \odot 2 = 2 \neq 1 = 3 \odot 3 = 3 \odot (3 \odot 2)$
> - $(2, 3, 3)$: $(2 \odot 3) \odot 3 = 3 \odot 3 = 1 \neq 2 = 2 \odot 1 = 2 \odot (3 \odot 3)$

---

## Part C (1)

An obvious algorithm for checking associativity is to test every triple $(x, y, z) \in X^3$. For each triple, we need two lookups to compute $(x \odot y) \odot z$ and two lookups to compute $x \odot (y \odot z)$. What is the running time of this brute-force approach on an $n$-element set?

## Options
- [ ] $O(n)$
- [ ] $O(n^2)$
- [x] $O(n^3)$ >>> Correct! There are $n^3$ triples, and each requires $O(1)$ table lookups.
- [ ] $O(n^2 \log n)$

---

## Part D (2)

A natural randomized approach is to repeatedly pick a random triple $(x, y, z) \in X^3$ uniformly at random and test it. If a nonassociative triple is found, we declare the operation nonassociative; otherwise, after some number of samples, we declare it associative.

It turns out that one can construct an operation on an $n$-element set that has exactly **one** nonassociative triple (for any $n \geqslant 3$). For such an operation, even if we test $n^2$ independently and uniformly random triples, the probability of detecting nonassociativity is only:

## Options
- [ ] at least $\frac{1}{2}$ >>> This would be great, but the single bad triple is a needle in a haystack of $n^3$ triples.
- [ ] roughly $\frac{1}{n^2}$
- [x] roughly $\frac{1}{n}$ >>> Correct! The probability of missing the single bad triple in one test is $1 - \frac{1}{n^3}$. Over $n^2$ independent tests, the probability of detection is $1 - \left(1 - \frac{1}{n^3}\right)^{n^2} \approx 1 - e^{-1/n} \approx \frac{1}{n}$ for large $n$.
- [ ] roughly $1 - \frac{1}{n}$

> [!solution]
> The probability that a single random triple hits the unique nonassociative triple is $\frac{1}{n^3}$. After $n^2$ independent trials, the probability of at least one hit is:
> $$1 - \left(1 - \frac{1}{n^3}\right)^{n^2} \approx \frac{n^2}{n^3} = \frac{1}{n}$$
> This is very far from the constant $\frac{1}{2}$ that we would like. We need a fundamentally different approach.

---

## Part E (2)

We now develop a much better algorithm. The idea is to "lift" the operation from individual elements to *vectors*, creating many more chances to detect nonassociativity.

Fix a field $\mathbb{K}$ (for concreteness, you may think of $\mathbb{K} = \mathbb{F}_7$, the field with $7$ elements). Consider the vector space $\mathbb{K}^X$, whose vectors are $n$-tuples of elements of $\mathbb{K}$ indexed by elements of $X$. For every $x \in X$, let $\mathbf{e}(x) \in \mathbb{K}^X$ be the standard basis vector that has $1$ in position $x$ and $0$ elsewhere.

We define a binary operation "$\square$" on $\mathbb{K}^X$ as a **linear extension** of "$\odot$." For two vectors $\mathbf{u} = \sum_{x \in X} \alpha_x \mathbf{e}(x)$ and $\mathbf{v} = \sum_{y \in X} \beta_y \mathbf{e}(y)$, we define:

$$\mathbf{u} \;\square\; \mathbf{v} = \sum_{x, y \in X} \alpha_x \beta_y\, \mathbf{e}(x \odot y).$$

Now consider $X = \{1, 2\}$ with the operation $1 \odot 1 = 1$, $1 \odot 2 = 2$, $2 \odot 1 = 2$, $2 \odot 2 = 1$, and working over the rationals. For $\mathbf{u} = 2\,\mathbf{e}(1) + 3\,\mathbf{e}(2)$ and $\mathbf{v} = 4\,\mathbf{e}(1) + 1\,\mathbf{e}(2)$, what is $\mathbf{u} \;\square\; \mathbf{v}$?

## Options
- [ ] $8\,\mathbf{e}(1) + 14\,\mathbf{e}(2)$
- [x] $11\,\mathbf{e}(1) + 14\,\mathbf{e}(2)$ >>> Correct! $\mathbf{u} \;\square\; \mathbf{v} = 2 \cdot 4\,\mathbf{e}(1 \odot 1) + 2 \cdot 1\,\mathbf{e}(1 \odot 2) + 3 \cdot 4\,\mathbf{e}(2 \odot 1) + 3 \cdot 1\,\mathbf{e}(2 \odot 2)$ $= 8\,\mathbf{e}(1) + 2\,\mathbf{e}(2) + 12\,\mathbf{e}(2) + 3\,\mathbf{e}(1) = 11\,\mathbf{e}(1) + 14\,\mathbf{e}(2)$.
- [ ] $14\,\mathbf{e}(1) + 11\,\mathbf{e}(2)$
- [ ] $11\,\mathbf{e}(1) + 11\,\mathbf{e}(2)$

---

## Part F (1)

Suppose "$\odot$" is associative. Is "$\square$" necessarily associative as well?

## Options
- [x] Yes >>> Correct! If $(x \odot y) \odot z = x \odot (y \odot z)$ for all $x, y, z$, then expanding $(\mathbf{u} \;\square\; \mathbf{v}) \;\square\; \mathbf{w}$ and $\mathbf{u} \;\square\; (\mathbf{v} \;\square\; \mathbf{w})$ on the standard basis shows they are equal for all vectors $\mathbf{u}, \mathbf{v}, \mathbf{w}$.
- [ ] No

> [!solution]
> Write $\mathbf{u} = \sum \alpha_x \mathbf{e}(x)$, $\mathbf{v} = \sum \beta_y \mathbf{e}(y)$, $\mathbf{w} = \sum \gamma_z \mathbf{e}(z)$.
>
> $(\mathbf{u} \;\square\; \mathbf{v}) \;\square\; \mathbf{w} = \sum_{x,y,z} \alpha_x \beta_y \gamma_z\, \mathbf{e}((x \odot y) \odot z)$
>
> $\mathbf{u} \;\square\; (\mathbf{v} \;\square\; \mathbf{w}) = \sum_{x,y,z} \alpha_x \beta_y \gamma_z\, \mathbf{e}(x \odot (y \odot z))$
>
> When "$\odot$" is associative, $(x \odot y) \odot z = x \odot (y \odot z)$ for every triple, so the two expressions are identical.

---

## Part G (1)

Now suppose $(a, b, c)$ is a **nonassociative** triple for "$\odot$", meaning $(a \odot b) \odot c \neq a \odot (b \odot c)$. Is $(\mathbf{e}(a), \mathbf{e}(b), \mathbf{e}(c))$ a nonassociative triple for "$\square$"?

## Options
- [x] Yes >>> Correct! By definition, $\mathbf{e}(a) \;\square\; \mathbf{e}(b) = \mathbf{e}(a \odot b)$, and then $(\mathbf{e}(a) \;\square\; \mathbf{e}(b)) \;\square\; \mathbf{e}(c) = \mathbf{e}((a \odot b) \odot c)$. Similarly, $\mathbf{e}(a) \;\square\; (\mathbf{e}(b) \;\square\; \mathbf{e}(c)) = \mathbf{e}(a \odot (b \odot c))$. Since $(a \odot b) \odot c \neq a \odot (b \odot c)$, these are different basis vectors.
- [ ] No
- [ ] Not enough information

> [!solution]
> On standard basis vectors, "$\square$" simply reduces to "$\odot$": $\mathbf{e}(x) \;\square\; \mathbf{e}(y) = \mathbf{e}(x \odot y)$. So every nonassociative triple for "$\odot$" translates directly into a nonassociative triple for "$\square$." However, the key feature of this construction is that "$\square$" typically has *many more* nonassociative triples than "$\odot$" — even if "$\odot$" has just one, "$\square$" amplifies this across the whole vector space.

---

## Part H (2)

We are now ready to describe the algorithm for associativity testing. Fix a $6$-element subset $S \subset \mathbb{K}$.

1. For every $x \in X$, choose $\alpha_x, \beta_x, \gamma_x \in S$ uniformly at random, all choices independent.
2. Set $\mathbf{u} := \sum_{x \in X} \alpha_x\, \mathbf{e}(x)$, $\;\mathbf{v} := \sum_{y \in X} \beta_y\, \mathbf{e}(y)$, $\;\mathbf{w} := \sum_{z \in X} \gamma_z\, \mathbf{e}(z)$.
3. Compute the vectors $(\mathbf{u} \;\square\; \mathbf{v}) \;\square\; \mathbf{w}$ and $\mathbf{u} \;\square\; (\mathbf{v} \;\square\; \mathbf{w})$. If they are equal, answer YES; otherwise, answer NO.

Given two arbitrary vectors $\mathbf{u}, \mathbf{v} \in \mathbb{K}^X$, the product $\mathbf{u} \;\square\; \mathbf{v}$ can be computed using $O(n^2)$ lookups in the table and $O(n^2)$ operations in $\mathbb{K}$. What is the overall running time of the algorithm?

## Options
- [ ] $O(n)$
- [x] $O(n^2)$ >>> Correct! Step 1 takes $O(n)$. Step 3 computes two $\square$-products in sequence: first $\mathbf{u} \;\square\; \mathbf{v}$ in $O(n^2)$, then multiplying the result by $\mathbf{w}$ in $O(n^2)$; and similarly for the other side. Total: $O(n^2)$.
- [ ] $O(n^3)$
- [ ] $O(n^2 \log n)$

---

## Part I (2)

We now analyze the error probability. Fix a nonassociative triple $(a, b, c)$ for "$\odot$", and let $r := (a \odot b) \odot c$. Note that $a \odot (b \odot c) \neq r$.

Consider the $r$-th component of the vectors $(\mathbf{u} \;\square\; \mathbf{v}) \;\square\; \mathbf{w}$ and $\mathbf{u} \;\square\; (\mathbf{v} \;\square\; \mathbf{w})$. Define:

$$f(\alpha_a, \beta_b, \gamma_c) := \bigl((\mathbf{u} \;\square\; \mathbf{v}) \;\square\; \mathbf{w}\bigr)_r, \qquad g(\alpha_a, \beta_b, \gamma_c) := \bigl(\mathbf{u} \;\square\; (\mathbf{v} \;\square\; \mathbf{w})\bigr)_r,$$

where we view all other $\alpha_x$ ($x \neq a$), $\beta_y$ ($y \neq b$), $\gamma_z$ ($z \neq c$) as fixed constants.

Using the definition of "$\square$", we can expand:

$$f(\alpha_a, \beta_b, \gamma_c) = \sum_{\substack{x, y, z \in X \\ (x \odot y) \odot z = r}} \alpha_x \beta_y \gamma_z.$$

The monomial $\alpha_a \beta_b \gamma_c$ appears in $f$ because $(a \odot b) \odot c = r$. Does the monomial $\alpha_a \beta_b \gamma_c$ appear in $g$?

## Options
- [ ] Yes, with coefficient $1$
- [x] No >>> Correct! $g$ sums over triples $(x,y,z)$ with $x \odot (y \odot z) = r$. For the monomial $\alpha_a \beta_b \gamma_c$ to appear, we would need $a \odot (b \odot c) = r$. But $a \odot (b \odot c) \neq r$ since $(a,b,c)$ is nonassociative. So this monomial does not appear in $g$.
- [ ] Yes, with coefficient $-1$

---

## Part J (1)

What is the total degree of the polynomial $f(\alpha_a, \beta_b, \gamma_c) - g(\alpha_a, \beta_b, \gamma_c)$ in the three variables $\alpha_a, \beta_b, \gamma_c$?

## Options
- [ ] At most $1$
- [ ] At most $2$
- [x] At most $3$ >>> Correct! Each monomial in $f$ (or $g$) is a product $\alpha_x \beta_y \gamma_z$, which has degree at most $1$ in each of $\alpha_a$, $\beta_b$, and $\gamma_c$ (depending on whether $x = a$, $y = b$, $z = c$). So the total degree in these three variables is at most $3$.
- [ ] Exactly $3$

> [!hint]
> Each summand $\alpha_x \beta_y \gamma_z$ contributes degree $1$ in $\alpha_a$ if $x = a$ (and degree $0$ otherwise), similarly for $\beta_b$ and $\gamma_c$.

---

## Part K (2)

From Parts I and J, we know that $f - g$ is a **nonzero** polynomial of total degree **at most $3$** in the variables $\alpha_a, \beta_b, \gamma_c$.

Recall the **Schwartz--Zippel Lemma**: if $p(x_1, \ldots, x_k)$ is a nonzero polynomial of total degree $d$ over a field $\mathbb{K}$, and each $x_i$ is chosen independently and uniformly from a finite set $S \subseteq \mathbb{K}$, then

$$\Pr[p(x_1, \ldots, x_k) = 0] \leqslant \frac{d}{|S|}.$$

In our algorithm, $\alpha_a, \beta_b, \gamma_c$ are chosen independently and uniformly from $S$ with $|S| = 6$. What is the probability that the algorithm *fails to detect* that $(a, b, c)$ is nonassociative — i.e., that $f(\alpha_a, \beta_b, \gamma_c) = g(\alpha_a, \beta_b, \gamma_c)$?

## Options
- [ ] $0$
- [ ] at most $\frac{1}{6}$
- [ ] at most $\frac{1}{3}$
- [x] at most $\frac{1}{2}$ >>> Correct! By Schwartz--Zippel, the probability that the nonzero polynomial $f - g$ of degree $\leqslant 3$ evaluates to zero is at most $\frac{3}{|S|} = \frac{3}{6} = \frac{1}{2}$.
- [ ] at most $\frac{2}{3}$

---

## Part L (2)

Which of the following correctly describes the guarantees of this algorithm?

## Options
- [ ] If "$\odot$" is associative, the algorithm always answers YES. If "$\odot$" is not associative, the algorithm always answers NO.
- [x] If "$\odot$" is associative, the algorithm always answers YES. If "$\odot$" is not associative, the algorithm answers NO with probability at least $\frac{1}{2}$. >>> Correct! When "$\odot$" is associative, "$\square$" is also associative (Part F), so the algorithm always answers YES. When "$\odot$" is not associative, Part K shows the algorithm detects this with probability at least $\frac{1}{2}$.
- [ ] If "$\odot$" is associative, the algorithm answers YES with probability at least $\frac{1}{2}$. If "$\odot$" is not associative, the algorithm always answers NO.
- [ ] If "$\odot$" is associative, the algorithm answers YES with probability at least $\frac{1}{2}$. If "$\odot$" is not associative, the algorithm answers NO with probability at least $\frac{1}{2}$.

> [!solution]
> **Summary of the algorithm and its analysis.**
>
> The algorithm runs in $O(n^2)$ time, a significant improvement over the brute-force $O(n^3)$. It is a *one-sided error* randomized algorithm:
>
> - **No false negatives:** If "$\odot$" is associative, then "$\square$" is associative (Part F), and the algorithm always answers YES.
> - **Bounded false positives:** If "$\odot$" is not associative, the algorithm detects this with probability at least $\frac{1}{2}$ (Part K).
>
> The error probability can be made arbitrarily small by repeating the algorithm $k$ times with fresh randomness: the probability of failing to detect nonassociativity drops to at most $\frac{1}{2^k}$.
>
> The key insight is the *amplification through linearization*: lifting the operation from elements to vectors over a field creates far more nonassociative triples in the vector space, making random testing effective. Even when "$\odot$" has a single nonassociative triple among $n^3$ possibilities, the linear extension "$\square$" has enough nonassociative vector triples that random sampling succeeds with constant probability.
>
> **Source.** S. Rajagopalan and L. Schulman, *Verification of Identities*, SIAM J. Computing **29**(4) (2000), 1155--1163.
