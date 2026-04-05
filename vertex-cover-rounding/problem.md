---
title: Rounding for Vertex Cover
type: multi_part
course: Advanced Algorithms
topic: Approximation Algorithms
tags:
  - vertex-cover
  - lp-rounding
  - approximation
difficulty: medium
bloom: analyze
points: 3
course-slug: advalgo
---

Recall the LP-rounding algorithm for weighted Vertex Cover:

$$
\begin{aligned}
\text{Minimize} \quad & \sum_{i=1}^{n} w(v_i)\,x_i \\
\text{subject to} \quad & x_i + x_j \ge 1 \quad \forall (v_i,v_j) \in E \\
& 0 \le x_i \le 1 \quad \forall i
\end{aligned}
$$

Then return $C = \{v_i \in V : x_i \ge 1/2\}$.

## Part A

Suppose we instead include $v_i$ when $x_i \ge 1/3$. What happens?

## Options
- [ ] We still get a valid solution, and the algorithm remains a 2-approximation.
- [x] We still get a valid solution, and the algorithm becomes a 3-approximation.
- [ ] We may no longer get a valid solution.

## Part B

Suppose we instead include $v_i$ when $x_i \ge 2/3$. What happens?

## Options
- [ ] We still get a valid solution, and the algorithm remains a 2-approximation.
- [ ] We still get a valid solution, and the algorithm becomes a $3/2$-approximation.
- [x] We may no longer get a valid solution.

## Part C

Consider this alternative rounding rule: for each edge $(v_i,v_j)$, include the endpoint with larger LP value (break ties toward larger index). Equivalently,
$C := \{ v_i : \exists (v_i,v_j)\in E \text{ with } (x_i > x_j) \text{ or } (x_i = x_j \text{ and } i > j)\}$.

Which statement is true?

## Options
- [ ] This does not work, because we might report an invalid solution.
- [ ] This gives a valid solution, but the approximation ratio becomes worse.
- [ ] This gives a valid solution, and the solution is always exactly the same as in the original rounding scheme.
- [x] This gives a valid solution. We sometimes report a better solution than in the original rounding scheme, but the approximation ratio is still strictly greater than 1.999 in the worst case.
- [ ] This gives a valid solution, and the approximation ratio becomes $3/2$.

> [!solution]
> **Part A:** Validity is preserved since every edge has $x_i+x_j\ge 1$, so at least one endpoint is at least $1/2$, and therefore at least $1/3$.  
> The cost bound becomes $w(C)\le 3\sum_i w(v_i)x_i$, giving a 3-approximation.
>
> **Part B:** Validity can fail: if an edge has LP values $(1/2,1/2)$, neither endpoint is selected by a $2/3$ threshold.
>
> **Part C:** This rule always covers each edge (one endpoint is chosen per edge), and selected vertices always satisfy $x_i\ge 1/2$, so it can improve over standard threshold rounding on some instances.  
> However, the worst-case approximation guarantee remains essentially 2 (it can still be above 1.999).
