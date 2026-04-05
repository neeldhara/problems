---
title: Ferrying the Deceased
type: multi_part
course: Advanced Algorithms
topic: NP-Hardness
tags:
  - graph-coloring
  - reductions
  - complexity
difficulty: medium
bloom: apply
points: 4
course-slug: advalgo
---

Betal has picked up a part-time job that involves ferrying $n$ deceased people across a river for a smooth transition into the next phase. Certain pairs of these people are sworn enemies, who cannot be taken together on the ferry because when on water, they can in fact get into a deadly fight, and this will be a distraction to Betal who will be navigating rough waters. It is safe to leave them on the shore because corpses don't fight on land.

The ferry has unlimited capacity, but Betal has limited time.

**Input:** Integers $k$ and $n$, and an $n$-vertex graph $G$ describing the pairs of enemies (an edge $(u,v)$ means $u$ and $v$ are enemies).

**Output:** TRUE if Betal can ferry all $n$ people across the river safely in at most $k$ rounds, FALSE otherwise.

---

## Part A

Consider 5 people: $A, B, C, D, E$ with the following enemy pairs:

$$\{A,B\}, \{B,C\}, \{C,D\}, \{D,E\}, \{E,A\}$$

(This forms a 5-cycle.)

What is the **minimum** number of ferry trips needed to transport everyone safely?

## Options
- [ ] 2 trips >>> With 2 trips, you'd need to partition the 5 people into 2 groups with no enemies in the same group. Try it — you'll find it's impossible for a 5-cycle.
- [x] 3 trips >>> Correct! A 5-cycle has chromatic number 3. One valid partition: $\{A, C\}$, $\{B, D\}$, $\{E\}$.
- [ ] 4 trips >>> You can do better! Look for larger independent sets.
- [ ] 5 trips (one person per trip) >>> This is always possible but not optimal. Look for groups of non-enemies.

> [!hint]
> Think about which people can safely travel together (no edge between them).

> [!solution]
> The enemy graph is a 5-cycle $C_5$, which has chromatic number 3.
>
> We cannot do it in 2 trips because $C_5$ is an odd cycle and not bipartite.
>
> We can do it in 3 trips:
> - Trip 1: $\{A, C\}$ (not enemies)
> - Trip 2: $\{B, D\}$ (not enemies)
> - Trip 3: $\{E\}$

---

## Part B

Is this decision problem NP-hard in general?

## Options
- [x] Yes, it is NP-hard >>> Correct! Each ferry trip must carry an independent set, so ferrying in $k$ rounds is equivalent to partitioning the graph into $k$ independent sets — exactly Graph $k$-Coloring.
- [ ] No, it can be solved in polynomial time >>> The problem is equivalent to Graph $k$-Coloring, which is NP-complete for $k \geq 3$.
- [ ] It depends on whether $k$ is part of the input or a fixed constant >>> While $k$-Coloring for fixed $k \geq 3$ is still NP-complete, even with $k$ as input, the problem remains NP-hard.
- [ ] The problem is not in NP >>> The problem is in NP: a certificate is a partition of people into $\leq k$ groups, verifiable in polynomial time.

> [!solution]
> Each ferry trip must carry an *independent set* of $G$ (no two enemies together). Ferrying all $n$ people in $\leq k$ rounds means partitioning $V(G)$ into $\leq k$ independent sets — exactly the definition of $k$-colorability. Since Graph $k$-Coloring is NP-complete for $k \geq 3$, this problem is NP-hard.
