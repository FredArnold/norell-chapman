module Exercises where

open import Definitions


-- 2.1
Matrix : Set -> Nat -> Nat -> Set
Matrix A n m = Vec (Vec A n) m

-- (a)
vec : {n : Nat}{A : Set} -> A -> Vec A n
vec {zero}  x = []
vec {suc n} x = x :: vec {n} x

-- (b)
_$_ : {n : Nat}{A B : Set} -> Vec (A -> B) n -> Vec A n -> Vec B n
[]        $ []        = []
(f :: fs) $ (x :: xs) = f x :: (fs $ xs)

-- (c)
transpose : forall {A n m} -> Matrix A n m -> Matrix A m n
transpose []        = vec []
transpose (v :: vs) = (vmap (\x xs -> x :: xs) v) $ transpose vs
