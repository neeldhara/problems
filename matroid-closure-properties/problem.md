---
title: Matroid Closure Properties
type: multi_part
course: Advanced Algorithms
topic: Matroids
tags: [matroids, closure-properties]
difficulty: medium
bloom: understand
points: 6
---

Let $M_1 = (E, \mathcal{I}_1)$ and $M_2 = (E, \mathcal{I}_2)$ be two matroids defined on the same ground set $E$. Recall that a matroid must satisfy:
1. **Non-empty:** $\emptyset \in \mathcal{I}$
2. **Hereditary:** If $A \in \mathcal{I}$ and $B \subseteq A$, then $B \in \mathcal{I}$
3. **Exchange:** If $A, B \in \mathcal{I}$ and $|A| < |B|$, then $\exists b \in B \setminus A$ such that $A \cup \{b\} \in \mathcal{I}$

---

## Part A

Consider the **intersection** of two matroids: $M = (E, \mathcal{I}_1 \cap \mathcal{I}_2)$, where a set is independent in $M$ if and only if it is independent in both $M_1$ and $M_2$.

Is $M$ always a matroid?

## Options
- [ ] Yes, the intersection of two matroids is always a matroid >>> The hereditary property holds, but the exchange property can fail. Try constructing a counterexample with two partition matroids.
- [x] No, the intersection of two matroids is not always a matroid >>> Correct! While $\mathcal{I}_1 \cap \mathcal{I}_2$ satisfies the hereditary property, the exchange property can fail.

> [!hint]
> Consider two partition matroids on $E = \{a, b, c, d\}$ with different partitions.

> [!solution]
> **No.** The intersection is not always a matroid.
>
> **Counterexample:** Let $E = \{a, b, c, d\}$.
> - $M_1$: partition matroid with blocks $\{a, b\}$ and $\{c, d\}$, taking at most 1 from each.
> - $M_2$: partition matroid with blocks $\{a, c\}$ and $\{b, d\}$, taking at most 1 from each.
>
> Then $\mathcal{I}_1 \cap \mathcal{I}_2 = \{\emptyset, \{a\}, \{b\}, \{c\}, \{d\}, \{a, d\}, \{b, c\}\}$
>
> The maximal sets are $\{a, d\}$ and $\{b, c\}$, both of size 2. Now consider $A = \{a\}$ and $B = \{b, c\}$. We have $|A| < |B|$, but:
> - $\{a, b\} \notin \mathcal{I}_1$ (both from same block in $M_1$)
> - $\{a, c\} \notin \mathcal{I}_2$ (both from same block in $M_2$)
>
> So we cannot extend $A$ using elements of $B$, violating the exchange property.

---

## Part B

Consider the **union** of two matroids: $M = (E, \mathcal{I}_1 \cup \mathcal{I}_2)$, where a set is independent in $M$ if it is independent in $M_1$ or independent in $M_2$ (or both).

Is $M$ always a matroid?

## Options
- [ ] Yes, the union of two matroids is always a matroid >>> While the hereditary property holds, the exchange property can fail. Try a simple example where one matroid has a loop that the other doesn't.
- [x] No, the union of two matroids is not always a matroid >>> Correct! The exchange property can fail when trying to extend a set from one matroid using elements that work in the other.

> [!hint]
> Consider $E = \{a, b, c\}$ where $M_1$ has $c$ as a loop, and $M_2$ has $a, b$ as loops.

> [!solution]
> **No.** The union is not always a matroid.
>
> **Counterexample:** Let $E = \{a, b, c\}$.
> - $M_1$: $\mathcal{I}_1 = \{\emptyset, \{a\}, \{b\}, \{a, b\}\}$ (uniform matroid on $\{a, b\}$; $c$ is a loop)
> - $M_2$: $\mathcal{I}_2 = \{\emptyset, \{c\}\}$ (only $c$ is independent, rank 1)
>
> Then $\mathcal{I}_1 \cup \mathcal{I}_2 = \{\emptyset, \{a\}, \{b\}, \{c\}, \{a, b\}\}$
>
> Consider $A = \{c\}$ and $B = \{a, b\}$. We have $|A| = 1 < 2 = |B|$.
>
> For exchange, we need some $x \in \{a, b\}$ such that $\{c, x\} \in \mathcal{I}_1 \cup \mathcal{I}_2$:
> - $\{c, a\} \notin \mathcal{I}_1$ (since $c$ is a loop) and $\{c, a\} \notin \mathcal{I}_2$ (max size is 1)
> - $\{c, b\} \notin \mathcal{I}_1$ and $\{c, b\} \notin \mathcal{I}_2$
>
> No valid extension exists, so the exchange property fails.

---

## Part C

Consider **element deletion**: Given a matroid $M = (E, \mathcal{I})$ and an element $e \in E$, define $M' = (E', \mathcal{I}')$ where:
- $E' = E \setminus \{e\}$
- $\mathcal{I}' = \{S \setminus \{e\} : S \in \mathcal{I}\}$

(We remove $e$ from the ground set and from every independent set.)

Is $M'$ always a matroid?

## Options
- [x] Yes, element deletion always yields a matroid >>> Correct! This operation is called *matroid deletion* and preserves all matroid axioms.
- [ ] No, element deletion does not always yield a matroid >>> Actually, deletion is a fundamental matroid operation that always produces a matroid. Check that all three axioms are preserved.

> [!hint]
> Note that by the hereditary property, if $S \in \mathcal{I}$ and $e \in S$, then $S \setminus \{e\} \in \mathcal{I}$ as well.

> [!solution]
> **Yes.** Element deletion always yields a matroid. This is a standard matroid operation denoted $M \setminus e$.
>
> **Proof:** We verify all three axioms for $\mathcal{I}' = \{S \setminus \{e\} : S \in \mathcal{I}\}$:
>
> 1. **Non-empty:** $\emptyset \in \mathcal{I}$, so $\emptyset \setminus \{e\} = \emptyset \in \mathcal{I}'$. ✓
>
> 2. **Hereditary:** Let $A \in \mathcal{I}'$ and $B \subseteq A$. Then $A = S \setminus \{e\}$ for some $S \in \mathcal{I}$. Since $B \subseteq A \subseteq S$ and $e \notin B$, we have $B \in \mathcal{I}$ (by hereditary property of $M$), so $B = B \setminus \{e\} \in \mathcal{I}'$. ✓
>
> 3. **Exchange:** Let $A, B \in \mathcal{I}'$ with $|A| < |B|$. Then $A, B \in \mathcal{I}$ (since neither contains $e$, they are unchanged). By exchange in $M$, $\exists b \in B \setminus A$ with $A \cup \{b\} \in \mathcal{I}$. Since $b \neq e$, we have $A \cup \{b\} \in \mathcal{I}'$. ✓
>
> Note: $\mathcal{I}' = \{S \in \mathcal{I} : e \notin S\}$, which is exactly the standard deletion operation.
