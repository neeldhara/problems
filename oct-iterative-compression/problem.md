---
title: Odd Cycle Transversal via Iterative Compression
type: multi_part
course: Advanced Algorithms
topic: Parameterized Algorithms
tags: [odd-cycle-transversal, iterative-compression, parameterized, bipartite, min-cut]
difficulty: medium
bloom: analyze
points: 7
course-slug: advalgo
---
In **Odd Cycle Transversal (OCT)**, we are given an undirected graph $G$ and a positive integer $k$. The goal is to find a set $X \subseteq V(G)$ with $|X| \leq k$ such that $G - X$ is bipartite, or to conclude that no such set exists. These questions walk through the key ideas behind solving OCT using iterative compression.

Suppose we apply iterative compression and arrive at the following subroutine, called **Disjoint Odd Cycle Transversal**: we are given $G$, an integer $k$, and a set $W$ of $k+1$ vertices such that $G - W$ is bipartite. The objective is to find a set $X \subseteq V(G) \setminus W$ of at most $k$ vertices such that $G - X$ is bipartite, or to conclude that no such set exists.

## Part A

Since $X \subseteq V(G) \setminus W$, every vertex of $W$ remains in $G - X$. In particular, $G[W]$ must also be bipartite. Suppose $G[W]$ is indeed bipartite and has $c$ connected components. How many proper $2$-colorings $f_W : W \to \{1,2\}$ does $G[W]$ admit?

## Options
- [ ] $c$
- [ ] $k + 1$
- [x] $2^c$
- [ ] $2^{k+1}$

> [!hint]
> In a connected bipartite graph, there are exactly two proper $2$-colorings (one is the swap of the other). Think about what this means for each connected component independently.

> [!solution]
> $2^c$. A bipartite graph with $c$ connected components admits exactly $2^c$ proper $2$-colorings, since each component can independently swap its two color classes.

## Part B

For a fixed proper $2$-coloring $f_W$ of $G[W]$, let $B_1^W = f_W^{-1}(1)$ and $B_2^W = f_W^{-1}(2)$. Consider a vertex $v \in V(G) \setminus W$ that is adjacent to at least one vertex in $B_1^W$ and at least one vertex in $B_2^W$. What can we conclude about such a vertex $v$? It is important to note that this question is in the context of a fixed choice of $f_W$, which is our guess for how the vertices of $W$ get colored in $G - X$. 

## Options
- [ ] $v$ must be colored $1$ in $G - X$
- [ ] $v$ must be colored $2$ in $G - X$
- [ ] $v$ can be colored either $1$ or $2$
- [x] $v$ must be included in $X$ (i.e., deleted)

> [!hint]
>  If $v \notin X$, then $v$ must receive a color that differs from both a color-$1$ neighbor and a color-$2$ neighbor — which is impossible with only two colors. In other words, if $v$ stays in the graph, it needs a color from $\{1,2\}$. 

> [!solution]
> $v$ must be included in $X$. With neighbors in both color classes, no single color from $\{1,2\}$ can be assigned to $v$ without creating a monochromatic edge.

## Part C

Assume there are no vertices adjacent to both color classes of $W$. Then the remaining vertices of $V(G) \setminus W$ fall into three categories: those with neighbors only in $B_1^W$ (call this set $B_2$, since they must receive color $2$ or be deleted), those with neighbors only in $B_2^W$ (call this set $B_1$, since they must receive color $1$ or be deleted), and those with no neighbors in $W$ at all. 

Independently, recall that $G - W$ is bipartite and already has some proper $2$-coloring. Let us denote this $2$-coloring by $f^*: V(G - W) \rightarrow \{1,2\}$.

Such an instance — a bipartite graph with a known $2$-coloring $f^*$ and prescribed color classes $B_1, B_2$ — the problem is called **Annotated Bipartite Coloring**. Consider the vertices of $C := (B_1 \cap (f^*)^{-1}(2)) \cup (B_2 \cap (f^*)^{-1}(1))$, i.e., those that must _change_ their color relative to $f^*$, and the vertices of $R := (B_1 \cap (f^*)^{-1}(1)) \cup (B_2 \cap (f^*)^{-1}(2))$, i.e., those that must _retain_ their color. 

We don't know $X$ yet, but for analysis, we observe that any connected component of $G \setminus X$, either all vertices keep their $f^*$-color or all vertices flip (why?). Thus, which of the following must hold?

