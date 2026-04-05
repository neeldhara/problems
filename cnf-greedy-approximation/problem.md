---
title: CNF Greedy Approximation
type: mcq
course: Advanced Algorithms
topic: Approximation Algorithms
tags:
  - cnf
  - greedy
  - approximation
difficulty: easy
bloom: analyze
points: 1
course-slug: advalgo
---

We consider monotone 3-CNF formulas (exactly three non-negated literals per clause). Goal: set as few variables to TRUE as possible while satisfying all clauses. Greedy-CNF repeatedly picks any remaining clause, sets one variable in it to TRUE, and removes all clauses containing that variable.

What is the approximation ratio of this algorithm?

## Options
- [ ] This algorithm is always optimal. >>> Consider the instance $(x,y_1,z_1), \ldots, (x,y_n,z_n)$ where the $z$s are all distinct. What if greedy never picks $x$ or $y$?
- [ ] This algorithm is a 2-approximation. >>> Consider the instance $(x,y_1,z_1), \ldots, (x,y_n,z_n)$ where the $z$s are all distinct. What if greedy never picks $x$ or $y$?
- [ ] This algorithm is a $(n/2)$-approximation. >>> Consider the instance $(x,y_1,z_1), \ldots, (x,y_n,z_n)$ where the $z$s are all distinct. What if greedy never picks $x$ or $y$?
- [x] The approximation ratio could be as bad as $n - 2$. >>> Indeed. Consider the instance $(x,y_1,z_1), \ldots, (x,y_n,z_n)$ where the $y$s and $z$s are all distinct. If greedy misses $x$ or $y$ it has to choose $k = n-2$ variables in the solution. 
 
> [!solution]
> Correct option: Indeed, the approximation could be as bad as $n - 2$. Consider the instance $(x,y,z_1), (x,y,z_2), \ldots, (x,y,z_k),$ where the $z$s are all distinct. The total number of variables here is $n = k+2$. What if greedy never picks $x$ or $y$? On the one hand, the optimal solution is to clearly just set the variable $x$ to true, or the variable $y$ to true. On the other hand, the greedy algorithm may end up picking all the $z$ variables, which is a solution of size $k = n-2$. 
