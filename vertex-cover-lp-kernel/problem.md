---
title: Half-Integral Hindsight · An LP-Based 2k Kernel for Vertex Cover
type: multi_part
topic: Parameterized Algorithms · Kernelization · Linear Programming
difficulty: medium
bloom: analyze
points: 5
---

Recall the **Vertex Cover** problem: given a graph $G$ and an integer $k$, decide whether there is a set $S \subseteq V(G)$ with $|S| \leqslant k$ such that every edge has at least one endpoint in $S$.

Encoding it as an integer program with one variable $x_v$ per vertex gives:

$$
\begin{aligned}
\text{minimize} \quad & \sum_{v \in V(G)} x_v \\
\text{subject to} \quad & x_u + x_v \geqslant 1 \quad \text{for every } uv \in E(G), \\
                       & 0 \leqslant x_v \leqslant 1 \quad \text{for every } v \in V(G), \\
                       & x_v \in \mathbb{Z} \quad \text{for every } v \in V(G).
\end{aligned}
$$

Dropping the integrality constraint $x_v \in \mathbb{Z}$ yields the linear program $\mathrm{LPVC}(G)$. We will partition the vertices according to an optimal LP solution $(x_v)_{v \in V(G)}$:

$$
V_0 := \{v : x_v < \tfrac{1}{2}\}, \quad V_{\frac{1}{2}} := \{v : x_v = \tfrac{1}{2}\}, \quad V_1 := \{v : x_v > \tfrac{1}{2}\}.
$$

## Part A (1)

Compute the optimum of $\mathrm{LPVC}(G)$ when $G$ is (i) the triangle $K_3$ and (ii) the cycle $C_5$ on vertices $v_1, v_2, v_3, v_4, v_5$.

## Answer
1.5, 2.5

> [!solution]
> **(i) $K_3$.** Setting every variable to $\tfrac{1}{2}$ is feasible (each constraint sums to $1$) with cost $\tfrac{3}{2}$. To see this is optimal, sum the three edge constraints: $2 \sum_v x_v \geqslant 3$, hence $\sum_v x_v \geqslant \tfrac{3}{2}$.
>
> **(ii) $C_5$.** Assigning $x_v = \tfrac{1}{2}$ to every vertex is feasible with cost $\tfrac{5}{2}$. Summing the five edge constraints gives $2 \sum_v x_v \geqslant 5$, so $\sum_v x_v \geqslant \tfrac{5}{2}$. (Note that the integer optimum is $3$ — the LP can be strictly smaller.)

## Part B (1)

Let $G$ be the **paw graph**: a triangle on $\{a, b, c\}$ together with a pendant vertex $d$ adjacent only to $a$ (so $E(G) = \{ab, bc, ca, ad\}$). Suppose the LP solver returns the optimal solution

$$(x_a, x_b, x_c, x_d) = \left(1, \tfrac{1}{2}, \tfrac{1}{2}, 0\right).$$
Identify $V_0$, $V_{\frac{1}{2}}$, and $V_1$.

## Options
- [ ] $V_0 = \emptyset$, $V_{\frac{1}{2}} = \{a, b, c, d\}$, $V_1 = \emptyset$. >>> This would describe the *other* LP optimum (all-halves), not the one given.
- [x] $V_0 = \{d\}$, $V_{\frac{1}{2}} = \{b, c\}$, $V_1 = \{a\}$. >>> Read off directly: $x_d = 0 < \tfrac{1}{2}$, $x_b = x_c = \tfrac{1}{2}$, $x_a = 1 > \tfrac{1}{2}$.
- [ ] $V_0 = \{a\}$, $V_{\frac{1}{2}} = \{b, c\}$, $V_1 = \{d\}$. >>> Swapped: $a$ has the *largest* LP value and $d$ has the smallest.
- [ ] $V_0 = \{b, c\}$, $V_{\frac{1}{2}} = \emptyset$, $V_1 = \{a, d\}$. >>> The values $\tfrac{1}{2}$ for $b, c$ go into $V_{\frac{1}{2}}$ — strict inequality is required for $V_0$.

> [!hint]
> The three sets are based on whether the LP value is strictly less than, equal to, or strictly greater than $\tfrac{1}{2}$.

## Part C (1)

Reduction VC.4 says: take all of $V_1$ into the cover, discard $V_0$, and recurse on $G[V_{\frac{1}{2}}]$ with the parameter dropped by $|V_1|$. Why is taking $V_1$ into the cover *safe* — i.e., why does there exist a minimum vertex cover $S$ with $V_1 \subseteq S \subseteq V_1 \cup V_{\frac{1}{2}}$?

