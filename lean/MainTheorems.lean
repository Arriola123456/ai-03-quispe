import EconCSLib

/-!
# Paper-Facing Theorems: Agentic Delegation and the Language Frontier of Software Developers: A Model and Evidence from Claude Code on GitHub

This file is the implementation theorem layer for the source paper. Keep
source-faithful definitions and theorem wrappers here, and expose only the
compact human-review subset in `PaperInterface.lean`.

During the statement-first phase, each exact paper-facing proposition lives in a
transparent `<name>Spec : Prop` declaration in `PaperInterface.lean`; the paired
theorem/lemma endpoint belongs in `ProofInterface.lean` and has exactly that
type. Add proof implementations here only after those specifications pass v11
raw-source-to-expanded-Spec review and recursive premise provenance audit. Before full closeout, the v11
realization audit independently binds pinned source atoms to the elaborated Spec
and accounts for the complete Lean closure; a proof hole or a declaration name
is never evidence for that correspondence.

## Source model (Section 4.1, Appendix A.2)

All objects are taken at a fixed developer-language-month `(i, k, t)`, so the
paper's functions `z(A)`, `κ(a, s)` and `σ_D^2(a, s, A)` enter as real numbers
`z`, `κ`, `σ`. The belief precision `π_ik,t` is named `prec` (to avoid the
`Real.pi` notation) and the delegation share `λ` is named `lam` (a Lean keyword).
The transparent `Spec` declarations in `PaperInterface.lean` are written directly
over these primitives; the named definitions below are only proof plumbing and
are definitionally equal to the expanded Spec bodies.
-/

namespace QX26AgenticDelegation

/-- Equation (1): solo certainty-equivalent surplus `V^S`. -/
noncomputable def soloSurplus (ω s μ prec b ρ : ℝ) : ℝ :=
  ω + s * μ - ρ * s ^ 2 / (2 * prec) - b

/-- Equation (2): Generation-1 (augmentation) surplus `V^C = V^S + γ s - r^C`. -/
noncomputable def augmentedSurplus (ω s μ prec b ρ γ rC : ℝ) : ℝ :=
  soloSurplus ω s μ prec b ρ + γ * s - rC

/-- Equation (3): Generation-2 (delegation) surplus `V^D`. -/
noncomputable def delegatedSurplus (ω s μ prec b ρ lam a z κ rD σ : ℝ) : ℝ :=
  ω + (1 - lam) * s * μ + lam * a * z - κ - rD - b
    - ρ / 2 * ((1 - lam) ^ 2 * s ^ 2 / prec + σ)

/-- Equation (4)/(16): solo activation threshold `T^S`. -/
noncomputable def soloThreshold (s μ prec b ρ : ℝ) : ℝ :=
  b - s * μ + ρ * s ^ 2 / (2 * prec)

/-- Equation (17): augmentation threshold `T^C = T^S - (γ s - r^C)`. -/
noncomputable def augmentedThreshold (s μ prec b ρ γ rC : ℝ) : ℝ :=
  soloThreshold s μ prec b ρ - (γ * s - rC)

/-- Equation (5)/(18): effective Generation-1 threshold `T^1 = min{T^S, T^C}`. -/
noncomputable def gen1Threshold (s μ prec b ρ γ rC : ℝ) : ℝ :=
  min (soloThreshold s μ prec b ρ) (augmentedThreshold s μ prec b ρ γ rC)

/-- Equation (6)/(19): delegation threshold `T^D`. -/
noncomputable def delegationThreshold (s μ prec b ρ lam a z κ rD σ : ℝ) : ℝ :=
  b - (1 - lam) * s * μ - lam * a * z + κ + rD
    + ρ / 2 * ((1 - lam) ^ 2 * s ^ 2 / prec + σ)

/-- Post-agent threshold `T^2 = min{T^1, T^D}` (text after Equation (6)). -/
noncomputable def gen2Threshold (s μ prec b ρ γ rC lam a z κ rD σ : ℝ) : ℝ :=
  min (gen1Threshold s μ prec b ρ γ rC) (delegationThreshold s μ prec b ρ lam a z κ rD σ)

