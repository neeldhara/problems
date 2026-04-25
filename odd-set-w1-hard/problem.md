---
title: Odd Coverings · W[1]-Hardness of Odd Set
type: multi_part
topic: Parameterized Complexity · W[1]-hardness · Reductions from Multicolored Clique
difficulty: hard
bloom: analyze
points: 14
---

In the **Odd Set** problem we are given a set system $\mathcal{F}$ over a universe $U$ and an integer $k$, and we must decide whether there is a subset $S \subseteq U$ of size at most $k$ such that $|S \cap F|$ is *odd* for every $F \in \mathcal{F}$.

We will dissect a parameterized reduction from $\mathrm{Multicolored\ Clique}$ that shows:

> $\mathrm{Odd\ Set}$ is W[1]-hard parameterized by $k$.

Recall: in $\mathrm{Multicolored\ Clique}$ we are given a graph $G$ along with a partition $V_1, \ldots, V_k$ of $V(G)$ into "color classes", and we must find a $k$-clique containing exactly one vertex from each $V_i$.

## Part A (2)

Let $U = \{1, 2, 3, 4, 5\}$ and $\mathcal{F} = \{\{1,2,3\}, \{3,4,5\}, \{1,5\}\}$. Which set $S \subseteq U$ is a valid Odd Set solution (i.e., $|S \cap F|$ is odd for **every** $F \in \mathcal{F}$)?

## Options
- [ ] $S = \{3\}$ >>> $|S \cap \{1,2,3\}| = 1$ ✓, $|S \cap \{3,4,5\}| = 1$ ✓, but $|S \cap \{1,5\}| = 0$, which is even.
- [ ] $S = \{1, 3, 5\}$ >>> $|S \cap \{1,2,3\}| = 2$, which is even.
- [x] $S = \{1, 4\}$ >>> $|S \cap \{1,2,3\}| = 1$ ✓, $|S \cap \{3,4,5\}| = 1$ ✓, $|S \cap \{1,5\}| = 1$ ✓.
- [ ] $S = \{2, 4\}$ >>> $|S \cap \{1,5\}| = 0$, even.

> [!solution]
> Take each set in $\mathcal{F}$ in turn and count the intersection with $S$ — the parity must be odd in every case.

## Part B (2)

Here is a "natural" first attempt to reduce $\mathrm{Multicolored\ Independent\ Set}$ to $\mathrm{Odd\ Set}$: keep $U = V(G)$, set $k$ unchanged, put each color class $V_i$ into $\mathcal{F}$ (forcing exactly one vertex per class to be picked), and for every edge $uv$ of $G$ also add the doubleton $\{u, v\}$ to $\mathcal{F}$ (hoping to forbid picking both $u$ and $v$).

Why does this attempt fail?

## Options
- [ ] The $V_i$ constraints are not enforceable in $\mathrm{Odd\ Set}$. >>> They are: $|S \cap V_i|$ odd plus $|S| = k$ forces exactly one vertex per class.
- [x] Adding $\{u, v\}$ requires $|S \cap \{u, v\}|$ to be **odd** — i.e., *exactly one* of $u, v$ in $S$. But for an independent set we need *at most one*; "neither in $S$" should be allowed when $u, v$ are not the chosen representatives of their color classes. >>> Spot on. The parity constraint is symmetric and cannot express the asymmetric "not both" relation.
- [ ] Doubletons cannot appear in $\mathcal{F}$. >>> They certainly can.
- [ ] The reduction blows up the parameter beyond $k$. >>> The parameter stays $k$; that is not the reason for failure.

> [!solution]
> The doubleton trick captures the wrong relation: it forbids both "both endpoints in $S$" and "neither endpoint in $S$", whereas independence only forbids the first. The actual proof uses a more elaborate reduction from $\mathrm{Multicolored\ Clique}$ where representing both vertices and edges of the clique by gadgets allows the *projection* "endpoint of edge $e$ is $v$" to be expressed via parity.

## Part C (2)

The actual reduction is from $\mathrm{Multicolored\ Clique}$. Let $E_{i,j}$ be the set of edges of $G$ between $V_i$ and $V_j$, and let $E_{i, j, v} \subseteq E_{i, j}$ be the edges incident to $v$. Construct an $\mathrm{Odd\ Set}$ instance with universe
$$
U := \bigcup_{i = 1}^{k} V_i \;\;\cup\;\; \bigcup_{1 \leqslant i < j \leqslant k} E_{i, j},
$$
parameter
$$
k' := k + \binom{k}{2},
$$
and family $\mathcal{F}$ containing each $V_i$, each $E_{i, j}$, and the sets $E'_{i, j, v} := E_{i, j, v} \cup (V_i \setminus \{v\})$ for each $i < j$ and each $v \in V_i$ (and analogously $E'_{i, j, w}$ for $w \in V_j$).

For $k = 4$, what is $k'$?

## Answer
10

> [!solution]
> $k' = k + \binom{k}{2} = 4 + 6 = 10$. We are picking $k = 4$ "vertex tokens" and $\binom{k}{2} = 6$ "edge tokens".

## Part D (2)