## Options
- [ ] Vertices in $V_1$ have higher degree than those in $V_0$, so they cover more edges. >>> A reasonable intuition, but degrees do not appear in the proof; the perturbation argument below is the actual reason.
- [ ] Because we can always assume $V_0 = V_1 = \emptyset$. >>> Not true in general; the bowtie is a counterexample.
- [x] Suppose otherwise: starting from any minimum vertex cover $S^*$, we can shift $\varepsilon$ of the LP weight from $V_1 \setminus S^*$ to $V_0 \cap S^*$ and still obtain a feasible LP solution of strictly smaller value, contradicting LP optimality. >>> This is the Nemhauser–Trotter perturbation argument used in the proof of Theorem 2.19.
- [ ] By LP duality, $V_1$ corresponds to a maximum matching saturating those vertices. >>> Vaguely related (the LP can be solved via bipartite matching), but this is not the argument that justifies the inclusion of $V_1$.

> [!solution]
> If some minimum cover $S^*$ avoided a vertex of $V_1$ (or kept a vertex of $V_0$), we could perturb the LP solution by a small $\varepsilon > 0$, decreasing $x_v$ on $V_1 \setminus S^*$ and increasing $x_v$ on $V_0 \cap S^*$. Feasibility holds because $S^*$ already covers every edge, and the perturbed solution has strictly smaller objective — contradicting optimality of the LP.

## Part D (1)

After Reduction VC.4, the kernel is the graph $G' = G[V_{\frac{1}{2}}]$ with parameter $k' = k - |V_1|$. Why does $|V(G')| \leqslant 2k$ on a yes-instance?

## Options
- [ ] Because $|V_{\frac{1}{2}}| \leqslant k$ — every vertex in $V_{\frac{1}{2}}$ contributes $\tfrac{1}{2}$ to the LP and the LP is at most $k$. >>> The arithmetic is off by a factor of $2$: $|V_{\frac{1}{2}}|/2 \leqslant k$ gives $|V_{\frac{1}{2}}| \leqslant 2k$, not $\leqslant k$.
- [x] On a yes-instance the LP optimum is at most $k$, and $\sum_v x_v \geqslant \tfrac{1}{2} |V_{\frac{1}{2}}|$, so $|V_{\frac{1}{2}}| \leqslant 2k$. >>> Each vertex of $V_{\frac{1}{2}}$ contributes exactly $\tfrac{1}{2}$ to the LP value, so $|V_{\frac{1}{2}}| \leqslant 2 \cdot \mathrm{LP}(G) \leqslant 2k$.
- [ ] By a direct combinatorial counting of edges. >>> The bound goes through the LP cost, not edge counts.
- [ ] Because every vertex in $V_{\frac{1}{2}}$ is matched in some maximum matching. >>> True via the matching reformulation, but this is not the size argument the kernel uses.

> [!solution]
> The integer optimum upper-bounds $k$ on a yes-instance, and the LP optimum is at most the integer optimum. So $\sum_v x_v \leqslant k$. Restricting the sum to $V_{\frac{1}{2}}$ gives $\tfrac{1}{2} |V_{\frac{1}{2}}| \leqslant \sum_{v \in V_{\frac{1}{2}}} x_v \leqslant k$, hence $|V_{\frac{1}{2}}| \leqslant 2k$.

## Part E (1)

You are given an instance $(G, k)$ with $k = 4$ and an LP optimum of $\sum_v x_v = 6$. What should the kernelization output?

## Options
- [ ] The kernel $G[V_{\frac{1}{2}}]$ with parameter $k' = 4 - |V_1|$. >>> Tempting, but ignores a more fundamental issue with this instance.
- [x] Report a no-instance and stop. >>> The LP optimum lower-bounds the integer optimum: any vertex cover has size $\geqslant 6 > 4 = k$, so no cover of size $k$ exists.
- [ ] Recurse on $G$ with $k' = 4$. >>> Pointless — the LP already certifies infeasibility.
- [ ] Output the empty graph with $k' = 0$. >>> Misrepresents the instance: the answer is "no", not "yes on the empty graph".

> [!solution]
> Reduction VC.4 begins with the test: if $\sum_v x_v > k$, declare a no-instance. The LP relaxation is a relaxation, so its optimum is a *lower bound* on every integer cover.

> [!hint]
> Think of $\mathrm{LPVC}(G)$ as a "soft" vertex cover. If the soft version already costs more than $k$, no integer cover can do better.
