# Repository 3 — Quispe & Xu (2026)

*Agentic Delegation and the Language Frontier of Software Developers: A Model and
Evidence from Claude Code on GitHub*
[arXiv:2605.25438](https://arxiv.org/abs/2605.25438) (v2, 2026-07-07) · econ.GN · 71 pp.

> **Honesty note, first.** The issue requires the Lean component to be produced
> with Codex (`gpt-5.6-sol`, effort `xhigh`). That run was launched exactly as
> instructed and died with `usage_limit_exceeded` ("Your workspace is out of
> credits") after reading the EconCSLib skills and writing the placeholder
> statement spec — no file in `papers/` was ever created. The remaining
> workflow steps (statement spec, `new`, Lean proofs, checks, reports) were done
> with **Claude Code**. Everything is disclosed in `prompts.md`,
> `lean/docs/RUN_LOG.md` and the deck; nothing in `lean/` is presented as the
> Codex run.

---

## What question the paper answers

Why would a developer who has only ever shipped Python suddenly start shipping
Rust the month she adopts a coding *agent* — when two years of ChatGPT and
Copilot did nothing of the kind?

The paper's answer is a **menu expansion**. Conversational AI (Generation 1)
*augments* work in languages the developer already knows: its value is
proportional to her execution skill $s$ in that language, so it cannot make an
unfamiliar language viable. Agentic AI (Generation 2) adds a third production
mode, *delegation*, whose value does not require language-specific skill. That
mode has its own entry threshold, and the languages whose opportunities fall
between the new and the old threshold — the **activation band** — are exactly
the ones that appear for the first time at adoption.

## The agent's problem

At a fixed developer–language–month, an opportunity of value $\omega$ and
activation cost $b$ can be produced in three modes. The developer has CARA
utility with coefficient $\rho$ and Normal beliefs $\theta \sim N(\mu, 1/\pi)$
about her match with the language, so a payoff with mean $m$ and variance
$\sigma^2$ is worth $m - \rho\sigma^2/2$ (Appendix A.1, derived by hand in
`hand/`). The three certainty-equivalent surpluses are

$$V^S = \omega + s\mu - \frac{\rho s^2}{2\pi} - b, \qquad
  V^C = V^S + \gamma s - r^C,$$

$$V^D = \omega + (1-\lambda)s\mu + \lambda a z(A) - \kappa(a,s) - r^D - b
      - \frac{\rho}{2}\Big[\frac{(1-\lambda)^2 s^2}{\pi} + \sigma_D^2(a,s,A)\Big].$$

Under menu $M_1 = \{S, C\}$ (before the agent) or $M_2 = \{S, C, D\}$ (after),
the developer takes the best mode, $V^g = \max_{m \in M_g} V^m$, and the
language is *active* when $Z^g = \mathbf 1[V^g \ge 0]$. Because every surplus is
affine in $\omega$ with slope one, each mode has a threshold $T^m$ with
$V^m = \omega - T^m$.

## The main result, with all its conditions

Write $T^S = b - s\mu + \rho s^2/(2\pi)$, $T^C = T^S - (\gamma s - r^C)$,
$T^1 = \min\{T^S, T^C\}$, and

$$T^D = b - (1-\lambda)s\mu - \lambda a z(A) + \kappa(a,s) + r^D
      + \frac{\rho}{2}\Big[\frac{(1-\lambda)^2 s^2}{\pi} + \sigma_D^2(a,s,A)\Big].$$

**Assumption 1 (augmentation requires a foothold).** For an unfamiliar language,
$\gamma s - r^C \le 0$; for a familiar one, $\gamma \bar s - r^C > 0$. Hence for an
unfamiliar language $T^1 = T^S$: Generation 1 does not move the entry margin.

**Assumption 2 (verification technology).** $\kappa_a < 0$, $\kappa_s \le 0$,
$\partial\sigma_D^2/\partial a \le 0$, $\partial\sigma_D^2/\partial s \le 0$,
$\partial\sigma_D^2/\partial A \le 0$.

The **agentic threshold reduction** for an unfamiliar language is
$B \equiv T^1 - T^D = T^S - T^D$, and differencing the thresholds gives

$$B = \lambda\big[a z(A) - s\mu\big] - \kappa(a,s) - r^D
    + \frac{\rho}{2}\Big[\frac{(2\lambda - \lambda^2)s^2}{\pi} - \sigma_D^2(a,s,A)\Big].$$

**Proposition 2 (Activation band).** *Consider an unfamiliar language satisfying
Assumption 1. If $B > 0$, then*

$$Z^2 - Z^1 = \mathbf 1\big[\,T^D \le \omega < T^S\,\big].$$

Conditions, spelled out: (i) the language is unfamiliar, so Assumption 1 applies
and $T^1 = T^S$; (ii) $B > 0$, i.e. $T^D < T^S$, so the band is nonempty;
(iii) the CARA–Normal certainty-equivalent representation behind $V^S, V^C, V^D$;
(iv) $\lambda \in (0,1]$, $\rho > 0$, $\pi > 0$. If the conditional CDF $F$ of
$\omega$ is continuous, the probability that delegation activates the language is
$F(T^S) - F(T^D)$, and expected language-count expansion is
$\sum_k [F(T^1_k) - F(T^2_k)] \ge 0$ (Equation (9)).

Two things the Lean check made explicit. The identity in Proposition 2 holds
**without** $B > 0$ (when $B \le 0$ the band is empty and both sides are zero),
so the premise only buys nonemptiness. And Proposition 3's "strictly increasing
and concave" cumulative effect, stated on the domain $p^1 = 0 < p^2$, **fails
at $p^2 = 1$**, where the effect is constant at $|U_i|$; the strict claims need
$p^2 < 1$. The second point was first flagged in my ChatGPT study session
(`prompts.md`, Session 1: "una pequeña omisión técnica"); Lean turned it into a
theorem with the added hypothesis plus a separate counterexample at $p^2 = 1$.

What the result does *not* claim (Remark 1): the frontier is a *production*
frontier, not a skill frontier. Adoption does not raise $s_{ik,t}$; the
developer ships Rust by directing an agent, not by learning Rust.

## Two papers, one phenomenon

Aouad–Lykouris–Zhong (week 1) make AI a **perfectly substitutable input**,
$x = s + e + a$, on the *intensive* margin of a task the worker already does:
assistance crowds out effort, effort builds skill, hence deskilling. Quispe–Xu
make agentic AI a **new production mode on the extensive margin**, with its own
threshold that does not load on $s$: it adds options rather than replacing
inputs, hence frontier expansion (Proposition 1 is literally "a larger menu").
Same technology, opposite conclusions, and the difference is exactly whether AI
enters *inside* the production function of an existing task or *beside* it as
an alternative way to produce a task that was previously infeasible.

## Extension: task complexity and the verification bottleneck

Above the floor. The idea came out of my ChatGPT study session (`prompts.md`,
Session 1); the choice of curvatures and the Lean proofs are from this
repository.

**Intuition.** The paper's frontier is horizontal — which *languages* a
developer can produce in. Projects also differ in how much they ask of her: a
task complexity $c \ge 0$. Complexity pulls delegation in opposite directions.
The agent absorbs the routine part, so each extra unit of complexity costs a
solo developer more than one who delegates (a per-unit execution saving
$\psi$). But delegated output must be *verified*, and complexity is where
verification bites: $\kappa$ rises convexly in $c$ (curvature $\eta$) and more
complex projects leave more places for an agent error to hide, so the residual
variance $\sigma_D^2$ rises with $c$ (curvature $\nu$) — and the developer is
risk averse. The gross value $R(c)$ and the activation cost $b$ are the same in
every mode: they decide whether a project is worth doing, not how.

| New element | Role | Assumption |
|---|---|---|
| $c \ge 0$ | task complexity of the opportunity | exogenous, one per $(i,k,t)$ |
| $R(c)$ | gross value of complexity | $R' > 0$; identical in $S$, $C$, $D$ |
| $C_S(c) = \tfrac{\chi}{2}c^2 + \psi c$, $C_D(c) = \tfrac{\chi}{2}c^2$ | execution cost | convex in both modes; $\psi > 0$ saved by delegating |
| $\kappa(a,s,c) = \kappa_0 + \tfrac{\eta}{2}c^2$ | verification cost | $\eta > 0$; $\kappa_a < 0$, $\kappa_s \le 0$ kept; $\eta$ falls with $a$ |
| $\sigma_D^2(a,s,A,c) = \sigma_0^2 + \tfrac{\nu}{2}c^2$ | residual agent-error variance | $\nu > 0$; falls with $a$, $s$, $A$ |
| $\lambda$ | share delegated | held fixed |

**The three modes with complexity** (same certainty equivalents as (1)–(3)):

$$V^S(c) = \omega + R(c) + s\mu - \Big[\tfrac{\chi}{2}c^2 + \psi c\Big] - b - \tfrac{\rho s^2}{2\pi},
\qquad V^C(c) = V^S(c) + \gamma s - r^C,$$

$$V^D(c) = \omega + R(c) + (1-\lambda)s\mu + \lambda a z(A) - \tfrac{\chi}{2}c^2
  - \Big[\kappa_0 + \tfrac{\eta}{2}c^2\Big] - r^D - b
  - \tfrac{\rho}{2}\Big[\tfrac{(1-\lambda)^2 s^2}{\pi} + \sigma_0^2 + \tfrac{\nu}{2}c^2\Big].$$

$V^C(c) - V^S(c) = \gamma s - r^C$ does not depend on $c$, so Assumption 1 still
gives $T^1(c) = T^S(c)$ for an unfamiliar language; $c = 0$ recovers the paper.
Each $V^m(c)$ is affine in $\omega$, with thresholds

$$T^S(c) = T^S - R(c) + \tfrac{\chi}{2}c^2 + \psi c, \qquad
  T^D(c) = T^D - R(c) + \tfrac{\chi}{2}c^2 + \tfrac{\eta}{2}c^2 + \tfrac{\rho}{2}\,\tfrac{\nu}{2}c^2,$$

and $R(c)$ and the common curvature $\chi$ cancel in the delegation advantage:

$$B(c) = B + \psi c - \tfrac{\theta}{2}c^2, \qquad \theta \equiv \eta + \tfrac{\rho\nu}{2}, \qquad B(0) = B.$$

The benchmark $\theta = 0$ (no verification bottleneck) gives $B(c) = B + \psi c$,
strictly increasing — the conclusion is the assumption. With $\theta > 0$ the
advantage **peaks** at $c^* = \psi/\theta$, since
$B(c^*) - B(c) = \tfrac{\theta}{2}(c - c^*)^2$; it is strictly increasing below
and strictly decreasing above $c^*$; it turns **negative** beyond an explicit
$\bar c$, so for complex enough projects delegation no longer activates the
language; and $c^*$ rises with general ability when $\eta$ and $\nu$ fall with
$a$ — the logic of Assumption 2 in a new dimension. Prediction: newly-used
languages should concentrate in projects of intermediate complexity.

The band at complexity $c$ is Proposition 2 again: if $B(c) > 0$,
$Z^2(c) - Z^1(c) = \mathbf 1[T^D(c) \le \omega < T^S(c)]$, of width $B(c)$ —
widest at $c^*$, empty beyond $\bar c$.

All of this is proved in Lean as extension theorems in `lean/MainTheorems.lean`
(`reductionC_eq` — for an arbitrary function $R$ —, `reductionC_zero`,
`activation_band_C`, `reductionC_benchmark_strictMono`, `reductionC_le_peak`,
`reductionC_strictMonoOn`, `reductionC_strictAntiOn`, `reductionC_neg_of_large`,
`peak_monotone_in_ability`); the source-facing Specs were not touched, and
`lake build` / `check --fast` were rerun (`lean/docs/CHECK_EXTENSION.txt`).
Figure: `analysis/figures/frontier_complexity.pdf`. Slides 12–16 of the deck
walk through the intuition, the three modes, the thresholds and the Lean code.

## What is in this repository

| File | What it is |
|---|---|
| `README.md` | This page |
| `prompts.md` | Raw prompts and answers, three sessions: the ChatGPT study session (the model term by term, Propositions 1–3, a complexity extension), the Codex session (until the credits ran out) and the Claude Code session |
| `hand/derivacion-a-mano.pdf` | Five notebook pages: the CARA–Normal certainty equivalent via the MGF, and the derivation of $V^S$, $V^C$, $V^D$ |
| `presentation.tex` / `.pdf` | The 20-minute Beamer deck, including the required Lean slide |
| `lean/` | The EconCSLib paper folder `papers/QX26AgenticDelegation/`, copied as generated after the run (15 Specs, 15 closed proofs, reports, audit stubs, `docs/RUN_LOG.md`, `docs/CHECK_FULL.log`) |
| `analysis/` | `cumulative_effect.py` and its figure: the activation band of Proposition 2 and the $p^2 = 1$ saturation of Proposition 3 (slide 4) |
| `paper/README.md` | Pointer to the article (the PDF itself is not committed) |

## The Lean component in one paragraph

Fifteen source-facing statements (Equations (4), (5), (6), (7), (18); the
ability comparative static; Propositions 1–5) were pinned to the v2 PDF in an
EconCSLib statement spec, scaffolded with `paper_contribution.py new`, and
proved with no `sorry`. `lake build QX26AgenticDelegation` completes; `check
--fast` exits 0; the full `check` passes the build and status lanes and stops
at the conclusion-provenance audit, which needs the LLM-as-judge sidecars that
were not run (`lean/docs/CHECK_FULL.log`). Status: **partially formalized**,
because the two strict Proposition 3 rows carry the added restriction
$p^2 < 1$ and the semantic audits are pending. `lean/FINAL_VALIDATION_REPORT.md`
has the full ledger.
