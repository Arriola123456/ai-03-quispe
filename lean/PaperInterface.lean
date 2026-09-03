import QX26AgenticDelegation.MainTheorems
import QX26AgenticDelegation.Assumptions

/-!
# Human-Facing Paper Interface: Agentic Delegation and the Language Frontier of Software Developers: A Model and Evidence from Claude Code on GitHub

This is the compact Lean file a human should read after formalization to check
whether the paper's definitions and named theorem statements were represented
correctly. Keep the row-level dashboard and LLM audit statements in this file
for every paper. Move implementation details, proof aliases, and bulky helper
lemmas behind imported modules such as `AuditInterface.lean`, but expose the
audited paper-facing statements directly here; do not use
`paper_interface.audit_surface_path`.

Rules for completing this file:

- Keep the paper's definitions/formatted objects first, in source order.
- Expose the actual paper formulas here; do not only point to generic library
  definitions or implementation witnesses.
- A material reusable `EconCSLib` primitive may remain a reference here only
  after `audit/library_semantic_review.json` records its exact bounded library
  declaration and an explicit byte-pinned paper-source connection. The
  dashboard and human-review packet show and source-check that declaration
  before the dependent Spec; a library name, docstring, or glossary is not a
  semantic bridge. Do not add a duplicate paper claim merely to restate it.
- If a named theorem needs a hypothesis that is not derived from earlier Lean
  declarations, declare that hypothesis in `Assumptions.lean` and list it in
  `status.json` `review_surface.assumption_names`.
- Then state the named results directly, with assumptions visible in each
  theorem signature by referencing named paper assumptions imported from
  `Assumptions.lean`.
- In the statement-first phase, write every complete source-facing statement as
  a transparent `<name>Spec : Prop` here, exactly once. Put the paired
  theorem/lemma of that exact type in `ProofInterface.lean`; its temporary
  proof body may be `by sorry` only in a private draft. This separation keeps
  the human semantic surface free of thin wrapper declarations.
- Before drafting that Lean surface, independently inventory every material
  source atom from exact pinned source quote bytes. Do not infer source atoms
  from declaration, binder, field, function, or source-map names.
- Run raw-source-to-expanded-Spec statement matching plus recursive
  premise/conclusion provenance on the skeleton. The semantic comparison uses
  only byte-pinned source quotes (and separately pinned source context) against
  the expanded transparent Spec; map summaries and proof wrappers are not
  semantic inputs. Then freeze each canonical Lean declaration-manifest digest.
- In the proof phase, replace the `ProofInterface.lean` `sorry` with a short
  proof that calls into `MainTheorems.lean` or lower proof files without
  changing the specification or theorem type. Any specification/type change
  invalidates the freeze and requires a fresh statement audit.
- At formalized closeout, complete the v11 realization receipt: Lean Meta checks
  the theorem has exactly the transparent Spec type; each source atom is bound
  to the elaborated Spec surface; closure traversal includes proof and instance
  arguments; and every material terminal has a source, approved correction or
  additional assumption, checked derivation, or version-pinned foundation
  disposition. No data, container, or identifier-based exemption is allowed.
- The transparent `...Spec` is the sole semantic-review target for its source
  claim. The paired theorem/lemma is a proof endpoint whose exact Spec type is
  verified by Lean Meta, not a duplicate source-to-Lean comparison row.
- Keep proof endpoints, exhaustive endpoint aliases, and proof-seam checks in
  `ProofInterface.lean`, implementation modules, or `ProofLedger.lean`, not
  here. Do not create new `PostPaperAudit.lean` or `AuditLedger.lean` files;
  those names are legacy.

## Named Results

Each entry has one semantic-review target (`Spec`) and one proof endpoint (the
paired theorem/lemma). The human dashboard and review packet present that pair
once rather than treating the two declarations as duplicate paper claims.