/-- Equation (7): agentic threshold reduction `B ≡ T^1 - T^D`. -/
noncomputable def thresholdReduction (s μ prec b ρ γ rC lam a z κ rD σ : ℝ) : ℝ :=
  gen1Threshold s μ prec b ρ γ rC - delegationThreshold s μ prec b ρ lam a z κ rD σ

/-! ## Threshold algebra (Appendix A.2) -/

/-- Each surplus is affine in the opportunity shock: `V^S = ω - T^S`. -/
theorem soloSurplus_eq (ω s μ prec b ρ : ℝ) :
    soloSurplus ω s μ prec b ρ = ω - soloThreshold s μ prec b ρ := by
  unfold soloSurplus soloThreshold; ring

/-- `V^D = ω - T^D`. -/
theorem delegatedSurplus_eq (ω s μ prec b ρ lam a z κ rD σ : ℝ) :
    delegatedSurplus ω s μ prec b ρ lam a z κ rD σ
      = ω - delegationThreshold s μ prec b ρ lam a z κ rD σ := by
  unfold delegatedSurplus delegationThreshold; ring

/-- Under Assumption 1 for an unfamiliar language (`γ s - r^C ≤ 0`), augmentation
is weakly dominated by solo production. -/
theorem augmentedSurplus_le (ω s μ prec b ρ γ rC : ℝ) (hA : γ * s - rC ≤ 0) :
    augmentedSurplus ω s μ prec b ρ γ rC ≤ soloSurplus ω s μ prec b ρ := by
  unfold augmentedSurplus; linarith

/-- Equation (18): under Assumption 1 the Generation-1 threshold is the solo one. -/
theorem gen1Threshold_eq_solo (s μ prec b ρ γ rC : ℝ) (hA : γ * s - rC ≤ 0) :
    gen1Threshold s μ prec b ρ γ rC = soloThreshold s μ prec b ρ := by
  unfold gen1Threshold augmentedThreshold
  exact min_eq_left (by linarith)

/-- `T^2 ≤ T^1`: menu expansion can only lower the entry margin. -/
theorem gen2Threshold_le (s μ prec b ρ γ rC lam a z κ rD σ : ℝ) :
    gen2Threshold s μ prec b ρ γ rC lam a z κ rD σ ≤ gen1Threshold s μ prec b ρ γ rC :=
  min_le_left _ _

/-- Equation (7)/(20) in named form. -/
theorem thresholdReduction_eq (s μ prec b ρ γ rC lam a z κ rD σ : ℝ)
    (hA : γ * s - rC ≤ 0) :
    thresholdReduction s μ prec b ρ γ rC lam a z κ rD σ
      = lam * (a * z - s * μ) - κ - rD
        + ρ / 2 * ((2 * lam - lam ^ 2) * s ^ 2 / prec - σ) := by
  unfold thresholdReduction
  rw [gen1Threshold_eq_solo s μ prec b ρ γ rC hA]
  unfold soloThreshold delegationThreshold
  ring

/-! ## Activation indicators (Section 4.2) -/

/-- Indicator identity behind Proposition 2: with `V^S = ω - T^S`, `V^D = ω - T^D`
and `T^D < T^S`, the difference of activation indicators is the band indicator. -/
theorem band_indicator {ω TS TD : ℝ} (hlt : TD < TS) :
    (if 0 ≤ max (ω - TS) (ω - TD) then (1 : ℝ) else 0)
        - (if 0 ≤ ω - TS then (1 : ℝ) else 0)
      = if TD ≤ ω ∧ ω < TS then (1 : ℝ) else 0 := by
  have hmax : max (ω - TS) (ω - TD) = ω - TD := max_eq_right (by linarith)
  rw [hmax]
  by_cases hS : TS ≤ ω
  · have h1 : 0 ≤ ω - TD := by linarith
    have h2 : 0 ≤ ω - TS := by linarith
    have h3 : ¬ (TD ≤ ω ∧ ω < TS) := fun h => absurd h.2 (not_lt.mpr hS)
    rw [if_pos h1, if_pos h2, if_neg h3]
    norm_num
  · by_cases hD : TD ≤ ω
    · have h1 : 0 ≤ ω - TD := by linarith
      have h2 : ¬ 0 ≤ ω - TS := by intro h; exact hS (by linarith)
      have h3 : TD ≤ ω ∧ ω < TS := ⟨hD, not_le.mp hS⟩
      rw [if_pos h1, if_neg h2, if_pos h3]
      norm_num
    · have h1 : ¬ 0 ≤ ω - TD := by intro h; exact hD (by linarith)
      have h2 : ¬ 0 ≤ ω - TS := by intro h; exact hS (by linarith)
      have h3 : ¬ (TD ≤ ω ∧ ω < TS) := fun h => hD h.1
      rw [if_neg h1, if_neg h2, if_neg h3]
      norm_num

