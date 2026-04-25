---
title: A Fair Share for Everyone · W[1]-Hardness of Equitable Connected Fair Division
type: multi_part
topic: Parameterized Complexity · Fair Division · W[1]-hardness · Reductions from Multicolored Independent Set
difficulty: hard
bloom: analyze
points: 5
---
In discrete fair division problems, we typically have $n$ agents, $m$ items, and each agent $i$ has a valuation function $u_i : [m] \to \mathbb{N}_{\geqslant 0}$ indicating that they derive $u_i(x)$ value if item $x$ is given to them. We assume valuations are additive, that is, if an agent is given a subset $S \subseteq [m]$ of items, then the value they derive from it is $\sum_{x \in S} u_i(x)$. 

An _allocation_ of items is a partition of the set of $m$ items into $n$ parts, with the $i$-th part being the set of items given to agent $i$, usually called the _bundle_ of agent $i$. An allocation is _equitable_ if all agents derive the same value from their respective bundles.

In this problem we will look at a variation of equitable allocation where the items are the nodes of a graph, and we want the bundles to induce connected subgraphs, however we don't have to allocate all items.

In particular, in the **Equitable Incomplete Connected Fair Division** problem (henceforth **EQ-ICFD**), an instance is a tuple $(G, A, \mathcal{U}, p, T)$, where:

- $G$ is the *utility graph* on $m$ items;
- $A = [n]$ is the set of $n$ *agents*;
- $\mathcal{U} = (u_1, \ldots, u_n)$ is a tuple of *additive* valuations $u_i : V(G) \to \mathbb{N}_{\geqslant 0}$;
- $p \in [0, m]$ is the number of items to allocate;
- $T \in \mathbb{N}$ is a *target value*.

An *allocation* is a tuple $\Pi = (\pi_1, \ldots, \pi_n)$ of pairwise disjoint subsets $\pi_i \subseteq V(G)$. These subsets are allowed to be empty. An allocation is **valid** if $\sum_{i=1}^n |\pi_i| = p$ and each $G[\pi_i]$ is connected. It is **equitable** if every agent receives exactly the target value:
$$
u_i(\pi_i) = T \qquad \text{for every } i \in [n].
$$
We will prove:

> $\mathrm{EQ\text{-}ICFD}$ is W[1]-hard parameterized by the number of agents $n$.

**Source problem.** $d$-regular **Multicolored Independent Set** ($d$-MCIS): given a $d$-regular graph $H$ with vertex set partitioned into colour classes $V_1, \ldots, V_k$, find an independent set $\{v_1, \ldots, v_k\}$ with $v_i \in V_i$. This problem is W[1]-hard parameterized by $k$ (for some fixed $d \geqslant 3$).

**The construction.** Given an instance $(H, V_1, \ldots, V_k)$ of $d$-MCIS:

1. Let $G$ be the **vertex-edge incidence graph** of $H$: $V(G) = V(H) \cup E(H)$, and a vertex $u \in V(H)$ is adjacent in $G$ to an "edge vertex" $e \in E(H)$ iff $u$ is an endpoint of $e$ in $H$. Note hat there are no edges within $V(H)$ and no edges within $E(H)$.)
2. Use $k$ agents, one per color class.
3. Valuations: for each $i \in [k]$,
   $$
   u_i(x) \;=\;
   \begin{cases}
   d + 1 & \text{if } x \in V_i, \\
   1 & \text{if } x \in E(H), \\
   0 & \text{otherwise} \quad (x \in V_j,\, j \neq i).
   \end{cases}
   $$
4. We will come back to the values of $p$ and $T$.

## Part A (1)

