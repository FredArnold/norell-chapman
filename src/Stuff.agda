module Stuff where

open import Definitions
open import Exercises


-- copy of ∘ with different type variables having different names
infixr 15 _O_
_O_ : {A : Set}{B : A -> Set}{C : (x : A) -> B x -> Set}
      (f : {x2 : A}(y : B x2) -> C x2 y)(g : (x3 : A) -> B x3)
      (x4 : A) -> C x4 (g x4)
(f O g) x = f (g x)

three : Nat
three = (suc O suc O suc) zero

threes : (n : Nat) -> Vec Nat n
threes n = vec three

sum : {n : Nat} -> Vec Nat n -> Nat
sum []        = zero
sum (x :: xs) = x + sum xs

timesThree : Nat -> Nat
timesThree = sum ∘ threes