/-- Proposition 2 in named-definition form (Appendix A.4). -/
theorem activation_band_named (ω s μ prec b ρ γ rC lam a z κ rD σ : ℝ)
    (hA : γ * s - rC ≤ 0)
    (hB : 0 < soloThreshold s μ prec b ρ - delegationThreshold s μ prec b ρ lam a z κ rD σ) :
    (if 0 ≤ max (max (soloSurplus ω s μ prec b ρ) (augmentedSurplus ω s μ prec b ρ γ rC))
          (delegatedSurplus ω s μ prec b ρ lam a z κ rD σ) then (1 : ℝ) else 0)
        - (if 0 ≤ max (soloSurplus ω s μ prec b ρ) (augmentedSurplus ω s μ prec b ρ γ rC)
            then (1 : ℝ) else 0)
      = if delegationThreshold s μ prec b ρ lam a z κ rD σ ≤ ω
            ∧ ω < soloThreshold s μ prec b ρ then (1 : ℝ) else 0 := by
  rw [max_eq_left (augmentedSurplus_le ω s μ prec b ρ γ rC hA), soloSurplus_eq,
    delegatedSurplus_eq]
  exact band_indicator (by linarith)

/-! ## Extensions beyond the printed statements -/

/-- Extension of Proposition 2: the band identity (8) holds without the premise
`B > 0`. When `B ≤ 0` the band `[T^D, T^S)` is empty and both sides vanish, so the
hypothesis `B > 0` only guarantees that the band is nonempty. -/
theorem activation_band_general (ω s μ prec b ρ γ rC lam a z κ rD σ : ℝ)
    (hA : γ * s - rC ≤ 0) :
    (if 0 ≤ max (max (soloSurplus ω s μ prec b ρ) (augmentedSurplus ω s μ prec b ρ γ rC))
          (delegatedSurplus ω s μ prec b ρ lam a z κ rD σ) then (1 : ℝ) else 0)
        - (if 0 ≤ max (soloSurplus ω s μ prec b ρ) (augmentedSurplus ω s μ prec b ρ γ rC)
            then (1 : ℝ) else 0)
      = if delegationThreshold s μ prec b ρ lam a z κ rD σ ≤ ω
            ∧ ω < soloThreshold s μ prec b ρ then (1 : ℝ) else 0 := by
  rw [max_eq_left (augmentedSurplus_le ω s μ prec b ρ γ rC hA), soloSurplus_eq,
    delegatedSurplus_eq]
  set TS := soloThreshold s μ prec b ρ with hTS
  set TD := delegationThreshold s μ prec b ρ lam a z κ rD σ with hTD
  rcases le_or_gt TS TD with hge | hlt
  · have hmax : max (ω - TS) (ω - TD) = ω - TS := max_eq_left (by linarith)
    rw [hmax]
    have h3 : ¬ (TD ≤ ω ∧ ω < TS) := fun h => absurd (lt_of_le_of_lt h.1 h.2) (not_lt.mpr hge)
    rw [if_neg h3]
    simp
  · exact band_indicator hlt

/-- Endpoint check for Proposition 3. The printed closed-frontier domain is
`p^1 = 0 < p^2`, which admits `p^2 = 1`. At `p^2 = 1` the cumulative effect
`ΔC_i(s) = Σ_k [1 - (1 - p^2_k)^{s+1}]` equals `|U_i|` at every horizon, so it is
*not* strictly increasing: the strict claim needs `p^2 < 1`. -/
theorem cumulative_effect_saturates_at_hazard_one {ι : Type} (U : Finset ι)
    (p2 : ι → ℝ) (s : ℕ) (h : ∀ k, p2 k = 1) :
    ∑ k ∈ U, ((1 - (0 : ℝ)) ^ (s + 1) - (1 - p2 k) ^ (s + 1))
      = ∑ k ∈ U, ((1 - (0 : ℝ)) ^ (s + 2) - (1 - p2 k) ^ (s + 2)) := by
  apply Finset.sum_congr rfl
  intro k _
  rw [h k]
  simp

