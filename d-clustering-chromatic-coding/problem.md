---
title: Color and Conquer · A Chromatic Coding Algorithm for d-Clustering
type: multi_part
topic: Parameterized Algorithms · Randomized FPT
difficulty: medium
bloom: analyze
points: 6
---
A graph $H$ is called an $\ell$**-cluster graph** if $H$ has exactly $\ell$ connected components and every component is a clique. A graph is a **cluster graph** if it is an $\ell$-cluster graph for some $\ell \geqslant 1$.

For a graph $G$ and a set of pairs $A \subseteq \binom{V(G)}{2}$, the **modified graph** $G \oplus A$ has the same vertex set as $G$ and edge set $(E(G) \setminus A) \cup (A \setminus E(G))$ — i.e., we toggle the pairs in $A$.

In the $d$-**Clustering** problem we are given an undirected graph $G$ and a non-negative integer $k$, and we ask whether there exists a set $A$ of at most $k$ adjacencies such that $G \oplus A$ is a $d$-cluster graph. Here $d$ is a fixed constant.

We will walk through the **chromatic coding** algorithm. The idea is to randomly color the vertices of $G$ with $q := \lceil \sqrt{8k} \rceil$ colors using a coloring $\chi : V(G) \to [q]$, hoping that for the (unknown) solution $A$, every pair $uv \in A$ satisfies $\chi(u) \neq \chi(v)$. If so, we say that $A$ is **properly colored** by $\chi$.

## Part A (1)

Suppose we want to know if it is possible, given a graph $G$, to delete a subset $S$  at most $k$ vertices so that $G \setminus S$ is a cluster graph. Which of the following is true?

- [ ] Reduce from Clique: $G$ has a clique of size $k$ if and only if $G$ can be made into a cluster graph by the removal of $n-k$ vertices.
- [x] Branch on induced paths on three vertices, since $G$ is a cluster graph if and only if $G$ has no induced paths on three vertices, this leads to a FPT algorithm.
- [ ] Just run the chromatic coding algorithm by looping over all valid choices of $\ell$, this is also a valid FPT algorithm

> [!solution]
> To be updated.

## Part B (1)

Let $G$ be the path $a - b - c - d$ on four vertices, $d = 2$, and $k = 1$. Which **single** modification $A$ (i.e., $|A| = 1$) makes $G \oplus A$ a $2$-cluster graph?

- [ ] $A = \{ac\}$ >>> Adds the chord $ac$. The graph stays connected ($1$ component) and is not a clique, so not a cluster graph.
- [x] $A = \{bc\}$ >>> Removes the middle edge, leaving the two cliques $\{a,b\}$ and $\{c,d\}$ — exactly two cliques.
- [ ] $A = \{ad\}$ >>> Adds the chord $ad$, creating the cycle $C_4$, which has $1$ component and is not a clique.
- [ ] $A = \{bd\}$ >>> The resulting graph stays connected with $4$ vertices but is missing the edges $ac$ and $ad$, so it is not a clique.

> [!solution]
> Deleting the middle edge $bc$ disconnects the path into two $K_2$'s, which is the unique $2$-cluster graph on $\{a,b,c,d\}$ reachable in one toggle.

## Part C (1)

Suppose $\chi$ properly colors a solution $A$, i.e., every pair $uv \in A$ has $\chi(u) \neq \chi(v)$. Pick the strongest correct statement about the induced subgraph $G[V_i]$, where $V_i := \chi^{-1}(i)$ is one of the color classes.

- [ ] $G[V_i]$ is always a single clique. >>> It has at most $d$ cliques, but possibly fewer than $d$ — and possibly more than one.
- [x] $G[V_i]$ is itself a cluster graph with at most $d$ components. >>> Inside $V_i$ no edges of $A$ are toggled, so $G[V_i] = (G \oplus A)[V_i]$. The latter is an induced subgraph of a $d$-cluster graph, hence a cluster graph with $\leqslant d$ components.
- [ ] $G[V_i]$ is always edgeless. >>> Edges within a color class are simply edges of $G$ that the solution does not touch — they can certainly exist.
- [ ] $G[V_i]$ is a path. >>> Nothing in the argument forces a path structure.

> [!solution]
> Since $A$ is properly colored, no pair in $A$ has both endpoints in the same color class. Therefore $G[V_i] = (G \oplus A)[V_i]$. As $G \oplus A$ is a $d$-cluster graph and induced subgraphs of cluster graphs are cluster graphs, $G[V_i]$ is a cluster graph; and it inherits at most $d$ components from the $d$ clusters of $G \oplus A$.