Apply the construction to $H$ with $V(H) = \{a, b, c, d\}$, partition $V_1 = \{a, c\}$, $V_2 = \{b, d\}$, and edge set $E(H) = \{ab,\, cd\}$ (so $H$ is $1$-regular). The resulting graph $G$ has vertex set $\{a, b, c, d, e_{ab}, e_{cd}\}$ and edges $\{a\text{-}e_{ab},\, b\text{-}e_{ab},\, c\text{-}e_{cd},\, d\text{-}e_{cd}\}$. The valuations are
- $u_1(a) = u_1(c) = 2$, $u_1(e_{ab}) = u_1(e_{cd}) = 1$, $u_1(b) = u_1(d) = 0$;
- $u_2(b) = u_2(d) = 2$, $u_2(e_{ab}) = u_2(e_{cd}) = 1$, $u_2(a) = u_2(c) = 0$.

Set $p = 4$ and $T = 3$. Which of the following is a **valid equitable allocation**?

## Options
- [x] $\pi_1 = \{a, e_{ab}\},\; \pi_2 = \{d, e_{cd}\}$. >>> Both bundles are connected in $G$, disjoint, total size $4 = p$, and the values check out: $u_1(\pi_1) = 2 + 1 = 3$ and $u_2(\pi_2) = 2 + 1 = 3$. (This is exactly the forward-direction allocation for the multicoloured independent set $\{a, d\}$ in $H$.)
- [ ] $\pi_1 = \{a, e_{ab}\},\; \pi_2 = \{c, e_{cd}\}$. >>> Connected and the right total size, but $u_2(\pi_2) = u_2(c) + u_2(e_{cd}) = 0 + 1 = 1 \neq 3$. Not equitable.
- [ ] $\pi_1 = \{a, b\},\; \pi_2 = \{c, d\}$. >>> $G[\{a, b\}]$ is not connected — $a$ and $b$ are *not* adjacent in $G$; they share the edge-vertex $e_{ab}$ as their only connection. Same problem for $\{c, d\}$.
- [ ] $\pi_1 = \{a, e_{ab}, b\},\; \pi_2 = \{c, e_{cd}, d\}$. >>> Total size is $6$, not $p = 4$.
- [ ] $\pi_1 = \{e_{ab}, e_{cd}\},\; \pi_2 = \{a, d\}$. >>> Neither bundle is connected: edge-vertices are non-adjacent in $G$, and so are colour-class vertices.

> [!solution]
> The valid equitable allocations of this instance are exactly the two "forward-direction" allocations corresponding to the two multicoloured independent sets $\{a, d\}$ and $\{c, b\}$ of $H$. The remaining options each fail one of the three constraints (equitability, connectivity, or size).

## Part B (1)

Now consider the general construction, and suppose $H$ is $d$-regular ($d \geqslant 2$) and $\{v_1, v_2, \ldots, v_k\}$ is a multicoloured independent set with $v_i \in V_i$. We have three natural candidates for a *forward-direction allocation*, each paired with the $(p, T)$ that makes it equitable:

- **(i) Just the colour-class vertex.** $\pi_i := \{v_i\}$, with $p = k$ and $T = d+1$.
- **(ii) Open neighbourhood in $G$.** $\pi_i := N_G(v_i) = \{e \in E(H) : v_i \in e\}$ (the $d$ incident edge-vertices, with $v_i$ itself excluded), with $p = kd$ and $T = d$.
- **(iii) Closed neighbourhood in $G$.** $\pi_i := N_G[v_i] = \{v_i\} \cup \{e \in E(H) : v_i \in e\}$, with $p = k(d+1)$ and $T = 2d+1$.

For our W[1]-hardness reduction we want the forward direction to (a) produce a *valid equitable allocation* and (b) leave enough structure for the **reverse direction** to recover an MCIS in $H$ from any equitable allocation. Which of the three choices satisfies both?

