---
title: Vertex Cover LP Matrix Notation
type: mcq
course: Advanced Algorithms
topic: Approximation Algorithms
tags: [vertex-cover, linear-programming, matrix-notation]
difficulty: easy
bloom: analyze
points: 1
course-slug: advalgo
---
For weighted vertex cover, each edge $(v_i,v_j)$ contributes a constraint $x_i + x_j \ge 1$. Suppose constraints are written as $A[x_1\ x_2\ x_3\ x_4\ x_5]^T \ge b$, with row $i$ corresponding to edge $e_i$.

![Graph with 5 vertices and 6 edges showing vertex weights and edge labels](graph.png)

## Part A (1)

If row $i$ in matrix $A$ corresponds to the constraint created for edge $e_i$, what would be the correct values of row 5?

## Options
- [x] $0,1,0,0,1$
- [ ] $0,4,0,0,10$
- [ ] $1,1,0,0,0$
- [ ] $5,4,0,0,0$

> [!solution]
> Correct option: $0,1,0,0,1$


## Part B (2)

Recall the dual formulation:

$$ \begin{aligned} \max \quad & \sum_{e \in E} y_e \ \text{s.t.} \quad & \sum_{e \ni v} y_e \leq w(v) \quad \forall v \in V \ & y_e \geq 0 \quad \forall e \in E \end{aligned} $$

Each vertex can absorb at most $w(v)$ units of total "edge charge" from its incident edges.

A vertex $v$ is **tight** when $\sum_{e \ni v} y_e = w(v)$.

The following is a primal-dual-based approximation algorithm for vertex cover:

Initialize $y_e = 0$ for all $e \in E$ and $C = \emptyset$.

Repeat until every edge has at least one tight endpoint:

1. Pick any edge $e = (u, v)$ with neither $u$ nor $v$ tight.
2. Raise $y_e$ until one of $u$ or $v$ becomes tight.
3. Add every newly-tight vertex to $C$.

Return $C$.

What is the output of the prima-dual algorithm when applied to the graph in this example?

## Answer

Foo Bar