## Part D (1)

Let us know explore a dynamic programming approach on a colored instance, where we assume that we are working with a good partition.

**Setup.** List the components of $G[V_1], G[V_2], \ldots, G[V_q]$ in any order: $C_1, C_2, \ldots, C_N$, with $N \leqslant dq$ since each color contributes at most $d$ components (Part C).

**Within-color constraint.** Within a single color $V_i$, distinct components of $G[V_i]$ are pairwise non-adjacent in $G$, hence in $G \oplus A$, hence sit in *distinct* clusters of $G \oplus A$. Call a subset $T \subseteq \{C_1, \ldots, C_N\}$ **valid** if it contains at most one component from each color. Each cluster of $G \oplus A$ is a valid subset.

**Cost decomposition.** For two components $C, C'$ from *different* colors, let $w_{\text{same}}(C, C')$ be the number of non-edges of $G$ between vertices of $C$ and $C'$, and $w_{\text{diff}}(C, C')$ the number of edges. The total toggle cost decomposes cleanly:

$$\mathrm{cost}(\mathrm{partition}) \;=\; D \;+\; \sum_{b=1}^{d}\, \mathrm{f}(T_b)$$

where:

$$\mathrm{f}(T) \;:=\; \!\!\sum_{\substack{C, C' \in T\\ C \neq C',\, \chi(C) \neq \chi(C')}}\!\! \big(w_{\text{same}}(C, C') - w_{\text{diff}}(C, C')\big),$$

and $D$ is a constant depending only on $G$ (the total cross-color edge count). Crucially, $\mathrm{f}(T)$ depends *only on the components in $T$* — not on what is happening in the other clusters.

**DP cell.** For $U \subseteq \{C_1, \ldots, C_N\}$ and $b \in \{0, 1, \ldots, d\}$,

$$\mathrm{dp}[U, b] \;=\; \min \sum_{j=1}^{b} \mathrm{f}(T_j),$$

where the minimum is over partitions of $U$ into $b$ non-empty valid clusters $T_1, \ldots, T_b$.

**Recurrence.** Peel off one cluster $T \subseteq U$ at a time:

$$\mathrm{dp}[U, b] \;=\; \min_{\substack{T \subseteq U,\; T \neq \emptyset \\ T \text{ valid}}}\big(\mathrm{dp}[U \setminus T, b-1] \;+\; \mathrm{f}(T)\big).$$

**Base / answer.** $\mathrm{dp}[\emptyset, 0] = 0$, and the algorithm accepts iff $D + \mathrm{dp}[\{C_1, \ldots, C_N\}, d] \leqslant k$.

**Question.** How many cells does this DP table have?

## Options
- [ ] $d^{c_1 + c_2 + \cdots + c_q} \leqslant d^{dq} = 2^{O(d \log d \, \sqrt{k})}$. >>> This is the count for the *brute-force* enumeration of full assignments — one cell per global mapping of components to clusters. The subset DP is much smaller because cells are indexed by *subsets*, not by full assignments.
- [x] $(d+1) \cdot 2^N \;\leqslant\; (d+1) \cdot 2^{dq} \;=\; 2^{O(d \, \sqrt{k})}$. >>> The cells are pairs $(U, b)$ with $U \subseteq \{C_1, \ldots, C_N\}$ and $b \in \{0, 1, \ldots, d\}$, giving $2^N \cdot (d+1)$ cells. Plugging in $N \leqslant dq = d \sqrt{8k}$ yields $2^{O(d \sqrt{k})}$ — *no* $\log d$ factor.
- [ ] $d^k$ — single-exponential in $k$. >>> The DP table size depends on the number of *components* $N \leqslant d \sqrt{8k}$, not on $k$ itself.
- [ ] $n^{O(\sqrt{k})}$ — XP-style. >>> The DP table size depends on $d$ and $q$, not on $n$.
- [ ] $\binom{N}{d}$ — choosing which $d$ components are "first" in their cluster. >>> Doesn't capture the subset structure of $U$ at all.

> [!solution]
> The DP table is indexed by $(U, b)$ where $U \subseteq \{C_1, \ldots, C_N\}$ and $b \in \{0, 1, \ldots, d\}$. There are $2^N$ subsets and $d+1$ values of $b$, giving $(d+1) \cdot 2^N$ cells. With $N \leqslant dq = d \cdot \lceil \sqrt{8k}\rceil$ and $d$ a constant, this is $2^{O(d \sqrt{k})}$.
>
> Compare with the brute-force enumeration of full cluster-assignments: $d^{dq} = 2^{O(d \log d \sqrt{k})}$ — strictly worse by a $\log d$ factor in the exponent. The cost decomposition $\mathrm{cost} = D + \sum_b \mathrm{f}(T_b)$ is what lets the DP forget the *labels* of the clusters and just track which components have been peeled off so far, dramatically shrinking the state space.

> [!hint]
> Why are subsets enough as state? Because $\mathrm{f}(T)$ depends only on the components inside $T$ — not on what other clusters look like. So once we have committed to a cluster $T$, all the remaining work is independent of $T$'s identity, and we can recurse on $U \setminus T$ alone.

## Part E (1)

For each DP cell $(U, b)$, computing $\mathrm{dp}[U, b]$ requires iterating over all valid non-empty subsets $T \subseteq U$. The total number of (cell, transition) pairs is therefore

$$\sum_{U \subseteq [N]} (d+1) \cdot 2^{|U|} \;=\; (d+1) \cdot \sum_{i=0}^{N} \binom{N}{i} 2^i \;=\; (d+1) \cdot 3^N.$$

Each transition computes $\mathrm{f}(T)$ in $\mathrm{poly}(n)$ time. Wrap this DP inside the chromatic-coding outer loop — $2^{O(\sqrt{k})}$ random colorings to amplify the success probability to $\Omega(1)$ — and treat $d$ as a constant. The total running time is:

- [x] $2^{O(d \, \sqrt{k})} \cdot n^{O(1)}$. >>> Per coloring: DP work $= O((d+1) \cdot 3^N) \cdot \mathrm{poly}(n) = 2^{O(d \sqrt{k})} \cdot n^{O(1)}$ (since $N \leqslant d \sqrt{8k}$ and $3^N = 2^{N \log_2 3}$). Multiply by $2^{O(\sqrt{k})}$ outer repetitions; for fixed $d$ this collapses to $2^{O(\sqrt{k})} \cdot n^{O(1)}$.
- [ ] $2^{O(d \log d \, \sqrt{k})} \cdot n^{O(1)}$. >>> This is the *brute-force* runtime, with the extra $\log d$ in the exponent. The subset DP shaves the $\log d$ off by exploiting the cost decomposition.
- [ ] $2^{O(k)} \cdot n^{O(1)}$. >>> Single-exponential — *worse* than what chromatic coding achieves; the whole point of using $\sqrt{8k}$ colors is to avoid this regime.
- [ ] $n^{O(\sqrt{k})}$. >>> The exponent of $n$ is a constant — this is FPT, not XP.
- [ ] $\mathrm{poly}(n)$. >>> $d$-Clustering is NP-hard for $d \geqslant 2$, so a polynomial-time algorithm is not on offer.

> [!solution]
> The full breakdown:
>
> - Outer loop (chromatic-coding repetitions): $2^{O(\sqrt{k})}$
> - Subset-DP transitions per coloring: $(d+1) \cdot 3^N \;=\; 2^{O(d \sqrt{k})}$
> - Per-transition work for $\mathrm{f}(T)$: $\mathrm{poly}(n)$
>
> The product is $2^{O(\sqrt{k})} \cdot 2^{O(d \sqrt{k})} \cdot n^{O(1)} = 2^{O(d \sqrt{k})} \cdot n^{O(1)}$, which is $2^{o(k)}$ for fixed $d$ — a genuinely sub-exponential parameterised algorithm. This is one of the few problems where sub-exponential FPT is known.
>
> The win over brute force (which gives $2^{O(d \log d \sqrt{k})}$) comes entirely from the *cost decomposition*: because $\mathrm{f}(T)$ depends only on the cluster $T$, the DP can index by subsets rather than by full cluster-assignments, replacing $d^{dq}$ enumerations with $3^N$ subset-pair iterations.

> [!hint]
> The chromatic-coding trade-off:
> - fewer colors $\Rightarrow$ higher success probability per random coloring (so fewer outer repetitions);
> - more colors $\Rightarrow$ smaller "colored" subproblem to solve via the DP (so cheaper inner work).
>
> Setting $q = \lceil \sqrt{8k} \rceil$ balances the two and pushes the exponent from $k$ down to $\sqrt{k}$.
