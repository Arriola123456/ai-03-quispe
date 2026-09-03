# Final Validation Report: Quispe and Xu (2026), Agentic Delegation and the Language Frontier
Updated: 2026-09-03

## 1. Human Verdict
Partially formalized. Every source-facing statement selected from Section 4 and
Appendix A — the threshold algebra (Equations (4), (5), (6), (7) and (18)), the
ability comparative static stated after Equation (7), and Propositions 1, 2, 3,
4 and 5 — has a closed Lean proof with no `sorry`. The paper does not reach
`formalized` for two reasons. First, Proposition 3's strict-increase and
strict-concavity claims are printed on the closed-frontier domain
$p^1 = 0 < p^2$, which admits $p^2 = 1$; there the cumulative effect equals the
number of unfamiliar languages at every horizon and the strict claims fail, so
the Lean statements add the restriction $p^2 < 1$ (and a nonempty candidate
set). Second, the protocol's independent semantic audits (LLM-as-judge
statement match, coverage, assumption review) and human dashboard sign-offs were
not executed in this run.

## 2. Closeout Status
- Completion status: partially formalized
- One-sentence recap: fifteen of fifteen selected statements proved; two of them
  under an added endpoint restriction that the source omits; semantic audits
  pending.

## 3. Source and Scope
- Paper: Agentic Delegation and the Language Frontier of Software Developers: A
  Model and Evidence from Claude Code on GitHub (Alexander Quispe and Kevin Xu)
- Source version: arXiv:2605.25438v2, 2026-07-07
- Lean folder: `papers/QX26AgenticDelegation`
- Human-facing theorem file: `papers/QX26AgenticDelegation/PaperInterface.lean`
- Paper assumption file: `papers/QX26AgenticDelegation/Assumptions.lean` (empty:
  every premise is visible in the theorem signatures)
- DAG artifacts: `papers/QX26AgenticDelegation/docs/DependencyDAG.tex`,
  `papers/QX26AgenticDelegation/docs/DependencyDAG.pdf`
- Lean footprint: four paper modules (`MainTheorems`, `Assumptions`,
  `PaperInterface`, `ProofInterface`); the paper build target
  `lake build QX26AgenticDelegation` completes with no errors.
- Scope: the theoretical content of Section 4 and Appendix A. The CARA–Normal
  certainty-equivalent derivation (Appendix A.1), the Bayesian learning
  extension (Appendix A.7), the empirical design (Sections 5–7) and all figures
  and tables are out of scope.

## 4. Researcher Summary of Checked Results
The model is taken at a fixed developer–language–month. Three production modes
deliver certainty-equivalent surpluses that are affine in the opportunity shock
$\omega$: solo $V^S = \omega + s\mu - \rho s^2/(2\pi) - b$, augmentation
$V^C = V^S + \gamma s - r^C$, and delegation $V^D = \omega + (1-\lambda)s\mu +
\lambda a z - \kappa - r^D - b - \tfrac{\rho}{2}[(1-\lambda)^2 s^2/\pi +
\sigma_D^2]$. Lean checks that each mode is active exactly when $\omega$ clears
its threshold (Equations (4), (6)), that the Generation-1 threshold is
$T^1 = T^S - \max\{0, \gamma s - r^C\}$ (Equation (5)), that under Assumption 1
for an unfamiliar language augmentation does not move the entry margin
($T^1 = T^S$, Equation (18)), and that the agentic threshold reduction
$B = T^1 - T^D$ equals the closed form of Equation (7).

Proposition 1 (frontier expansion) is checked in its path-by-path form: for any
finite set of languages the Generation-2 language count weakly exceeds the
Generation-1 count, because the delegation option can always be ignored.
Proposition 2 (activation band) is checked exactly as printed: under Assumption
1 and $B > 0$, $Z^2 - Z^1 = \mathbf 1[T^D \le \omega < T^S]$. Lean also shows
that the identity holds without $B > 0$ (the band is then empty), so the
premise only guarantees that the band is nonempty.

Proposition 3 is checked in three parts. The cumulative effect
$\Delta C_i(s) = \sum_{k \in U_i}[(1-p^1_k)^{s+1} - (1-p^2_k)^{s+1}]$ is
nonnegative whenever $p^1_k \le p^2_k \le 1$. In the closed-frontier benchmark
$p^1 = 0$ it is strictly increasing and strictly concave in the horizon $s$
provided $0 < p^2_k < 1$ for every candidate language and $U_i$ is nonempty.
At $p^2_k = 1$ the effect is constant and equal to $|U_i|$, which refutes the
printed strict claims on their stated domain.

