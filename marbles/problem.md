---
title: Marbles Elimination
type: multi_part
course: Advanced Algorithms
course-slug: advalgo
topic: NP-Hardness
tags: [reductions, hamiltonian-cycle, games]
difficulty: medium
bloom: analyze
points: 8
---

*Marbles* is a solitaire game played on an undirected graph $G$, where each vertex has zero or more marbles. A single move in this game consists of removing two marbles from a vertex $v$ and adding one marble to an arbitrary neighbor of $v$. Note that the vertex $v$ must have at least two marbles on it before the move.

The **Marbles Elimination** problem asks: given a graph $G=(V, E)$ and a marble count $p(v)$ for each vertex $v$, is there a sequence of valid moves that removes all but one marble?

---

**Example:** Consider a triangle graph with vertices $A, B, C$ and edges $\{A,B\}, \{B,C\}, \{C,A\}$.

If we start with marbles $A=2, B=1, C=1$ (total = 4):
1. Move from $A$ to $B$: now $A=0, B=2, C=1$
2. Move from $B$ to $C$: now $A=0, B=0, C=2$
3. Move from $C$ to $A$: now $A=1, B=0, C=0$

We end with exactly 1 marble.

---

## Part A

Consider a **path graph** $P_4$ with vertices $A - B - C - D$ (edges $\{A,B\}, \{B,C\}, \{C,D\}$).

Starting configuration: $A=1, B=2, C=1, D=1$ (total = 5 marbles).

Can the game be won (reduced to exactly 1 marble)?

## Options
- [ ] Yes >>> Try simulating the moves. After a few moves, you'll find yourself stuck with multiple marbles but no vertex having 2 or more.
- [x] No >>> Correct! The path $P_4$ has no Hamiltonian cycle. Any move sequence eventually leaves marbles stranded on vertices with no way to combine them.

> [!hint]
> Try a few move sequences. What happens when marbles get pushed to the endpoints?

> [!solution]
> No matter how we play, we get stuck. For example:
> - Move $B \to C$: $A=1, B=0, C=2, D=1$
> - Move $C \to D$: $A=1, B=0, C=0, D=2$
> - Move $D \to C$: $A=1, B=0, C=1, D=0$
>
> Now we have 2 marbles but no vertex has $\geq 2$ marbles — stuck! The path graph has no Hamiltonian cycle, which is essential for the elimination to work.

---

## Part B

Consider a **cycle graph** $C_4$ with vertices $A - B - C - D - A$ (edges $\{A,B\}, \{B,C\}, \{C,D\}, \{D,A\}$).

Starting configuration: $A=2, B=1, C=1, D=1$ (total = 5 marbles).

Can the game be won (reduced to exactly 1 marble)?

## Options
- [x] Yes >>> Correct! The cycle $C_4$ has a Hamiltonian cycle, so we can "push" the marbles around the cycle until only one remains.
- [ ] No >>> The cycle graph does have a Hamiltonian cycle. Try following the cycle with your moves.

> [!hint]
> Follow the cycle: move from $A$ to $B$, then from $B$ to $C$, and so on.

> [!solution]
> Yes! Follow the Hamiltonian cycle:
> 1. Move $A \to B$: $A=0, B=2, C=1, D=1$
> 2. Move $B \to C$: $A=0, B=0, C=2, D=1$
> 3. Move $C \to D$: $A=0, B=0, C=0, D=2$
> 4. Move $D \to A$: $A=1, B=0, C=0, D=0$
>
> We end with exactly 1 marble on $A$.

---

## Part C

Consider the general **Marbles Elimination** decision problem with the following setup:
- **Input:** A graph $G$ with $n$ vertices, where one designated vertex $w$ has 2 marbles and all other vertices have 1 marble each.
- **Output:** TRUE if we can reduce to exactly 1 marble, FALSE otherwise.

What is the complexity of this problem?

## Options
- [ ] The problem is solvable in polynomial time >>> This would imply Hamiltonian Cycle is in P, which is unlikely.
- [x] The problem is NP-complete >>> Correct! It reduces from Hamiltonian Cycle: the game can be won if and only if the graph has a Hamiltonian cycle starting and ending at $w$.
- [ ] The problem is in P but not known to be NP-complete >>> The reduction from Hamiltonian Cycle shows it's NP-hard.
- [ ] The problem is not in NP >>> The problem is in NP: a certificate is the sequence of moves, verifiable in polynomial time.

> [!solution]
> **NP-completeness proof:**
>
> *In NP:* A certificate is the sequence of moves. We can verify in polynomial time that each move is valid and that we end with 1 marble.
>
> *NP-hard (reduction from Hamiltonian Cycle):* Given graph $G$, pick any vertex $w$ and set $p(w)=2$, $p(v)=1$ for all $v \neq w$.
>
> **If $G$ has a Hamiltonian cycle** $w = v_1, v_2, \ldots, v_n, v_1$: Move from $v_1$ to $v_2$, from $v_2$ to $v_3$, etc. After $n$ moves, exactly 1 marble remains at $w$.
>
> **If we can eliminate to 1 marble:** Each move reduces the count by 1 and transfers a marble along an edge. Starting with $n+1$ marbles, we need $n$ moves. The sequence of moves traces a walk that visits each vertex (to collect its marble) and returns to $w$ — a Hamiltonian cycle.
