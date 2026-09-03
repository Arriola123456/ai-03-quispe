import QX26AgenticDelegation.PaperInterface

/-!
# Proof Interface: Agentic Delegation and the Language Frontier of Software Developers: A Model and Evidence from Claude Code on GitHub

This file contains exact-type proof endpoints for the transparent propositions
in `PaperInterface.lean`. It is not a human semantic-review surface: one source
claim is reviewed once, against its expanded `...Spec : Prop` declaration.
-/

namespace QX26AgenticDelegation

/--
Lean proof endpoint for `paper_equation_4_solo_thresholdSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_equation_4_solo_threshold :
  paper_equation_4_solo_thresholdSpec := by
  intro ω s μ prec b ρ
  constructor <;> intro h <;> linarith

/--
Lean proof endpoint for `paper_equation_5_generation1_thresholdSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_equation_5_generation1_threshold :
  paper_equation_5_generation1_thresholdSpec := by
  intro ω s μ prec b ρ γ rC
  dsimp only
  rcases le_total 0 (γ * s - rC) with h | h
  · rw [max_eq_right h, max_eq_right (by linarith)]
    constructor <;> intro h' <;> linarith
  · rw [max_eq_left h, max_eq_left (by linarith)]
    constructor <;> intro h' <;> linarith

/--
Lean proof endpoint for `paper_equation_18_unfamiliar_no_augmentationSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_equation_18_unfamiliar_no_augmentation :
  paper_equation_18_unfamiliar_no_augmentationSpec := by
  intro ω s μ prec b ρ γ rC
  dsimp only
  intro h
  rw [max_eq_left (by linarith)]
  constructor <;> intro h' <;> linarith

/--
Lean proof endpoint for `paper_equation_6_delegation_thresholdSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_equation_6_delegation_threshold :
  paper_equation_6_delegation_thresholdSpec := by
  intro ω s μ prec b ρ lam a z κ rD σ
  constructor <;> intro h <;> linarith