Proposition 4 is checked as the identity $\sum_{k\in U_i} p = |U_i|\,p$ together
with monotonicity in the candidate set and in a hazard that is itself
increasing in ability. Proposition 5 is checked in its indicator form: if every
repository's entry cost weakly falls, the count of feasible repositories weakly
rises, and it rises strictly when some repository's opportunity lies between
the new and old costs. The comparative static after Equation (7) is checked in
a discrete form: $B$ is monotone in general ability when verification cost and
residual error are antitone in ability, $\rho \ge 0$, $\lambda \ge 0$ and
$z \ge 0$.

## 5. Remaining Boundaries and Gaps
- Proposition 3 (strict increase, concavity): proved only under the added
  restriction $p^2_k < 1$ and $U_i \ne \emptyset$; see Section 10.
- Proposition 4: the expectation $E[E_i \mid a_i, U_i]$ is represented by its
  value under Assumption 3 (a common increment $p$), not derived from a
  probability model of $Z^2 - Z^1$; the ability monotonicity is represented
  through a hazard given as an increasing function of ability.
- Proposition 5: repository entry is represented by abstract cost thresholds
  $c_r(\ell(r), g)$ and opportunity values, as in the source proof; the link
  between "delegation weakly expands the active-language set" and
  $c_r(\ell, 2) \le c_r(\ell, 1)$ is taken as the hypothesis, as in the source.
- The source functions $z(A)$, $\kappa(a, s)$ and $\sigma_D^2(a, s, A)$ enter
  the threshold rows as real numbers at the fixed $(i, k, t)$; the ability
  comparative static uses one-variable functions of $a$.
- Appendix A.1 (certainty equivalent), Appendix A.7 (learning), and the
  probability statements $F(T^S) - F(T^D)$ of Equation (9) are not formalized.
- LLM-as-judge and human semantic audits of the review surface were not run.