- `paper_equation_4_solo_thresholdSpec` -> `paper_equation_4_solo_threshold`: Equation (4): solo activation threshold, Section 4.2, page 12, Equation (4); Appendix A.2, page 60, Equation (16).
- `paper_equation_5_generation1_thresholdSpec` -> `paper_equation_5_generation1_threshold`: Equation (5): effective Generation-1 threshold, Section 4.2, page 12, Equation (5); Appendix A.2, page 61, Equations (17)-(18).
- `paper_equation_18_unfamiliar_no_augmentationSpec` -> `paper_equation_18_unfamiliar_no_augmentation`: Assumption 1 consequence: augmentation does not move the unfamiliar-language entry margin (T^1 = T^S), Section 4.2, page 12, text after Equation (5); Appendix A.2, page 61, Equation (18).
- `paper_equation_6_delegation_thresholdSpec` -> `paper_equation_6_delegation_threshold`: Equation (6): delegation activation threshold, Section 4.2, page 13, Equation (6); Appendix A.2, page 61, Equation (19).
- `paper_equation_7_agentic_threshold_reductionSpec` -> `paper_equation_7_agentic_threshold_reduction`: Equation (7): agentic threshold reduction B for an unfamiliar language, Section 4.2, page 13, Equation (7); Appendix A.2, page 61, Equation (20).
- `paper_reduction_increasing_in_abilitySpec` -> `paper_reduction_increasing_in_ability`: Comparative statics of B: the reduction is larger for higher-ability developers (Assumption 2), Section 4.2, page 13, text after Equation (7); Assumption 2, page 12.
- `paper_proposition_1_frontier_expansionSpec` -> `paper_proposition_1_frontier_expansion`: Proposition 1 (Frontier expansion), Section 4.2, page 13, Proposition 1; proof in Appendix A.3, pages 61-62, Equation (21).
- `paper_proposition_2_activation_bandSpec` -> `paper_proposition_2_activation_band`: Proposition 2 (Activation band for unfamiliar languages), Equation (8), Section 4.2, page 13, Proposition 2, Equation (8); proof in Appendix A.4, page 62.
- `paper_proposition_3_cumulative_effect_nonnegSpec` -> `paper_proposition_3_cumulative_effect_nonneg`: Proposition 3 (Dynamic cumulative-language effect), Equation (10): nonnegativity, Section 4.3, page 15, Proposition 3, Equation (10); proof in Appendix A.6, page 63, Equations (24)-(25).
- `paper_proposition_3_closed_frontier_strictly_increasingSpec` -> `paper_proposition_3_closed_frontier_strictly_increasing`: Proposition 3 (Dynamic cumulative-language effect): strict increase in the closed-frontier benchmark, Section 4.3, page 15, Proposition 3; Appendix A.6, page 64, Equation (26).
- `paper_proposition_3_closed_frontier_concaveSpec` -> `paper_proposition_3_closed_frontier_concave`: Proposition 3 (Dynamic cumulative-language effect): concavity in the closed-frontier benchmark, Section 4.3, page 15, Proposition 3; Appendix A.6, page 64, Equation (26).
- `paper_proposition_4_expected_expansionSpec` -> `paper_proposition_4_expected_expansion`: Proposition 4 (Specialist and ability heterogeneity), Equation (22): expected expansion identity and monotonicity in the candidate stock, Appendix A.5, pages 62-63, Proposition 4, Equations (22)-(23).
- `paper_proposition_4_increasing_in_abilitySpec` -> `paper_proposition_4_increasing_in_ability`: Proposition 4 (Specialist and ability heterogeneity): monotonicity in general ability, Appendix A.5, pages 62-63, Proposition 4 and its proof.
- `paper_proposition_5_repository_expansionSpec` -> `paper_proposition_5_repository_expansion`: Proposition 5 (Repository expansion): weak expansion, Appendix A.8, page 64, Proposition 5 and its proof.
- `paper_proposition_5_repository_expansion_strictSpec` -> `paper_proposition_5_repository_expansion_strict`: Proposition 5 (Repository expansion): strict expansion, Appendix A.8, page 64, Proposition 5 and its proof.
-/

