module Definitions where


data Bool : Set where
  true  : Bool
  false : Bool

not : Bool -> Bool
not true  = false
not false = true

data Nat : Set where
  zero : Nat
  suc : Nat -> Nat

_+_ : Nat -> Nat -> Nat
zero  + m = m
suc n + m = suc (n + m)

_*_ : Nat -> Nat -> Nat
zero  * m = zero
suc n * m = m + n * m

_or_ : Bool -> Bool -> Bool
false or x = x
true or _ = true

if_then_else_ : {A : Set} -> Bool -> A -> A -> A
if true  then x else y = x
if false then x else y = y

infixl 60 _*_
infixl 40 _+_
infixr 10 _or_
infix  5 if_then_else_

infixr 40 _::_
data List (A : Set) : Set where
  []   : List A
  _::_ : A -> List A -> List A

identity : (A : Set) -> A -> A
identity A x = x

zero' : Nat
zero' = identity Nat zero

apply : (A : Set)(B : A -> Set) ->
        ((x : A) -> B x) -> (a : A) -> B a
apply A B f a = f a

id : {A : Set} -> A -> A
id x = x

true' : Bool
true' = id true

silly : {A : Set}{x : A} -> A
silly {_}{x} = x

one : Nat
one = identity _ (suc zero)

_∘_ : {A : Set}{B : A -> Set}{C : (x : A) -> B x -> Set}
      (f : {x : A}(y : B x) -> C x y)(g : (x : A) -> B x)
      (x : A) -> C x (g x)
(f ∘ g) x = f (g x)

plus-two = suc ∘ suc

map : {A B : Set} -> (A -> B) -> List A -> List B
map f []        = []
map f (x :: xs) = f x :: map f xs

_++_ : {A : Set} -> List A -> List A -> List A
[]        ++ ys = ys
(x :: xs) ++ ys = x :: (xs ++ ys)

data Vec (A : Set) : Nat -> Set where
  []   : Vec A zero
  _::_ : {n : Nat} -> A -> Vec A n -> Vec A (suc n)

vmap : {A B : Set}{n : Nat} -> (A -> B) -> Vec A n -> Vec B n
vmap f []        = []
vmap f (x :: xs) = f x :: vmap f xs

data Vec₂ (A : Set) : Nat -> Set where
  nil : Vec₂ A zero
  cons : (n : Nat) -> A -> Vec₂ A n -> Vec₂ A (suc n)

vmap₂ : {A B : Set}(n : Nat) -> (A -> B) -> Vec₂ A n -> Vec₂ B n
vmap₂ .zero f nil = nil
vmap₂ .(suc n) f (cons n x xs) = cons n (f x) (vmap₂ n f xs)

data Image_∋_ {A B : Set}(f : A -> B) : B -> Set where
  im : (x : A) -> Image f ∋ f x

inv : {A B : Set}(f : A -> B)(y : B) -> Image f ∋ y -> A
inv f .(f x) (im x) = x

data Fin : Nat -> Set where
  fzero : {n : Nat} -> Fin (suc n)
  fsuc  : {n : Nat} -> Fin n -> Fin (suc n)

magic : {A : Set} -> Fin zero -> A
magic ()

data Empty : Set where
  empty : Fin zero -> Empty

magic' : {A : Set} -> Empty -> A
magic' (empty ())

_!_ : {n : Nat}{A : Set} -> Vec A n -> Fin n -> A
[]        ! ()
(x :: xs) ! fzero    = x
(x :: xs) ! (fsuc i) = xs ! i

tabulate : {n : Nat}{A : Set} -> (Fin n -> A) -> Vec A n
tabulate {zero}  f = []
tabulate {suc n} f = f fzero :: tabulate (f ∘ fsuc)

data False : Set where
record True : Set where

trivial : True
trivial = _

isTrue : Bool -> Set
isTrue true  = True
isTrue false = False