## Options
- [ ] (i) — bundle $\{v_i\}$ with $p = k, T = d+1$. >>> The *forward* direction is fine: singletons are trivially connected and $u_i(\{v_i\}) = d + 1 = T$. But the *reverse* direction collapses: any one-vertex-per-colour-class selection $\{v_1, \ldots, v_k\}$ is an equitable allocation, regardless of whether the $v_i$'s are independent in $H$. We cannot recover an MCIS from this.
- [ ] (ii) — bundle $N_G(v_i)$ with $p = kd, T = d$. >>> The *forward* direction is invalid for $d \geqslant 2$: edge-vertices in $G$ are pairwise non-adjacent (they share no neighbours unless they share a colour-class vertex, but $G$ has no edges within $E(H)$), so a $d$-element bundle of edge-vertices is disconnected. The very allocation $\pi_i = N_G(v_i)$ violates the connectivity requirement.
- [x] (iii) — bundle $N_G[v_i]$ with $p = k(d+1), T = 2d+1$. >>> Forward: each $\pi_i$ is the star centred at $v_i$ in $G$, hence connected, with value $u_i(\pi_i) = (d+1) + d \cdot 1 = 2d+1 = T$. Disjointness across agents comes from independence of $\{v_1, \ldots, v_k\}$ in $H$. And the reverse direction has enough room — the $(d+1)$-vertex budget combined with $T = 2d+1$ and connectivity will pin every bundle to exactly one $V_i$-vertex plus its $d$ incident edges, which is precisely what we need to recover the MCIS.
- [ ] All three work equally well. >>> Only (iii) gives both a valid forward direction and a useful reverse direction.
- [ ] None of the three work. >>> (iii) does work — the rest of the reduction relies on this choice.

> [!solution]
> Comparing the three candidates is a good way to see *why* the reduction picks $p = k(d+1), T = 2d+1$ rather than something simpler.
>
> - In (i), the bundles are too small: the value-equation $a_i(d+1) + b_i = d+1$ admits the trivial solution $a_i = 1, b_i = 0$, leaving no edge-vertices in the bundle and hence no constraint that ties the chosen $v_i$'s back to edges of $H$.
> - In (ii), the forward direction itself is broken: the $d$ edge-vertices of $N_G(v_i)$ are not adjacent to each other in $G$, so their bundle is disconnected for any $d \geqslant 2$.
> - Choice (iii) is the unique sweet spot: $T = 2d+1$ is large enough to force one $V_i$-vertex *and* $d$ edge-vertices in each bundle, and $p = k(d+1)$ tightens the budget so no extra vertices can sneak in. We will exploit this in Parts C and D.

## Part C (1)

For the reverse direction, suppose we are given a valid equitable allocation $(\pi_1, \ldots, \pi_k)$ of the constructed instance: $\sum_i |\pi_i| = p$, each $G[\pi_i]$ connected, and $u_i(\pi_i) = T$ for every $i$. For what combination of $p$ and $T$ can we conclude that each agent's bundle contains **exactly one** vertex from their own colour class $V_i$, **no** vertices from any other colour class, *and* exactly $d$ edge-vertices (so that we have the structure we need for the rest of the reverse-direction argument)?

## Options
- [ ] $p = k$ and $T = d + 1$. >>> The conclusion partly holds (bundles must contain exactly one $V_i$-vertex and nothing else), but each bundle ends up being just the singleton $\{v_i\}$ — there are *no* edge-vertices in the bundle, so we lose all the edge information we'd need to argue independence in Part D.
- [ ] $p = kd$ and $T = d$. >>> No valid equitable allocation exists in the first place: the value equation $a_i(d+1) + b_i = d$ forces $a_i = 0, b_i = d$, but a bundle of $d$ edge-vertices and no colour-class vertices is disconnected in $G$ for any $d \geqslant 2$.
- [x] $p = k(d+1)$ and $T = 2d + 1$. >>> The value equation $a_i(d+1) + b_i = 2d+1$ admits exactly two non-negative integer solutions, $a_i \in \{0, 1\}$. The case $a_i = 0$ would force $b_i = 2d+1$ edge-vertices plus at least one connecting colour-class vertex (from another class) for $G[\pi_i]$ to be connected, giving $|\pi_i| \geqslant 2d+2$. The budget $\sum_i |\pi_i| = k(d+1)$ then rules this out, so $a_i = 1$ for every $i$ — and the budget becomes tight, forcing $c_i^{\mathrm{other}} = 0$ and $b_i = d$.
- [ ] $p = k(d+1)$ and $T = d + 1$. >>> The value equation $a_i(d+1) + b_i = d+1$ admits $(a_i, b_i) \in \{(1, 0), (0, d+1)\}$. Both cases are compatible with the budget $p = k(d+1)$ in different ways, so we cannot uniquely pin down the bundle structure.
- [ ] No combination of $p$ and $T$ produces this conclusion. >>> The choice $p = k(d+1), T = 2d+1$ does — see the analysis above.