namespace QX26AgenticDelegation

/--
Equation (4): solo activation threshold

Paper statement: Because each surplus is affine in the opportunity shock ω, each mode has an activation threshold. Setting V^S ≥ 0 in Equation (1), solo production is viable when ω ≥ T^S ≡ b - sμ + ρ s^2/(2π).

Source location: Section 4.2, page 12, Equation (4); Appendix A.2, page 60, Equation (16)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_equation_4_solo_thresholdSpec : Prop :=
  ∀ ω s μ prec b ρ : ℝ,
    (0 ≤ ω + s * μ - ρ * s ^ 2 / (2 * prec) - b ↔ b - s * μ + ρ * s ^ 2 / (2 * prec) ≤ ω)

/--
Equation (5): effective Generation-1 threshold

Paper statement: Since V^C = V^S + γs - r^C, augmentation is viable when ω ≥ T^C = T^S - (γs - r^C). The developer takes whichever pre-agent mode clears first, so the effective Generation-1 threshold is T^1 = min{T^S, T^C} = T^S - max{0, γs - r^C}.

Source location: Section 4.2, page 12, Equation (5); Appendix A.2, page 61, Equations (17)-(18)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_equation_5_generation1_thresholdSpec : Prop :=
  ∀ ω s μ prec b ρ γ rC : ℝ,
    let VS := ω + s * μ - ρ * s ^ 2 / (2 * prec) - b
    let TS := b - s * μ + ρ * s ^ 2 / (2 * prec)
    (0 ≤ max VS (VS + γ * s - rC) ↔ TS - max 0 (γ * s - rC) ≤ ω)

/--
Assumption 1 consequence: augmentation does not move the unfamiliar-language entry margin (T^1 = T^S)

Paper statement: For an unfamiliar language Assumption 1 implies γs - r^C ≤ 0, hence T^1 = T^S: augmentation does not move the entry margin.

Source location: Section 4.2, page 12, text after Equation (5); Appendix A.2, page 61, Equation (18)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_equation_18_unfamiliar_no_augmentationSpec : Prop :=
  ∀ ω s μ prec b ρ γ rC : ℝ,
    let VS := ω + s * μ - ρ * s ^ 2 / (2 * prec) - b
    let TS := b - s * μ + ρ * s ^ 2 / (2 * prec)
    γ * s - rC ≤ 0 → (0 ≤ max VS (VS + γ * s - rC) ↔ TS ≤ ω)

/--
Equation (6): delegation activation threshold

Paper statement: Setting V^D ≥ 0 in Equation (3), delegation is viable when ω ≥ T^D ≡ b - (1-λ)sμ - λ a z(A) + κ(a,s) + r^D + (ρ/2)[(1-λ)^2 s^2/π + σ_D^2(a,s,A)], so the post-agent threshold is T^2 = min{T^1, T^D} ≤ T^1.

Source location: Section 4.2, page 13, Equation (6); Appendix A.2, page 61, Equation (19)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_equation_6_delegation_thresholdSpec : Prop :=
  ∀ ω s μ prec b ρ lam a z κ rD σ : ℝ,
    (0 ≤ ω + (1 - lam) * s * μ + lam * a * z - κ - rD - b
          - ρ / 2 * ((1 - lam) ^ 2 * s ^ 2 / prec + σ)
      ↔ b - (1 - lam) * s * μ - lam * a * z + κ + rD
          + ρ / 2 * ((1 - lam) ^ 2 * s ^ 2 / prec + σ) ≤ ω)

/--
Equation (7): agentic threshold reduction B for an unfamiliar language

