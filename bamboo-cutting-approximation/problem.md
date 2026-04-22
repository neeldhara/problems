---
title: Bamboo Cutting — A 4-Approximation Discovery
type: multi_part
course: Advanced Algorithms
topic: Approximation Algorithms
tags: [bamboo-cutting, greedy-approximation, lower-bound]
difficulty: hard
bloom: analyze
points: 8
course-slug: advalgo
---
You are the caretaker of a bamboo garden with $n$ bamboos. Bamboo $i$ has growth rate $h_i > 0$ (height units per day). At the start, all bamboos have height $0$. At the end of each day, you may cut **exactly one** bamboo, resetting its height to $0$. 

A robotic gardener maintaining the garden trims bamboos to height zero according to some schedule. The height of a bamboo $b_i$ after $t \geq 0$ days is equal to $(t-t')h_i$, where $t'$ is the last time when this bamboo was trimmed, or $t' = 0$, if it has never been trimmed. 

The goal of the gardener is to keep all bamboos as low as possible forever — that is, to minimize the supremum of heights ever reached by any bamboo.

Define $H = h_1 + h_2 + \cdots + h_n$. We will use the running example $h_1 = 4, h_2 = 3, h_3 = 1$, so $n = 3$ and $H = 8$. 

In this exploration, we develop an approximation algorithm for this problem in the online setting. An online algorithm is based on simple queries of type “what is the tallest bamboo?”, or “what is the fastest growing bamboo among all bamboos whose height is above some threshold?”. Such queries can be answered without knowing the whole distribution of growth rates.

The Reduce-Fastest($x$) algorithm works as follows: cut next the fastest growing bamboo among those with the current heights at least $x \cdot H$, for some constant $x > 1$. If none are above the threshold, cut nothing.


---

## Part A

Suppose, for contradiction, an algorithm $\mathcal{A}$ guarantees that **every bamboo always has height at most $H_{\mathrm{MAX}}$** for some $H_{\mathrm{MAX}} < H$.

Let $T$ be the **total height** of the garden — the sum of the current heights of all bamboos. Under the assumption above, **by how much does $T$ increase each day, in the worst case**?

## Options
- [ ] $T$ increases by exactly $H$.
- [ ] $T$ increases by at most $H_{\mathrm{MAX}}$.
- [x] $T$ increases by **at least $H - H_{\mathrm{MAX}}$**.
- [ ] $T$ might decrease.

> [!solution]
> Every day, all bamboos grow by a combined $H$ units (the total growth rate). Then one bamboo is cut, removing its current height from $T$. Under our assumption that no bamboo ever exceeds $H_{\mathrm{MAX}}$, the cut removes **at most $H_{\mathrm{MAX}}$**. So the net change is at least
> $$H - H_{\mathrm{MAX}} > 0.$$
> In particular, $T$ strictly increases every single day — even though no individual bamboo is allowed to grow unboundedly!

> [!hint]
> Count the two things that happen each day: growth across all bamboos (how much is added to $T$?) and one cut (how much is removed from $T$?). For the cut, use the assumption that every bamboo is below $H_{\mathrm{MAX}}$.

---

## Part B

Consider our running example $h_1 = 4, h_2 = 3, h_3 = 1$, so $H = 8$ and $n = 3$. Suppose someone claims an algorithm $\mathcal{A}$ keeps every bamboo at height $\leq 7$ forever; that is, $H_{\mathrm{MAX}} = H - 1 = 7$.

Now consider the following statement that contradicts the claimed behavior of the algorithm:

_No matter what the algorithm does, after day $X$, it must be the case that some bamboo has height strictly greater than 7._ 

What is the smallest value of $X$ for which the statement above is true?

## Options
- [ ] 1
- [ ] 7
- [ ] 21
- [x] 22
- [ ] 25

> [!solution]
> After $t$ days, $T \geq t \cdot (H - H_{\mathrm{MAX}}) = t$. But $T \leq n \cdot H_{\mathrm{MAX}} = 21$ must hold. Setting $t = 22$:
> $$T \geq 22 > 21 = n \cdot H_{\mathrm{MAX}},$$
> which is impossible if every one of the $n = 3$ bamboos has height $\leq 7$. By the pigeonhole principle, **some bamboo must have height strictly greater than $7$** on day $22$ — contradicting the claim.

> [!hint]
> You have a quantity $T$ that grows by at least $1$ per day but is capped at $21$. How long before $T$ is forced past $21$?

---

## Part C

In general, suppose an algorithm claims to keep every bamboo below some threshold $H_{\mathrm{MAX}} < H$. After how many days is this claim forced into a contradiction?

## Options
- [ ] $\lfloor H_{\mathrm{MAX}} / (H - H_{\mathrm{MAX}}) \rfloor + 1$
- [x] $\lfloor n \cdot H_{\mathrm{MAX}} / (H - H_{\mathrm{MAX}}) \rfloor + 1$
- [ ] $\lfloor n \cdot H / (H - H_{\mathrm{MAX}}) \rfloor + 1$
- [ ] $n \cdot H_{\mathrm{MAX}}$

> [!solution]
> After $t$ days, $T \geq t(H - H_{\mathrm{MAX}})$. For a contradiction we want
> $$t(H - H_{\mathrm{MAX}}) > n \cdot H_{\mathrm{MAX}} \qquad \Longleftrightarrow \qquad t > \frac{n \cdot H_{\mathrm{MAX}}}{H - H_{\mathrm{MAX}}}.$$
> The smallest such integer is $t = \lfloor n \cdot H_{\mathrm{MAX}} / (H - H_{\mathrm{MAX}}) \rfloor + 1$. On that day, $T$ exceeds $n \cdot H_{\mathrm{MAX}}$, so by pigeonhole some bamboo must have height strictly greater than $H_{\mathrm{MAX}}$ — a contradiction.
>
> Since this argument works for **every** $H_{\mathrm{MAX}} < H$, we conclude: no algorithm can keep every bamboo's height strictly below $H$. Therefore
> $$\mathrm{OPT} \geq H.$$

> [!hint]
> Replace the numbers $1$ and $21$ from Part B with their abstract counterparts $H - H_{\mathrm{MAX}}$ and $n \cdot H_{\mathrm{MAX}}$, and repeat the same arithmetic.

---

## Part D

Consider the greedy algorithm **Reduce-Fastest(2)**, so the threshold for being "eligible to cut" is $2H$. For our running example ($h_1 = 4, h_2 = 3, h_3 = 1$, $H = 8$), after how many days does the first bamboo first become eligible to be cut?

## Options
- [ ] $1$ day
- [ ] $2$ days
- [x] $4$ days
- [ ] $16$ days

> [!solution]
> Bamboo $1$ grows at rate $h_1 = 4$, so to reach height $16$ it needs $16 / 4 = 4$ days.

---

## Part E

You might hope Reduce-Fastest(2) trivially caps every bamboo at $2H$: the moment a bamboo reaches $2H$, we cut it. **Why does this argument fail?**

## Options
- [ ] The growth rates can change unexpectedly.
- [ ] The algorithm can only measure heights up to $H$.
- [x] The algorithm cuts **only one** bamboo per day, so if several bamboos are simultaneously above $2H$, only the fastest is cut — the others keep growing past $2H$.
- [ ] Bamboos grow faster once they cross $2H$.

> [!solution]
> Reduce-Fastest(2) cuts **the fastest eligible bamboo** — not all of them. If multiple bamboos cross $2H$ in the same window of days, the slower ones sit above $2H$ growing while the algorithm attends to faster bamboos first. So the actual cap on height is larger than $2H$ — in fact, we'll see it's nearly $4H$.

---

## Part F

Assume that if there are two or more bamboos with the same fastest growth rate among the bamboos with the current height at least $x \cdot H$, then Reduce-Fastest chooses for trimming the bamboo with the smallest index.

Bamboo $1$ — the fastest — is the easy case. Once bamboo $1$ crosses the $2H$ threshold, it is the fastest bamboo above the threshold (nothing grows faster), so it gets cut the next day. During that one extra day, it grows by $h_1$ more. 

What is the tightest upper bound on the **maximum height bamboo $1$ ever reaches** under Reduce-Fastest(2)?

## Options
- [ ] $2H$
- [x] $2H + h_1 \leq 3H$
- [ ] $3H + h_1$
- [ ] $4H$

> [!solution]
> Just before being cut, bamboo $1$ can be at height at most $2H + h_1$ (it crossed into the "eligible" region $[2H, \infty)$ and then grew for one more day before being picked). Since $h_1 \leq H$, this is at most $3H = (x+1)H$ with $x = 2$. For faster bamboos, this is the best bound; the harder case is the **slower** bamboos $b_i$ for $i \geq 2$, which can be "blocked" by faster bamboos monopolizing cuts.

---

## Part G

Now for the slower bamboos $b_i$ with $i \geq 2$. Assume (for contradiction) that **$b_i$ reaches height at least $C \cdot H$** for some constant $C \geq x + 1$. We'll derive an upper bound on $C$.

Split heights into two regions: the **lower region** $[0, xH)$ and the **upper region** $[xH, \infty)$. To reach height $CH$, bamboo $b_i$ must make a final climb from $xH$ up to $CH$ without being cut. For how many consecutive days must $b_i$ stay in the upper region on this climb?

## Options
- [ ] At least $\lfloor xH / h_i \rfloor$ days.
- [x] At least $\lfloor (C - x)H / h_i \rfloor$ days.
- [ ] At least $\lfloor CH / h_i \rfloor$ days.
- [ ] At least $i \cdot \lfloor H / h_i \rfloor$ days.

> [!solution]
> Growing at rate $h_i$, the climb from height $xH$ to $CH$ covers $(C - x)H$ units of height, which takes $(C - x)H / h_i$ days. Taking the floor (since heights are observed at the end of each day), $b_i$ must be in the upper region for at least
> $$t := \left\lfloor \frac{(C - x) H}{h_i} \right\rfloor$$
> consecutive days without being cut.

> [!hint]
> From height $xH$, how long does growth at rate $h_i$ take to reach $CH$?

---

## Part H

Call the duration above $t$. On each of these $t$ days, $b_i$ is eligible to be cut (it's in the upper region), but is **not** cut. So on each of those days, Reduce-Fastest picks some **other** bamboo instead — specifically, a faster one that is also in the upper region. Since rates are sorted $h_1 \geq \cdots \geq h_n$, any such "blocker" must be some $b_j$ with $j < i$.

Fix a single $b_j$ with $j < i$. After $b_j$ is cut, it restarts at height $0$ and must re-climb to $xH$ before it can block $b_i$ again. Let $f_j := \lceil x H / h_j \rceil$ denote this re-climb time. **Over our $t$-day window, how many times can $b_j$ block $b_i$?**

## Options
- [ ] At most $t$ times.
- [x] At most $1 + \lfloor t / f_j \rfloor$ times.
- [ ] At most $f_j$ times.
- [ ] Exactly $t / f_j$ times.

> [!solution]
> Between two consecutive times $b_j$ blocks $b_i$, at least $f_j = \lceil xH/h_j \rceil$ days must pass (the re-climb). So in a window of $t$ days, $b_j$ can block at most $1 + \lfloor t / f_j \rfloor$ times — one initial block, plus at most one extra per full re-climb interval that fits in the window.

> [!hint]
> Think of $b_j$'s blocks as events separated by at least $f_j$ days each. How many such events fit in a $t$-day window?

---

## Part I

Now combine. Let $\alpha(j)$ denote your answer to the previous question (this is potentially independent of $j$). 

Since $b_i$ is blocked on **every** one of its $t$ upper-region days, the total block count over all faster bamboos must reach $t$:

$$t \leq \sum_{j=1}^{i-1} \alpha(j).$$

Divide by $t$ and substitute for $t$ from your previous answer and $f_j = \lceil xH/h_j \rceil$. To simplify, use two facts from the rate ordering $h_1 \geq h_2 \geq \cdots \geq h_n$:

- $h_i \leq H/i$ (since $i \cdot h_i \leq h_1 + \cdots + h_i \leq H$),
- $\sum_{j=1}^{i-1} h_j < H$ (strict, since $h_i > 0$).

**Which inequality on $C$ and $x$ do these simplifications yield?**

## Options
- [ ] $\dfrac{1}{C - x} + \dfrac{1}{x} < 1$
- [x] $\dfrac{1}{C - x} + \dfrac{1}{x} > 1$
- [ ] $\dfrac{1}{C} + \dfrac{1}{x} > 1$
- [ ] $\dfrac{1}{C - x} - \dfrac{1}{x} > 1$

> [!solution]
> For the first term, using $h_i \leq H/i$:
> $$\frac{i-1}{\lfloor (C-x)H/h_i \rfloor} \;\lesssim\; \frac{(i-1) h_i}{(C-x)H} \;\leq\; \frac{(i-1) \cdot H/i}{(C-x) H} \;=\; \frac{i-1}{i(C-x)} \;<\; \frac{1}{C - x}.$$
> For the second term, using $\sum_{j=1}^{i-1} h_j < H$:
> $$\sum_{j=1}^{i-1} \frac{1}{\lceil xH/h_j \rceil} \;\leq\; \sum_{j=1}^{i-1} \frac{h_j}{xH} \;=\; \frac{1}{xH}\sum_{j=1}^{i-1} h_j \;<\; \frac{1}{x}.$$
> Combining: $1 < \dfrac{1}{C-x} + \dfrac{1}{x}$.

> [!hint]
> Substitute the bounds $h_i \leq H/i$ and $\sum_{j<i} h_j < H$ into the two terms separately, and ignore floor/ceiling noise (the paper handles this carefully; for the discovery version, just track the dominant terms).

---

## Part J

We get to choose $x$, so pick the one that gives you the best approximation ratio. What do you arrive at?

## Options
- [ ] $x = 1$, giving $C < 2$
- [x] $x = 2$, giving $C < 4$
- [ ] $x = 3$, giving $C < 3.5$
- [ ] $x \to \infty$, giving $C < \infty$

> [!solution]
> Let $f(x) = 2 + (x - 1) + \dfrac{1}{x - 1}$ for $x > 1$. Its derivative is $f'(x) = 1 - \dfrac{1}{(x - 1)^2}$, which vanishes at $x = 2$. At the minimum: $f(2) = 2 + 1 + 1 = 4$. So the tightest bound provable by this argument is $C < 4$, attained at $x = 2$. This means **Reduce-Fastest(2) keeps every slower bamboo $b_i$ ($i \geq 2$) below height $4H$.** Combined with Part F (which gave $\leq 3H$ for $b_1$), no bamboo ever reaches height $4H$.