## 6. Additional Assumptions Beyond Paper
- $p^2_k < 1$ and $U_i \ne \emptyset$ in the strict parts of Proposition 3.
- $\rho \ge 0$, $\lambda \ge 0$ and $z(A) \ge 0$ in the ability comparative
  static ($\rho > 0$ and $\lambda \in (0, 1]$ are source conditions; $z \ge 0$ is
  implicit in the source's reading of $\lambda a z(A)$ as agent execution).
- $p^2_k \le 1$ and $p^1_k \le p^2_k$ in Proposition 3 (hazards are
  probabilities in the source).

## 7. Proof-Strategy Deviations
- Proposition 2 is proved through the affine representation $V^m = \omega - T^m$
  and a case split on $\omega$ relative to $T^D$ and $T^S$; the source proof is
  the same argument in prose.
- Proposition 3's second difference is evaluated through the factorisation
  $(1-p)^{s+3} = (1-p)^{s+1}(1-p)^2$ rather than the source's displayed formula
  $-(p^2)^2(1-p^2)^{s+1}$; the endpoints agree.

## 8. Proof Tricks Worth Reusing
- Writing every mode surplus as $\omega - T^m$ turns all activation statements
  into linear facts that `linarith` closes; the indicator identity behind the
  activation band is then a three-way case split.
- Stating the Specs with `let`-bound abbreviations keeps them transparent and
  self-contained while remaining definitionally equal to named model
  definitions in `MainTheorems.lean`, so proof endpoints are one `exact`.

## 9. Generalizations, Conjectures, and Extensions
- `activation_band_general`: Equation (8) holds without $B > 0$.
- `cumulative_effect_saturates_at_hazard_one` and
  `cumulative_effect_at_hazard_one_eq_card`: at $p^2 = 1$ the cumulative effect
  is $|U_i|$ at every horizon.
- Proposition 5's strict part only needs one repository in the band, not
  "positive mass" in an opportunity distribution.
- Complexity extension (not in the source; developed in the student's ChatGPT
  study session and formalized here). With task complexity $c \ge 0$ entering
  execution cost in both modes ($T^S(c) = T^S + \chi c^2/2 + \psi c$,
  $T^D(c) = T^D + \chi c^2/2 + \eta c^2/2 + \tfrac{\rho}{2}\tfrac{\nu}{2}c^2$),
  the delegation advantage is $B(c) = (T^S - T^D) + \psi c - \theta c^2/2$ with
  $\theta = \eta + \rho\nu/2$ (`reductionC_eq`). Lean proves: the benchmark
  $\theta = 0$ is strictly increasing in $c$ (`reductionC_benchmark_strictMono`);
  for $\theta > 0$ the advantage peaks at $c^* = \psi/\theta$
  (`reductionC_le_peak`, `reductionC_le_peak_div`, via
  $B(c^*) - B(c) = \tfrac{\theta}{2}(c - c^*)^2$), is strictly increasing below
  and strictly decreasing above the peak (`reductionC_strictMonoOn`,
  `reductionC_strictAntiOn`), turns negative beyond an explicit bound so the
  band closes (`reductionC_neg_of_large`), and the peak rises with general
  ability when $\eta$ and $\nu$ are antitone in ability
  (`peak_monotone_in_ability`). These are extension theorems in
  `MainTheorems.lean`, not source-facing Specs.

## 10. Mathematical Typos or Other Fixes Suggested in the Source Paper
- Proposition 3 and Appendix A.6 state that in the closed-frontier benchmark
  $p^1 = 0 < p^2$ the cumulative effect is strictly increasing and concave,
  with first difference $p^2(1-p^2)^{s+1} > 0$ and second difference
  $-(p^2)^2(1-p^2)^{s+1} < 0$. Both displayed inequalities are equalities at
  $p^2 = 1$, which the printed domain allows. Corrected reading: strict
  increase and strict concavity hold for $0 < p^2 < 1$; weak monotonicity holds
  on the whole domain.

## 11. Paper Issues or Caveats
None beyond Section 10.

## 12. Detailed Formalization Evidence
- `lake build QX26AgenticDelegation`: Build completed successfully (4000 jobs).
- `python3 scripts/paper_contribution.py check QX26AgenticDelegation --fast`:
  exit code 0 (focused interface build, semantic import isolation check, and
  `git diff --check` all passed).
- No declaration in the paper folder uses `sorry`, `axiom` or `unsafe`.
- `Assumptions.lean` declares nothing; `status.json`
  `review_surface.assumption_names` is empty.

## 13. Paper Assumption Provenance
| Assumption declaration | Lean declaration | Source location / statement | Assumption validators | Comments |
| --- | --- | --- | --- | --- |
| None | `none` | Assumption 1 and Assumption 2 enter as explicit theorem premises (`γ * s - rC ≤ 0`; `Antitone κ`, `Antitone σ`) | None | No paper assumption is declared as an axiom-like premise. |

## 14. Displayed Formula Provenance
| Paper formula / subclaim | Lean declaration | Provenance | Validators | Comments |
| --- | --- | --- | --- | --- |
| Equation (4) | `paper_equation_4_solo_thresholdSpec` | derived in Lean | Lean build | source condition |
| Equation (5) | `paper_equation_5_generation1_thresholdSpec` | derived in Lean | Lean build | source condition |
| Equation (18) | `paper_equation_18_unfamiliar_no_augmentationSpec` | derived in Lean | Lean build | under Assumption 1 |
| Equation (6) | `paper_equation_6_delegation_thresholdSpec` | derived in Lean | Lean build | source condition |
| Equation (7) / (20) | `paper_equation_7_agentic_threshold_reductionSpec` | derived in Lean (`ring`) | Lean build | under Assumption 1 |
| Equation (8) | `paper_proposition_2_activation_bandSpec` | derived in Lean | Lean build | under Assumption 1 and B > 0 |
| Equation (10) | `paper_proposition_3_cumulative_effect_nonnegSpec` | derived in Lean | Lean build | hazards in [0, 1] |
| Equation (22) | `paper_proposition_4_expected_expansionSpec` | derived in Lean | Lean build | common increment p |

## 15. Library Lift Pass
- Reusable library extraction candidates: the indicator identity
  `band_indicator` (difference of two threshold indicators equals a band
  indicator) is paper-independent.
- Library certificate/source-boundary audit: not run; no certificate-taking
  library API is used.
- Paper-local hidden-premise audit: not run; all premises are visible binders.

## 16. DAG Audit
- Rendered artifact: `docs/DependencyDAG.pdf` rendered from
  `docs/DependencyDAG.tex`.
- Topology: model definitions feed the threshold rows; Proposition 2 depends
  on Equations (4), (6), (18); Proposition 3 rows are independent of the
  threshold algebra; Propositions 4 and 5 are independent leaves.
- Layout: checked visually.

## 17. Validation Checks
- Targeted Lean build: passed.
- Statement precheck / assumption precheck / repository audit / LLM audits:
  not run (see Section 5).

## 18. Paper Definitions Checked
- Equations (1)–(3): the three mode surpluses (named definitions in
  `MainTheorems.lean`; expanded inline in every Spec).
- Menus $M_1 = \{S, C\}$ and $M_2 = \{S, C, D\}$ through the nested `max`.
- Activation indicators $Z^g = \mathbf 1[V^g \ge 0]$ and counts
  $N^g = \sum_k Z^g_k$.

## 19. Named Theorem Statements Checked
### Proposition 1
**Paper statement.** For every developer, language, date and opportunity
realization, $Z^2 \ge Z^1$, hence $N^2 \ge N^1$ path by path.

**Lean interface statement.**
- `paper_proposition_1_frontier_expansionSpec`: the count inequality over any
  finite language set.

**Status.** formalized.

### Proposition 2
**Paper statement.** Under Assumption 1 and $B > 0$,
$Z^2 - Z^1 = \mathbf 1[T^D \le \omega < T^S]$.

**Lean interface statement.**
- `paper_proposition_2_activation_bandSpec`: exactly that identity.

**Status.** formalized.

### Proposition 3
**Paper statement.** If $p^2 \ge p^1$, $\Delta C_i(s) \ge 0$; in the
closed-frontier benchmark $p^1 = 0 < p^2$ it is strictly increasing and
concave.

**Lean interface statement.**
- `paper_proposition_3_cumulative_effect_nonnegSpec`: nonnegativity.
- `paper_proposition_3_closed_frontier_strictly_increasingSpec`: strict
  increase with the added $p^2 < 1$.
- `paper_proposition_3_closed_frontier_concaveSpec`: strict concavity with the
  added $p^2 < 1$.

**Status.** partially formalized (added endpoint restriction).

### Proposition 4
**Paper statement.** $E[E_i \mid a_i, U_i] = U_i\,p_i(a_i, A)$, increasing in
$U_i$ and in $a_i$.

**Lean interface statement.**
- `paper_proposition_4_expected_expansionSpec`: identity and monotonicity in
  the candidate set.
- `paper_proposition_4_increasing_in_abilitySpec`: monotonicity in ability.

**Status.** formalized under the representation of Section 5.

### Proposition 5
**Paper statement.** Weak repository expansion, strict when some repository
requires a language in the activation band.

**Lean interface statement.**
- `paper_proposition_5_repository_expansionSpec`: weak part.
- `paper_proposition_5_repository_expansion_strictSpec`: strict part.

**Status.** formalized under the representation of Section 5.

## 20. Paper-Facing Statement Validator Ledger
| Paper-facing statement | Lean declaration | Validators | Validator comments |
| --- | --- | --- | --- |
| Equation (4) | `paper_equation_4_solo_thresholdSpec` | Lean build 2026-09-03 | proof closed |
| Equation (5) | `paper_equation_5_generation1_thresholdSpec` | Lean build 2026-09-03 | proof closed |
| Equation (18) | `paper_equation_18_unfamiliar_no_augmentationSpec` | Lean build 2026-09-03 | proof closed |
| Equation (6) | `paper_equation_6_delegation_thresholdSpec` | Lean build 2026-09-03 | proof closed |
| Equation (7) | `paper_equation_7_agentic_threshold_reductionSpec` | Lean build 2026-09-03 | proof closed |
| Comparative static after (7) | `paper_reduction_increasing_in_abilitySpec` | Lean build 2026-09-03 | added ρ, λ, z ≥ 0 |
| Proposition 1 | `paper_proposition_1_frontier_expansionSpec` | Lean build 2026-09-03 | proof closed |
| Proposition 2 | `paper_proposition_2_activation_bandSpec` | Lean build 2026-09-03 | proof closed |
| Proposition 3 (10) | `paper_proposition_3_cumulative_effect_nonnegSpec` | Lean build 2026-09-03 | proof closed |
| Proposition 3 strict | `paper_proposition_3_closed_frontier_strictly_increasingSpec` | Lean build 2026-09-03 | added p² < 1 |
| Proposition 3 concave | `paper_proposition_3_closed_frontier_concaveSpec` | Lean build 2026-09-03 | added p² < 1 |
| Proposition 4 (22) | `paper_proposition_4_expected_expansionSpec` | Lean build 2026-09-03 | representation |
| Proposition 4 ability | `paper_proposition_4_increasing_in_abilitySpec` | Lean build 2026-09-03 | representation |
| Proposition 5 weak | `paper_proposition_5_repository_expansionSpec` | Lean build 2026-09-03 | representation |
| Proposition 5 strict | `paper_proposition_5_repository_expansion_strictSpec` | Lean build 2026-09-03 | representation |

## 21. Source-Coverage Audit Ledger
- Source inventory: 15 statements inventoried from the pinned v2 PDF
  (`paper.pdf`, SHA-256
  `cddc048711c43022d5fd01b995bfb1114c728c8c879b809b5fdc354a391d3c35`).
- Coverage result: 15 direct rows; Appendix A.1, A.7 and Equation (9)
  out-of-scope; Section 5–7 empirical material out-of-scope.
- LLM-as-judge coverage audit: not run.
- Row-local statement checks: not run.

| Source statement | Linked Lean review rows | Coverage judgment | Row-local statement checks | Comments |
| --- | --- | --- | --- | --- |
| Equations (4)–(7), (18) | five `paper_equation_*Spec` rows | covered | pending | threshold algebra |
| Propositions 1–5 | nine `paper_proposition_*Spec` rows | covered / conditional boundary (Prop. 3 strict parts) | pending | see Sections 5, 6, 10 |
| Comparative static after (7) | `paper_reduction_increasing_in_abilitySpec` | conditional boundary | pending | added sign conditions |
| Appendix A.1, A.7; Equation (9) | none | out-of-scope | — | probability content |
