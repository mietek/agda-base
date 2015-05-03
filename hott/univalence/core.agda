module hott.univalence.core where

open import level using (lsuc)
open import sum using (_,_ ; proj₁)
open import equality.core
open import equality.calculus
open import equality.reasoning
open import function.core
open import function.isomorphism.core using (_≅_ ; module _≅_)
open import hott.equivalence.core

-- mapping from equality to function
coerce : ∀ {i} {X Y : Set i} → X ≡ Y → X → Y
coerce refl = id

coerce-equiv : ∀ {i} {X Y : Set i} → (p : X ≡ Y) → weak-equiv (coerce p)
coerce-equiv refl x = (x , refl) , λ { (.x , refl) → refl }

coerce-hom : ∀ {i} {X Y Z : Set i}
           → (p : X ≡ Y)(q : Y ≡ Z)
           → coerce (p · q) ≡ coerce q ∘ coerce p
coerce-hom refl q = refl

-- mapping from propositional equality to weak equivalence
≡⇒≈ : ∀ {i} {X Y : Set i} → X ≡ Y → X ≈ Y
≡⇒≈ p = coerce p , coerce-equiv p

Univalence : ∀ i → Set (lsuc i)
Univalence i = {X Y : Set i} → weak-equiv $ ≡⇒≈ {X = X} {Y = Y}