/-- At `p^2 = 1` the cumulative effect is exactly the number of unfamiliar
languages, at every horizon. -/
theorem cumulative_effect_at_hazard_one_eq_card {ι : Type} (U : Finset ι)
    (p2 : ι → ℝ) (s : ℕ) (h : ∀ k, p2 k = 1) :
    ∑ k ∈ U, ((1 - (0 : ℝ)) ^ (s + 1) - (1 - p2 k) ^ (s + 1)) = (U.card : ℝ) := by
  rw [Finset.sum_congr rfl (fun k _ => by rw [h k])]
  simp

/-! ## Extension: task complexity and the verification bottleneck

Not in the source. A project of complexity `c ≥ 0` is worth `R c` more (the
same in every production mode), costs more to execute in both modes,
`C_S(c) = χ c²/2 + ψ c` and `C_D(c) = χ c²/2` (delegation removes the linear
component, `ψ > 0`), and, when delegated, is costlier to verify,
`κ(c) = κ₀ + η c²/2`, and riskier, `σ_D²(c) = σ₀² + ν c²/2`. The paper's
thresholds `T^S` and `T^D` (checked from primitives in `PaperInterface.lean`)
are taken as given; the extension adds the complexity terms to them. The
delegation share `λ` is kept fixed. -/

/-- Solo threshold with complexity: `T^S(c) = T^S - R(c) + χ c²/2 + ψ c`. -/
noncomputable def soloThresholdC (TS : ℝ) (R : ℝ → ℝ) (χ ψ c : ℝ) : ℝ :=
  TS - R c + χ / 2 * c ^ 2 + ψ * c

/-- Delegation threshold with complexity:
`T^D(c) = T^D - R(c) + χ c²/2 + η c²/2 + (ρ/2)(ν c²/2)`. -/
noncomputable def delegationThresholdC (TD : ℝ) (R : ℝ → ℝ) (χ η ν ρ c : ℝ) : ℝ :=
  TD - R c + χ / 2 * c ^ 2 + η / 2 * c ^ 2 + ρ / 2 * (ν / 2 * c ^ 2)

/-- Delegation advantage with complexity, `B(c) = T^S(c) - T^D(c)`. -/
noncomputable def reductionC (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ c : ℝ) : ℝ :=
  soloThresholdC TS R χ ψ c - delegationThresholdC TD R χ η ν ρ c

/-- Closed form: `B(c) = B + ψ c - θ c²/2` with `θ = η + ρ ν / 2`. The project
value `R(c)` and the common execution curvature `χ` cancel. -/
theorem reductionC_eq (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ c : ℝ) :
    reductionC TS TD R χ ψ η ν ρ c
      = (TS - TD) + ψ * c - (η + ρ * ν / 2) / 2 * c ^ 2 := by
  unfold reductionC soloThresholdC delegationThresholdC; ring

/-- `c = 0` recovers the paper's reduction `B = T^S - T^D` exactly. -/
theorem reductionC_zero (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ : ℝ) :
    reductionC TS TD R χ ψ η ν ρ 0 = TS - TD := by
  rw [reductionC_eq]; ring

/-- The activation band at complexity `c` (Proposition 2 with complexity, for an
unfamiliar language so that `T^1(c) = T^S(c)`): if `B(c) > 0` then
`Z²(c) - Z¹(c) = 1[T^D(c) ≤ ω < T^S(c)]`, a band of width `B(c)`. -/
theorem activation_band_C (ω TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ c : ℝ)
    (hB : 0 < reductionC TS TD R χ ψ η ν ρ c) :
    (if 0 ≤ max (ω - soloThresholdC TS R χ ψ c) (ω - delegationThresholdC TD R χ η ν ρ c)
        then (1 : ℝ) else 0)
      - (if 0 ≤ ω - soloThresholdC TS R χ ψ c then (1 : ℝ) else 0)
      = if delegationThresholdC TD R χ η ν ρ c ≤ ω ∧ ω < soloThresholdC TS R χ ψ c
          then (1 : ℝ) else 0 :=
  band_indicator (by unfold reductionC at hB; linarith)

