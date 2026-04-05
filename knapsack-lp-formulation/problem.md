---
title: Knapsack LP Formulation
type: mcq
course: Advanced Algorithms
topic: Approximation Algorithms
tags: [knapsack, linear-programming, modeling]
difficulty: easy
bloom: analyze
points: 1
course-slug: advalgo
---

A student proposes a 0/1-LP for knapsack using decision variables $y_i \in \{0,1\}$, constraint $\sum_i \text{weight}(x_i) y_i \le W$, and objective $\min \sum_i \text{value}(x_i) y_i$. Determine whether this correctly models knapsack.

Does this 0/1-linear program correctly model the knapsack problem?

## Options
- [ ] Yes.
- [x] No, but if we maximize the objective function instead of minimizing it, we get a correct 0/1-LP formulation of the knapsack problem.
- [ ] No, and changing the minimization to maximization does not help because the constraints are not linear.

> [!solution]
> Correct option: No, but if we maximize the objective function instead of minimizing it, we get a correct 0/1-LP formulation of the knapsack problem.
