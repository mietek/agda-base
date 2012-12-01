{-# OPTIONS --without-K #-}
module category.groupoid where

open import level using (Level ; lsuc ; _⊔_)
open import category.category
open import category.functor using (Functor)
open import equality.core using (_≡_)

record Groupoid (i j : Level) : Set (lsuc (i ⊔ j)) where
  field
    cat : Category i j

  open Category cat

  infix 9 _⁻¹

  field
    -- structure
    _⁻¹ : {A B : obj} → hom A B → hom B A

    -- laws
    left-inverse : {A B : obj}(f : hom A B)
                 → f ⁻¹ ∘ f ≡ id A

    right-inverse : {A B : obj}(f : hom A B)
                  → f ∘ f ⁻¹ ≡ id B

  open Category cat public

open Groupoid using (cat)

-- a morphism of groupoids is just a functor of the underlying categories
Morphism : ∀ {i j i' j'} (G : Groupoid i j)(H : Groupoid i' j') → Set _
Morphism G H = Functor (cat G) (cat H)
