/- Copyright (c) Heather Macbeth, 2023.  All rights reserved. -/
import Mathlib.Data.Real.Basic
import Library.Basic

math2001_init

--`push_neg` simplifie des négations
-- `dsimp [f]` remplace les occurrences de `f` par sa définition

open Function
namespace Int

def q (x : ℝ) : ℝ := x + 3

example : Injective q := by
  dsimp [Injective]
  intro x1 x2 h
  dsimp [q] at h
  addarith [h]
  done

example : ¬ Injective (fun x : ℝ ↦ x ^ 2) := by
  dsimp [Injective]
  push_neg
  use -1, 1
  constructor
  · numbers
  · numbers
  done

def s (a : ℚ) : ℚ := 3 * a + 2

example : Surjective s := by
  dsimp [Surjective]
  intro y
  use (y - 2) / 3
  calc s ((y - 2) / 3) = 3 * ((y - 2) / 3) + 2 := by rw [s]
    _ = y := by ring
  done

example : ¬ Surjective (fun x : ℝ ↦ x ^ 2) := by
  dsimp [Surjective]
  push_neg
  use -1
  intro x
  apply ne_of_gt
  calc -1 < 0 := by numbers
    _ ≤ x ^ 2 := by extra
  done

example : Injective (fun (x:ℝ) ↦ x ^ 3) := by
  intro x1 x2 hx
  dsimp at hx
  have H : (x1 - x2) * (x1 ^ 2 + x1 * x2 + x2 ^ 2) = 0
  · calc (x1 - x2) * (x1 ^ 2 + x1 * x2 + x2 ^ 2) = x1 ^ 3 - x2 ^ 3 := by ring
      _ = x1 ^ 3 - x1 ^ 3 := by rw [hx]
      _ = 0 := by ring
  rw [mul_eq_zero] at H
  obtain H1 | H2 := H
  · -- case 1: x1 - x2 = 0
    addarith [H1]
  · -- case 2: x1 ^2 + x1 * x2 + x2 ^ 2  = 0
    by_cases hx1 : x1 = 0
    · -- case 2a: x1 = 0
      have hx2 :=
      calc x2 ^ 3 = x1 ^ 3 := by rw [hx]
        _ = 0 ^ 3 := by rw [hx1]
        _ = 0 := by numbers
      cancel 3 at hx2
      calc x1 = 0 := by rw [hx1]
        _ = x2 := by rw [hx2]
    · -- case 2b: x1 ≠ 0
      have :=
      calc 0 < x1 ^ 2 + ((x1 + x2) ^ 2 + x2 ^ 2) := by extra
          _ = 2 * (x1 ^ 2 + x1 * x2 + x2 ^ 2) := by ring
          _ = 2 * 0 := by rw [H2]
          _ = 0 := by ring
      numbers at this -- contradiction!
  done

/-! # Exercises -/


/-- Il y a des paires d'énoncés du type `example : 1 + 1 = 2` et `example : ¬(1 + 1 = 2)`.
Bien évidemment un est vrai et l'autre est faux. À vous de trouver lequel est faisable. -/

example : Injective (fun (x : ℚ) ↦ x - 12) := by
  sorry
  done
example : ¬ Injective (fun (x : ℚ) ↦ x - 12) := by
  sorry
  done

example : Injective (fun (x : ℝ) ↦ 3) := by
  sorry
  done
example : ¬ Injective (fun (x : ℝ) ↦ 3) := by
  sorry
  done

example : Injective (fun (x : ℚ) ↦ 3 * x - 1) := by
  sorry
  done
example : ¬ Injective (fun (x : ℚ) ↦ 3 * x - 1) := by
  sorry
  done

example : Injective (fun (x : ℤ) ↦ 3 * x - 1) := by
  sorry
  done
example : ¬ Injective (fun (x : ℤ) ↦ 3 * x - 1) := by
  sorry
  done

example : Surjective (fun (x : ℝ) ↦ 2 * x) := by
  sorry
  done
example : ¬ Surjective (fun (x : ℝ) ↦ 2 * x) := by
  sorry
  done

example : Surjective (fun (x : ℤ) ↦ 2 * x) := by
  sorry
  done
example : ¬ Surjective (fun (x : ℤ) ↦ 2 * x) := by
  sorry
  done

example : Surjective (fun (n : ℕ) ↦ n ^ 2) := by
  sorry
  done
example : ¬ Surjective (fun (n : ℕ) ↦ n ^ 2) := by
  sorry
  done

example : ∀ (f : ℚ → ℚ), Injective f → Injective (fun x ↦ f x + 1) := by
  sorry
  done
example : ¬ ∀ (f : ℚ → ℚ), Injective f → Injective (fun x ↦ f x + 1) := by
  sorry
  done

example : ∀ (f : ℚ → ℚ), Injective f → Injective (fun x ↦ f x + x) := by
  sorry
  done
example : ¬ ∀ (f : ℚ → ℚ), Injective f → Injective (fun x ↦ f x + x) := by
  sorry
  done

example : ∀ (f : ℤ → ℤ), Surjective f → Surjective (fun x ↦ 2 * f x) := by
  sorry
  done
example : ¬ ∀ (f : ℤ → ℤ), Surjective f → Surjective (fun x ↦ 2 * f x) := by
  sorry
  done

example : ∀ c : ℝ, Surjective (fun x ↦ c * x) := by
  sorry
  done
example : ¬ ∀ c : ℝ, Surjective (fun x ↦ c * x) := by
  sorry
  done

-- Tous les énoncés à partir d'ici sont vrais. Vous pouvez les prouver.

example (f : X → Y) : Injective f ↔ ∀ x1 x2 : X, x1 ≠ x2 → f x1 ≠ f x2 := by
  sorry
  done

example {f : ℚ → ℚ} (hf : ∀ x y, x < y → f x < f y) : Injective f := by
  sorry
  done

example {X : Type} {f : X → ℕ} {x0 : X} (h0 : f x0 = 0) {i : X → X}
    (hi : ∀ x, f (i x) = f x + 1) : Surjective f := by
  sorry
  done