Paper statement: For an unfamiliar language, the economics reduce to the agentic threshold reduction B ≡ T^1 - T^D = T^S - T^D. Differencing Equations (4) and (6) gives B = λ[a z(A) - sμ] - κ(a,s) - r^D + (ρ/2)[(2λ - λ^2) s^2/π - σ_D^2(a,s,A)].

Source location: Section 4.2, page 13, Equation (7); Appendix A.2, page 61, Equation (20)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_equation_7_agentic_threshold_reductionSpec : Prop :=
  ∀ s μ prec b ρ γ rC lam a z κ rD σ : ℝ,
    let TS := b - s * μ + ρ * s ^ 2 / (2 * prec)
    let TC := TS - (γ * s - rC)
    let TD := b - (1 - lam) * s * μ - lam * a * z + κ + rD
                + ρ / 2 * ((1 - lam) ^ 2 * s ^ 2 / prec + σ)
    γ * s - rC ≤ 0 →
      min TS TC - TD
        = lam * (a * z - s * μ) - κ - rD + ρ / 2 * ((2 * lam - lam ^ 2) * s ^ 2 / prec - σ)

/--
Comparative statics of B: the reduction is larger for higher-ability developers (Assumption 2)

Paper statement: If B > 0, delegation lowers the entry threshold for the unfamiliar language, and by Assumption 2 the reduction is larger for higher-ability developers and more capable agents. Assumption 2 (Verification technology): κ_a < 0, κ_s ≤ 0, and ∂σ_D^2/∂a ≤ 0, ∂σ_D^2/∂s ≤ 0, ∂σ_D^2/∂A ≤ 0.

Source location: Section 4.2, page 13, text after Equation (7); Assumption 2, page 12
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_reduction_increasing_in_abilitySpec : Prop :=
  ∀ (s μ prec ρ lam z rD : ℝ) (κ σ : ℝ → ℝ),
    0 ≤ ρ → 0 ≤ lam → 0 ≤ z → Antitone κ → Antitone σ →
      Monotone (fun a : ℝ =>
        lam * (a * z - s * μ) - κ a - rD + ρ / 2 * ((2 * lam - lam ^ 2) * s ^ 2 / prec - σ a))

/--
Proposition 1 (Frontier expansion)

Paper statement: For every developer, language, date, and opportunity realization, Z^2_ik,t ≥ Z^1_ik,t, hence N^2_it ≥ N^1_it path by path.

Source location: Section 4.2, page 13, Proposition 1; proof in Appendix A.3, pages 61-62, Equation (21)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_1_frontier_expansionSpec : Prop :=
  ∀ {ι : Type} (K : Finset ι) (ω s μ prec b ρ γ rC lam a z κ rD σ : ι → ℝ),
    let V1 : ι → ℝ := fun k =>
      max (ω k + s k * μ k - ρ k * s k ^ 2 / (2 * prec k) - b k)
        (ω k + s k * μ k - ρ k * s k ^ 2 / (2 * prec k) - b k + γ k * s k - rC k)
    let V2 : ι → ℝ := fun k =>
      max (V1 k)
        (ω k + (1 - lam k) * s k * μ k + lam k * a k * z k - κ k - rD k - b k
          - ρ k / 2 * ((1 - lam k) ^ 2 * s k ^ 2 / prec k + σ k))
    ∑ k ∈ K, (if 0 ≤ V1 k then (1 : ℝ) else 0) ≤ ∑ k ∈ K, (if 0 ≤ V2 k then (1 : ℝ) else 0)

/--
Proposition 2 (Activation band for unfamiliar languages), Equation (8)

Paper statement: Consider an unfamiliar language satisfying Assumption 1. If B_ik,t > 0, then Z^2_ik,t - Z^1_ik,t = 1[T^D_ik,t ≤ ω_ik,t < T^S_ik,t].