Suppose $v_1 \in V_1, \ldots, v_k \in V_k$ form a multicolored $k$-clique in $G$, and let $e_{i,j} := v_i v_j$ for $i < j$. Consider the candidate odd-set
$$
S := \{v_1, \ldots, v_k\} \;\cup\; \{e_{i,j} : 1 \leqslant i < j \leqslant k\}.
$$
What are the values $|S \cap V_i|$ and $|S \cap E_{i, j}|$ for each $i, j$?

## Options
- [x] Both equal $1$, hence both odd. >>> $S$ contains exactly $v_i$ from $V_i$ and exactly $e_{i, j}$ from $E_{i, j}$.
- [ ] Both equal $0$. >>> Then $|S| = 0$, contradicting the construction.
- [ ] $|S \cap V_i| = 1$ but $|S \cap E_{i, j}|$ is the degree of $v_i$. >>> $S$ contains only the *clique* edges, not all incident edges.
- [ ] $|S \cap V_i| = k - 1$. >>> $S$ contains only one vertex from each $V_i$, namely $v_i$.

> [!solution]
> By construction $S \cap V_i = \{v_i\}$ and $S \cap E_{i, j} = \{e_{i, j}\}$.

## Part E (3)

Continue with the same $S$. The trickiest sets to verify are those of the form $E'_{i, j, v} = E_{i, j, v} \cup (V_i \setminus \{v\})$. Consider $|S \cap E'_{i, j, v}|$.

Mark **all** correct statements.

## Options
- [x] If $v = v_i$ (the chosen representative of $V_i$): $|S \cap (V_i \setminus \{v\})| = 0$ and $|S \cap E_{i, j, v}| = 1$ since $e_{i, j}$ is incident to $v_i$. Total: $1$, odd. >>> The edge $e_{i, j} = v_i v_j$ lies in $E_{i, j, v_i}$ exactly because it is incident to $v_i$.
- [x] If $v \neq v_i$: $|S \cap (V_i \setminus \{v\})| = 1$ (since $v_i \in V_i \setminus \{v\}$) and $|S \cap E_{i, j, v}| = 0$ (since the only $E_{i, j}$-element of $S$, namely $e_{i, j}$, is not incident to $v$). Total: $1$, odd. >>> The "swap" of which contribution is non-empty is what makes the parity always $1$.
- [ ] $|S \cap E'_{i, j, v}|$ depends sensitively on the degree of $v$ in $G$. >>> No: in both cases the total is exactly $1$.
- [ ] $|S \cap E'_{i, j, v}|$ is sometimes even. >>> A careful case split (above) shows the total is always exactly $1$.

> [!solution]
> The role of the sets $E'_{i, j, v}$ is to **force** the edge token $e_{i, j}$ in any solution to be incident to the vertex token $v_i$. The parity is engineered to be exactly $1$ in both possible cases for $v$.

## Part F (3)

For the reverse direction, suppose $S \subseteq U$ has $|S| \leqslant k'$ and is a valid odd set. Using $|S \cap V_i|$ and $|S \cap E_{i, j}|$ being odd plus $|S| \leqslant k + \binom{k}{2}$, we must have $S \cap V_i = \{v_i\}$ and $S \cap E_{i, j} = \{e_{i, j}\}$ for unique $v_i, e_{i, j}$. The crucial step is to argue that **$e_{i, j}$ is the edge $v_i v_j$ of $G$**. Why?

## Options
- [ ] Because $e_{i, j}$ is the unique edge between $V_i$ and $V_j$ in $G$. >>> Not in general — $E_{i, j}$ can have many edges.
- [x] Because $|S \cap E'_{i, j, v_i}|$ is odd; with $|S \cap (V_i \setminus \{v_i\})| = 0$ (since $S \cap V_i = \{v_i\}$), we need $|S \cap E_{i, j, v_i}|$ odd, forcing $e_{i, j} \in E_{i, j, v_i}$, i.e., $e_{i, j}$ is incident to $v_i$. By symmetry, $e_{i, j}$ is also incident to $v_j$. >>> Exactly the "$E'$ projects edge endpoints onto vertex choices" idea.
- [ ] The construction picked $e_{i, j} = v_i v_j$ explicitly, so this holds by definition. >>> In the reverse direction we are *given* an arbitrary odd set $S$; nothing was picked for us.
- [ ] By a cardinality count: $|E_{i, j}| = 1$ because $G$ has only $k$ edges. >>> No such cardinality assumption is made.

> [!solution]
> The sets $E'_{i, j, v}$ act as a *projection gadget*: they force the edge token $e_{i, j}$ in $S$ to be incident to the vertex token in $V_i$, and (symmetrically) to the vertex token in $V_j$. Hence $e_{i, j}$ is precisely the edge $v_i v_j$, certifying that $\{v_1, \ldots, v_k\}$ is a clique in $G$.

> [!hint]
> The general principle illustrated by this proof: when reducing from $\mathrm{Multicolored\ Clique}$, you create $k$ vertex gadgets and $\binom{k}{2}$ edge gadgets. The non-trivial design is making each *edge gadget* simultaneously force a specific state of the two relevant *vertex gadgets* — here, achieved by parity.