## Options
- [ ] Every vertex of $C$ must be included in $X$
- [ ] Every vertex of $R$ must be included in $X$
- [x] No connected component of $G \setminus X$ contains both a vertex of $C$ and a vertex of $R$
- [ ] $|C| \leq |R|$

> [!hint]
> In a connected bipartite graph, if you know the color of one vertex, the coloring of the entire component is determined. So within a component, either every vertex keeps its original color, or every vertex flips. What happens if the component contains one vertex that must flip and another that must stay?

> [!solution]
> No connected component of $G \setminus X$ contains both a vertex of $C$ and a vertex of $R$. In a connected component of a bipartite graph, any two proper $2$-colorings either agree everywhere or disagree everywhere (i.e., one is the flip of the other). So if one vertex must flip and another must stay, they cannot be in the same component.

## Part D

Based on your answer to the previous question, how will you find the set $X$?

## Options
- [ ] A greedy algorithm that iteratively removes high-degree vertices
- [x] A maximum flow / minimum cut computation
- [ ] Dynamic programming on a tree decomposition
- [ ] A reduction to $2$-SAT

> [!hint]
> Think about the relationship between vertex separators and network flows. There is a classical min-max duality at play here.

> [!solution]
> Maximum flow / minimum cut. Finding a minimum vertex separator between two sets is equivalent to a minimum cut problem in an appropriately constructed network (split each vertex into two nodes connected by a unit-capacity edge, add a source connected to all of $C$ and a sink connected to all of $R$).

## Part E

Based on your choices above, what is your running time for the **Disjoint** Odd Cycle Transversal problem?

## Options
- [ ] $\mathcal{O}(k(n+m))$
- [x] $\mathcal{O}(2^k \cdot k(n+m))$
- [ ] $\mathcal{O}(k^2(n+m))$
- [ ] $\mathcal{O}(2^{k^2} \cdot (n+m))$

> [!hint]
> For each of the at most $2^{k+1}$ colorings, we solve one min-cut instance. What is the product?

> [!solution]
> $\mathcal{O}(2^k \cdot k(n+m))$. We iterate over at most $2^{k+1}$ colorings, and for each we solve a min-cut instance in $\mathcal{O}(k(n+m))$ time.

## Part F

So far we have solved the **disjoint** variant, where $X \cap W = \emptyset$. For the full compression step, we do not require $X$ to be disjoint from $W$. Instead, for each vertex $w \in W$, there are three possibilities: (i) $w \in X$ (deleted), (ii) $w \notin X$ and is colored $1$, or (iii) $w \notin X$ and is colored $2$. For a fixed choice of which vertices of $W$ are deleted, the remainder is a Disjoint OCT instance (with a smaller $W$ and adjusted budget). The total number of such choices across all vertices of $W$ is:

## Options
- [ ] $2^{k+1}$
- [x] $3^{k+1}$
- [ ] $(k+1)!$
- [ ] $\binom{2(k+1)}{k+1}$

> [!hint]
> Think of it combinatorially: choosing a subset $S \subseteq W$ to delete and then a $2$-coloring of $W \setminus S$ is the same as assigning each vertex of $W$ one of three labels. You can also verify this algebraically: $\sum_{S \subseteq W} 2^{|W \setminus S|} = 3^{|W|}$.

> [!solution]
> $3^{k+1}$. Each of the $k+1$ vertices in $W$ independently has three options: be deleted, be colored $1$, or be colored $2$. This gives $3^{k+1}$ total scenarios, each of which reduces to an Annotated Bipartite Coloring instance.

## Part G

Combining everything: each of the $3^{k+1}$ scenarios leads to an Annotated Bipartite Coloring instance solvable in $\mathcal{O}(k(n+m))$ time, giving $\mathcal{O}(3^k \cdot k(n+m))$ per compression step. The iterative compression framework processes vertices one at a time ($n$ iterations total). What is the overall running time for Odd Cycle Transversal?

## Options
- [ ] $\mathcal{O}(2^k \cdot kn(n+m))$
- [x] $\mathcal{O}(3^k \cdot kn(n+m))$
- [ ] $\mathcal{O}(4^k \cdot n(n+m))$
- [ ] $\mathcal{O}(2^{k^2} \cdot n^2)$

> [!hint]
> Multiply the cost of one compression step by the number of iterations in the framework.

> [!solution]
> $\mathcal{O}(3^k \cdot kn(n+m))$. The iterative compression framework runs $n$ iterations, and each compression step takes $\mathcal{O}(3^k \cdot k(n+m))$ time. This matches Theorem 4.17 from the textbook.