Source location: Section 4.2, page 13, Proposition 2, Equation (8); proof in Appendix A.4, page 62
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_2_activation_bandSpec : Prop :=
  ∀ ω s μ prec b ρ γ rC lam a z κ rD σ : ℝ,
    let VS := ω + s * μ - ρ * s ^ 2 / (2 * prec) - b
    let VC := VS + γ * s - rC
    let VD := ω + (1 - lam) * s * μ + lam * a * z - κ - rD - b
                - ρ / 2 * ((1 - lam) ^ 2 * s ^ 2 / prec + σ)
    let TS := b - s * μ + ρ * s ^ 2 / (2 * prec)
    let TD := b - (1 - lam) * s * μ - lam * a * z + κ + rD
                + ρ / 2 * ((1 - lam) ^ 2 * s ^ 2 / prec + σ)
    γ * s - rC ≤ 0 → 0 < TS - TD →
      (if 0 ≤ max (max VS VC) VD then (1 : ℝ) else 0)
          - (if 0 ≤ max VS VC then (1 : ℝ) else 0)
        = if TD ≤ ω ∧ ω < TS then (1 : ℝ) else 0

/--
Proposition 3 (Dynamic cumulative-language effect), Equation (10): nonnegativity

Paper statement: For an initially unfamiliar language, let p^g_ik be the per-period first-use hazard under generation g. If p^2_ik ≥ p^1_ik, the expected cumulative-language effect at event-time horizon s is ΔC_i(s) = Σ_{k∈U_i} [(1 - p^1_ik)^{s+1} - (1 - p^2_ik)^{s+1}] ≥ 0.

Source location: Section 4.3, page 15, Proposition 3, Equation (10); proof in Appendix A.6, page 63, Equations (24)-(25)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_3_cumulative_effect_nonnegSpec : Prop :=
  ∀ {ι : Type} (U : Finset ι) (p1 p2 : ι → ℝ) (s : ℕ),
    (∀ k, p2 k ≤ 1) → (∀ k, p1 k ≤ p2 k) →
      0 ≤ ∑ k ∈ U, ((1 - p1 k) ^ (s + 1) - (1 - p2 k) ^ (s + 1))

/--
Proposition 3 (Dynamic cumulative-language effect): strict increase in the closed-frontier benchmark

Paper statement: ΔC_i(s), which in the closed-frontier benchmark p^1_ik = 0 < p^2_ik is strictly increasing and concave over the observed horizon. (Appendix A.6: If p1 = 0 < p2, the first difference is p2 (1 - p2)^{s+1} > 0.)

Source location: Section 4.3, page 15, Proposition 3; Appendix A.6, page 64, Equation (26)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_3_closed_frontier_strictly_increasingSpec : Prop :=
  ∀ {ι : Type} (U : Finset ι) (p2 : ι → ℝ) (s : ℕ),
    U.Nonempty → (∀ k, 0 < p2 k) → (∀ k, p2 k < 1) →
      ∑ k ∈ U, ((1 - (0 : ℝ)) ^ (s + 1) - (1 - p2 k) ^ (s + 1))
        < ∑ k ∈ U, ((1 - (0 : ℝ)) ^ (s + 2) - (1 - p2 k) ^ (s + 2))

/--
Proposition 3 (Dynamic cumulative-language effect): concavity in the closed-frontier benchmark

Paper statement: ΔC_i(s), which in the closed-frontier benchmark p^1_ik = 0 < p^2_ik is strictly increasing and concave over the observed horizon. (Appendix A.6: the second difference is -(p2)^2 (1 - p2)^{s+1} < 0, giving strict increase and concavity.)

Source location: Section 4.3, page 15, Proposition 3; Appendix A.6, page 64, Equation (26)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_3_closed_frontier_concaveSpec : Prop :=
  ∀ {ι : Type} (U : Finset ι) (p2 : ι → ℝ) (s : ℕ),
    U.Nonempty → (∀ k, 0 < p2 k) → (∀ k, p2 k < 1) →
      let Δ : ℕ → ℝ := fun t => ∑ k ∈ U, ((1 - (0 : ℝ)) ^ (t + 1) - (1 - p2 k) ^ (t + 1))
      Δ (s + 2) - Δ (s + 1) < Δ (s + 1) - Δ s