> [!solution]
> Two ingredients drive the argument when $p = k(d+1)$ and $T = 2d+1$:
>
> 1. **Value bound.** $u_i(\pi_i) = a_i(d+1) + b_i = 2d+1$ has exactly two non-negative integer solutions: $a_i = 0$ (with $b_i = 2d+1$) and $a_i = 1$ (with $b_i = d$).
>
> 2. **Budget bound.** $G$ is bipartite between colour-class vertices and edge-vertices, so any connected bundle of size $\geqslant 2$ must contain at least one of each. In particular, a bundle with $a_i = 0$ would have $b_i = 2d+1 \geqslant 3$ edge-vertices and therefore at least one colour-class vertex (necessarily from another class), giving $|\pi_i| \geqslant 2d+2$. With $\sum |\pi_i| = k(d+1)$ and every $|\pi_j| \geqslant d+1$, no agent can have a bundle as large as $2d+2$. So the case $a_i = 0$ never occurs, and $a_i = 1$ for every $i$.
>
> Once $a_i = 1$ for all agents, the budget $\sum_i |\pi_i| = k(d+1) = \sum_i (1 + d)$ is tight: there is no slack for any extra vertices, so $c_i^{\mathrm{other}} = 0$ and $b_i = d$ exactly. The smaller-$T$ choices in the other options force *some* part of this conclusion but lose the edge-vertices that the next part of the argument needs.

## Part D (1)

Continuing the reverse direction, if we now know that we can pick $p$ and $T$ to force that every agent's bundle has exactly one vertex corresponding to a vertex from $V(H)$, we may want to argue that these vertices (call them $S$) now induce an independent set back in $H$. Is this possible to argue?

## Options
- [ ] No matter how we pick $p$ and $T$, this is impossible to argue: the construction does not encode adjacency in $H$ in any valid way. >>> Adjacency in $H$ *is* visible to the bundles, via the edge-vertices in $G$. Each edge of $H$ is realised as a vertex of $G$ that can sit in at most one bundle, and that's exactly how the construction will block adjacencies.
- [x] Yes — there is a choice from Part C for which the vertices in $S$ form an independent set in $H$. >>> Exactly the disjointness pinch.

> [!solution]
> The argument is a clean three-step pinch, all using the structure of $\pi_i = \{v_i\} \cup F_i$ from Part C:
>
> 1. **Connectivity in $G$** forces every edge-vertex in $F_i$ to be adjacent (in $G$) to $v_i$ — since $v_i$ is the *only* colour-class vertex in $\pi_i$ and edge-vertices in $G$ have no neighbours other than their two endpoints. Translated back to $H$: every edge in $F_i$ is incident to $v_i$.
>
> 2. **$d$-regularity of $H$** combined with $|F_i| = d$ then forces $F_i$ to be exactly the set of all $d$ edges of $H$ incident to $v_i$.
>
> 3. **Disjointness** of bundles ($\pi_i \cap \pi_j = \emptyset$) now prohibits any edge $v_i v_j$ in $H$: such an edge would correspond to a single vertex $e_{v_i v_j}$ of $G$ that must live in both $F_i$ and $F_j$, which is impossible.
>
> Hence $\{v_1, \ldots, v_k\}$ is independent in $H$, with one vertex from each colour class — a multicoloured independent set, completing the reverse direction.
>
> *(Aside on $G$ vs $H$.)* Independence of $S$ in $G$ is trivially free, since $G$ is bipartite between $V(H)$ and $E(H)$ and $S \subseteq V(H)$ — there are no edges in $G$ between any two colour-class vertices. The non-trivial content of the argument is the lift to independence in $H$, which is what the construction was engineered to capture.

## Part E (1)