/--
Lean proof endpoint for `paper_equation_7_agentic_threshold_reductionSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_equation_7_agentic_threshold_reduction :
  paper_equation_7_agentic_threshold_reductionSpec := by
  intro s μ prec b ρ γ rC lam a z κ rD σ
  dsimp only
  intro h
  rw [min_eq_left (by linarith)]
  ring

/--
Lean proof endpoint for `paper_reduction_increasing_in_abilitySpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_reduction_increasing_in_ability :
  paper_reduction_increasing_in_abilitySpec := by
  intro s μ prec ρ lam z rD κ σ hρ hlam hz hκ hσ
  intro a a' haa'
  dsimp only
  have h1 : κ a' ≤ κ a := hκ haa'
  have h2 : σ a' ≤ σ a := hσ haa'
  have key : (lam * (a' * z - s * μ) - κ a' - rD
        + ρ / 2 * ((2 * lam - lam ^ 2) * s ^ 2 / prec - σ a'))
      - (lam * (a * z - s * μ) - κ a - rD
        + ρ / 2 * ((2 * lam - lam ^ 2) * s ^ 2 / prec - σ a))
      = lam * z * (a' - a) + (κ a - κ a') + ρ / 2 * (σ a - σ a') := by ring
  have t1 : 0 ≤ lam * z * (a' - a) := mul_nonneg (mul_nonneg hlam hz) (by linarith)
  have t2 : 0 ≤ κ a - κ a' := by linarith
  have t3 : 0 ≤ ρ / 2 * (σ a - σ a') := mul_nonneg (by linarith) (by linarith)
  linarith [key, t1, t2, t3]

/--
Lean proof endpoint for `paper_proposition_1_frontier_expansionSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_1_frontier_expansion :
  paper_proposition_1_frontier_expansionSpec := by
  intro ι K ω s μ prec b ρ γ rC lam a z κ rD σ
  dsimp only
  apply Finset.sum_le_sum
  intro k _
  split_ifs with h1 h2
  · exact le_rfl
  · exact absurd (le_trans h1 (le_max_left _ _)) h2
  · exact zero_le_one
  · exact le_rfl

/--
Lean proof endpoint for `paper_proposition_2_activation_bandSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_2_activation_band :
  paper_proposition_2_activation_bandSpec := by
  intro ω s μ prec b ρ γ rC lam a z κ rD σ
  dsimp only
  intro hA hB
  exact activation_band_named ω s μ prec b ρ γ rC lam a z κ rD σ hA hB

/--
Lean proof endpoint for `paper_proposition_3_cumulative_effect_nonnegSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_3_cumulative_effect_nonneg :
  paper_proposition_3_cumulative_effect_nonnegSpec := by
  intro ι U p1 p2 s h2 h12
  apply Finset.sum_nonneg
  intro k _
  have h0 : 0 ≤ 1 - p2 k := by linarith [h2 k]
  have hle : 1 - p2 k ≤ 1 - p1 k := by linarith [h12 k]
  have := pow_le_pow_left₀ h0 hle (s + 1)
  linarith

/--
Lean proof endpoint for `paper_proposition_3_closed_frontier_strictly_increasingSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_3_closed_frontier_strictly_increasing :
  paper_proposition_3_closed_frontier_strictly_increasingSpec := by
  intro ι U p2 s hU h0 h1
  apply Finset.sum_lt_sum_of_nonempty hU
  intro k _
  have hq0 : 0 < 1 - p2 k := by linarith [h1 k]
  have hq1 : 1 - p2 k < 1 := by linarith [h0 k]
  have := pow_lt_pow_right_of_lt_one₀ hq0 hq1 (show s + 1 < s + 2 by omega)
  simp only [sub_zero, one_pow]
  linarith

/--
Lean proof endpoint for `paper_proposition_3_closed_frontier_concaveSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_3_closed_frontier_concave :
  paper_proposition_3_closed_frontier_concaveSpec := by
  intro ι U p2 s hU h0 h1
  dsimp only
  rw [← Finset.sum_sub_distrib, ← Finset.sum_sub_distrib]
  apply Finset.sum_lt_sum_of_nonempty hU
  intro k _
  have hq0 : 0 < 1 - p2 k := by linarith [h1 k]
  simp only [sub_zero, one_pow]
  have hp : 0 < p2 k := h0 k
  have hpow : 0 < (1 - p2 k) ^ (s + 1) := pow_pos hq0 _
  have e : (1 - p2 k) ^ (s + 3) = (1 - p2 k) ^ (s + 1) * (1 - p2 k) ^ 2 := by ring
  have e' : (1 - p2 k) ^ (s + 2) = (1 - p2 k) ^ (s + 1) * (1 - p2 k) := by ring
  rw [e, e']
  nlinarith [mul_pos hpow hp, mul_pos (mul_pos hpow hp) hp]

/--
Lean proof endpoint for `paper_proposition_4_expected_expansionSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_4_expected_expansion :
  paper_proposition_4_expected_expansionSpec := by
  intro ι U U' p hp hUU'
  refine ⟨by simp, ?_⟩
  apply Finset.sum_le_sum_of_subset_of_nonneg hUU'
  intro _ _ _
  exact hp

/--
Lean proof endpoint for `paper_proposition_4_increasing_in_abilitySpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_4_increasing_in_ability :
  paper_proposition_4_increasing_in_abilitySpec := by
  intro n p hp a a' haa'
  exact mul_le_mul_of_nonneg_left (hp haa') (Nat.cast_nonneg n)

/--
Lean proof endpoint for `paper_proposition_5_repository_expansionSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_5_repository_expansion :
  paper_proposition_5_repository_expansionSpec := by
  intro ι R Ω c1 c2 h
  apply Finset.sum_le_sum
  intro r _
  split_ifs with h1 h2
  · exact le_rfl
  · exact absurd (le_trans (h r) h1) h2
  · exact zero_le_one
  · exact le_rfl

/--
Lean proof endpoint for `paper_proposition_5_repository_expansion_strictSpec`.

This theorem is intentionally outside `PaperInterface.lean`: Lean Meta checks
that it has exactly the transparent Spec type, while source-to-Lean semantic
review compares the raw source bundle only to that Spec.
-/
theorem paper_proposition_5_repository_expansion_strict :
  paper_proposition_5_repository_expansion_strictSpec := by
  intro ι R Ω c1 c2 h hex
  obtain ⟨r0, hr0, hc2, hc1⟩ := hex
  apply Finset.sum_lt_sum
  · intro r _
    split_ifs with h1 h2
    · exact le_rfl
    · exact absurd (le_trans (h r) h1) h2
    · exact zero_le_one
    · exact le_rfl
  · refine ⟨r0, hr0, ?_⟩
    rw [if_neg (not_le.mpr hc1), if_pos hc2]
    exact zero_lt_one

end QX26AgenticDelegation