/--
Proposition 4 (Specialist and ability heterogeneity), Equation (22): expected expansion identity and monotonicity in the candidate stock

Paper statement: Under Assumption 3, expected expansion into initially unfamiliar languages is E[E_i | a_i, U_i] = U_i p_i(a_i, A), E_i ≡ Σ_{k∈U_i} (Z^2_ik - Z^1_ik). It is increasing in the stock of unfamiliar-language candidates U_i and in general ability a_i.

Source location: Appendix A.5, pages 62-63, Proposition 4, Equations (22)-(23)
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_4_expected_expansionSpec : Prop :=
  ∀ {ι : Type} (U U' : Finset ι) (p : ℝ),
    0 ≤ p → U ⊆ U' →
      (∑ _k ∈ U, p = (U.card : ℝ) * p) ∧ ∑ _k ∈ U, p ≤ ∑ _k ∈ U', p

/--
Proposition 4 (Specialist and ability heterogeneity): monotonicity in general ability

Paper statement: Assumption 2 implies stronger general ability lowers verification costs and weakly lowers residual error, so p_i(a_i, A) is increasing in a_i when the opportunity density is positive at the relevant threshold. The product U_i p_i(a_i, A) is therefore largest for developers with many candidates and high ability.

Source location: Appendix A.5, pages 62-63, Proposition 4 and its proof
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_4_increasing_in_abilitySpec : Prop :=
  ∀ (n : ℕ) (p : ℝ → ℝ), Monotone p → Monotone (fun a : ℝ => (n : ℝ) * p a)

/--
Proposition 5 (Repository expansion): weak expansion

Paper statement: Suppose each repository requires at least one programming language and carries an entry cost that is weakly decreasing when the developer can activate that language. If agentic delegation weakly expands the active-language set, then the expected number of repositories the developer can contribute to weakly increases.

Source location: Appendix A.8, page 64, Proposition 5 and its proof
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_5_repository_expansionSpec : Prop :=
  ∀ {ι : Type} (R : Finset ι) (Ω c1 c2 : ι → ℝ),
    (∀ r, c2 r ≤ c1 r) →
      ∑ r ∈ R, (if c1 r ≤ Ω r then (1 : ℝ) else 0)
        ≤ ∑ r ∈ R, (if c2 r ≤ Ω r then (1 : ℝ) else 0)

/--
Proposition 5 (Repository expansion): strict expansion

Paper statement: It increases strictly when some repositories require languages in the delegation activation band. (Proof: strict expansion follows if the opportunity distribution places positive mass on repositories whose required language lies in the activation band.)

Source location: Appendix A.8, page 64, Proposition 5 and its proof
Source status: pinned statement-spec transcription; independent source audit pending

This transparent proposition is the exact statement-audit target. It is not
proof evidence. Its exact-type proof endpoint is declared in
`ProofInterface.lean`, so this human-facing file presents the full semantic
proposition once. At closeout, source atoms must be independently inventoried
from pinned source quote bytes and bound to this elaborated proposition rather
than inferred from identifiers.
-/
def paper_proposition_5_repository_expansion_strictSpec : Prop :=
  ∀ {ι : Type} (R : Finset ι) (Ω c1 c2 : ι → ℝ),
    (∀ r, c2 r ≤ c1 r) → (∃ r ∈ R, c2 r ≤ Ω r ∧ Ω r < c1 r) →
      ∑ r ∈ R, (if c1 r ≤ Ω r then (1 : ℝ) else 0)
        < ∑ r ∈ R, (if c2 r ≤ Ω r then (1 : ℝ) else 0)

end QX26AgenticDelegation