Putting Parts B–D together, we have a parameterized reduction from $d$-MCIS to $\mathrm{EQ\text{-}ICFD}$. Which of the following parameters does **this reduction directly transfer** the W[1]-hardness of $d$-MCIS to?

## Options
- [x] $n$ alone (the number of agents). >>> Correct: the MCIS parameter $k$ is exactly the number of agents in the constructed instance ($n = k$), so the reduction *is* a parameterized reduction in $n$. This is the classical statement.
- [ ] $m$ alone (the number of items). >>> $m$ scales with $|V(H)|$, which is *not* bounded by any function of $k$. So the reduction is not a parameterized reduction with $m$ as the target parameter.
- [ ] $T$ alone (the target value). >>> $T = 2d + 1$ is a *constant* in the reduction, so we get NP-hardness for fixed $T$ (paraNP-hardness) rather than W[1]-hardness in the sense the MCIS parameter would carry.
- [ ] $p$ alone (the number of items to allocate). >>> Technically this is also a valid hardness statement: $p = k(d+1)$ is bounded by a linear function of $k$, so the reduction is also a parameterized reduction in $p$. However, since $p = (d+1) \cdot n$ in our construction, parameterizing by $p$ adds no new information beyond parameterizing by $n$ — the cleaner classical statement is in $n$.
- [ ] $(n, m)$ — agents and items. >>> $m$ is unbounded in $k$, so this combination fails to give a parameterized reduction.
- [ ] $(n, T)$ — agents and target. >>> A valid hardness statement (both are bounded), but adds nothing beyond hardness in $n$ alone — $T$ being constant is incidental once $n = k$.
- [ ] $(n, p)$ — agents and items-to-allocate. >>> Both bounded, so technically valid, but $p$ is determined by $n$ and the constant $d$ — this combination collapses to "hardness in $n$" with extra accounting.
- [ ] $(m, T)$ — items and target. >>> $m$ unbounded.
- [ ] $(m, p)$ — items and items-to-allocate. >>> $m$ unbounded.
- [ ] $(p, T)$ — items-to-allocate and target. >>> Both bounded, so the reduction does transfer hardness here too — but again, this is strictly weaker than hardness in $n$ alone, since $p$ and $T$ are both functions of $n$ in the construction.

> [!solution]
> A parameterized reduction from $(\Pi_1, k_1)$ to $(\Pi_2, k_2)$ requires that $k_2 \leqslant f(k_1)$ for some computable function $f$. In our reduction:
>
> | Parameter of EQ-ICFD | Value | Bound by $f(k)$? |
> |----------------------|-------|------------------|
> | $n$ | $k$ | yes — linear |
> | $m$ | $\mid V(H) \mid (1 + d/2)$ | **no** — unbounded in $k$ |
> | $p$ | $k(d+1)$ | yes — linear (for fixed $d$) |
> | $T$ | $2d+1$ | yes — constant |
>
> Any parameter combination that *includes* $m$ fails to be a parameterized reduction. The remaining options — $n, p, T, (n,T), (n,p), (p, T)$ — all give *valid* W[1]-hardness statements via this reduction. The strongest single-parameter statement is **hardness in $n$ alone**: it is the smallest of the bounded parameters in the reduction (the others are constants or polynomial blowups of $n$), and in our construction $T$ and $p$ are both completely determined by $n$ and the constant $d$. Adding $p$ or $T$ to the parameter only "decorates" the statement without strengthening it.
>
> The same construction was originally used in the literature to show W[1]-hardness of *envy-free* ICFD in the number of agents; we have repurposed it for the equitable variant by exploiting the same target $T = 2d+1$ and the same connectivity-driven structure.

> [!hint]
> The recipe for "which parameter does this reduction transfer hardness to" is mechanical: list the parameters of the target instance, ask which are bounded by some computable function of the source parameter $k$, and discard the rest. Among what survives, the *finest* parameter — the one that any other surviving parameter is a function of — is the cleanest place to state the hardness. Here, $n$ is finest because $T = 2d+1$ and $p = (d+1)n$ are both determined by $n$ and the constant $d$.