/-- Benchmark without a bottleneck (`η = ν = 0`): the advantage is `B + ψ c`. -/
theorem reductionC_benchmark (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ ρ c : ℝ) :
    reductionC TS TD R χ ψ 0 0 ρ c = (TS - TD) + ψ * c := by
  rw [reductionC_eq]; ring

/-- In the benchmark the advantage is strictly increasing in complexity when
`ψ > 0`: the conclusion is the assumption. -/
theorem reductionC_benchmark_strictMono (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ ρ : ℝ) (hψ : 0 < ψ) :
    StrictMono (fun c : ℝ => reductionC TS TD R χ ψ 0 0 ρ c) := by
  intro c c' h
  change reductionC TS TD R χ ψ 0 0 ρ c < reductionC TS TD R χ ψ 0 0 ρ c'
  rw [reductionC_benchmark, reductionC_benchmark]
  have := mul_lt_mul_of_pos_left h hψ
  linarith

/-- Completing the square: `B(c*) - B(c) = θ/2 (c - c*)²` whenever `θ c* = ψ`. -/
theorem reductionC_sub_peak (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ c cstar : ℝ)
    (hc : (η + ρ * ν / 2) * cstar = ψ) :
    reductionC TS TD R χ ψ η ν ρ cstar - reductionC TS TD R χ ψ η ν ρ c
      = (η + ρ * ν / 2) / 2 * (c - cstar) ^ 2 := by
  rw [reductionC_eq, reductionC_eq, ← hc]; ring

/-- The verification bottleneck: with `θ ≥ 0` the advantage is maximal at the
complexity `c*` with `θ c* = ψ`. -/
theorem reductionC_le_peak (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ c cstar : ℝ)
    (hθ : 0 ≤ η + ρ * ν / 2) (hc : (η + ρ * ν / 2) * cstar = ψ) :
    reductionC TS TD R χ ψ η ν ρ c ≤ reductionC TS TD R χ ψ η ν ρ cstar := by
  have h := reductionC_sub_peak TS TD R χ ψ η ν ρ c cstar hc
  have : 0 ≤ (η + ρ * ν / 2) / 2 * (c - cstar) ^ 2 := by positivity
  linarith

/-- The peak is `c* = ψ / θ` when `θ > 0`. -/
theorem reductionC_le_peak_div (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ c : ℝ)
    (hθ : 0 < η + ρ * ν / 2) :
    reductionC TS TD R χ ψ η ν ρ c
      ≤ reductionC TS TD R χ ψ η ν ρ (ψ / (η + ρ * ν / 2)) :=
  reductionC_le_peak TS TD R χ ψ η ν ρ c _ hθ.le (mul_div_cancel₀ ψ hθ.ne')

/-- Below the peak the advantage is strictly increasing in complexity. -/
theorem reductionC_strictMonoOn (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ cstar : ℝ)
    (hθ : 0 < η + ρ * ν / 2) (hc : (η + ρ * ν / 2) * cstar = ψ) :
    StrictMonoOn (fun c : ℝ => reductionC TS TD R χ ψ η ν ρ c) (Set.Iic cstar) := by
  intro c hc1 c' hc2 hlt
  simp only [Set.mem_Iic] at hc1 hc2
  change reductionC TS TD R χ ψ η ν ρ c < reductionC TS TD R χ ψ η ν ρ c'
  rw [reductionC_eq, reductionC_eq, ← hc]
  have e : ((TS - TD) + (η + ρ * ν / 2) * cstar * c' - (η + ρ * ν / 2) / 2 * c' ^ 2)
      - ((TS - TD) + (η + ρ * ν / 2) * cstar * c - (η + ρ * ν / 2) / 2 * c ^ 2)
      = (c' - c) * ((η + ρ * ν / 2) * (cstar - (c + c') / 2)) := by ring
  have hpos : 0 < (c' - c) * ((η + ρ * ν / 2) * (cstar - (c + c') / 2)) :=
    mul_pos (by linarith) (mul_pos hθ (by linarith))
  linarith

