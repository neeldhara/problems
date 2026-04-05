---
title: Shortest Common Superstring
type: multi_part
course: Advanced Algorithms
topic: Greedy
tags: [strings]
difficulty: medium
bloom: analyze
points: 15
course-slug: advalgo
---

In the Shortest Common Superstring Problem (SCS), one is given a set of strings and needs to find the shortest string that contains all of them as substrings. We denote the set of $n$ input strings by $\mathcal{S}=\left\{s_1, \ldots, s_n\right\}$.

For a string $s$, by $|s|$ we denote its length. For non-empty strings $s$ and $t$, by $\text{ov}(s, t)$ we denote their overlap, that is, the longest string $y$, such that $s=xy$ and $t=yz$ for some non-empty strings $x$ and $z$. In this case, the string $xyz$ is called a *merge* of $s$ and $t$.

**Example 1:** Consider $\mathcal{S} = \{\texttt{abc}, \texttt{bcd}, \texttt{cde}\}$.
- $\text{ov}(\texttt{abc}, \texttt{bcd}) = \texttt{bc}$ (length 2)
- $\text{ov}(\texttt{bcd}, \texttt{cde}) = \texttt{cd}$ (length 2)
- Merging in order $(\texttt{abc}, \texttt{bcd}, \texttt{cde})$ gives: $\texttt{abcde}$ (length 5)
- Total length = $3 + 3 + 3 - 2 - 2 = 5$

**Example 2:** Consider $\mathcal{S} = \{\texttt{cat}, \texttt{atom}, \texttt{omit}\}$.
- $\text{ov}(\texttt{cat}, \texttt{atom}) = \texttt{at}$ (length 2)
- $\text{ov}(\texttt{atom}, \texttt{omit}) = \texttt{om}$ (length 2)
- Merging in order $(\texttt{cat}, \texttt{atom}, \texttt{omit})$ gives: $\texttt{catomit}$ (length 7)
- The compression is $2 + 2 = 4$

**Example 3:** Consider $\mathcal{S} = \{\texttt{ab}, \texttt{bc}, \texttt{ca}\}$.
- $\text{ov}(\texttt{ab}, \texttt{bc}) = \texttt{b}$, $\text{ov}(\texttt{bc}, \texttt{ca}) = \texttt{c}$, $\text{ov}(\texttt{ca}, \texttt{ab}) = \texttt{a}$
- Order $(\texttt{ca}, \texttt{ab}, \texttt{bc})$ gives: $\texttt{cabc}$ (length 4)
- Order $(\texttt{ab}, \texttt{bc}, \texttt{ca})$ gives: $\texttt{abca}$ (length 4)

---

## Part A

Argue that to solve SCS, it is sufficient to find:

## Options
- [x] a permutation $\pi$ of $[n]$ such that when we consider the input strings in the order $\left(s_{\pi(1)}, \ldots, s_{\pi(n)}\right)$, the length of the string obtained by merging adjacent strings is as small as possible.
- [ ] a permutation $\pi$ of $[n]$ such that when we consider the input strings in the order $\left(s_{\pi(1)}, \ldots, s_{\pi(n)}\right)$, the length of the string obtained by merging adjacent strings is as large as possible.
- [ ] Neither of the above

> [!solution]
> WLOG, there are no repeats. Any solution contains all the input strings in some order; this order corresponds to the desired permutation.

---

## Part B

Observe that for a given $\pi$, the length of the corresponding superstring $s(\pi)$, which is obtained by writing the input strings in the order $\left(s_{\pi(1)}, \ldots, s_{\pi(n)}\right)$ and merging adjacent strings, is given by:

$$
|s(\pi)|=\sum_{i=1}^n\left|s_i\right|-\sum_{i=1}^{n-1}\left|\text{ov}\left(s_{\pi(i)}, s_{\pi(i+1)}\right)\right|
$$

The *compression* of $\pi$ is the sum of the overlaps of adjacent strings in the permutation $\pi$. Finding a shortest superstring is equivalent to:

## Options
- [x] Finding a permutation $\pi$ that maximizes the compression.
- [ ] Finding a permutation $\pi$ that minimizes the compression.
- [ ] Neither of the above

> [!solution]
> Since the sum of string lengths $\sum_{i=1}^n |s_i|$ is fixed, minimizing the superstring length is equivalent to maximizing the sum of overlaps (i.e., the compression).

---

## Part C

Consider $\mathcal{S} = \{\texttt{abc}, \texttt{bca}, \texttt{cab}\}$. What is the length of the shortest common superstring?

## Answer
5

> [!solution]
> The overlaps are:
> - $\text{ov}(\texttt{abc}, \texttt{bca}) = \texttt{bc}$ (length 2)
> - $\text{ov}(\texttt{bca}, \texttt{cab}) = \texttt{ca}$ (length 2)
> - $\text{ov}(\texttt{cab}, \texttt{abc}) = \texttt{ab}$ (length 2)
>
> Using order $(\texttt{cab}, \texttt{abc}, \texttt{bca})$ gives $\texttt{cabca}$ with length 5.
> This achieves total compression of 4, which is optimal since each string has length 3 and we have 3 strings, giving $3 \times 3 - 4 = 5$.

> [!hint]
> Try different permutations and compute the overlaps for each adjacent pair.

---

## Part D

We define an overlap graph $OG(\mathcal{S})$ associated with $\mathcal{S}$ as follows: $OG(\mathcal{S})$ is a complete directed graph $(V, E)$ (that is, for every $s, t \in V$ there are edges $(s, t)$ and $(t, s)$), where $V=\mathcal{S}$, and the weight of an edge $(s, t)$ is $|\text{ov}(s, t)|$.

Let us say that an edge $(u, v)$ *dominates* another edge $(u', v')$, if they share head or tail (that is, $u=u'$ or $v=v'$) and $|\text{ov}(u, v)| \geq |\text{ov}(u', v')|$.

In terms of the overlap graph, the greedy algorithm goes through a list of all edges in $OG(\mathcal{S})$ in the nonincreasing order of their overlap and includes some of them in a solution. Specifically, the greedy algorithm does not include another edge if and only if:

- **R1.** it is dominated by an already chosen edge,
- **R2.** it is not dominated but it would form a cycle.

What is the structure of the set of edges returned by the greedy algorithm?

## Options
- [ ] A Hamiltonian cycle, i.e., a cycle that visits every vertex in the graph exactly once
- [x] A Hamiltonian path, i.e., a path that visits every vertex in the graph exactly once
- [ ] A regular graph, i.e., a graph where every vertex has the same degree

> [!solution]
> The greedy algorithm selects exactly $n-1$ edges (one less than the number of vertices). By R1, each vertex has at most one outgoing and one incoming selected edge. By R2, there are no cycles. Together, this forms a Hamiltonian path.

---

## Part E

Does the greedy algorithm always produce the optimal (shortest) superstring?

## Options
- [ ] Yes
- [x] No

> [!solution]
> The greedy algorithm does not always produce the optimal solution. Consider $\mathcal{S} = \{\texttt{ab}, \texttt{bb}, \texttt{bc}\}$:
> - Greedy might pick edge $(\texttt{ab}, \texttt{bb})$ with overlap 1, then $(\texttt{bb}, \texttt{bc})$ with overlap 1, giving $\texttt{abbc}$ (length 4).
> - But the optimal is $(\texttt{ab}, \texttt{bc})$ with overlap 1, and $\texttt{bb}$ can overlap with both, giving potentially shorter solutions depending on the tie-breaking.
>
> More generally, the greedy algorithm is known to give a 3.5-approximation for SCS.