/-- Above the peak the advantage is strictly decreasing in complexity. -/
theorem reductionC_strictAntiOn (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ cstar : ℝ)
    (hθ : 0 < η + ρ * ν / 2) (hc : (η + ρ * ν / 2) * cstar = ψ) :
    StrictAntiOn (fun c : ℝ => reductionC TS TD R χ ψ η ν ρ c) (Set.Ici cstar) := by
  intro c hc1 c' hc2 hlt
  simp only [Set.mem_Ici] at hc1 hc2
  change reductionC TS TD R χ ψ η ν ρ c' < reductionC TS TD R χ ψ η ν ρ c
  rw [reductionC_eq, reductionC_eq, ← hc]
  have e : ((TS - TD) + (η + ρ * ν / 2) * cstar * c - (η + ρ * ν / 2) / 2 * c ^ 2)
      - ((TS - TD) + (η + ρ * ν / 2) * cstar * c' - (η + ρ * ν / 2) / 2 * c' ^ 2)
      = (c' - c) * ((η + ρ * ν / 2) * ((c + c') / 2 - cstar)) := by ring
  have hpos : 0 < (c' - c) * ((η + ρ * ν / 2) * ((c + c') / 2 - cstar)) :=
    mul_pos (by linarith) (mul_pos hθ (by linarith))
  linarith

/-- The band closes: beyond an explicit complexity bound the advantage is
negative, so delegation no longer activates the language. -/
theorem reductionC_neg_of_large (TS TD : ℝ) (R : ℝ → ℝ) (χ ψ η ν ρ c : ℝ)
    (hθ : 0 < η + ρ * ν / 2) (hψ : 0 ≤ ψ) (hB : 0 ≤ TS - TD)
    (hc : 4 * ψ + 4 * ((TS - TD) + 1) + (η + ρ * ν / 2) ≤ (η + ρ * ν / 2) * c) :
    reductionC TS TD R χ ψ η ν ρ c < 0 := by
  rw [reductionC_eq]
  set θ := η + ρ * ν / 2 with hθdef
  have h1 : 4 * ψ ≤ θ * c := by linarith
  have h2 : 4 * ((TS - TD) + 1) ≤ θ * c := by linarith
  have h3 : θ ≤ θ * c := by linarith
  have hc1 : 1 ≤ c := by
    by_contra hlt
    have hlt2 : c < 1 := not_le.mp hlt
    have : θ * c < θ * 1 := mul_lt_mul_of_pos_left hlt2 hθ
    linarith
  have hc0 : 0 ≤ c := by linarith
  have hcc : c ≤ c ^ 2 := by nlinarith
  have hψc : 4 * (ψ * c) ≤ θ * c ^ 2 := by nlinarith [mul_le_mul_of_nonneg_right h1 hc0]
  have hB' : 4 * ((TS - TD) + 1) ≤ θ * c ^ 2 := by
    nlinarith [mul_le_mul_of_nonneg_left hcc hθ.le]
  nlinarith

/-- Comparative static: if the verification and residual-risk curvatures fall
with general ability (the logic of Assumption 2), the peak complexity
`ψ / θ(a)` rises with ability. -/
theorem peak_monotone_in_ability (ψ ρ : ℝ) (hψ : 0 ≤ ψ) (hρ : 0 ≤ ρ)
    (η ν : ℝ → ℝ) (hη : Antitone η) (hν : Antitone ν)
    (hpos : ∀ a, 0 < η a + ρ * ν a / 2) :
    Monotone (fun a : ℝ => ψ / (η a + ρ * ν a / 2)) := by
  intro a a' haa'
  have h1 : η a' ≤ η a := hη haa'
  have h2 : ν a' ≤ ν a := hν haa'
  have hle : η a' + ρ * ν a' / 2 ≤ η a + ρ * ν a / 2 := by
    have := mul_le_mul_of_nonneg_left h2 hρ
    linarith
  exact div_le_div_of_nonneg_left hψ (hpos a') hle

end QX26AgenticDelegation
